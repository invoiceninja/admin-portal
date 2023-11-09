// Flutter imports:
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/repositories/purchase_order_repository.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_actions.dart';
import 'package:invoiceninja_flutter/ui/purchase_order/edit/purchase_order_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/purchase_order/purchase_order_email_vm.dart';
import 'package:invoiceninja_flutter/ui/purchase_order/purchase_order_pdf_vm.dart';
import 'package:invoiceninja_flutter/ui/purchase_order/purchase_order_screen.dart';
import 'package:invoiceninja_flutter/ui/purchase_order/view/purchase_order_view_vm.dart';

// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';

List<Middleware<AppState>> createStorePurchaseOrdersMiddleware([
  PurchaseOrderRepository repository = const PurchaseOrderRepository(),
]) {
  final viewPurchaseOrderList = _viewPurchaseOrderList();
  final viewPurchaseOrder = _viewPurchaseOrder();
  final editPurchaseOrder = _editPurchaseOrder();
  final showEmailPurchaseOrder = _showEmailPurchaseOrder();
  final showPdfPurchaseOrder = _showPdfPurchaseOrder();
  final approvePurchaseOrder = _approvePurchaseOrder(repository);
  final loadPurchaseOrders = _loadPurchaseOrders(repository);
  final loadPurchaseOrder = _loadPurchaseOrder(repository);
  final savePurchaseOrder = _savePurchaseOrder(repository);
  final archivePurchaseOrder = _archivePurchaseOrder(repository);
  final deletePurchaseOrder = _deletePurchaseOrder(repository);
  final restorePurchaseOrder = _restorePurchaseOrder(repository);
  final emailPurchaseOrder = _emailPurchaseOrder(repository);
  final bulkEmailPurchaseOrders = _bulkEmailPurchaseOrders(repository);
  final markSentPurchaseOrder = _markSentPurchaseOrder(repository);
  final convertPurchaseOrdersToExpense =
      _convertPurchaseOrdersToExpense(repository);
  final addPurchaseOrdersToInventory =
      _addPurchaseOrdersToInventory(repository);
  final acceptPurchaseOrders = _acceptPurchaseOrders(repository);
  final cancelPurchaseOrders = _cancelPurchaseOrders(repository);
  final downloadPurchaseOrders = _downloadPurchaseOrders(repository);
  final saveDocument = _saveDocument(repository);

  return [
    TypedMiddleware<AppState, ViewPurchaseOrderList>(viewPurchaseOrderList),
    TypedMiddleware<AppState, ViewPurchaseOrder>(viewPurchaseOrder),
    TypedMiddleware<AppState, EditPurchaseOrder>(editPurchaseOrder),
    TypedMiddleware<AppState, ApprovePurchaseOrders>(approvePurchaseOrder),
    TypedMiddleware<AppState, ShowEmailPurchaseOrder>(showEmailPurchaseOrder),
    TypedMiddleware<AppState, ShowPdfPurchaseOrder>(showPdfPurchaseOrder),
    TypedMiddleware<AppState, LoadPurchaseOrders>(loadPurchaseOrders),
    TypedMiddleware<AppState, LoadPurchaseOrder>(loadPurchaseOrder),
    TypedMiddleware<AppState, SavePurchaseOrderRequest>(savePurchaseOrder),
    TypedMiddleware<AppState, ArchivePurchaseOrdersRequest>(
        archivePurchaseOrder),
    TypedMiddleware<AppState, DeletePurchaseOrdersRequest>(deletePurchaseOrder),
    TypedMiddleware<AppState, RestorePurchaseOrdersRequest>(
        restorePurchaseOrder),
    TypedMiddleware<AppState, EmailPurchaseOrderRequest>(emailPurchaseOrder),
    TypedMiddleware<AppState, BulkEmailPurchaseOrdersRequest>(
        bulkEmailPurchaseOrders),
    TypedMiddleware<AppState, MarkPurchaseOrdersSentRequest>(
        markSentPurchaseOrder),
    TypedMiddleware<AppState, ConvertPurchaseOrdersToExpensesRequest>(
        convertPurchaseOrdersToExpense),
    TypedMiddleware<AppState, AddPurchaseOrdersToInventoryRequest>(
        addPurchaseOrdersToInventory),
    TypedMiddleware<AppState, AcceptPurchaseOrdersRequest>(
        acceptPurchaseOrders),
    TypedMiddleware<AppState, CancelPurchaseOrdersRequest>(
        cancelPurchaseOrders),
    TypedMiddleware<AppState, DownloadPurchaseOrdersRequest>(
        downloadPurchaseOrders),
    TypedMiddleware<AppState, SavePurchaseOrderDocumentRequest>(saveDocument),
  ];
}

