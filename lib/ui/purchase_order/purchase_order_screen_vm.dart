import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_actions.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_selectors.dart';
import 'package:redux/redux.dart';

import 'purchase_order_screen.dart';

class PurchaseOrderScreenBuilder extends StatelessWidget {
  const PurchaseOrderScreenBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PurchaseOrderScreenVM>(
      converter: PurchaseOrderScreenVM.fromStore,
      builder: (context, vm) {
        return PurchaseOrderScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class PurchaseOrderScreenVM {
  PurchaseOrderScreenVM({
    required this.isInMultiselect,
    required this.purchaseOrderList,
    required this.userCompany,
    required this.onEntityAction,
    required this.purchaseOrderMap,
  });

  final bool isInMultiselect;
  final UserCompanyEntity? userCompany;
  final List<String> purchaseOrderList;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final BuiltMap<String, InvoiceEntity> purchaseOrderMap;

  static PurchaseOrderScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return PurchaseOrderScreenVM(
      purchaseOrderMap: state.purchaseOrderState.map,
      purchaseOrderList: memoizedFilteredPurchaseOrderList(
        state.getUISelection(EntityType.purchaseOrder),
        state.purchaseOrderState.map,
        state.purchaseOrderState.list,
        state.clientState.map,
        state.vendorState.map,
        state.purchaseOrderListState,
        state.userState.map,
      ),
      userCompany: state.userCompany,
      isInMultiselect: state.purchaseOrderListState.isInMultiselect(),
      onEntityAction: (BuildContext context, List<BaseEntity> purchaseOrders,
              EntityAction action) =>
          handlePurchaseOrderAction(context, purchaseOrders, action),
    );
  }
}
