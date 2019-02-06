import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/quote/edit/quote_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/quote/quote_email_vm.dart';
import 'package:invoiceninja_flutter/ui/quote/quote_screen.dart';
import 'package:invoiceninja_flutter/ui/quote/view/quote_view_vm.dart';
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
    TypedMiddleware<AppState, ConvertQuote>(convertQuote),
    TypedMiddleware<AppState, ShowEmailQuote>(showEmailQuote),
    TypedMiddleware<AppState, LoadQuotes>(loadQuotes),
    TypedMiddleware<AppState, LoadQuote>(loadQuote),
    TypedMiddleware<AppState, SaveQuoteRequest>(saveQuote),
    TypedMiddleware<AppState, ArchiveQuoteRequest>(archiveQuote),
    TypedMiddleware<AppState, DeleteQuoteRequest>(deleteQuote),
    TypedMiddleware<AppState, RestoreQuoteRequest>(restoreQuote),
    TypedMiddleware<AppState, EmailQuoteRequest>(emailQuote),
    TypedMiddleware<AppState, MarkSentQuoteRequest>(markSentQuote),
  ];
}

Middleware<AppState> _viewQuote() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);

    store.dispatch(UpdateCurrentRoute(QuoteViewScreen.route));
    await Navigator.of(action.context).pushNamed(QuoteViewScreen.route);
  };
}

Middleware<AppState> _viewQuoteList() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    next(action);

    store.dispatch(UpdateCurrentRoute(QuoteScreen.route));
    Navigator.of(action.context).pushNamedAndRemoveUntil(
        QuoteScreen.route, (Route<dynamic> route) => false);
  };
}

Middleware<AppState> _editQuote() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);

    store.dispatch(UpdateCurrentRoute(QuoteEditScreen.route));
    final quote =
        await Navigator.of(action.context).pushNamed(QuoteEditScreen.route);

    if (action.completer != null && quote != null) {
      action.completer.complete(quote);
    }
  };
}

Middleware<AppState> _showEmailQuote() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);

    final emailWasSent =
        await Navigator.of(action.context).pushNamed(QuoteEmailScreen.route);

    if (action.completer != null && emailWasSent != null && emailWasSent) {
      action.completer.complete(null);
    }
  };
}

Middleware<AppState> _archiveQuote(QuoteRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    final origQuote = store.state.quoteState.map[action.quoteId];
    repository
        .saveData(store.state.selectedCompany, store.state.authState, origQuote,
            EntityAction.archive)
        .then((InvoiceEntity quote) {
      store.dispatch(ArchiveQuoteSuccess(quote));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveQuoteFailure(origQuote));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _deleteQuote(QuoteRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    final origQuote = store.state.quoteState.map[action.quoteId];
    repository
        .saveData(store.state.selectedCompany, store.state.authState, origQuote,
            EntityAction.delete)
        .then((InvoiceEntity quote) {
      store.dispatch(DeleteQuoteSuccess(quote));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteQuoteFailure(origQuote));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _restoreQuote(QuoteRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    final origQuote = store.state.quoteState.map[action.quoteId];
    repository
        .saveData(store.state.selectedCompany, store.state.authState, origQuote,
        EntityAction.restore)
        .then((InvoiceEntity quote) {
      store.dispatch(RestoreQuoteSuccess(quote));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreQuoteFailure(origQuote));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _convertQuote(QuoteRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    final quote = store.state.quoteState.map[action.quoteId];
    repository
        .saveData(store.state.selectedCompany, store.state.authState, quote,
        EntityAction.convert)
        .then((InvoiceEntity invoice) {
      store.dispatch(ConvertQuoteSuccess(quote: quote, invoice: invoice));
      action.completer.complete(invoice);
    }).catchError((Object error) {
      print(error);
      store.dispatch(ConvertQuoteFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _markSentQuote(QuoteRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    final origQuote = store.state.quoteState.map[action.quoteId];
    repository
        .saveData(store.state.selectedCompany, store.state.authState, origQuote,
            EntityAction.markSent)
        .then((InvoiceEntity quote) {
      store.dispatch(MarkSentQuoteSuccess(quote));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(MarkSentQuoteFailure(origQuote));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _emailQuote(QuoteRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    final origQuote = store.state.quoteState.map[action.quoteId];
    repository
        .emailQuote(store.state.selectedCompany, store.state.authState,
        origQuote, action.template, action.subject, action.body)
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
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    repository
        .saveData(
            store.state.selectedCompany, store.state.authState, action.quote)
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
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    final AppState state = store.state;

    if (state.isLoading) {
      next(action);
      return;
    }

    store.dispatch(LoadQuoteRequest());
    repository
        .loadItem(state.selectedCompany, state.authState, action.quoteId)
        .then((quote) {
      store.dispatch(LoadQuoteSuccess(quote));

      if (action.completer != null) {
        action.completer.complete(null);
      }
      if (state.projectState.isStale) {
        store.dispatch(LoadProjects());
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
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
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
    repository
        .loadList(state.selectedCompany, state.authState, updatedAt)
        .then((data) {
      store.dispatch(LoadQuotesSuccess(data));
      if (action.completer != null) {
        action.completer.complete(null);
      }
      if (state.projectState.isStale) {
        store.dispatch(LoadProjects());
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
