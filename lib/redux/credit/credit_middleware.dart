// Flutter imports:
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';

// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/repositories/credit_repository.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/credit/credit_email_vm.dart';
import 'package:invoiceninja_flutter/ui/credit/credit_pdf_vm.dart';
import 'package:invoiceninja_flutter/ui/credit/credit_screen.dart';
import 'package:invoiceninja_flutter/ui/credit/edit/credit_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/credit/view/credit_view_vm.dart';

List<Middleware<AppState>> createStoreCreditsMiddleware([
  CreditRepository repository = const CreditRepository(),
]) {
  final viewCreditList = _viewCreditList();
  final viewCredit = _viewCredit();
  final editCredit = _editCredit();
  final showEmailCredit = _showEmailCredit();
  final showPdfCredit = _showPdfCredit();
  final loadCredits = _loadCredits(repository);
  final loadCredit = _loadCredit(repository);
  final saveCredit = _saveCredit(repository);
  final archiveCredit = _archiveCredit(repository);
  final deleteCredit = _deleteCredit(repository);
  final restoreCredit = _restoreCredit(repository);
  final emailCredit = _emailCredit(repository);
  final bulkEmailCredits = _bulkEmailCredits(repository);
  final markPaidCredit = _markPaidCredit(repository);
  final markSentCredit = _markSentCredit(repository);
  final downloadCredits = _downloadCredits(repository);
  final saveDocument = _saveDocument(repository);

  return [
    TypedMiddleware<AppState, ViewCreditList>(viewCreditList),
    TypedMiddleware<AppState, ViewCredit>(viewCredit),
    TypedMiddleware<AppState, EditCredit>(editCredit),
    TypedMiddleware<AppState, ShowEmailCredit>(showEmailCredit),
    TypedMiddleware<AppState, ShowPdfCredit>(showPdfCredit),
    TypedMiddleware<AppState, LoadCredits>(loadCredits),
    TypedMiddleware<AppState, LoadCredit>(loadCredit),
    TypedMiddleware<AppState, SaveCreditRequest>(saveCredit),
    TypedMiddleware<AppState, ArchiveCreditsRequest>(archiveCredit),
    TypedMiddleware<AppState, DeleteCreditsRequest>(deleteCredit),
    TypedMiddleware<AppState, RestoreCreditsRequest>(restoreCredit),
    TypedMiddleware<AppState, EmailCreditRequest>(emailCredit),
    TypedMiddleware<AppState, BulkEmailCreditsRequest>(bulkEmailCredits),
    TypedMiddleware<AppState, MarkSentCreditRequest>(markSentCredit),
    TypedMiddleware<AppState, MarkCreditsPaidRequest>(markPaidCredit),
    TypedMiddleware<AppState, DownloadCreditsRequest>(downloadCredits),
    TypedMiddleware<AppState, SaveCreditDocumentRequest>(saveDocument),
  ];
}

Middleware<AppState> _viewCredit() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewCredit?;

    next(action);

    store.dispatch(UpdateCurrentRoute(CreditViewScreen.route));

    if (store.state.prefState.isMobile) {
      await navigatorKey.currentState!.pushNamed(CreditViewScreen.route);
    }
  };
}

Middleware<AppState> _viewCreditList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewCreditList?;

    next(action);

    if (store.state.isStale) {
      store.dispatch(RefreshData());
    }

    store.dispatch(UpdateCurrentRoute(CreditScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          CreditScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _editCredit() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditCredit?;

    next(action);

    store.dispatch(UpdateCurrentRoute(CreditEditScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(CreditEditScreen.route);
    }
  };
}

Middleware<AppState> _showEmailCredit() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ShowEmailCredit?;

    next(action);

    store.dispatch(UpdateCurrentRoute(CreditEmailScreen.route));

    if (store.state.prefState.isMobile) {
      final emailWasSent =
          await navigatorKey.currentState!.pushNamed(CreditEmailScreen.route);

      if (action!.completer != null &&
          emailWasSent != null &&
          emailWasSent as bool) {
        action.completer!.complete(null);
      }
    }
  };
}

Middleware<AppState> _showPdfCredit() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ShowPdfCredit?;

    next(action);

    store.dispatch(UpdateCurrentRoute(CreditPdfScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(CreditPdfScreen.route);
    }
  };
}

