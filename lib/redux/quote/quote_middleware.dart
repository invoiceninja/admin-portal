import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_middleware.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/quote/edit/quote_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/quote/quote_email_vm.dart';
import 'package:invoiceninja_flutter/ui/quote/quote_screen.dart';
import 'package:invoiceninja_flutter/ui/quote/view/quote_view_vm.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/repositories/quote_repository.dart';

List<Middleware<AppState>> createStoreQuotesMiddleware([
  QuoteRepository repository = const QuoteRepository(),
]) {
  final viewQuoteList = _viewQuoteList();
  final viewQuote = _viewQuote();
  final editQuote = _editQuote();
  final showEmailQuote = _showEmailQuote();
  final convertQuote = _convertQuote(repository);
  final loadQuotes = _loadQuotes(repository);
  final loadQuote = _loadQuote(repository);
  final saveQuote = _saveQuote(repository);
  final archiveQuote = _archiveQuote(repository);
  final deleteQuote = _deleteQuote(repository);
  final restoreQuote = _restoreQuote(repository);
  final emailQuote = _emailQuote(repository);
  final markSentQuote = _markSentQuote(repository);

  return [
    TypedMiddleware<AppState, ViewQuoteList>(viewQuoteList),
    TypedMiddleware<AppState, ViewQuote>(viewQuote),
    TypedMiddleware<AppState, EditQuote>(editQuote),
    TypedMiddleware<AppState, ConvertQuotes>(convertQuote),
    TypedMiddleware<AppState, ShowEmailQuote>(showEmailQuote),
    TypedMiddleware<AppState, LoadQuotes>(loadQuotes),
    TypedMiddleware<AppState, LoadQuote>(loadQuote),
    TypedMiddleware<AppState, SaveQuoteRequest>(saveQuote),
    TypedMiddleware<AppState, ArchiveQuotesRequest>(archiveQuote),
    TypedMiddleware<AppState, DeleteQuotesRequest>(deleteQuote),
    TypedMiddleware<AppState, RestoreQuotesRequest>(restoreQuote),
    TypedMiddleware<AppState, EmailQuoteRequest>(emailQuote),
    TypedMiddleware<AppState, MarkSentQuotesRequest>(markSentQuote),
  ];
}

Middleware<AppState> _viewQuote() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewQuote;

    if (!action.force &&
        hasChanges(store: store, context: action.context, action: action)) {
      return;
    }

    next(action);

    store.dispatch(UpdateCurrentRoute(QuoteViewScreen.route));

    if (isMobile(action.context)) {
      await action.navigator.pushNamed(QuoteViewScreen.route);
    }
  };
}

Middleware<AppState> _viewQuoteList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewQuoteList;

    if (!action.force &&
        hasChanges(store: store, context: action.context, action: action)) {
      return;
    }

    next(action);

    if (store.state.quoteState.isStale) {
      store.dispatch(LoadQuotes());
    }

    store.dispatch(UpdateCurrentRoute(QuoteScreen.route));

    if (isMobile(action.context)) {
      action.navigator.pushNamedAndRemoveUntil(
          QuoteScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _editQuote() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditQuote;

    if (!action.force &&
        hasChanges(store: store, context: action.context, action: action)) {
      return;
    }

    next(action);

    store.dispatch(UpdateCurrentRoute(QuoteEditScreen.route));

    if (isMobile(action.context)) {
      action.navigator.pushNamed(QuoteEditScreen.route);
    }
  };
}

Middleware<AppState> _showEmailQuote() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ShowEmailQuote;

    next(action);

    store.dispatch(UpdateCurrentRoute(QuoteEmailScreen.route));

    if (isMobile(action.context)) {
      final emailWasSent =
          await Navigator.of(action.context).pushNamed(QuoteEmailScreen.route);

      if (action.completer != null && emailWasSent != null && emailWasSent) {
        action.completer.complete(null);
      }
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
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveQuotesFailure(prevQuotes));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
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
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteQuotesFailure(prevQuotes));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
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
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreQuotesFailure(prevQuotes));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _convertQuote(QuoteRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ConvertQuotes;
    repository
        .bulkAction(
            store.state.credentials, action.quoteIds, EntityAction.convert)
        .then((quotes) {
      store.dispatch(ConvertQuoteSuccess(quotes: quotes));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(ConvertQuoteFailure(error));
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
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(MarkSentQuoteFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _emailQuote(QuoteRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EmailQuoteRequest;
    final origQuote = store.state.quoteState.map[action.quoteId];
    repository
        .emailQuote(store.state.credentials, origQuote, action.template,
            action.subject, action.body)
        .then((void _) {
      store.dispatch(EmailQuoteSuccess());
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(EmailQuoteFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
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
        .saveData(store.state.credentials, updatedQuote)
        .then((InvoiceEntity quote) {
      if (action.quote.isNew) {
        store.dispatch(AddQuoteSuccess(quote));
      } else {
        store.dispatch(SaveQuoteSuccess(quote));
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
    final AppState state = store.state;

    if (state.isLoading) {
      next(action);
      return;
    }

    store.dispatch(LoadQuoteRequest());
    repository.loadItem(store.state.credentials, action.quoteId).then((quote) {
      store.dispatch(LoadQuoteSuccess(quote));

      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadQuoteFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadQuotes(QuoteRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadQuotes;
    final AppState state = store.state;

    if (!state.quoteState.isStale && !action.force) {
      next(action);
      return;
    }

    if (state.isLoading) {
      next(action);
      return;
    }

    final int updatedAt = (state.quoteState.lastUpdated / 1000).round();

    store.dispatch(LoadQuotesRequest());
    repository.loadList(store.state.credentials, updatedAt).then((data) {
      store.dispatch(LoadQuotesSuccess(data));
      if (action.completer != null) {
        action.completer.complete(null);
      }
      if (state.creditState.isStale) {
        store.dispatch(LoadCredits());
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadQuotesFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}
