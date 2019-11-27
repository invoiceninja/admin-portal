import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_middleware.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_email_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_screen.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/repositories/invoice_repository.dart';

List<Middleware<AppState>> createStoreInvoicesMiddleware([
  InvoiceRepository repository = const InvoiceRepository(),
]) {
  final viewInvoiceList = _viewInvoiceList();
  final viewInvoice = _viewInvoice();
  final editInvoice = _editInvoice();
  final showEmailInvoice = _showEmailInvoice();
  final loadInvoices = _loadInvoices(repository);
  final loadInvoice = _loadInvoice(repository);
  final saveInvoice = _saveInvoice(repository);
  final archiveInvoice = _archiveInvoice(repository);
  final deleteInvoice = _deleteInvoice(repository);
  final restoreInvoice = _restoreInvoice(repository);
  final emailInvoice = _emailInvoice(repository);
  final markInvoiceSent = _markInvoiceSent(repository);
  final markInvoicePaid = _markInvoicePaid(repository);

  return [
    TypedMiddleware<AppState, ViewInvoiceList>(viewInvoiceList),
    TypedMiddleware<AppState, ViewInvoice>(viewInvoice),
    TypedMiddleware<AppState, EditInvoice>(editInvoice),
    TypedMiddleware<AppState, ShowEmailInvoice>(showEmailInvoice),
    TypedMiddleware<AppState, LoadInvoices>(loadInvoices),
    TypedMiddleware<AppState, LoadInvoice>(loadInvoice),
    TypedMiddleware<AppState, SaveInvoiceRequest>(saveInvoice),
    TypedMiddleware<AppState, ArchiveInvoiceRequest>(archiveInvoice),
    TypedMiddleware<AppState, DeleteInvoiceRequest>(deleteInvoice),
    TypedMiddleware<AppState, RestoreInvoiceRequest>(restoreInvoice),
    TypedMiddleware<AppState, EmailInvoiceRequest>(emailInvoice),
    TypedMiddleware<AppState, MarkInvoicesSentRequest>(markInvoiceSent),
    TypedMiddleware<AppState, MarkInvoicesPaidRequest>(markInvoicePaid),
  ];
}

Middleware<AppState> _viewInvoiceList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewInvoiceList;

    if (!action.force &&
        hasChanges(store: store, context: action.context, action: action)) {
      return;
    }

    next(action);

    if (store.state.invoiceState.isStale) {
      store.dispatch(LoadInvoices());
    }

    store.dispatch(UpdateCurrentRoute(InvoiceScreen.route));

    if (isMobile(action.context)) {
      action.navigator.pushNamedAndRemoveUntil(
          InvoiceScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _viewInvoice() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewInvoice;

    if (!action.force &&
        hasChanges(store: store, context: action.context, action: action)) {
      return;
    }

    next(action);

    store.dispatch(UpdateCurrentRoute(InvoiceViewScreen.route));

    if (isMobile(action.context)) {
      await action.navigator.pushNamed(InvoiceViewScreen.route);
    }
  };
}

Middleware<AppState> _editInvoice() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditInvoice;

    if (!action.force &&
        hasChanges(store: store, context: action.context, action: action)) {
      return;
    }

    next(action);

    store.dispatch(UpdateCurrentRoute(InvoiceEditScreen.route));

    if (isMobile(action.context)) {
      action.navigator.pushNamed(InvoiceEditScreen.route);
    }
  };
}

Middleware<AppState> _showEmailInvoice() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ShowEmailInvoice;

    next(action);

    store.dispatch(UpdateCurrentRoute(InvoiceEmailScreen.route));

    if (isMobile(action.context)) {
      final emailWasSent =
      await Navigator.of(action.context).pushNamed(InvoiceEmailScreen.route);

      if (action.completer != null && emailWasSent != null && emailWasSent) {
        action.completer.complete(null);
      }
    }
  };
}

