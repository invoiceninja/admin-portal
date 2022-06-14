import 'dart:async';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/purchase_order/purchase_order_list_item.dart';
import 'package:invoiceninja_flutter/ui/purchase_order/purchase_order_presenter.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_selectors.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_actions.dart';

class PurchaseOrderListBuilder extends StatelessWidget {
  const PurchaseOrderListBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PurchaseOrderListVM>(
      converter: PurchaseOrderListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            entityType: EntityType.purchaseOrder,
            presenter: PurchaseOrderPresenter(),
            state: viewModel.state,
            entityList: viewModel.purchaseOrderList,
            tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onSortColumn: viewModel.onSortColumn,
            onClearMultiselect: viewModel.onClearMultielsect,
            itemBuilder: (BuildContext context, index) {
              final state = viewModel.state;
              final purchaseOrderId = viewModel.purchaseOrderList[index];
              final purchaseOrder = viewModel.purchaseOrderMap[purchaseOrderId];
              final listState = state.getListState(EntityType.purchaseOrder);
              final isInMultiselect = listState.isInMultiselect();

              return PurchaseOrderListItem(
                user: viewModel.state.user,
                filter: viewModel.filter,
                purchaseOrder: purchaseOrder,
                isChecked:
                    isInMultiselect && listState.isSelected(purchaseOrder.id),
              );
            });
      },
    );
  }
}

class PurchaseOrderListVM {
  PurchaseOrderListVM({
    @required this.state,
    @required this.userCompany,
    @required this.purchaseOrderList,
    @required this.purchaseOrderMap,
    @required this.filter,
    @required this.isLoading,
    @required this.listState,
    @required this.onRefreshed,
    @required this.onEntityAction,
    @required this.tableColumns,
    @required this.onSortColumn,
    @required this.onClearMultielsect,
  });

  static PurchaseOrderListVM fromStore(Store<AppState> store) {
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

    return PurchaseOrderListVM(
      state: state,
      userCompany: state.userCompany,
      listState: state.purchaseOrderListState,
      purchaseOrderList: memoizedFilteredPurchaseOrderList(
        state.getUISelection(EntityType.purchaseOrder),
        state.purchaseOrderState.map,
        state.purchaseOrderState.list,
        state.clientState.map,
        state.purchaseOrderListState,
        state.userState.map,
      ),
      purchaseOrderMap: state.purchaseOrderState.map,
      isLoading: state.isLoading,
      filter: state.purchaseOrderUIState.listUIState.filter,
      onEntityAction: (BuildContext context, List<BaseEntity> purchaseOrders,
              EntityAction action) =>
          handlePurchaseOrderAction(context, purchaseOrders, action),
      onRefreshed: (context) => _handleRefresh(context),
      tableColumns: state.userCompany.settings
              ?.getTableColumns(EntityType.purchaseOrder) ??
          PurchaseOrderPresenter.getDefaultTableFields(state.userCompany),
      onSortColumn: (field) => store.dispatch(SortPurchaseOrders(field)),
      onClearMultielsect: () => store.dispatch(ClearPurchaseOrderMultiselect()),
    );
  }

  final AppState state;
  final UserCompanyEntity userCompany;
  final List<String> purchaseOrderList;
  final BuiltMap<String, InvoiceEntity> purchaseOrderMap;
  final ListUIState listState;
  final String filter;
  final bool isLoading;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final List<String> tableColumns;
  final Function(String) onSortColumn;
  final Function onClearMultielsect;
}
