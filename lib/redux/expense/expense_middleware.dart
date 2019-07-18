import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
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
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);

    store.dispatch(UpdateCurrentRoute(ExpenseEditScreen.route));
    final expense =
        await Navigator.of(action.context).pushNamed(ExpenseEditScreen.route);

    if (action.completer != null && expense != null) {
      action.completer.complete(expense);
    }
  };
}

Middleware<AppState> _viewExpense() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);

    store.dispatch(UpdateCurrentRoute(ExpenseViewScreen.route));
    Navigator.of(action.context).pushNamed(ExpenseViewScreen.route);
  };
}

Middleware<AppState> _viewExpenseList() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    next(action);

    store.dispatch(UpdateCurrentRoute(ExpenseScreen.route));

    Navigator.of(action.context).pushNamedAndRemoveUntil(
        ExpenseScreen.route, (Route<dynamic> route) => false);
  };
}

Middleware<AppState> _archiveExpense(ExpenseRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    final origExpense = store.state.expenseState.map[action.expenseId];
    repository
        .saveData(store.state.selectedCompany, store.state.authState,
            origExpense, EntityAction.archive)
        .then((ExpenseEntity expense) {
      store.dispatch(ArchiveExpenseSuccess(expense));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveExpenseFailure(origExpense));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _deleteExpense(ExpenseRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    final origExpense = store.state.expenseState.map[action.expenseId];
    repository
        .saveData(store.state.selectedCompany, store.state.authState,
            origExpense, EntityAction.delete)
        .then((ExpenseEntity expense) {
      store.dispatch(DeleteExpenseSuccess(expense));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteExpenseFailure(origExpense));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _restoreExpense(ExpenseRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    final origExpense = store.state.expenseState.map[action.expenseId];
    repository
        .saveData(store.state.selectedCompany, store.state.authState,
            origExpense, EntityAction.restore)
        .then((ExpenseEntity expense) {
      store.dispatch(RestoreExpenseSuccess(expense));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreExpenseFailure(origExpense));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _saveExpense(ExpenseRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    repository
        .saveData(
            store.state.selectedCompany, store.state.authState, action.expense)
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
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    final AppState state = store.state;

    if (state.isLoading) {
      next(action);
      return;
    }

    store.dispatch(LoadExpenseRequest());
    repository
        .loadItem(state.selectedCompany, state.authState, action.expenseId)
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
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
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
    repository
        .loadList(state.selectedCompany, state.authState, updatedAt)
        .then((data) {
      store.dispatch(LoadExpensesSuccess(data));

      if (action.completer != null) {
        action.completer.complete(null);
      }
      if (state.dashboardState.isStale) {
        if (state.selectedCompany.isEnterprisePlan) {
          store.dispatch(LoadDocuments());
        } else {
          store.dispatch(LoadDashboard());
        }
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadExpensesFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}