Middleware<AppState> _viewPurchaseOrder() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewPurchaseOrder?;

    next(action);

    store.dispatch(UpdateCurrentRoute(PurchaseOrderViewScreen.route));

    if (store.state.prefState.isMobile) {
      await navigatorKey.currentState!.pushNamed(PurchaseOrderViewScreen.route);
    }
  };
}

Middleware<AppState> _viewPurchaseOrderList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewPurchaseOrderList?;

    next(action);

    if (store.state.isStale) {
      store.dispatch(RefreshData());
    }

    store.dispatch(UpdateCurrentRoute(PurchaseOrderScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          PurchaseOrderScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _editPurchaseOrder() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditPurchaseOrder?;

    next(action);

    store.dispatch(UpdateCurrentRoute(PurchaseOrderEditScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(PurchaseOrderEditScreen.route);
    }
  };
}

Middleware<AppState> _showEmailPurchaseOrder() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ShowEmailPurchaseOrder?;

    next(action);

    store.dispatch(UpdateCurrentRoute(PurchaseOrderEmailScreen.route));

    if (store.state.prefState.isMobile) {
      final emailWasSent = await navigatorKey.currentState!
          .pushNamed(PurchaseOrderEmailScreen.route);

      if (action!.completer != null &&
          emailWasSent != null &&
          emailWasSent as bool) {
        action.completer!.complete(null);
      }
    }
  };
}

