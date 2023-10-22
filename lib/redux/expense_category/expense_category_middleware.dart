// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/repositories/expense_category_repository.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/expense_category/expense_category_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/expense_category/edit/expense_category_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/expense_category/expense_category_screen.dart';
import 'package:invoiceninja_flutter/ui/expense_category/view/expense_category_view_vm.dart';

List<Middleware<AppState>> createStoreExpenseCategoriesMiddleware([
  ExpenseCategoryRepository repository = const ExpenseCategoryRepository(),
]) {
  final viewExpenseCategoryList = _viewExpenseCategoryList();
  final viewExpenseCategory = _viewExpenseCategory();
  final editExpenseCategory = _editExpenseCategory();
  final loadExpenseCategories = _loadExpenseCategories(repository);
  final loadExpenseCategory = _loadExpenseCategory(repository);
  final saveExpenseCategory = _saveExpenseCategory(repository);
  final archiveExpenseCategory = _archiveExpenseCategory(repository);
  final deleteExpenseCategory = _deleteExpenseCategory(repository);
  final restoreExpenseCategory = _restoreExpenseCategory(repository);

  return [
    TypedMiddleware<AppState, ViewExpenseCategoryList>(viewExpenseCategoryList),
    TypedMiddleware<AppState, ViewExpenseCategory>(viewExpenseCategory),
    TypedMiddleware<AppState, EditExpenseCategory>(editExpenseCategory),
    TypedMiddleware<AppState, LoadExpenseCategories>(loadExpenseCategories),
    TypedMiddleware<AppState, LoadExpenseCategory>(loadExpenseCategory),
    TypedMiddleware<AppState, SaveExpenseCategoryRequest>(saveExpenseCategory),
    TypedMiddleware<AppState, ArchiveExpenseCategoriesRequest>(
        archiveExpenseCategory),
    TypedMiddleware<AppState, DeleteExpenseCategoriesRequest>(
        deleteExpenseCategory),
    TypedMiddleware<AppState, RestoreExpenseCategoriesRequest>(
        restoreExpenseCategory),
  ];
}

Middleware<AppState> _editExpenseCategory() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditExpenseCategory?;

    next(action);

    store.dispatch(UpdateCurrentRoute(ExpenseCategoryEditScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(ExpenseCategoryEditScreen.route);
    }
  };
}

Middleware<AppState> _viewExpenseCategory() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewExpenseCategory?;

    next(action);

    store.dispatch(UpdateCurrentRoute(ExpenseCategoryViewScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(ExpenseCategoryViewScreen.route);
    }
  };
}

Middleware<AppState> _viewExpenseCategoryList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewExpenseCategoryList?;

    next(action);

    if (store.state.staticState.isStale) {
      store.dispatch(RefreshData());
    }

    store.dispatch(UpdateCurrentRoute(ExpenseCategoryScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          ExpenseCategoryScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _archiveExpenseCategory(
    ExpenseCategoryRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ArchiveExpenseCategoriesRequest;
    final prevExpenseCategories = action.expenseCategoryIds
        .map((id) => store.state.expenseCategoryState.map[id])
        .toList();
    repository
        .bulkAction(store.state.credentials, action.expenseCategoryIds,
            EntityAction.archive)
        .then((List<ExpenseCategoryEntity> expenseCategories) {
      store.dispatch(ArchiveExpenseCategoriesSuccess(expenseCategories));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveExpenseCategoriesFailure(prevExpenseCategories));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _deleteExpenseCategory(
    ExpenseCategoryRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DeleteExpenseCategoriesRequest;
    final prevExpenseCategories = action.expenseCategoryIds
        .map((id) => store.state.expenseCategoryState.map[id])
        .toList();
    repository
        .bulkAction(store.state.credentials, action.expenseCategoryIds,
            EntityAction.delete)
        .then((List<ExpenseCategoryEntity> expenseCategories) {
      store.dispatch(DeleteExpenseCategoriesSuccess(expenseCategories));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteExpenseCategoriesFailure(prevExpenseCategories));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _restoreExpenseCategory(
    ExpenseCategoryRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RestoreExpenseCategoriesRequest;
    final prevExpenseCategories = action.expenseCategoryIds
        .map((id) => store.state.expenseCategoryState.map[id])
        .toList();
    repository
        .bulkAction(store.state.credentials, action.expenseCategoryIds,
            EntityAction.restore)
        .then((List<ExpenseCategoryEntity> expenseCategories) {
      store.dispatch(RestoreExpenseCategoriesSuccess(expenseCategories));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreExpenseCategoriesFailure(prevExpenseCategories));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _saveExpenseCategory(
    ExpenseCategoryRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveExpenseCategoryRequest;
    repository
        .saveData(store.state.credentials, action.expenseCategory!)
        .then((ExpenseCategoryEntity expenseCategory) {
      if (action.expenseCategory!.isNew) {
        store.dispatch(AddExpenseCategorySuccess(expenseCategory));
      } else {
        store.dispatch(SaveExpenseCategorySuccess(expenseCategory));
      }

      action.completer!.complete(expenseCategory);

      final expenseCategoryUIState = store.state.expenseCategoryUIState;
      if (expenseCategoryUIState.saveCompleter != null) {
        expenseCategoryUIState.saveCompleter!.complete(expenseCategory);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveExpenseCategoryFailure(error));
      action.completer!.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _loadExpenseCategory(
    ExpenseCategoryRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadExpenseCategory;
    final AppState state = store.state;

    store.dispatch(LoadExpenseCategoryRequest());
    repository
        .loadItem(state.credentials, action.expenseCategoryId)
        .then((expenseCategory) {
      store.dispatch(LoadExpenseCategorySuccess(expenseCategory));

      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadExpenseCategoryFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadExpenseCategories(
    ExpenseCategoryRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadExpenseCategories?;
    final AppState state = store.state;

    store.dispatch(LoadExpenseCategoriesRequest());
    repository.loadList(state.credentials).then((data) {
      store.dispatch(LoadExpenseCategoriesSuccess(data));

      if (action!.completer != null) {
        action.completer!.complete(null);
      }
      /*
      if (state.productState.isStale) {
        store.dispatch(LoadProducts());
      }
      */
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadExpenseCategoriesFailure(error));
      if (action!.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}
