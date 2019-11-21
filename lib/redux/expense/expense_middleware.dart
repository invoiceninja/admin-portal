import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/redux/app/app_middleware.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/expense/expense_screen.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view_vm.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/repositories/expense_repository.dart';

List<Middleware<AppState>> createStoreExpensesMiddleware([
  ExpenseRepository repository = const ExpenseRepository(),
]) {
  final viewExpenseList = _viewExpenseList();
  final viewExpense = _viewExpense();
  final editExpense = _editExpense();
  final loadExpenses = _loadExpenses(repository);
  final loadExpense = _loadExpense(repository);
  final saveExpense = _saveExpense(repository);
  final archiveExpense = _archiveExpense(repository);
  final deleteExpense = _deleteExpense(repository);
  final restoreExpense = _restoreExpense(repository);

  return [
    TypedMiddleware<AppState, ViewExpenseList>(viewExpenseList),
    TypedMiddleware<AppState, ViewExpense>(viewExpense),
    TypedMiddleware<AppState, EditExpense>(editExpense),
    TypedMiddleware<AppState, LoadExpenses>(loadExpenses),
    TypedMiddleware<AppState, LoadExpense>(loadExpense),
    TypedMiddleware<AppState, SaveExpenseRequest>(saveExpense),
    TypedMiddleware<AppState, ArchiveExpenseRequest>(archiveExpense),
    TypedMiddleware<AppState, DeleteExpenseRequest>(deleteExpense),
    TypedMiddleware<AppState, RestoreExpenseRequest>(restoreExpense),
  ];
}

Middleware<AppState> _editExpense() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditExpense;

    if (!action.force &&
        hasChanges(store: store, context: action.context, action: action)) {
      return;
    }

    next(action);

    store.dispatch(UpdateCurrentRoute(ExpenseEditScreen.route));

    if (isMobile(action.context)) {
      action.navigator.pushNamed(ExpenseEditScreen.route);
    }
  };
}

Middleware<AppState> _viewExpense() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewExpense;

    if (!action.force &&
        hasChanges(store: store, context: action.context, action: action)) {
      return;
    }

    next(action);

    store.dispatch(UpdateCurrentRoute(ExpenseViewScreen.route));

    if (isMobile(action.context)) {
      action.navigator.pushNamed(ExpenseViewScreen.route);
    }
  };
}

Middleware<AppState> _viewExpenseList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewExpenseList;

    if (!action.force &&
        hasChanges(store: store, context: action.context, action: action)) {
      return;
    }

    next(action);

    if (store.state.expenseState.isStale) {
      store.dispatch(LoadExpenses());
    }

    store.dispatch(UpdateCurrentRoute(ExpenseScreen.route));

    if (isMobile(action.context)) {
      action.navigator.pushNamedAndRemoveUntil(
          ExpenseScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _archiveExpense(ExpenseRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ArchiveExpenseRequest;

    repository
        .bulkAction(
            store.state.credentials, action.expenseIds, EntityAction.archive)
        .then((List<ExpenseEntity> expenses) {
      store.dispatch(ArchiveExpenseSuccess(expenses));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      final expenses = action.expenseIds
          .map((id) => store.state.expenseState.map[id])
          .toList();
      store.dispatch(ArchiveExpenseFailure(expenses));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _deleteExpense(ExpenseRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DeleteExpenseRequest;

    repository
        .bulkAction(
            store.state.credentials, action.expenseIds, EntityAction.delete)
        .then((List<ExpenseEntity> expenses) {
      store.dispatch(DeleteExpenseSuccess(expenses));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      final expenses = action.expenseIds
          .map((id) => store.state.expenseState.map[id])
          .toList();
      store.dispatch(DeleteExpenseFailure(expenses));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _restoreExpense(ExpenseRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RestoreExpenseRequest;

    repository
        .bulkAction(
            store.state.credentials, action.expenseIds, EntityAction.restore)
        .then((List<ExpenseEntity> expenses) {
      store.dispatch(RestoreExpenseSuccess(expenses));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      final expenses = action.expenseIds
          .map((id) => store.state.expenseState.map[id])
          .toList();
      store.dispatch(RestoreExpenseFailure(expenses));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _saveExpense(ExpenseRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveExpenseRequest;
    repository
        .saveData(store.state.credentials, action.expense)
        .then((ExpenseEntity expense) {
      if (action.expense.isNew) {
        store.dispatch(AddExpenseSuccess(expense));
      } else {
        store.dispatch(SaveExpenseSuccess(expense));
      }
      action.completer.complete(expense);
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveExpenseFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _loadExpense(ExpenseRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadExpense;
    final AppState state = store.state;

    if (state.isLoading) {
      next(action);
      return;
    }

    store.dispatch(LoadExpenseRequest());
    repository
        .loadItem(store.state.credentials, action.expenseId)
        .then((expense) {
      store.dispatch(LoadExpenseSuccess(expense));

      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadExpenseFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadExpenses(ExpenseRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadExpenses;
    final AppState state = store.state;

    if (!state.expenseState.isStale && !action.force) {
      next(action);
      return;
    }

    if (state.isLoading) {
      next(action);
      return;
    }

    final int updatedAt = (state.expenseState.lastUpdated / 1000).round();

    store.dispatch(LoadExpensesRequest());
    repository.loadList(store.state.credentials, updatedAt).then((data) {
      store.dispatch(LoadExpensesSuccess(data));

      if (action.completer != null) {
        action.completer.complete(null);
      }
      if (state.company.isEnterprisePlan) {
        if (state.documentState.isStale) {
          store.dispatch(LoadDocuments());
        }
      } else {
        if (state.dashboardState.isStale) {
          store.dispatch(LoadDashboard());
        }
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadExpensesFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }

      // Support selfhost users with older versions
      // TODO remove this in v2
      if (state.dashboardState.isStale) {
        store.dispatch(LoadDashboard());
      }
    });

    next(action);
  };
}
