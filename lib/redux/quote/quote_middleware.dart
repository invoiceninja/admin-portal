// Flutter imports:
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';

// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/repositories/quote_repository.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/quote/edit/quote_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/quote/quote_email_vm.dart';
import 'package:invoiceninja_flutter/ui/quote/quote_pdf_vm.dart';
import 'package:invoiceninja_flutter/ui/quote/quote_screen.dart';
import 'package:invoiceninja_flutter/ui/quote/view/quote_view_vm.dart';

List<Middleware<AppState>> createStoreQuotesMiddleware([
  QuoteRepository repository = const QuoteRepository(),
]) {
  final viewQuoteList = _viewQuoteList();
  final viewQuote = _viewQuote();
  final editQuote = _editQuote();
  final showEmailQuote = _showEmailQuote();
  final showPdfQuote = _showPdfQuote();
  final convertQuotesToInvoices = _convertQuotesToInvoices(repository);
  final convertQuotesToProjects = _convertQuotesToProjects(repository);
  final approveQuote = _approveQuote(repository);
  final loadQuotes = _loadQuotes(repository);
  final loadQuote = _loadQuote(repository);
  final saveQuote = _saveQuote(repository);
  final archiveQuote = _archiveQuote(repository);
  final deleteQuote = _deleteQuote(repository);
  final restoreQuote = _restoreQuote(repository);
  final emailQuote = _emailQuote(repository);
  final bulkEmailQuotes = _bulkEmailQuotes(repository);
  final markSentQuote = _markSentQuote(repository);
  final downloadQuotes = _downloadQuotes(repository);
  final saveDocument = _saveDocument(repository);

  return [
    TypedMiddleware<AppState, ViewQuoteList>(viewQuoteList),
    TypedMiddleware<AppState, ViewQuote>(viewQuote),
    TypedMiddleware<AppState, EditQuote>(editQuote),
    TypedMiddleware<AppState, ConvertQuotesToInvoices>(convertQuotesToInvoices),
    TypedMiddleware<AppState, ConvertQuotesToProjects>(convertQuotesToProjects),
    TypedMiddleware<AppState, ApproveQuotes>(approveQuote),
    TypedMiddleware<AppState, ShowEmailQuote>(showEmailQuote),
    TypedMiddleware<AppState, ShowPdfQuote>(showPdfQuote),
    TypedMiddleware<AppState, LoadQuotes>(loadQuotes),
    TypedMiddleware<AppState, LoadQuote>(loadQuote),
    TypedMiddleware<AppState, SaveQuoteRequest>(saveQuote),
    TypedMiddleware<AppState, ArchiveQuotesRequest>(archiveQuote),
    TypedMiddleware<AppState, DeleteQuotesRequest>(deleteQuote),
    TypedMiddleware<AppState, RestoreQuotesRequest>(restoreQuote),
    TypedMiddleware<AppState, EmailQuoteRequest>(emailQuote),
    TypedMiddleware<AppState, BulkEmailQuotesRequest>(bulkEmailQuotes),
    TypedMiddleware<AppState, MarkSentQuotesRequest>(markSentQuote),
    TypedMiddleware<AppState, DownloadQuotesRequest>(downloadQuotes),
    TypedMiddleware<AppState, SaveQuoteDocumentRequest>(saveDocument),
  ];
}

Middleware<AppState> _viewQuote() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewQuote?;

    next(action);

    store.dispatch(UpdateCurrentRoute(QuoteViewScreen.route));

    if (store.state.prefState.isMobile) {
      await navigatorKey.currentState!.pushNamed(QuoteViewScreen.route);
    }
  };
}

Middleware<AppState> _viewQuoteList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewQuoteList?;

    next(action);

    if (store.state.isStale) {
      store.dispatch(RefreshData());
    }

    store.dispatch(UpdateCurrentRoute(QuoteScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          QuoteScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _editQuote() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditQuote?;

    next(action);

    store.dispatch(UpdateCurrentRoute(QuoteEditScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(QuoteEditScreen.route);
    }
  };
}

Middleware<AppState> _showEmailQuote() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ShowEmailQuote?;

    next(action);

    store.dispatch(UpdateCurrentRoute(QuoteEmailScreen.route));

    if (store.state.prefState.isMobile) {
      final emailWasSent =
          await navigatorKey.currentState!.pushNamed(QuoteEmailScreen.route);

      if (action!.completer != null &&
          emailWasSent != null &&
          emailWasSent as bool) {
        action.completer!.complete(null);
      }
    }
  };
}

Middleware<AppState> _showPdfQuote() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ShowPdfQuote?;

    next(action);

    store.dispatch(UpdateCurrentRoute(QuotePdfScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(QuotePdfScreen.route);
    }
  };
}

