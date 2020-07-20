import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_selectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
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
          return EntityList(
              entityType: EntityType.credit,
              presenter: CreditPresenter(),
              state: viewModel.state,
              entityList: viewModel.invoiceList,
              tableColumns: viewModel.tableColumns,
              onRefreshed: viewModel.onRefreshed,
              onClearEntityFilterPressed: viewModel.onClearEntityFilterPressed,
              onViewEntityFilterPressed: viewModel.onViewEntityFilterPressed,
              onSortColumn: viewModel.onSortColumn,
              itemBuilder: (BuildContext context, index) {
                final state = viewModel.state;
                final invoiceId = viewModel.invoiceList[index];
                final invoice = viewModel.invoiceMap[invoiceId];
                final listUIState = state.getListState(EntityType.credit);
                final isInMultiselect = listUIState.isInMultiselect();

                return CreditListItem(
                  user: state.user,
                  filter: viewModel.filter,
                  credit: invoice,
                  client:
                      viewModel.clientMap[invoice.clientId] ?? ClientEntity(),
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
    List<String> invoiceList,
    BuiltMap<String, InvoiceEntity> invoiceMap,
    BuiltMap<String, ClientEntity> clientMap,
    String filter,
    bool isLoading,
    bool isLoaded,
    Function(BuildContext) onRefreshed,
    Function onClearEntityFilterPressed,
    Function(BuildContext) onViewEntityFilterPressed,
    Function(BuildContext, List<InvoiceEntity>, EntityAction) onEntityAction,
    List<String> tableColumns,
    EntityType entityType,
    Function(String) onSortColumn,
  }) : super(
          state: state,
          invoiceList: invoiceList,
          invoiceMap: invoiceMap,
          clientMap: clientMap,
          filter: filter,
          isLoading: isLoading,
          isLoaded: isLoaded,
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
      store.dispatch(RefreshData(completer: completer));
      return completer.future;
    }

    final state = store.state;

    return CreditListVM(
      state: state,
      invoiceList: memoizedFilteredCreditList(
          state.creditState.map,
          state.creditState.list,
          state.clientState.map,
          state.creditListState,
          state.staticState,
          state.userState.map),
      invoiceMap: state.creditState.map,
      clientMap: state.clientState.map,
      isLoading: state.isLoading,
      filter: state.creditListState.filter,
      onRefreshed: (context) => _handleRefresh(context),
      onClearEntityFilterPressed: () => store.dispatch(ClearEntityFilter()),
      onViewEntityFilterPressed: (BuildContext context) => viewEntityById(
          context: context,
          entityId: state.creditListState.filterEntityId,
          entityType: state.creditListState.filterEntityType),
      onEntityAction: (BuildContext context, List<BaseEntity> credits,
              EntityAction action) =>
          handleCreditAction(context, credits, action),
      tableColumns:
          state.userCompany.settings.getTableColumns(EntityType.credit) ??
              CreditPresenter.getAllTableFields(state.userCompany),
      entityType: EntityType.credit,
      onSortColumn: (field) => store.dispatch(SortCredits(field)),
    );
  }
}
