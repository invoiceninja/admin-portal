// Flutter imports:
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_actions.dart';

// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/repositories/invoice_repository.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_email_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_pdf_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_screen.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';

List<Middleware<AppState>> createStoreInvoicesMiddleware([
  InvoiceRepository repository = const InvoiceRepository(),
]) {
  final viewInvoiceList = _viewInvoiceList();
  final viewInvoice = _viewInvoice();
  final editInvoice = _editInvoice();
  final showEmailInvoice = _showEmailInvoice();
  final showPdfInvoice = _showPdfInvoice();
  final loadInvoices = _loadInvoices(repository);
  final loadInvoice = _loadInvoice(repository);
  final saveInvoice = _saveInvoice(repository);
  final archiveInvoice = _archiveInvoice(repository);
  final deleteInvoice = _deleteInvoice(repository);
  final restoreInvoice = _restoreInvoice(repository);
  final emailInvoice = _emailInvoice(repository);
  final autoBillInvoices = _autoBillInvoices(repository);
  final bulkEmailInvoices = _bulkEmailInvoices(repository);
  final markInvoiceSent = _markInvoiceSent(repository);
  final markInvoicePaid = _markInvoicePaid(repository);
  final cancelInvoices = _cancelInvoices(repository);
  final downloadInvoices = _downloadInvoices(repository);
  final saveDocument = _saveDocument(repository);

  return [
    TypedMiddleware<AppState, ViewInvoiceList>(viewInvoiceList),
    TypedMiddleware<AppState, ViewInvoice>(viewInvoice),
    TypedMiddleware<AppState, EditInvoice>(editInvoice),
    TypedMiddleware<AppState, ShowEmailInvoice>(showEmailInvoice),
    TypedMiddleware<AppState, ShowPdfInvoice>(showPdfInvoice),
    TypedMiddleware<AppState, LoadInvoices>(loadInvoices),
    TypedMiddleware<AppState, LoadInvoice>(loadInvoice),
    TypedMiddleware<AppState, SaveInvoiceRequest>(saveInvoice),
    TypedMiddleware<AppState, ArchiveInvoicesRequest>(archiveInvoice),
    TypedMiddleware<AppState, DeleteInvoicesRequest>(deleteInvoice),
    TypedMiddleware<AppState, RestoreInvoicesRequest>(restoreInvoice),
    TypedMiddleware<AppState, EmailInvoiceRequest>(emailInvoice),
    TypedMiddleware<AppState, BulkEmailInvoicesRequest>(bulkEmailInvoices),
    TypedMiddleware<AppState, AutoBillInvoicesRequest>(autoBillInvoices),
    TypedMiddleware<AppState, MarkInvoicesSentRequest>(markInvoiceSent),
    TypedMiddleware<AppState, MarkInvoicesPaidRequest>(markInvoicePaid),
    TypedMiddleware<AppState, CancelInvoicesRequest>(cancelInvoices),
    TypedMiddleware<AppState, DownloadInvoicesRequest>(downloadInvoices),
    TypedMiddleware<AppState, SaveInvoiceDocumentRequest>(saveDocument),
  ];
}

Middleware<AppState> _viewInvoiceList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewInvoiceList?;

    next(action);

    if (store.state.isStale) {
      store.dispatch(RefreshData());
    }

    store.dispatch(UpdateCurrentRoute(InvoiceScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          InvoiceScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _viewInvoice() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewInvoice?;

    next(action);

    store.dispatch(UpdateCurrentRoute(InvoiceViewScreen.route));

    if (store.state.prefState.isMobile) {
      await navigatorKey.currentState!.pushNamed(InvoiceViewScreen.route);
    }
  };
}

Middleware<AppState> _editInvoice() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditInvoice?;

    next(action);

    store.dispatch(UpdateCurrentRoute(InvoiceEditScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(InvoiceEditScreen.route);
    }
  };
}

Middleware<AppState> _showEmailInvoice() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ShowEmailInvoice?;

    next(action);

    store.dispatch(UpdateCurrentRoute(InvoiceEmailScreen.route));

    if (store.state.prefState.isMobile) {
      final emailWasSent =
          await navigatorKey.currentState!.pushNamed(InvoiceEmailScreen.route);

      if (action!.completer != null &&
          emailWasSent != null &&
          emailWasSent as bool) {
        action.completer!.complete(null);
      }
    }
  };
}

Middleware<AppState> _showPdfInvoice() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ShowPdfInvoice?;

    next(action);

    store.dispatch(UpdateCurrentRoute(InvoicePdfScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(InvoicePdfScreen.route);
    }
  };
}