Middleware<AppState> _archiveQuote(QuoteRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ArchiveQuotesRequest;
    final prevQuotes =
        action.quoteIds.map((id) => store.state.quoteState.map[id]).toList();
    repository
        .bulkAction(
            store.state.credentials, action.quoteIds, EntityAction.archive)
        .then((List<InvoiceEntity> quotes) {
      store.dispatch(ArchiveQuotesSuccess(quotes));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveQuotesFailure(prevQuotes));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _deleteQuote(QuoteRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DeleteQuotesRequest;
    final prevQuotes =
        action.quoteIds.map((id) => store.state.quoteState.map[id]).toList();

    repository
        .bulkAction(
            store.state.credentials, action.quoteIds, EntityAction.delete)
        .then((List<InvoiceEntity> quotes) {
      store.dispatch(DeleteQuotesSuccess(quotes));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteQuotesFailure(prevQuotes));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _restoreQuote(QuoteRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RestoreQuotesRequest;
    final prevQuotes =
        action.quoteIds.map((id) => store.state.quoteState.map[id]).toList();

    repository
        .bulkAction(
            store.state.credentials, action.quoteIds, EntityAction.restore)
        .then((List<InvoiceEntity> quotes) {
      store.dispatch(RestoreQuotesSuccess(quotes));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreQuotesFailure(prevQuotes));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _convertQuotesToInvoices(QuoteRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ConvertQuotesToInvoices;
    repository
        .bulkAction(store.state.credentials, action.quoteIds,
            EntityAction.convertToInvoice)
        .then((quotes) {
      store.dispatch(ConvertQuotesToInvoicesSuccess(quotes: quotes));
      store.dispatch(RefreshData());
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(ConvertQuotesToInvoicesFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _convertQuotesToProjects(QuoteRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ConvertQuotesToProjects;
    repository
        .bulkAction(store.state.credentials, action.quoteIds,
            EntityAction.convertToProject)
        .then((quotes) {
      store.dispatch(ConvertQuotesToProjectsSuccess(quotes: quotes));
      store.dispatch(RefreshData());
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(ConvertQuotesToProjectsFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _approveQuote(QuoteRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ApproveQuotes;
    repository
        .bulkAction(
            store.state.credentials, action.quoteIds, EntityAction.approve)
        .then((quotes) {
      store.dispatch(ApproveQuoteSuccess(quotes: quotes));
      store.dispatch(RefreshData());
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(ApproveQuoteFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _markSentQuote(QuoteRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as MarkSentQuotesRequest;
    repository
        .bulkAction(
            store.state.credentials, action.quoteIds, EntityAction.markSent)
        .then((quotes) {
      store.dispatch(MarkSentQuoteSuccess(quotes));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(MarkSentQuoteFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _emailQuote(QuoteRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EmailQuoteRequest;
    final origQuote = store.state.quoteState.map[action.quoteId]!;
    repository
        .emailQuote(
      store.state.credentials,
      origQuote,
      action.template,
      action.subject,
      action.body,
      action.ccEmail,
    )
        .then((quote) {
      store.dispatch(EmailQuoteSuccess(quote));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(EmailQuoteFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _saveQuote(QuoteRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveQuoteRequest;

    // remove any empty line items
    final updatedQuote = action.quote.rebuild((b) => b
      ..lineItems
          .replace(action.quote.lineItems.where((item) => !item.isEmpty)));

    repository
        .saveData(store.state.credentials, updatedQuote, action.action)
        .then((InvoiceEntity quote) {
      if (action.quote.isNew) {
        store.dispatch(AddQuoteSuccess(quote));
      } else {
        store.dispatch(SaveQuoteSuccess(quote));
      }
      if (action.action == EntityAction.convertToInvoice) {
        store.dispatch(RefreshData());
      }
      action.completer.complete(quote);
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveQuoteFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _loadQuote(QuoteRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadQuote;

    store.dispatch(LoadQuoteRequest());
    repository.loadItem(store.state.credentials, action.quoteId).then((quote) {
      store.dispatch(LoadQuoteSuccess(quote));

      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadQuoteFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _downloadQuotes(QuoteRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DownloadQuotesRequest;
    repository
        .bulkAction(store.state.credentials, action.invoiceIds,
            EntityAction.bulkDownload)
        .then((invoices) {
      store.dispatch(DownloadQuotesSuccess());
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(DownloadQuotesFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _bulkEmailQuotes(QuoteRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as BulkEmailQuotesRequest;

    repository
        .bulkAction(
            store.state.credentials, action.quoteIds!, EntityAction.sendEmail)
        .then((List<InvoiceEntity> quotes) {
      store.dispatch(BulkEmailQuotesSuccess(quotes));
      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(BulkEmailQuotesFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadQuotes(QuoteRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadQuotes;
    final state = store.state;

    store.dispatch(LoadQuotesRequest());
    repository
        .loadList(
      state.credentials,
      action.page,
      state.createdAtLimit,
      state.filterDeletedClients,
    )
        .then((data) {
      store.dispatch(LoadQuotesSuccess(data));

      final documents = <DocumentEntity>[];
      data.forEach((quote) {
        quote.documents.forEach((document) {
          documents.add(document.rebuild((b) => b
            ..parentId = quote.id
            ..parentType = EntityType.quote));
        });
      });
      store.dispatch(LoadDocumentsSuccess(documents));

      if (data.length == kMaxRecordsPerPage) {
        store.dispatch(LoadQuotes(
          completer: action.completer,
          page: action.page + 1,
        ));
      } else {
        if (action.completer != null) {
          action.completer!.complete(null);
        }
        store.dispatch(LoadCredits());
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadQuotesFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _saveDocument(QuoteRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveQuoteDocumentRequest?;
    if (store.state.isEnterprisePlan) {
      repository
          .uploadDocument(
        store.state.credentials,
        action!.quote,
        action.multipartFile,
        action.isPrivate!,
      )
          .then((quote) {
        store.dispatch(SaveQuoteSuccess(quote));

        final documents = <DocumentEntity>[];
        quote.documents.forEach((document) {
          documents.add(document.rebuild((b) => b
            ..parentId = quote.id
            ..parentType = EntityType.quote));
        });
        store.dispatch(LoadDocumentsSuccess(documents));
        action.completer.complete(documents);
      }).catchError((Object error) {
        print(error);
        store.dispatch(SaveQuoteDocumentFailure(error));
        action.completer.completeError(error);
      });
    } else {
      const error = 'Uploading documents requires an enterprise plan';
      store.dispatch(SaveQuoteDocumentFailure(error));
      action!.completer.completeError(error);
    }

    next(action);
  };
}
