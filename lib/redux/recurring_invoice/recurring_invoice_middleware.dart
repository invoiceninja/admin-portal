// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';

// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/repositories/recurring_invoice_repository.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/recurring_invoice/edit/recurring_invoice_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/recurring_invoice/recurring_invoice_pdf_vm.dart';
import 'package:invoiceninja_flutter/ui/recurring_invoice/recurring_invoice_screen.dart';
import 'package:invoiceninja_flutter/ui/recurring_invoice/view/recurring_invoice_view_vm.dart';

List<Middleware<AppState>> createStoreRecurringInvoicesMiddleware([
  RecurringInvoiceRepository repository = const RecurringInvoiceRepository(),
]) {
  final viewRecurringInvoiceList = _viewRecurringInvoiceList();
  final viewRecurringInvoice = _viewRecurringInvoice();
  final editRecurringInvoice = _editRecurringInvoice();
  final showPdfRecurringInvoice = _showPdfRecurringInvoice();
  final loadRecurringInvoices = _loadRecurringInvoices(repository);
  final loadRecurringInvoice = _loadRecurringInvoice(repository);
  final saveRecurringInvoice = _saveRecurringInvoice(repository);
  final archiveRecurringInvoice = _archiveRecurringInvoice(repository);
  final deleteRecurringInvoice = _deleteRecurringInvoice(repository);
  final restoreRecurringInvoice = _restoreRecurringInvoice(repository);
  final startRecurringInvoice = _startRecurringInvoice(repository);
  final stopRecurringInvoice = _stopRecurringInvoice(repository);
  final updatePricesRecurringInvoice =
      _updatePricesRecurringInvoice(repository);
  final increasePricesRecurringInvoice =
      _increasePricesRecurringInvoice(repository);
  final sendNowRecurringInvoice = _sendNowRecurringInvoice(repository);
  final saveDocument = _saveDocument(repository);

  return [
    TypedMiddleware<AppState, ViewRecurringInvoiceList>(
        viewRecurringInvoiceList),
    TypedMiddleware<AppState, ViewRecurringInvoice>(viewRecurringInvoice),
    TypedMiddleware<AppState, EditRecurringInvoice>(editRecurringInvoice),
    TypedMiddleware<AppState, LoadRecurringInvoices>(loadRecurringInvoices),
    TypedMiddleware<AppState, LoadRecurringInvoice>(loadRecurringInvoice),
    TypedMiddleware<AppState, ShowPdfRecurringInvoice>(showPdfRecurringInvoice),
    TypedMiddleware<AppState, SaveRecurringInvoiceRequest>(
        saveRecurringInvoice),
    TypedMiddleware<AppState, ArchiveRecurringInvoicesRequest>(
        archiveRecurringInvoice),
    TypedMiddleware<AppState, DeleteRecurringInvoicesRequest>(
        deleteRecurringInvoice),
    TypedMiddleware<AppState, RestoreRecurringInvoicesRequest>(
        restoreRecurringInvoice),
    TypedMiddleware<AppState, StartRecurringInvoicesRequest>(
        startRecurringInvoice),
    TypedMiddleware<AppState, StopRecurringInvoicesRequest>(
        stopRecurringInvoice),
    TypedMiddleware<AppState, UpdatePricesRecurringInvoicesRequest>(
        updatePricesRecurringInvoice),
    TypedMiddleware<AppState, IncreasePricesRecurringInvoicesRequest>(
        increasePricesRecurringInvoice),
    TypedMiddleware<AppState, SendNowRecurringInvoicesRequest>(
        sendNowRecurringInvoice),
    TypedMiddleware<AppState, SaveRecurringInvoiceDocumentRequest>(
        saveDocument),
  ];
}

Middleware<AppState> _editRecurringInvoice() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditRecurringInvoice?;

    next(action);

    store.dispatch(UpdateCurrentRoute(RecurringInvoiceEditScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(RecurringInvoiceEditScreen.route);
    }
  };
}

