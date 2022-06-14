import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/purchase_order/purchase_order_screen.dart';
import 'package:invoiceninja_flutter/ui/purchase_order/edit/purchase_order_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/purchase_order/view/purchase_order_view_vm.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/repositories/purchase_order_repository.dart';

List<Middleware<AppState>> createStorePurchaseOrdersMiddleware([
  PurchaseOrderRepository repository = const PurchaseOrderRepository(),
]) {
  final viewPurchaseOrderList = _viewPurchaseOrderList();
  final viewPurchaseOrder = _viewPurchaseOrder();
  final editPurchaseOrder = _editPurchaseOrder();
  final loadPurchaseOrders = _loadPurchaseOrders(repository);
  final loadPurchaseOrder = _loadPurchaseOrder(repository);
  final savePurchaseOrder = _savePurchaseOrder(repository);
  final archivePurchaseOrder = _archivePurchaseOrder(repository);
  final deletePurchaseOrder = _deletePurchaseOrder(repository);
  final restorePurchaseOrder = _restorePurchaseOrder(repository);

  return [
    TypedMiddleware<AppState, ViewPurchaseOrderList>(viewPurchaseOrderList),
    TypedMiddleware<AppState, ViewPurchaseOrder>(viewPurchaseOrder),
    TypedMiddleware<AppState, EditPurchaseOrder>(editPurchaseOrder),
    TypedMiddleware<AppState, LoadPurchaseOrders>(loadPurchaseOrders),
    TypedMiddleware<AppState, LoadPurchaseOrder>(loadPurchaseOrder),
    TypedMiddleware<AppState, SavePurchaseOrderRequest>(savePurchaseOrder),
    TypedMiddleware<AppState, ArchivePurchaseOrdersRequest>(
        archivePurchaseOrder),
    TypedMiddleware<AppState, DeletePurchaseOrdersRequest>(deletePurchaseOrder),
    TypedMiddleware<AppState, RestorePurchaseOrdersRequest>(
        restorePurchaseOrder),
  ];
}

Middleware<AppState> _editPurchaseOrder() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditPurchaseOrder;

    next(action);

    store.dispatch(UpdateCurrentRoute(PurchaseOrderEditScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState.pushNamed(PurchaseOrderEditScreen.route);
    }
  };
}

Middleware<AppState> _viewPurchaseOrder() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewPurchaseOrder;

    next(action);

    store.dispatch(UpdateCurrentRoute(PurchaseOrderViewScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState.pushNamed(PurchaseOrderViewScreen.route);
    }
  };
}

Middleware<AppState> _viewPurchaseOrderList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewPurchaseOrderList;

    next(action);

    if (store.state.staticState.isStale) {
      store.dispatch(RefreshData());
    }

    store.dispatch(UpdateCurrentRoute(PurchaseOrderScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState.pushNamedAndRemoveUntil(
          PurchaseOrderScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _archivePurchaseOrder(PurchaseOrderRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ArchivePurchaseOrdersRequest;
    final prevPurchaseOrders = action.purchaseOrderIds
        .map((id) => store.state.purchaseOrderState.map[id])
        .toList();
    repository
        .bulkAction(store.state.credentials, action.purchaseOrderIds,
            EntityAction.archive)
        .then((List<InvoiceEntity> purchaseOrders) {
      store.dispatch(ArchivePurchaseOrdersSuccess(purchaseOrders));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchivePurchaseOrdersFailure(prevPurchaseOrders));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _deletePurchaseOrder(PurchaseOrderRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DeletePurchaseOrdersRequest;
    final prevPurchaseOrders = action.purchaseOrderIds
        .map((id) => store.state.purchaseOrderState.map[id])
        .toList();
    repository
        .bulkAction(store.state.credentials, action.purchaseOrderIds,
            EntityAction.delete)
        .then((List<InvoiceEntity> purchaseOrders) {
      store.dispatch(DeletePurchaseOrdersSuccess(purchaseOrders));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeletePurchaseOrdersFailure(prevPurchaseOrders));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _restorePurchaseOrder(PurchaseOrderRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RestorePurchaseOrdersRequest;
    final prevPurchaseOrders = action.purchaseOrderIds
        .map((id) => store.state.purchaseOrderState.map[id])
        .toList();
    repository
        .bulkAction(store.state.credentials, action.purchaseOrderIds,
            EntityAction.restore)
        .then((List<InvoiceEntity> purchaseOrders) {
      store.dispatch(RestorePurchaseOrdersSuccess(purchaseOrders));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestorePurchaseOrdersFailure(prevPurchaseOrders));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _savePurchaseOrder(PurchaseOrderRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SavePurchaseOrderRequest;
    repository
        .saveData(store.state.credentials, action.purchaseOrder)
        .then((InvoiceEntity purchaseOrder) {
      if (action.purchaseOrder.isNew) {
        store.dispatch(AddPurchaseOrderSuccess(purchaseOrder));
      } else {
        store.dispatch(SavePurchaseOrderSuccess(purchaseOrder));
      }

      action.completer.complete(purchaseOrder);
    }).catchError((Object error) {
      print(error);
      store.dispatch(SavePurchaseOrderFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _loadPurchaseOrder(PurchaseOrderRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadPurchaseOrder;
    final AppState state = store.state;

    store.dispatch(LoadPurchaseOrderRequest());
    repository
        .loadItem(state.credentials, action.purchaseOrderId)
        .then((purchaseOrder) {
      store.dispatch(LoadPurchaseOrderSuccess(purchaseOrder));

      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadPurchaseOrderFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadPurchaseOrders(PurchaseOrderRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadPurchaseOrders;
    final AppState state = store.state;

    store.dispatch(LoadPurchaseOrdersRequest());
    repository.loadList(state.credentials).then((data) {
      store.dispatch(LoadPurchaseOrdersSuccess(data));

      if (action.completer != null) {
        action.completer.complete(null);
      }
      /*
      if (state.productState.isStale) {
        store.dispatch(LoadProducts());
      }
      */
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadPurchaseOrdersFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}
