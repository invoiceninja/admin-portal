import 'dart:async';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/purchase_order/view/purchase_order_view.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class PurchaseOrderViewScreen extends StatelessWidget {
  const PurchaseOrderViewScreen({
    Key key,
    this.isFilter = false,
  }) : super(key: key);
  static const String route = '/purchase_order/view';
  final bool isFilter;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PurchaseOrderViewVM>(
      converter: (Store<AppState> store) {
        return PurchaseOrderViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return PurchaseOrderView(
          viewModel: vm,
          isFilter: isFilter,
        );
      },
    );
  }
}

class PurchaseOrderViewVM {
  PurchaseOrderViewVM({
    @required this.state,
    @required this.purchaseOrder,
    @required this.company,
    @required this.onEntityAction,
    @required this.onRefreshed,
    @required this.isSaving,
    @required this.isLoading,
    @required this.isDirty,
  });

  factory PurchaseOrderViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final purchaseOrder =
        state.purchaseOrderState.map[state.purchaseOrderUIState.selectedId] ??
            InvoiceEntity(id: state.purchaseOrderUIState.selectedId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadPurchaseOrder(
          completer: completer, purchaseOrderId: purchaseOrder.id));
      return completer.future;
    }

    return PurchaseOrderViewVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: purchaseOrder.isNew,
      purchaseOrder: purchaseOrder,
      onRefreshed: (context) => _handleRefresh(context),
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions([purchaseOrder], action, autoPop: true),
    );
  }

  final AppState state;
  final InvoiceEntity purchaseOrder;
  final CompanyEntity company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext) onRefreshed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
