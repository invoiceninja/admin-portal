import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/recurring_expense/recurring_expense_screen.dart';
import 'package:invoiceninja_flutter/ui/recurring_expense/edit/recurring_expense_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/recurring_expense/view/recurring_expense_view_vm.dart';
import 'package:invoiceninja_flutter/redux/recurring_expense/recurring_expense_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/repositories/recurring_expense_repository.dart';

List<Middleware<AppState>> createStoreRecurringExpensesMiddleware([
  RecurringExpenseRepository repository = const RecurringExpenseRepository(),
]) {
  final viewRecurringExpenseList = _viewRecurringExpenseList();
  final viewRecurringExpense = _viewRecurringExpense();
  final editRecurringExpense = _editRecurringExpense();
  final loadRecurringExpenses = _loadRecurringExpenses(repository);
  final loadRecurringExpense = _loadRecurringExpense(repository);
  final saveRecurringExpense = _saveRecurringExpense(repository);
  final archiveRecurringExpense = _archiveRecurringExpense(repository);
  final deleteRecurringExpense = _deleteRecurringExpense(repository);
  final restoreRecurringExpense = _restoreRecurringExpense(repository);

  return [
    TypedMiddleware<AppState, ViewRecurringExpenseList>(
        viewRecurringExpenseList),
    TypedMiddleware<AppState, ViewRecurringExpense>(viewRecurringExpense),
    TypedMiddleware<AppState, EditRecurringExpense>(editRecurringExpense),
    TypedMiddleware<AppState, LoadRecurringExpenses>(loadRecurringExpenses),
    TypedMiddleware<AppState, LoadRecurringExpense>(loadRecurringExpense),
    TypedMiddleware<AppState, SaveRecurringExpenseRequest>(
        saveRecurringExpense),
    TypedMiddleware<AppState, ArchiveRecurringExpensesRequest>(
        archiveRecurringExpense),
    TypedMiddleware<AppState, DeleteRecurringExpensesRequest>(
        deleteRecurringExpense),
    TypedMiddleware<AppState, RestoreRecurringExpensesRequest>(
        restoreRecurringExpense),
  ];
}

Middleware<AppState> _editRecurringExpense() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditRecurringExpense;

    next(action);

    store.dispatch(UpdateCurrentRoute(RecurringExpenseEditScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState.pushNamed(RecurringExpenseEditScreen.route);
    }
  };
}

Middleware<AppState> _viewRecurringExpense() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewRecurringExpense;

    next(action);

    store.dispatch(UpdateCurrentRoute(RecurringExpenseViewScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState.pushNamed(RecurringExpenseViewScreen.route);
    }
  };
}

Middleware<AppState> _viewRecurringExpenseList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewRecurringExpenseList;

    next(action);

    if (store.state.staticState.isStale) {
      store.dispatch(RefreshData());
    }

    store.dispatch(UpdateCurrentRoute(RecurringExpenseScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState.pushNamedAndRemoveUntil(
          RecurringExpenseScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _archiveRecurringExpense(
    RecurringExpenseRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ArchiveRecurringExpensesRequest;
    final prevRecurringExpenses = action.recurringExpenseIds
        .map((id) => store.state.recurringExpenseState.map[id])
        .toList();
    repository
        .bulkAction(store.state.credentials, action.recurringExpenseIds,
            EntityAction.archive)
        .then((List<ExpenseEntity> recurringExpenses) {
      store.dispatch(ArchiveRecurringExpensesSuccess(recurringExpenses));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveRecurringExpensesFailure(prevRecurringExpenses));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _deleteRecurringExpense(
    RecurringExpenseRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DeleteRecurringExpensesRequest;
    final prevRecurringExpenses = action.recurringExpenseIds
        .map((id) => store.state.recurringExpenseState.map[id])
        .toList();
    repository
        .bulkAction(store.state.credentials, action.recurringExpenseIds,
            EntityAction.delete)
        .then((List<ExpenseEntity> recurringExpenses) {
      store.dispatch(DeleteRecurringExpensesSuccess(recurringExpenses));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteRecurringExpensesFailure(prevRecurringExpenses));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _restoreRecurringExpense(
    RecurringExpenseRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RestoreRecurringExpensesRequest;
    final prevRecurringExpenses = action.recurringExpenseIds
        .map((id) => store.state.recurringExpenseState.map[id])
        .toList();
    repository
        .bulkAction(store.state.credentials, action.recurringExpenseIds,
            EntityAction.restore)
        .then((List<ExpenseEntity> recurringExpenses) {
      store.dispatch(RestoreRecurringExpensesSuccess(recurringExpenses));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreRecurringExpensesFailure(prevRecurringExpenses));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _saveRecurringExpense(
    RecurringExpenseRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveRecurringExpenseRequest;
    repository
        .saveData(store.state.credentials, action.recurringExpense)
        .then((ExpenseEntity recurringExpense) {
      if (action.recurringExpense.isNew) {
        store.dispatch(AddRecurringExpenseSuccess(recurringExpense));
      } else {
        store.dispatch(SaveRecurringExpenseSuccess(recurringExpense));
      }

      action.completer.complete(recurringExpense);
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveRecurringExpenseFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _loadRecurringExpense(
    RecurringExpenseRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadRecurringExpense;
    final AppState state = store.state;

    store.dispatch(LoadRecurringExpenseRequest());
    repository
        .loadItem(state.credentials, action.recurringExpenseId)
        .then((recurringExpense) {
      store.dispatch(LoadRecurringExpenseSuccess(recurringExpense));

      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadRecurringExpenseFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadRecurringExpenses(
    RecurringExpenseRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadRecurringExpenses;
    final AppState state = store.state;

    store.dispatch(LoadRecurringExpensesRequest());
    repository.loadList(state.credentials).then((data) {
      store.dispatch(LoadRecurringExpensesSuccess(data));

      if (action.completer != null) {
        action.completer.complete(null);
      }
      /*
      if (state.productState.isStale) {
        store.dispatch(LoadProducts());
      }
      */
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadRecurringExpensesFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}
