// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_actions.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_selectors.dart';
import 'package:invoiceninja_flutter/ui/purchase_order/purchase_order_list_item.dart';
import 'package:invoiceninja_flutter/ui/purchase_order/purchase_order_presenter.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_list_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PurchaseOrderListBuilder extends StatelessWidget {
  const PurchaseOrderListBuilder({Key? key}) : super(key: key);

  static const String route = '/purchase_orders/edit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PurchaseOrderListVM>(
        converter: PurchaseOrderListVM.fromStore,
        builder: (context, viewModel) {
          return EntityList(
              onClearMultiselect: viewModel.onClearMultiselect,
              entityType: EntityType.purchaseOrder,
              presenter: PurchaseOrderPresenter(),
              state: viewModel.state,
              entityList: viewModel.invoiceList,
              tableColumns: viewModel.tableColumns,
              onRefreshed: viewModel.onRefreshed,
              onSortColumn: viewModel.onSortColumn,
              itemBuilder: (BuildContext context, index) {
                final state = viewModel.state;
                final invoiceId = viewModel.invoiceList[index];
                final invoice = viewModel.invoiceMap[invoiceId]!;
                final listUIState =
                    state.getListState(EntityType.purchaseOrder);
                final isInMultiselect = listUIState.isInMultiselect();

                return PurchaseOrderListItem(
                  user: state.user,
                  filter: viewModel.filter,
                  purchaseOrder: invoice,
                  vendor: state.vendorState.get(invoice.vendorId),
                  isChecked:
                      isInMultiselect && listUIState.isSelected(invoice.id),
                );
              });
        });
  }
}

class PurchaseOrderListVM extends EntityListVM {
  PurchaseOrderListVM({
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

  static PurchaseOrderListVM fromStore(Store<AppState> store) {
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

    return PurchaseOrderListVM(
      state: state,
      invoiceList: memoizedFilteredPurchaseOrderList(
          state.getUISelection(EntityType.purchaseOrder),
          state.purchaseOrderState.map,
          state.purchaseOrderState.list,
          state.clientState.map,
          state.vendorState.map,
          state.purchaseOrderListState,
          state.userState.map),
      invoiceMap: state.purchaseOrderState.map,
      clientMap: state.clientState.map,
      isLoading: state.isLoading,
      filter: state.purchaseOrderListState.filter,
      onRefreshed: (context) => _handleRefresh(context),
      onEntityAction: (BuildContext context, List<BaseEntity> purchaseOrders,
              EntityAction action) =>
          handlePurchaseOrderAction(context, purchaseOrders, action),
      tableColumns: state.userCompany.settings
              .getTableColumns(EntityType.purchaseOrder) ??
          PurchaseOrderPresenter.getDefaultTableFields(state.userCompany),
      entityType: EntityType.purchaseOrder,
      onSortColumn: (field) => store.dispatch(SortPurchaseOrders(field)),
      onClearMultiselect: () => store.dispatch(ClearPurchaseOrderMultiselect()),
    );
  }
}
