import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/transaction/transaction_screen.dart';
import 'package:invoiceninja_flutter/ui/transaction/edit/transaction_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/transaction/view/transaction_view_vm.dart';
import 'package:invoiceninja_flutter/redux/transaction/transaction_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/repositories/transaction_repository.dart';

List<Middleware<AppState>> createStoreTransactionsMiddleware([
  TransactionRepository repository = const TransactionRepository(),
]) {
  final viewTransactionList = _viewTransactionList();
  final viewTransaction = _viewTransaction();
  final editTransaction = _editTransaction();
  final loadTransactions = _loadTransactions(repository);
  final loadTransaction = _loadTransaction(repository);
  final saveTransaction = _saveTransaction(repository);
  final archiveTransaction = _archiveTransaction(repository);
  final deleteTransaction = _deleteTransaction(repository);
  final restoreTransaction = _restoreTransaction(repository);
  final convertTransactions = _convertTransactions(repository);
  final unlinkTransactions = _unlinkTransactions(repository);
  final convertToPayment = _convertToPayment(repository);
  final convertToExpense = _convertToExpense(repository);
  final linkToPayment = _linkToPayment(repository);
  final linkToExpense = _linkToExpense(repository);

  return [
    TypedMiddleware<AppState, ViewTransactionList>(viewTransactionList),
    TypedMiddleware<AppState, ViewTransaction>(viewTransaction),
    TypedMiddleware<AppState, EditTransaction>(editTransaction),
    TypedMiddleware<AppState, LoadTransactions>(loadTransactions),
    TypedMiddleware<AppState, LoadTransaction>(loadTransaction),
    TypedMiddleware<AppState, SaveTransactionRequest>(saveTransaction),
    TypedMiddleware<AppState, ArchiveTransactionsRequest>(archiveTransaction),
    TypedMiddleware<AppState, DeleteTransactionsRequest>(deleteTransaction),
    TypedMiddleware<AppState, RestoreTransactionsRequest>(restoreTransaction),
    TypedMiddleware<AppState, ConvertTransactionsRequest>(convertTransactions),
    TypedMiddleware<AppState, UnlinkTransactionsRequest>(unlinkTransactions),
    TypedMiddleware<AppState, ConvertTransactionToPaymentRequest>(
        convertToPayment),
    TypedMiddleware<AppState, ConvertTransactionsToExpensesRequest>(
        convertToExpense),
    TypedMiddleware<AppState, LinkTransactionToPaymentRequest>(linkToPayment),
    TypedMiddleware<AppState, LinkTransactionToExpenseRequest>(linkToExpense),
  ];
}

Middleware<AppState> _editTransaction() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditTransaction?;

    next(action);

    store.dispatch(UpdateCurrentRoute(TransactionEditScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(TransactionEditScreen.route);
    }
  };
}

Middleware<AppState> _viewTransaction() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewTransaction?;

    next(action);

    store.dispatch(UpdateCurrentRoute(TransactionViewScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(TransactionViewScreen.route);
    }
  };
}