Middleware<AppState> _archiveInvoice(InvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ArchiveInvoiceRequest;
    final prevInvoices = action.invoiceIds
        .map((id) => store.state.invoiceState.map[id])
        .toList();
    repository
        .bulkAction(
            store.state.credentials, action.invoiceIds, EntityAction.archive)
        .then((List<InvoiceEntity> invoices) {
      store.dispatch(ArchiveInvoiceSuccess(invoices));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveInvoiceFailure(prevInvoices));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _deleteInvoice(InvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DeleteInvoiceRequest;
    final prevInvoices = action.invoiceIds
        .map((id) => store.state.invoiceState.map[id])
        .toList();
    repository
        .bulkAction(
            store.state.credentials, action.invoiceIds, EntityAction.delete)
        .then((List<InvoiceEntity> invoices) {
      store.dispatch(DeleteInvoiceSuccess(invoices));
      store.dispatch(LoadClient(clientId: invoices.first.clientId));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteInvoiceFailure(prevInvoices));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _restoreInvoice(InvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RestoreInvoiceRequest;
    final prevInvoices = action.invoiceIds
        .map((id) => store.state.invoiceState.map[id])
        .toList();
    repository
        .bulkAction(
            store.state.credentials, action.invoiceIds, EntityAction.restore)
        .then((List<InvoiceEntity> invoices) {
      store.dispatch(RestoreInvoiceSuccess(invoices));
      store.dispatch(LoadClient(clientId: invoices.first.clientId));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreInvoiceFailure(prevInvoices));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _markInvoiceSent(InvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as MarkInvoicesSentRequest;
    repository
        .bulkAction(
            store.state.credentials, action.invoiceIds, EntityAction.markSent)
        .then((invoices) {
      store.dispatch(MarkInvoicesSentSuccess(invoices));
      store.dispatch(LoadClient(clientId: invoices.first.clientId));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(MarkInvoicesSentFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _markInvoicePaid(InvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as MarkInvoicesPaidRequest;
    repository
        .bulkAction(
            store.state.credentials, action.invoiceIds, EntityAction.markSent)
        .then((invoices) {
      store.dispatch(MarkInvoicesSentSuccess(invoices));
      store.dispatch(LoadClient(clientId: invoices.first.clientId));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(MarkInvoicesSentFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _emailInvoice(InvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EmailInvoiceRequest;
    final origInvoice = store.state.invoiceState.map[action.invoiceId];
    repository
        .emailInvoice(store.state.credentials, origInvoice, action.template,
            action.subject, action.body)
        .then((void _) {
      store.dispatch(EmailInvoiceSuccess());
      store.dispatch(LoadClient(clientId: origInvoice.clientId));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(EmailInvoiceFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _saveInvoice(InvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveInvoiceRequest;
    repository
        .saveData(store.state.credentials, action.invoice)
        .then((InvoiceEntity invoice) {
      if (action.invoice.isNew) {
        store.dispatch(AddInvoiceSuccess(invoice));
      } else {
        store.dispatch(SaveInvoiceSuccess(invoice));
      }
      if (invoice.hasTasks) {
        store.dispatch(LoadTasks(force: true));
      } else if (invoice.hasExpenses) {
        store.dispatch(LoadExpenses(force: true));
      } else {
        // TODO add check if auto-update is enabled
        store.dispatch(LoadProducts(force: true));
      }
      action.completer.complete(invoice);
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveInvoiceFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _loadInvoice(InvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadInvoice;
    final AppState state = store.state;

    if (state.isLoading) {
      next(action);
      return;
    }

    store.dispatch(LoadInvoiceRequest());
    repository
        .loadItem(store.state.credentials, action.invoiceId)
        .then((invoice) {
      store.dispatch(LoadInvoiceSuccess(invoice));
      store.dispatch(LoadClient(clientId: invoice.clientId));

      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadInvoiceFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadInvoices(InvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadInvoices;
    final AppState state = store.state;

    if (!state.invoiceState.isStale && !action.force) {
      next(action);
      return;
    }

    if (state.isLoading) {
      next(action);
      return;
    }

    final int updatedAt = (state.invoiceState.lastUpdated / 1000).round();

    store.dispatch(LoadInvoicesRequest());
    repository.loadList(store.state.credentials, updatedAt).then((data) {
      store.dispatch(LoadInvoicesSuccess(data));
      if (action.completer != null) {
        action.completer.complete(null);
      }
      if (state.paymentState.isStale) {
        store.dispatch(LoadPayments());
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadInvoicesFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}