Middleware<AppState> _showPdfPurchaseOrder() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ShowPdfPurchaseOrder?;

    next(action);

    store.dispatch(UpdateCurrentRoute(PurchaseOrderPdfScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(PurchaseOrderPdfScreen.route);
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
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchivePurchaseOrdersFailure(prevPurchaseOrders));
      action.completer.completeError(error);
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
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeletePurchaseOrdersFailure(prevPurchaseOrders));
      action.completer.completeError(error);
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
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestorePurchaseOrdersFailure(prevPurchaseOrders));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _approvePurchaseOrder(PurchaseOrderRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ApprovePurchaseOrders;
    repository
        .bulkAction(store.state.credentials, action.purchaseOrderIds,
            EntityAction.approve)
        .then((purchaseOrders) {
      store.dispatch(
          ApprovePurchaseOrderSuccess(purchaseOrders: purchaseOrders));
      store.dispatch(RefreshData());
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(ApprovePurchaseOrderFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _markSentPurchaseOrder(
    PurchaseOrderRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as MarkPurchaseOrdersSentRequest;
    repository
        .bulkAction(store.state.credentials, action.purchaseOrderIds,
            EntityAction.markSent)
        .then((purchaseOrders) {
      store.dispatch(MarkPurchaseOrderSentSuccess(purchaseOrders));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(MarkPurchaseOrderSentFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _convertPurchaseOrdersToExpense(
    PurchaseOrderRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ConvertPurchaseOrdersToExpensesRequest;
    repository
        .bulkAction(store.state.credentials, action.purchaseOrderIds,
            EntityAction.convertToExpense)
        .then((purchaseOrders) {
      store.dispatch(ConvertPurchaseOrdersToExpensesSuccess(purchaseOrders));
      store.dispatch(RefreshData());
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(ConvertPurchaseOrdersToExpensesFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _addPurchaseOrdersToInventory(
    PurchaseOrderRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as AddPurchaseOrdersToInventoryRequest;
    repository
        .bulkAction(store.state.credentials, action.purchaseOrderIds,
            EntityAction.addToInventory)
        .then((purchaseOrders) {
      store.dispatch(AddPurchaseOrdersToInventorySuccess(purchaseOrders));
      store.dispatch(RefreshData());
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(AddPurchaseOrdersToInventoryFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _acceptPurchaseOrders(PurchaseOrderRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as AcceptPurchaseOrdersRequest;
    repository
        .bulkAction(store.state.credentials, action.purchaseOrderIds,
            EntityAction.accept)
        .then((purchaseOrders) {
      store.dispatch(AcceptPurchaseOrderSuccess(purchaseOrders));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(AcceptPurchaseOrderFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _cancelPurchaseOrders(PurchaseOrderRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as CancelPurchaseOrdersRequest;
    repository
        .bulkAction(
            store.state.credentials, action.purchaseOrderIds, EntityAction.back)
        .then((purchaseOrders) {
      store.dispatch(CancelPurchaseOrderSuccess(purchaseOrders));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(CancelPurchaseOrderFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _emailPurchaseOrder(PurchaseOrderRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EmailPurchaseOrderRequest;
    final origPurchaseOrder =
        store.state.purchaseOrderState.map[action.purchaseOrderId]!;
    repository
        .emailPurchaseOrder(
      store.state.credentials,
      origPurchaseOrder,
      action.template,
      action.subject,
      action.body,
      action.ccEmail,
    )
        .then((purchaseOrder) {
      store.dispatch(EmailPurchaseOrderSuccess(purchaseOrder));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(EmailPurchaseOrderFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _savePurchaseOrder(PurchaseOrderRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SavePurchaseOrderRequest;

    // remove any empty line items
    final updatedPurchaseOrder = action.purchaseOrder.rebuild((b) => b
      ..lineItems.replace(
          action.purchaseOrder.lineItems.where((item) => !item.isEmpty)));

    repository
        .saveData(
      store.state.credentials,
      updatedPurchaseOrder,
      action.action,
    )
        .then((InvoiceEntity purchaseOrder) {
      if (action.purchaseOrder.isNew) {
        store.dispatch(AddPurchaseOrderSuccess(purchaseOrder));
      } else {
        store.dispatch(SavePurchaseOrderSuccess(purchaseOrder));
      }
      if (action.action == EntityAction.convertToInvoice) {
        store.dispatch(RefreshData());
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

    store.dispatch(LoadPurchaseOrderRequest());
    repository
        .loadItem(store.state.credentials, action.purchaseOrderId)
        .then((purchaseOrder) {
      store.dispatch(LoadPurchaseOrderSuccess(purchaseOrder));

      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadPurchaseOrderFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _downloadPurchaseOrders(
    PurchaseOrderRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DownloadPurchaseOrdersRequest;
    repository
        .bulkAction(store.state.credentials, action.invoiceIds,
            EntityAction.bulkDownload)
        .then((invoices) {
      store.dispatch(DownloadPurchaseOrdersSuccess());
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(DownloadPurchaseOrdersFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _bulkEmailPurchaseOrders(
    PurchaseOrderRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as BulkEmailPurchaseOrdersRequest;

    repository
        .bulkAction(store.state.credentials, action.purchaseOrderIds!,
            EntityAction.sendEmail)
        .then((List<InvoiceEntity> purchaseOrders) {
      store.dispatch(BulkEmailPurchaseOrdersSuccess(purchaseOrders));
      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(BulkEmailPurchaseOrdersFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadPurchaseOrders(PurchaseOrderRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadPurchaseOrders;
    final state = store.state;

    store.dispatch(LoadPurchaseOrdersRequest());
    repository
        .loadList(
      state.credentials,
      action.page,
      state.createdAtLimit,
      //state.filterDeletedClients,
    )
        .then((data) {
      store.dispatch(LoadPurchaseOrdersSuccess(data));

      final documents = <DocumentEntity>[];
      data.forEach((purchaseOrder) {
        purchaseOrder.documents.forEach((document) {
          documents.add(document.rebuild((b) => b
            ..parentId = purchaseOrder.id
            ..parentType = EntityType.purchaseOrder));
        });
      });
      store.dispatch(LoadDocumentsSuccess(documents));

      if (data.length == kMaxRecordsPerPage) {
        store.dispatch(LoadPurchaseOrders(
          completer: action.completer,
          page: action.page + 1,
        ));
      } else {
        if (action.completer != null) {
          action.completer!.complete(null);
        }
        store.dispatch(LoadExpenses());
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadPurchaseOrdersFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _saveDocument(PurchaseOrderRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SavePurchaseOrderDocumentRequest?;
    if (store.state.isEnterprisePlan) {
      repository
          .uploadDocument(
        store.state.credentials,
        action!.purchaseOrder,
        action.multipartFiles,
        action.isPrivate!,
      )
          .then((purchaseOrder) {
        store.dispatch(SavePurchaseOrderSuccess(purchaseOrder));

        final documents = <DocumentEntity>[];
        purchaseOrder.documents.forEach((document) {
          documents.add(document.rebuild((b) => b
            ..parentId = purchaseOrder.id
            ..parentType = EntityType.purchaseOrder));
        });
        store.dispatch(LoadDocumentsSuccess(documents));
        action.completer.complete(documents);
      }).catchError((Object error) {
        print(error);
        store.dispatch(SavePurchaseOrderDocumentFailure(error));
        action.completer.completeError(error);
      });
    } else {
      const error = 'Uploading documents requires an enterprise plan';
      store.dispatch(SavePurchaseOrderDocumentFailure(error));
      action!.completer.completeError(error);
    }

    next(action);
  };
}