Middleware<AppState> _archiveCredit(CreditRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ArchiveCreditsRequest;
    final prevCredits =
        action.creditIds.map((id) => store.state.creditState.map[id]).toList();
    repository
        .bulkAction(
            store.state.credentials, action.creditIds, EntityAction.archive)
        .then((List<InvoiceEntity> credits) {
      store.dispatch(ArchiveCreditsSuccess(credits));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveCreditsFailure(prevCredits));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _deleteCredit(CreditRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DeleteCreditsRequest;
    final prevCredits =
        action.creditIds.map((id) => store.state.creditState.map[id]).toList();

    repository
        .bulkAction(
            store.state.credentials, action.creditIds, EntityAction.delete)
        .then((List<InvoiceEntity> credits) {
      store.dispatch(DeleteCreditsSuccess(credits));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteCreditsFailure(prevCredits));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _restoreCredit(CreditRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RestoreCreditsRequest;
    final prevCredits =
        action.creditIds.map((id) => store.state.creditState.map[id]).toList();

    repository
        .bulkAction(
            store.state.credentials, action.creditIds, EntityAction.restore)
        .then((List<InvoiceEntity> credits) {
      store.dispatch(RestoreCreditsSuccess(credits));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreCreditsFailure(prevCredits));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _markSentCredit(CreditRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as MarkSentCreditRequest;
    repository
        .bulkAction(
            store.state.credentials, action.creditIds, EntityAction.markSent)
        .then((credits) {
      store.dispatch(MarkSentCreditSuccess(credits));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(MarkSentCreditFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _markPaidCredit(CreditRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as MarkCreditsPaidRequest;
    repository
        .bulkAction(
            store.state.credentials, action.invoiceIds, EntityAction.markPaid)
        .then((invoices) {
      store.dispatch(MarkCreditsPaidSuccess(invoices));
      store.dispatch(RefreshData());
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(MarkCreditsPaidFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _emailCredit(CreditRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EmailCreditRequest;
    final origCredit = store.state.creditState.map[action.creditId]!;
    repository
        .emailCredit(
      store.state.credentials,
      origCredit,
      action.template,
      action.subject,
      action.body,
      action.ccEmail,
    )
        .then((void _) {
      store.dispatch(EmailCreditSuccess());
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(EmailCreditFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _saveCredit(CreditRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveCreditRequest;

    // remove any empty line items
    final updatedCredit = action.credit.rebuild((b) => b
      ..lineItems
          .replace(action.credit.lineItems.where((item) => !item.isEmpty)));

    repository
        .saveData(store.state.credentials, updatedCredit, action.action)
        .then((InvoiceEntity credit) {
      if (action.credit.isNew) {
        store.dispatch(AddCreditSuccess(credit));
      } else {
        store.dispatch(SaveCreditSuccess(credit));
      }
      action.completer.complete(credit);
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveCreditFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _loadCredit(CreditRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadCredit;

    store.dispatch(LoadCreditRequest());
    repository
        .loadItem(store.state.credentials, action.creditId)
        .then((credit) {
      store.dispatch(LoadCreditSuccess(credit));

      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadCreditFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadCredits(CreditRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadCredits?;
    final state = store.state;

    store.dispatch(LoadCreditsRequest());
    repository
        .loadList(
            state.credentials, state.createdAtLimit, state.filterDeletedClients)
        .then((data) {
      store.dispatch(LoadCreditsSuccess(data));

      final documents = <DocumentEntity>[];
      data.forEach((credit) {
        credit.documents.forEach((document) {
          documents.add(document.rebuild((b) => b
            ..parentId = credit.id
            ..parentType = EntityType.credit));
        });
      });
      store.dispatch(LoadDocumentsSuccess(documents));

      if (action!.completer != null) {
        action.completer!.complete(documents.firstOrNull);
      }
      store.dispatch(LoadProjects());
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadCreditsFailure(error));
      if (action!.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _downloadCredits(CreditRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DownloadCreditsRequest;
    repository
        .bulkAction(store.state.credentials, action.creditIds,
            EntityAction.bulkDownload)
        .then((invoices) {
      store.dispatch(DownloadCreditsSuccess());
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(DownloadCreditsFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _bulkEmailCredits(CreditRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as BulkEmailCreditsRequest;

    repository
        .bulkAction(
            store.state.credentials, action.creditIds!, EntityAction.sendEmail)
        .then((List<InvoiceEntity> credits) {
      store.dispatch(BulkEmailCreditsSuccess(credits));
      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(BulkEmailCreditsFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _saveDocument(CreditRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveCreditDocumentRequest?;
    if (store.state.isEnterprisePlan) {
      repository
          .uploadDocuments(
        store.state.credentials,
        action!.credit,
        action.multipartFiles,
        action.isPrivate!,
      )
          .then((credit) {
        store.dispatch(SaveCreditSuccess(credit));

        final documents = <DocumentEntity>[];
        credit.documents.forEach((document) {
          documents.add(document.rebuild((b) => b
            ..parentId = credit.id
            ..parentType = EntityType.credit));
        });
        store.dispatch(LoadDocumentsSuccess(documents));
        action.completer.complete(documents);
      }).catchError((Object error) {
        print(error);
        store.dispatch(SaveCreditDocumentFailure(error));
        action.completer.completeError(error);
      });
    } else {
      const error = 'Uploading documents requires an enterprise plan';
      store.dispatch(SaveCreditDocumentFailure(error));
      action!.completer.completeError(error);
    }

    next(action);
  };
}
