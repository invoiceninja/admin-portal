// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';

// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/repositories/expense_repository.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/redux/recurring_expense/recurring_expense_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/expense/expense_screen.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view_vm.dart';

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
  final saveDocument = _saveDocument(repository);

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
    TypedMiddleware<AppState, SaveExpenseDocumentRequest>(saveDocument),
  ];
}

Middleware<AppState> _editExpense() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditExpense?;

    next(action);

    store.dispatch(UpdateCurrentRoute(ExpenseEditScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(ExpenseEditScreen.route);
    }
  };
}

Middleware<AppState> _viewExpense() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewExpense?;

    next(action);

    store.dispatch(UpdateCurrentRoute(ExpenseViewScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(ExpenseViewScreen.route);
    }
  };
}

Middleware<AppState> _viewExpenseList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewExpenseList?;

    next(action);

    if (store.state.isStale) {
      store.dispatch(RefreshData());
    }

    store.dispatch(UpdateCurrentRoute(ExpenseScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          ExpenseScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _archiveExpense(ExpenseRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ArchiveExpenseRequest;
    final prevExpenses = action.expenseIds
        .map((id) => store.state.expenseState.map[id])
        .toList();

    repository
        .bulkAction(
            store.state.credentials, action.expenseIds, EntityAction.archive)
        .then((List<ExpenseEntity> expenses) {
      store.dispatch(ArchiveExpenseSuccess(expenses));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveExpenseFailure(prevExpenses));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _deleteExpense(ExpenseRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DeleteExpenseRequest;
    final prevExpenses = action.expenseIds
        .map((id) => store.state.expenseState.map[id])
        .toList();

    repository
        .bulkAction(
            store.state.credentials, action.expenseIds, EntityAction.delete)
        .then((List<ExpenseEntity> expenses) {
      store.dispatch(DeleteExpenseSuccess(expenses));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteExpenseFailure(prevExpenses));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _restoreExpense(ExpenseRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RestoreExpenseRequest;
    final prevExpenses = action.expenseIds
        .map((id) => store.state.expenseState.map[id])
        .toList();

    repository
        .bulkAction(
            store.state.credentials, action.expenseIds, EntityAction.restore)
        .then((List<ExpenseEntity> expenses) {
      store.dispatch(RestoreExpenseSuccess(expenses));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreExpenseFailure(prevExpenses));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _saveExpense(ExpenseRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveExpenseRequest;
    repository
        .saveData(store.state.credentials, action.expense!)
        .then((ExpenseEntity expense) {
      if (action.expense!.isNew) {
        store.dispatch(AddExpenseSuccess(expense));
      } else {
        store.dispatch(SaveExpenseSuccess(expense));
      }
      action.completer!.complete(expense);
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveExpenseFailure(error));
      action.completer!.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _loadExpense(ExpenseRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadExpense;

    store.dispatch(LoadExpenseRequest());
    repository
        .loadItem(store.state.credentials, action.expenseId)
        .then((expense) {
      store.dispatch(LoadExpenseSuccess(expense));

      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadExpenseFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadExpenses(ExpenseRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadExpenses;
    final state = store.state;

    store.dispatch(LoadExpensesRequest());
    repository
        .loadList(state.credentials, action.page, state.createdAtLimit,
            state.filterDeletedClients)
        .then((data) {
      store.dispatch(LoadExpensesSuccess(data));

      final documents = <DocumentEntity>[];
      data.forEach((expense) {
        expense.documents.forEach((document) {
          documents.add(document.rebuild((b) => b
            ..parentId = expense.id
            ..parentType = EntityType.expense));
        });
      });
      store.dispatch(LoadDocumentsSuccess(documents));

      if (data.length == kMaxRecordsPerPage) {
        store.dispatch(LoadExpenses(
          completer: action.completer,
          page: action.page + 1,
        ));
      } else {
        if (action.completer != null) {
          action.completer!.complete(null);
        }
        store.dispatch(LoadRecurringExpenses());
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadExpensesFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _saveDocument(ExpenseRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveExpenseDocumentRequest?;
    if (store.state.isEnterprisePlan) {
      repository
          .uploadDocuments(
        store.state.credentials,
        action!.expense,
        action.multipartFiles,
        action.isPrivate!,
      )
          .then((expense) {
        store.dispatch(SaveExpenseSuccess(expense));

        final documents = <DocumentEntity>[];
        expense.documents.forEach((document) {
          documents.add(document.rebuild((b) => b
            ..parentId = expense.id
            ..parentType = EntityType.expense));
        });
        store.dispatch(LoadDocumentsSuccess(documents));
        action.completer.complete(documents);
      }).catchError((Object error) {
        print(error);
        store.dispatch(SaveExpenseDocumentFailure(error));
        action.completer.completeError(error);
      });
    } else {
      const error = 'Uploading documents requires an enterprise plan';
      store.dispatch(SaveExpenseDocumentFailure(error));
      action!.completer.completeError(error);
    }

    next(action);
  };
}