Middleware<AppState> _viewRecurringInvoice() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewRecurringInvoice?;

    next(action);

    store.dispatch(UpdateCurrentRoute(RecurringInvoiceViewScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(RecurringInvoiceViewScreen.route);
    }
  };
}

Middleware<AppState> _viewRecurringInvoiceList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewRecurringInvoiceList?;

    next(action);

    if (store.state.staticState.isStale) {
      store.dispatch(RefreshData());
    }

    store.dispatch(UpdateCurrentRoute(RecurringInvoiceScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          RecurringInvoiceScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _showPdfRecurringInvoice() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ShowPdfRecurringInvoice?;

    next(action);

    store.dispatch(UpdateCurrentRoute(RecurringInvoicePdfScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(RecurringInvoicePdfScreen.route);
    }
  };
}

Middleware<AppState> _startRecurringInvoice(
    RecurringInvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as StartRecurringInvoicesRequest;
    repository
        .bulkAction(
            store.state.credentials, action.invoiceIds!, EntityAction.start)
        .then((List<InvoiceEntity> invoices) {
      store.dispatch(StartRecurringInvoicesSuccess(invoices));
      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(StartRecurringInvoicesFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _stopRecurringInvoice(
    RecurringInvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as StopRecurringInvoicesRequest;
    repository
        .bulkAction(
            store.state.credentials, action.invoiceIds!, EntityAction.stop)
        .then((List<InvoiceEntity> invoices) {
      store.dispatch(StopRecurringInvoicesSuccess(invoices));
      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(StopRecurringInvoicesFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _updatePricesRecurringInvoice(
    RecurringInvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as UpdatePricesRecurringInvoicesRequest;
    repository
        .bulkAction(store.state.credentials, action.recurringInvoiceIds!,
            EntityAction.updatePrices)
        .then((List<InvoiceEntity> invoices) {
      store.dispatch(UpdatePricesRecurringInvoicesSuccess(invoices));
      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(
          UpdatePricesRecurringInvoicesFailure(error as List<InvoiceEntity>));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _increasePricesRecurringInvoice(
    RecurringInvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as IncreasePricesRecurringInvoicesRequest;
    repository.bulkAction(store.state.credentials, action.recurringInvoiceIds,
        EntityAction.increasePrices,
        data: {
          'percentage_increase': action.percentageIncrease,
        }).then((List<InvoiceEntity> invoices) {
      store.dispatch(IncreasePricesRecurringInvoicesSuccess(invoices));
      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(
          IncreasePricesRecurringInvoicesFailure(error as List<InvoiceEntity>));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _sendNowRecurringInvoice(
    RecurringInvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SendNowRecurringInvoicesRequest;
    repository
        .bulkAction(store.state.credentials, action.recurringInvoiceIds,
            EntityAction.sendNow)
        .then((List<InvoiceEntity> invoices) {
      store.dispatch(SendNowRecurringInvoicesSuccess(invoices));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(
          SendNowRecurringInvoicesFailure(error as List<InvoiceEntity>));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _archiveRecurringInvoice(
    RecurringInvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ArchiveRecurringInvoicesRequest;
    final prevRecurringInvoices = action.recurringInvoiceIds
        .map((id) => store.state.recurringInvoiceState.map[id])
        .toList();
    repository
        .bulkAction(store.state.credentials, action.recurringInvoiceIds,
            EntityAction.archive)
        .then((List<InvoiceEntity> recurringInvoices) {
      store.dispatch(ArchiveRecurringInvoicesSuccess(recurringInvoices));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveRecurringInvoicesFailure(prevRecurringInvoices));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _deleteRecurringInvoice(
    RecurringInvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DeleteRecurringInvoicesRequest;
    final prevRecurringInvoices = action.recurringInvoiceIds
        .map((id) => store.state.recurringInvoiceState.map[id])
        .toList();
    repository
        .bulkAction(store.state.credentials, action.recurringInvoiceIds,
            EntityAction.delete)
        .then((List<InvoiceEntity> recurringInvoices) {
      store.dispatch(DeleteRecurringInvoicesSuccess(recurringInvoices));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteRecurringInvoicesFailure(prevRecurringInvoices));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _restoreRecurringInvoice(
    RecurringInvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RestoreRecurringInvoicesRequest;
    final prevRecurringInvoices = action.recurringInvoiceIds
        .map((id) => store.state.recurringInvoiceState.map[id])
        .toList();
    repository
        .bulkAction(store.state.credentials, action.recurringInvoiceIds,
            EntityAction.restore)
        .then((List<InvoiceEntity> recurringInvoices) {
      store.dispatch(RestoreRecurringInvoicesSuccess(recurringInvoices));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreRecurringInvoicesFailure(prevRecurringInvoices));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _saveRecurringInvoice(
    RecurringInvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveRecurringInvoiceRequest;

    // remove any empty line items
    final updatedInvoice = action.recurringInvoice!.rebuild((b) => b
      ..lineItems.replace(
          action.recurringInvoice!.lineItems.where((item) => !item.isEmpty)));

    repository
        .saveData(store.state.credentials, updatedInvoice,
            action: action.action)
        .then((InvoiceEntity recurringInvoice) {
      if (action.recurringInvoice!.isNew) {
        store.dispatch(AddRecurringInvoiceSuccess(recurringInvoice));
      } else {
        store.dispatch(SaveRecurringInvoiceSuccess(recurringInvoice));
      }

      action.completer!.complete(recurringInvoice);
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveRecurringInvoiceFailure(error));
      action.completer!.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _loadRecurringInvoice(
    RecurringInvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadRecurringInvoice;
    final AppState state = store.state;

    store.dispatch(LoadRecurringInvoiceRequest());
    repository
        .loadItem(state.credentials, action.recurringInvoiceId)
        .then((recurringInvoice) {
      store.dispatch(LoadRecurringInvoiceSuccess(recurringInvoice));

      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadRecurringInvoiceFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadRecurringInvoices(
    RecurringInvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadRecurringInvoices;
    final AppState state = store.state;

    store.dispatch(LoadRecurringInvoicesRequest());
    repository
        .loadList(
      state.credentials,
      action.page,
      state.filterDeletedClients,
    )
        .then((data) {
      store.dispatch(LoadRecurringInvoicesSuccess(data));

      final documents = <DocumentEntity>[];
      data.forEach((client) {
        client.documents.forEach((invoice) {
          documents.add(invoice.rebuild((b) => b
            ..parentId = client.id
            ..parentType = EntityType.recurringInvoice));
        });
      });
      store.dispatch(LoadDocumentsSuccess(documents));

      if (data.length == kMaxRecordsPerPage) {
        store.dispatch(LoadRecurringInvoices(
          completer: action.completer,
          page: action.page + 1,
        ));
      } else {
        if (action.completer != null) {
          action.completer!.complete(null);
        }
        store.dispatch(LoadPayments());
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadRecurringInvoicesFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _saveDocument(RecurringInvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveRecurringInvoiceDocumentRequest?;
    if (store.state.isEnterprisePlan) {
      repository
          .uploadDocument(
        store.state.credentials,
        action!.invoice,
        action.multipartFiles,
        action.isPrivate,
      )
          .then((invoice) {
        store.dispatch(SaveRecurringInvoiceSuccess(invoice));

        final documents = <DocumentEntity>[];
        invoice.documents.forEach((document) {
          documents.add(document.rebuild((b) => b
            ..parentId = invoice.id
            ..parentType = EntityType.recurringInvoice));
        });
        store.dispatch(LoadDocumentsSuccess(documents));
        action.completer.complete(documents);
      }).catchError((Object error) {
        print(error);
        store.dispatch(SaveRecurringInvoiceDocumentFailure(error));
        action.completer.completeError(error);
      });
    } else {
      const error = 'Uploading documents requires an enterprise plan';
      store.dispatch(SaveRecurringInvoiceDocumentFailure(error));
      action!.completer.completeError(error);
    }

    next(action);
  };
}
