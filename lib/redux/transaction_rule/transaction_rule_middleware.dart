import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/transaction_rule/transaction_rule_screen.dart';
import 'package:invoiceninja_flutter/ui/transaction_rule/edit/transaction_rule_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/transaction_rule/view/transaction_rule_view_vm.dart';
import 'package:invoiceninja_flutter/redux/transaction_rule/transaction_rule_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/repositories/transaction_rule_repository.dart';

List<Middleware<AppState>> createStoreTransactionRulesMiddleware([
  TransactionRuleRepository repository = const TransactionRuleRepository(),
]) {
  final viewTransactionRuleList = _viewTransactionRuleList();
  final viewTransactionRule = _viewTransactionRule();
  final editTransactionRule = _editTransactionRule();
  final loadTransactionRules = _loadTransactionRules(repository);
  final loadTransactionRule = _loadTransactionRule(repository);
  final saveTransactionRule = _saveTransactionRule(repository);
  final archiveTransactionRule = _archiveTransactionRule(repository);
  final deleteTransactionRule = _deleteTransactionRule(repository);
  final restoreTransactionRule = _restoreTransactionRule(repository);

  return [
    TypedMiddleware<AppState, ViewTransactionRuleList>(viewTransactionRuleList),
    TypedMiddleware<AppState, ViewTransactionRule>(viewTransactionRule),
    TypedMiddleware<AppState, EditTransactionRule>(editTransactionRule),
    TypedMiddleware<AppState, LoadTransactionRules>(loadTransactionRules),
    TypedMiddleware<AppState, LoadTransactionRule>(loadTransactionRule),
    TypedMiddleware<AppState, SaveTransactionRuleRequest>(saveTransactionRule),
    TypedMiddleware<AppState, ArchiveTransactionRulesRequest>(
        archiveTransactionRule),
    TypedMiddleware<AppState, DeleteTransactionRulesRequest>(
        deleteTransactionRule),
    TypedMiddleware<AppState, RestoreTransactionRulesRequest>(
        restoreTransactionRule),
  ];
}

Middleware<AppState> _editTransactionRule() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditTransactionRule?;

    next(action);

    store.dispatch(UpdateCurrentRoute(TransactionRuleEditScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(TransactionRuleEditScreen.route);
    }
  };
}

Middleware<AppState> _viewTransactionRule() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewTransactionRule?;

    next(action);

    store.dispatch(UpdateCurrentRoute(TransactionRuleViewScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(TransactionRuleViewScreen.route);
    }
  };
}

Middleware<AppState> _viewTransactionRuleList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewTransactionRuleList?;

    next(action);

    if (store.state.staticState.isStale) {
      store.dispatch(RefreshData());
    }

    store.dispatch(UpdateCurrentRoute(TransactionRuleScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          TransactionRuleScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _archiveTransactionRule(
    TransactionRuleRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ArchiveTransactionRulesRequest;
    final prevTransactionRules = action.transactionRuleIds
        .map((id) => store.state.transactionRuleState.map[id])
        .toList();
    repository
        .bulkAction(store.state.credentials, action.transactionRuleIds,
            EntityAction.archive)
        .then((List<TransactionRuleEntity> transactionRules) {
      store.dispatch(ArchiveTransactionRulesSuccess(transactionRules));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveTransactionRulesFailure(prevTransactionRules));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _deleteTransactionRule(
    TransactionRuleRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DeleteTransactionRulesRequest;
    final prevTransactionRules = action.transactionRuleIds
        .map((id) => store.state.transactionRuleState.map[id])
        .toList();
    repository
        .bulkAction(store.state.credentials, action.transactionRuleIds,
            EntityAction.delete)
        .then((List<TransactionRuleEntity> transactionRules) {
      store.dispatch(DeleteTransactionRulesSuccess(transactionRules));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteTransactionRulesFailure(prevTransactionRules));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _restoreTransactionRule(
    TransactionRuleRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RestoreTransactionRulesRequest;
    final prevTransactionRules = action.transactionRuleIds
        .map((id) => store.state.transactionRuleState.map[id])
        .toList();
    repository
        .bulkAction(store.state.credentials, action.transactionRuleIds,
            EntityAction.restore)
        .then((List<TransactionRuleEntity> transactionRules) {
      store.dispatch(RestoreTransactionRulesSuccess(transactionRules));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreTransactionRulesFailure(prevTransactionRules));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _saveTransactionRule(
    TransactionRuleRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveTransactionRuleRequest;
    repository
        .saveData(store.state.credentials, action.transactionRule!)
        .then((TransactionRuleEntity transactionRule) {
      if (action.transactionRule!.isNew) {
        store.dispatch(AddTransactionRuleSuccess(transactionRule));
      } else {
        store.dispatch(SaveTransactionRuleSuccess(transactionRule));
      }

      action.completer!.complete(transactionRule);
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveTransactionRuleFailure(error));
      action.completer!.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _loadTransactionRule(
    TransactionRuleRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadTransactionRule;
    final AppState state = store.state;

    store.dispatch(LoadTransactionRuleRequest());
    repository
        .loadItem(state.credentials, action.transactionRuleId)
        .then((transactionRule) {
      store.dispatch(LoadTransactionRuleSuccess(transactionRule));

      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadTransactionRuleFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadTransactionRules(
    TransactionRuleRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadTransactionRules?;
    final AppState state = store.state;

    store.dispatch(LoadTransactionRulesRequest());
    repository.loadList(state.credentials).then((data) {
      store.dispatch(LoadTransactionRulesSuccess(data));

      if (action!.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadTransactionRulesFailure(error));
      if (action!.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}