Middleware<AppState> _cancelInvoices(InvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as CancelInvoicesRequest;
    repository
        .bulkAction(store.state.credentials, action.invoiceIds,
            EntityAction.cancelInvoice)
        .then((List<InvoiceEntity> invoices) {
      store.dispatch(CancelInvoicesSuccess(invoices));
      store.dispatch(RefreshData());
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(CancelInvoicesFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _archiveInvoice(InvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ArchiveInvoicesRequest;
    final prevInvoices = action.invoiceIds
        .map((id) => store.state.invoiceState.map[id])
        .toList();
    repository
        .bulkAction(
            store.state.credentials, action.invoiceIds, EntityAction.archive)
        .then((List<InvoiceEntity> invoices) {
      store.dispatch(ArchiveInvoicesSuccess(invoices));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveInvoicesFailure(prevInvoices));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _deleteInvoice(InvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DeleteInvoicesRequest;
    final prevInvoices = action.invoiceIds
        .map((id) => store.state.invoiceState.map[id])
        .toList();
    repository
        .bulkAction(
            store.state.credentials, action.invoiceIds, EntityAction.delete)
        .then((List<InvoiceEntity> invoices) {
      store.dispatch(DeleteInvoicesSuccess(invoices));
      store.dispatch(RefreshData());
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteInvoicesFailure(prevInvoices));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _restoreInvoice(InvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RestoreInvoicesRequest;
    final prevInvoices = action.invoiceIds
        .map((id) => store.state.invoiceState.map[id])
        .toList();
    repository
        .bulkAction(
            store.state.credentials, action.invoiceIds, EntityAction.restore)
        .then((List<InvoiceEntity> invoices) {
      store.dispatch(RestoreInvoicesSuccess(invoices));
      store.dispatch(RefreshData());
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreInvoicesFailure(prevInvoices));
      action.completer.completeError(error);
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
      store.dispatch(RefreshData());
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(MarkInvoicesSentFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _autoBillInvoices(InvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as AutoBillInvoicesRequest;
    repository
        .bulkAction(
            store.state.credentials, action.invoiceIds, EntityAction.autoBill)
        .then((invoices) {
      store.dispatch(AutoBillInvoicesSuccess(invoices));
      store.dispatch(RefreshData());
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(AutoBillInvoicesFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _markInvoicePaid(InvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as MarkInvoicesPaidRequest;
    repository
        .bulkAction(
            store.state.credentials, action.invoiceIds, EntityAction.markPaid)
        .then((invoices) {
      store.dispatch(MarkInvoicesPaidSuccess(invoices));
      store.dispatch(RefreshData());
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(MarkInvoicesPaidFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _downloadInvoices(InvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DownloadInvoicesRequest;
    repository
        .bulkAction(store.state.credentials, action.invoiceIds,
            EntityAction.bulkDownload)
        .then((invoices) {
      store.dispatch(DownloadInvoicesSuccess());
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(DownloadInvoicesFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _emailInvoice(InvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EmailInvoiceRequest;
    final origInvoice = store.state.invoiceState.map[action.invoiceId]!;
    repository
        .emailInvoice(
      store.state.credentials,
      origInvoice,
      action.template,
      action.subject,
      action.body,
      action.ccEmail,
    )
        .then((InvoiceEntity invoice) {
      store.dispatch(EmailInvoiceSuccess(invoice: invoice));
      store.dispatch(RefreshData());
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(EmailInvoiceFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _bulkEmailInvoices(InvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as BulkEmailInvoicesRequest;

    repository
        .bulkAction(
      store.state.credentials,
      action.invoiceIds!,
      EntityAction.sendEmail,
      template: action.template,
    )
        .then((List<InvoiceEntity> invoices) {
      store.dispatch(BulkEmailInvoicesSuccess(invoices));
      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(BulkEmailInvoicesFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _saveInvoice(InvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveInvoiceRequest;

    // remove any empty line items
    final updatedInvoice = action.invoice.rebuild((b) => b
      ..lineItems
          .replace(action.invoice.lineItems.where((item) => !item.isEmpty)));

    repository
        .saveData(
      store.state.credentials,
      updatedInvoice,
      action: action.entityAction,
    )
        .then((InvoiceEntity invoice) {
      if (action.invoice.isNew) {
        store.dispatch(AddInvoiceSuccess(invoice));
      } else {
        store.dispatch(SaveInvoiceSuccess(invoice));
      }
      store.dispatch(RefreshData());
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

    store.dispatch(LoadInvoiceRequest());
    repository
        .loadItem(store.state.credentials, action.invoiceId)
        .then((invoice) {
      store.dispatch(LoadInvoiceSuccess(invoice));

      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadInvoiceFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadInvoices(InvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadInvoices;
    final state = store.state;

    store.dispatch(LoadInvoicesRequest());

    repository
        .loadList(
      state.credentials,
      action.page,
      state.createdAtLimit,
      state.filterDeletedClients,
    )
        .then((data) {
      store.dispatch(LoadInvoicesSuccess(data));

      final documents = <DocumentEntity>[];
      data.forEach((invoice) {
        invoice.documents.forEach((document) {
          documents.add(document.rebuild((b) => b
            ..parentId = invoice.id
            ..parentType = EntityType.invoice));
        });
      });
      store.dispatch(LoadDocumentsSuccess(documents));

      if (data.length == kMaxRecordsPerPage) {
        store.dispatch(LoadInvoices(
          completer: action.completer,
          page: action.page + 1,
        ));
      } else {
        if (action.completer != null) {
          action.completer!.complete(null);
        }
        store.dispatch(LoadRecurringInvoices());
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadInvoicesFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _saveDocument(InvoiceRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveInvoiceDocumentRequest?;
    if (store.state.isEnterprisePlan) {
      repository
          .uploadDocuments(
        store.state.credentials,
        action!.invoice,
        action.multipartFiles,
        action.isPrivate!,
      )
          .then((invoice) {
        store.dispatch(SaveInvoiceSuccess(invoice));

        final documents = <DocumentEntity>[];
        invoice.documents.forEach((document) {
          documents.add(document.rebuild((b) => b
            ..parentId = invoice.id
            ..parentType = EntityType.invoice));
        });
        store.dispatch(LoadDocumentsSuccess(documents));
        action.completer.complete(documents);
      }).catchError((Object error) {
        print(error);
        store.dispatch(SaveInvoiceDocumentFailure(error));
        action.completer.completeError(error);
      });
    } else {
      const error = 'Uploading documents requires an enterprise plan';
      store.dispatch(SaveInvoiceDocumentFailure(error));
      action!.completer.completeError(error);
    }

    next(action);
  };
}
