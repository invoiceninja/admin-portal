import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_middleware.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/credit/edit/credit_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/credit/credit_email_vm.dart';
import 'package:invoiceninja_flutter/ui/credit/credit_screen.dart';
import 'package:invoiceninja_flutter/ui/credit/view/credit_view_vm.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/repositories/credit_repository.dart';

List<Middleware<AppState>> createStoreCreditsMiddleware([
  CreditRepository repository = const CreditRepository(),
]) {
  final viewCreditList = _viewCreditList();
  final viewCredit = _viewCredit();
  final editCredit = _editCredit();
  final showEmailCredit = _showEmailCredit();
  final loadCredits = _loadCredits(repository);
  final loadCredit = _loadCredit(repository);
  final saveCredit = _saveCredit(repository);
  final archiveCredit = _archiveCredit(repository);
  final deleteCredit = _deleteCredit(repository);
  final restoreCredit = _restoreCredit(repository);
  final emailCredit = _emailCredit(repository);
  final markSentCredit = _markSentCredit(repository);

  return [
    TypedMiddleware<AppState, ViewCreditList>(viewCreditList),
    TypedMiddleware<AppState, ViewCredit>(viewCredit),
    TypedMiddleware<AppState, EditCredit>(editCredit),
    TypedMiddleware<AppState, ShowEmailCredit>(showEmailCredit),
    TypedMiddleware<AppState, LoadCredits>(loadCredits),
    TypedMiddleware<AppState, LoadCredit>(loadCredit),
    TypedMiddleware<AppState, SaveCreditRequest>(saveCredit),
    TypedMiddleware<AppState, ArchiveCreditsRequest>(archiveCredit),
    TypedMiddleware<AppState, DeleteCreditsRequest>(deleteCredit),
    TypedMiddleware<AppState, RestoreCreditsRequest>(restoreCredit),
    TypedMiddleware<AppState, EmailCreditRequest>(emailCredit),
    TypedMiddleware<AppState, MarkSentCreditRequest>(markSentCredit),
  ];
}

Middleware<AppState> _viewCredit() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewCredit;

    if (!action.force &&
        hasChanges(store: store, context: action.context, action: action)) {
      return;
    }

    next(action);

    store.dispatch(UpdateCurrentRoute(CreditViewScreen.route));

    if (isMobile(action.context)) {
      await action.navigator.pushNamed(CreditViewScreen.route);
    }
  };
}

Middleware<AppState> _viewCreditList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewCreditList;

    if (!action.force &&
        hasChanges(store: store, context: action.context, action: action)) {
      return;
    }

    next(action);

    if (store.state.creditState.isStale) {
      store.dispatch(LoadCredits());
    }

    store.dispatch(UpdateCurrentRoute(CreditScreen.route));

    if (isMobile(action.context)) {
      action.navigator.pushNamedAndRemoveUntil(
          CreditScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _editCredit() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditCredit;

    if (!action.force &&
        hasChanges(store: store, context: action.context, action: action)) {
      return;
    }

    next(action);

    store.dispatch(UpdateCurrentRoute(CreditEditScreen.route));

    if (isMobile(action.context)) {
      action.navigator.pushNamed(CreditEditScreen.route);
    }
  };
}

Middleware<AppState> _showEmailCredit() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ShowEmailCredit;

    next(action);

    store.dispatch(UpdateCurrentRoute(CreditEmailScreen.route));

    if (isMobile(action.context)) {
      final emailWasSent =
          await Navigator.of(action.context).pushNamed(CreditEmailScreen.route);

      if (action.completer != null && emailWasSent != null && emailWasSent) {
        action.completer.complete(null);
      }
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
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveCreditsFailure(prevCredits));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
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
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteCreditsFailure(prevCredits));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
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
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreCreditsFailure(prevCredits));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
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
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(MarkSentCreditFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _emailCredit(CreditRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EmailCreditRequest;
    final origCredit = store.state.creditState.map[action.creditId];
    repository
        .emailCredit(store.state.credentials, origCredit, action.template,
            action.subject, action.body)
        .then((void _) {
      store.dispatch(EmailCreditSuccess());
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(EmailCreditFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
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
        .saveData(store.state.credentials, updatedCredit)
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
    final AppState state = store.state;

    if (state.isLoading) {
      next(action);
      return;
    }

    store.dispatch(LoadCreditRequest());
    repository
        .loadItem(store.state.credentials, action.creditId)
        .then((credit) {
      store.dispatch(LoadCreditSuccess(credit));

      if (action.completer != null) {
        action.completer.complete(null);
      }
      if (state.projectState.isStale) {
        store.dispatch(LoadProjects());
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadCreditFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadCredits(CreditRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadCredits;
    final AppState state = store.state;

    if (!state.creditState.isStale && !action.force) {
      next(action);
      return;
    }

    if (state.isLoading) {
      next(action);
      return;
    }

    final int updatedAt = (state.creditState.lastUpdated / 1000).round();

    store.dispatch(LoadCreditsRequest());
    repository.loadList(store.state.credentials, updatedAt).then((data) {
      store.dispatch(LoadCreditsSuccess(data));
      if (action.completer != null) {
        action.completer.complete(null);
      }
      if (state.clientState.isStale) {
        store.dispatch(LoadClients());
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadCreditsFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}
