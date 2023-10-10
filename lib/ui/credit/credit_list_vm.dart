// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/credit/credit_list_item.dart';
import 'package:invoiceninja_flutter/ui/credit/credit_presenter.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_list_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class CreditListBuilder extends StatelessWidget {
  const CreditListBuilder({Key? key}) : super(key: key);

  static const String route = '/credits/edit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreditListVM>(
        converter: CreditListVM.fromStore,
        builder: (context, viewModel) {
          return EntityList(
              onClearMultiselect: viewModel.onClearMultiselect,
              entityType: EntityType.credit,
              presenter: CreditPresenter(),
              state: viewModel.state,
              entityList: viewModel.invoiceList,
              tableColumns: viewModel.tableColumns,
              onRefreshed: viewModel.onRefreshed,
              onSortColumn: viewModel.onSortColumn,
              itemBuilder: (BuildContext context, index) {
                final state = viewModel.state;
                final invoiceId = viewModel.invoiceList[index];
                final invoice = viewModel.invoiceMap[invoiceId]!;
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
    required AppState state,
    required List<String> invoiceList,
    required BuiltMap<String, InvoiceEntity> invoiceMap,
    required BuiltMap<String, ClientEntity> clientMap,
    required String? filter,
    required bool isLoading,
    required Function(BuildContext) onRefreshed,
    required Function(BuildContext, List<InvoiceEntity>, EntityAction)
        onEntityAction,
    required List<String> tableColumns,
    required EntityType entityType,
    required Function(String) onSortColumn,
    required Function onClearMultiselect,
  }) : super(
          state: state,
          invoiceList: invoiceList,
          invoiceMap: invoiceMap,
          clientMap: clientMap,
          filter: filter,
          isLoading: isLoading,
          onRefreshed: onRefreshed,
          tableColumns: tableColumns,
          entityType: entityType,
          onSortColumn: onSortColumn,
          onClearMultiselect: onClearMultiselect,
        );

  static CreditListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>.value();
      }
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);
      store.dispatch(RefreshData(completer: completer));
      return completer.future;
    }

    final state = store.state;

    return CreditListVM(
      state: state,
      invoiceList: memoizedFilteredCreditList(
          state.getUISelection(EntityType.credit),
          state.creditState.map,
          state.creditState.list,
          state.clientState.map,
          state.vendorState.map,
          state.paymentState.map,
          state.creditListState,
          state.userState.map),
      invoiceMap: state.creditState.map,
      clientMap: state.clientState.map,
      isLoading: state.isLoading,
      filter: state.creditListState.filter,
      onRefreshed: (context) => _handleRefresh(context),
      onEntityAction: (BuildContext context, List<BaseEntity> credits,
              EntityAction action) =>
          handleCreditAction(context, credits, action),
      tableColumns:
          state.userCompany.settings.getTableColumns(EntityType.credit) ??
              CreditPresenter.getDefaultTableFields(state.userCompany),
      entityType: EntityType.credit,
      onSortColumn: (field) => store.dispatch(SortCredits(field)),
      onClearMultiselect: () => store.dispatch(ClearCreditMultiselect()),
    );
  }
}