Middleware<AppState> _viewTransactionList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewTransactionList?;

    next(action);

    if (store.state.staticState.isStale) {
      store.dispatch(RefreshData());
    }

    store.dispatch(UpdateCurrentRoute(TransactionScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          TransactionScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _archiveTransaction(TransactionRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ArchiveTransactionsRequest;
    final prevTransactions = action.transactionIds
        .map((id) => store.state.transactionState.map[id])
        .toList();
    repository
        .bulkAction(store.state.credentials, action.transactionIds,
            EntityAction.archive)
        .then((List<TransactionEntity> transactions) {
      store.dispatch(ArchiveTransactionsSuccess(transactions));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveTransactionsFailure(prevTransactions));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _deleteTransaction(TransactionRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DeleteTransactionsRequest;
    final prevTransactions = action.transactionIds
        .map((id) => store.state.transactionState.map[id])
        .toList();
    repository
        .bulkAction(
            store.state.credentials, action.transactionIds, EntityAction.delete)
        .then((List<TransactionEntity> transactions) {
      store.dispatch(DeleteTransactionsSuccess(transactions));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteTransactionsFailure(prevTransactions));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _restoreTransaction(TransactionRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RestoreTransactionsRequest;
    final prevTransactions = action.transactionIds
        .map((id) => store.state.transactionState.map[id])
        .toList();
    repository
        .bulkAction(store.state.credentials, action.transactionIds,
            EntityAction.restore)
        .then((List<TransactionEntity> transactions) {
      store.dispatch(RestoreTransactionsSuccess(transactions));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreTransactionsFailure(prevTransactions));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _convertTransactions(TransactionRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ConvertTransactionsRequest;
    repository
        .bulkAction(store.state.credentials, action.transactionIds,
            EntityAction.convertMatched)
        .then((List<TransactionEntity> transactions) {
      store.dispatch(ConvertTransactionsSuccess(
          BuiltList<TransactionEntity>(transactions)));
      store.dispatch(RefreshData());
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(ConvertTransactionsFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _unlinkTransactions(TransactionRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as UnlinkTransactionsRequest;
    repository
        .bulkAction(
            store.state.credentials, action.transactionIds, EntityAction.unlink)
        .then((List<TransactionEntity> transactions) {
      store.dispatch(UnlinkTransactionsSuccess(
          BuiltList<TransactionEntity>(transactions)));
      store.dispatch(RefreshData());
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(UnlinkTransactionsFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _convertToPayment(TransactionRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ConvertTransactionToPaymentRequest;
    repository
        .convertToPayment(
      store.state.credentials,
      action.transactionId,
      action.invoiceIds,
    )
        .then((TransactionEntity transaction) {
      store.dispatch(ConvertTransactionToPaymentSuccess(transaction));
      store.dispatch(RefreshData());
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(ConvertTransactionToPaymentFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _convertToExpense(TransactionRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ConvertTransactionsToExpensesRequest;
    repository
        .convertToExpense(
      store.state.credentials,
      action.transactionIds,
      action.vendorId,
      action.categoryId,
    )
        .then((BuiltList<TransactionEntity> transactions) {
      store.dispatch(ConvertTransactionsToExpensesSuccess(transactions));
      store.dispatch(RefreshData());
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(ConvertTransactionsToExpensesFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _linkToPayment(TransactionRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LinkTransactionToPaymentRequest;
    repository
        .linkToPayment(
      store.state.credentials,
      action.transactionId,
      action.paymentId,
    )
        .then((TransactionEntity transaction) {
      store.dispatch(LinkTransactionToPaymentSuccess(transaction));
      store.dispatch(RefreshData());
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(LinkTransactionToPaymentFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _linkToExpense(TransactionRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LinkTransactionToExpenseRequest;
    repository
        .linkToExpense(
      store.state.credentials,
      action.transactionId,
      action.expenseId,
    )
        .then((TransactionEntity transaction) {
      store.dispatch(LinkTransactionToExpenseSuccess(transaction));
      store.dispatch(RefreshData());
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(LinkTransactionToExpenseFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _saveTransaction(TransactionRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveTransactionRequest;
    repository
        .saveData(store.state.credentials, action.transaction!)
        .then((TransactionEntity transaction) {
      if (action.transaction!.isNew) {
        store.dispatch(AddTransactionSuccess(transaction));
      } else {
        store.dispatch(SaveTransactionSuccess(transaction));
      }
      store.dispatch(RefreshData());
      action.completer!.complete(transaction);
    }).catchError((Object error) {
      //store.dispatch(AddTransactionSuccess(action.transaction.rebuild((b) => b..id = '1')));
      print(error);
      store.dispatch(SaveTransactionFailure(error));
      action.completer!.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _loadTransaction(TransactionRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadTransaction;
    final AppState state = store.state;

    store.dispatch(LoadTransactionRequest());
    repository
        .loadItem(state.credentials, action.transactionId)
        .then((transaction) {
      store.dispatch(LoadTransactionSuccess(transaction));

      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadTransactionFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadTransactions(TransactionRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadTransactions;
    final AppState state = store.state;

    store.dispatch(LoadTransactionsRequest());
    repository
        .loadList(
      state.credentials,
      action.page,
      state.createdAtLimit,
    )
        .then((data) {
      store.dispatch(LoadTransactionsSuccess(data));

      if (data.length == kMaxRecordsPerPage) {
        store.dispatch(LoadTransactions(
          completer: action.completer,
          page: action.page + 1,
        ));
      } else {
        if (action.completer != null) {
          action.completer!.complete(null);
        }
        store.dispatch(PersistData());
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadTransactionsFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}
