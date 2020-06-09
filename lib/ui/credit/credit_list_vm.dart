import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_selectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/document/document_selectors.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/credit/credit_list_item.dart';
import 'package:invoiceninja_flutter/ui/credit/credit_presenter.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_list_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class CreditListBuilder extends StatelessWidget {
  const CreditListBuilder({Key key}) : super(key: key);

  static const String route = '/credits/edit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreditListVM>(
        converter: CreditListVM.fromStore,
        builder: (context, viewModel) {
          final state = viewModel.state;
          final documentMap = memoizedEntityDocumentMap(EntityType.credit,
              state.documentState.map, state.expenseState.map);

          return EntityList(
              isLoaded: viewModel.isLoaded,
              entityType: EntityType.credit,
              presenter: CreditPresenter(),
              state: viewModel.state,
              entityList: viewModel.invoiceList,
              onEntityTap: viewModel.onInvoiceTap,
              tableColumns: viewModel.tableColumns,
              onRefreshed: viewModel.onRefreshed,
              onClearEntityFilterPressed: viewModel.onClearEntityFilterPressed,
              onViewEntityFilterPressed: viewModel.onViewEntityFilterPressed,
              onSortColumn: viewModel.onSortColumn,
              itemBuilder: (BuildContext context, index) {
                final state = viewModel.state;
                final invoiceId = viewModel.invoiceList[index];
                final invoice = viewModel.invoiceMap[invoiceId];
                final client =
                    viewModel.clientMap[invoice.clientId] ?? ClientEntity();
                final listUIState = state.getListState(EntityType.credit);
                final isInMultiselect = listUIState.isInMultiselect();

                void showDialog() => showEntityActionsDialog(
                      entities: [invoice],
                      context: context,
                      client: client,
                    );

                return CreditListItem(
                  user: viewModel.user,
                  filter: viewModel.filter,
                  hasDocuments: documentMap[invoice.id] == true,
                  credit: invoice,
                  client:
                      viewModel.clientMap[invoice.clientId] ?? ClientEntity(),
                  onTap: () => viewModel.onInvoiceTap(context, invoice),
                  onEntityAction: (EntityAction action) {
                    if (action == EntityAction.more) {
                      showDialog();
                    } else {
                      handleInvoiceAction(context, [invoice], action);
                    }
                  },
                  onLongPress: () async {
                    final longPressIsSelection =
                        state.prefState.longPressSelectionIsDefault ?? true;
                    if (longPressIsSelection && !isInMultiselect) {
                      handleInvoiceAction(
                          context, [invoice], EntityAction.toggleMultiselect);
                    } else {
                      showDialog();
                    }
                  },
                  isChecked:
                      isInMultiselect && listUIState.isSelected(invoice.id),
                );
              });
        });
  }
}

class CreditListVM extends EntityListVM {
  CreditListVM({
    AppState state,
    UserEntity user,
    ListUIState listState,
    List<String> invoiceList,
    BuiltMap<String, InvoiceEntity> invoiceMap,
    BuiltMap<String, ClientEntity> clientMap,
    String filter,
    bool isLoading,
    bool isLoaded,
    Function(BuildContext, BaseEntity) onInvoiceTap,
    Function(BuildContext) onRefreshed,
    Function onClearEntityFilterPressed,
    Function(BuildContext) onViewEntityFilterPressed,
    Function(BuildContext, List<InvoiceEntity>, EntityAction) onEntityAction,
    List<String> tableColumns,
    EntityType entityType,
    Function(String) onSortColumn,
  }) : super(
          state: state,
          user: user,
          listState: listState,
          invoiceList: invoiceList,
          invoiceMap: invoiceMap,
          clientMap: clientMap,
          filter: filter,
          isLoading: isLoading,
          isLoaded: isLoaded,
          onInvoiceTap: onInvoiceTap,
          onRefreshed: onRefreshed,
          onClearEntityFilterPressed: onClearEntityFilterPressed,
          onViewEntityFilterPressed: onViewEntityFilterPressed,
          tableColumns: tableColumns,
          entityType: entityType,
          onSortColumn: onSortColumn,
        );

  static CreditListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>(null);
      }
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadCredits(completer: completer, force: true));
      return completer.future;
    }

    final state = store.state;

    return CreditListVM(
      state: state,
      user: state.user,
      listState: state.creditListState,
      invoiceList: memoizedFilteredCreditList(state.creditState.map,
          state.creditState.list, state.clientState.map, state.creditListState),
      invoiceMap: state.creditState.map,
      clientMap: state.clientState.map,
      isLoading: state.isLoading,
      isLoaded: state.creditState.isLoaded && state.clientState.isLoaded,
      filter: state.creditListState.filter,
      onInvoiceTap: (context, credit) {
        viewEntity(context: context, entity: credit);
      },
      onRefreshed: (context) => _handleRefresh(context),
      onClearEntityFilterPressed: () => store.dispatch(FilterCreditsByEntity()),
      onViewEntityFilterPressed: (BuildContext context) => viewEntityById(
          context: context,
          entityId: state.creditListState.filterEntityId,
          entityType: state.creditListState.filterEntityType),
      onEntityAction: (BuildContext context, List<BaseEntity> credits,
              EntityAction action) =>
          handleCreditAction(context, credits, action),
      tableColumns: CreditPresenter.getDefaultTableFields(state.userCompany),
      entityType: EntityType.credit,
      onSortColumn: (field) => store.dispatch(SortCredits(field)),
    );
  }
}
