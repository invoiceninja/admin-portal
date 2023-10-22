import 'package:redux/redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/transaction/transaction_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/transaction/transaction_state.dart';

EntityUIState transactionUIReducer(TransactionUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(transactionListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action)!)
    ..selectedId = selectedIdReducer(state.selectedId, action)
    ..forceSelected = forceSelectedReducer(state.forceSelected, action)
    ..tabIndex = tabIndexReducer(state.tabIndex, action));
}

final forceSelectedReducer = combineReducers<bool?>([
  TypedReducer<bool?, ViewTransaction>((completer, action) => true),
  TypedReducer<bool?, ViewTransactionList>((completer, action) => false),
  TypedReducer<bool?, FilterTransactionsByState>((completer, action) => false),
  TypedReducer<bool?, FilterTransactionsByStatus>((completer, action) => false),
  TypedReducer<bool?, FilterTransactions>((completer, action) => false),
  TypedReducer<bool?, FilterTransactionsByCustom1>(
      (completer, action) => false),
  TypedReducer<bool?, FilterTransactionsByCustom2>(
      (completer, action) => false),
  TypedReducer<bool?, FilterTransactionsByCustom3>(
      (completer, action) => false),
  TypedReducer<bool?, FilterTransactionsByCustom4>(
      (completer, action) => false),
]);

final int? Function(int, dynamic) tabIndexReducer = combineReducers<int?>([
  TypedReducer<int?, UpdateTransactionTab>((completer, action) {
    return action.tabIndex;
  }),
  TypedReducer<int?, PreviewEntity>((completer, action) {
    return 0;
  }),
]);

Reducer<String?> selectedIdReducer = combineReducers([
  TypedReducer<String?, ArchiveTransactionsSuccess>((completer, action) => ''),
  TypedReducer<String?, DeleteTransactionsSuccess>((completer, action) => ''),
  TypedReducer<String?, PreviewEntity>((selectedId, action) =>
      action.entityType == EntityType.transaction
          ? action.entityId
          : selectedId),
  TypedReducer<String?, ViewTransaction>(
      (String? selectedId, dynamic action) => action.transactionId),
  TypedReducer<String?, AddTransactionSuccess>(
      (String? selectedId, dynamic action) => action.transaction.id),
  TypedReducer<String?, SelectCompany>(
      (selectedId, action) => action.clearSelection ? '' : selectedId),
  TypedReducer<String?, ClearEntityFilter>((selectedId, action) => ''),
  TypedReducer<String?, SortTransactions>((selectedId, action) => ''),
  TypedReducer<String?, FilterTransactions>((selectedId, action) => ''),
  TypedReducer<String?, FilterTransactionsByState>((selectedId, action) => ''),
  TypedReducer<String?, FilterTransactionsByStatus>((selectedId, action) => ''),
  TypedReducer<String?, FilterTransactionsByCustom1>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterTransactionsByCustom2>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterTransactionsByCustom3>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterTransactionsByCustom4>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterByEntity>(
      (selectedId, action) => action.clearSelection
          ? ''
          : action.entityType == EntityType.transaction
              ? action.entityId
              : selectedId),
]);

final editingReducer = combineReducers<TransactionEntity?>([
  TypedReducer<TransactionEntity?, SaveTransactionSuccess>(_updateEditing),
  TypedReducer<TransactionEntity?, AddTransactionSuccess>(_updateEditing),
  TypedReducer<TransactionEntity?, RestoreTransactionsSuccess>(
      (transactions, action) {
    return action.transactions[0];
  }),
  TypedReducer<TransactionEntity?, ArchiveTransactionsSuccess>(
      (transactions, action) {
    return action.transactions[0];
  }),
  TypedReducer<TransactionEntity?, DeleteTransactionsSuccess>(
      (transactions, action) {
    return action.transactions[0];
  }),
  TypedReducer<TransactionEntity?, EditTransaction>(_updateEditing),
  TypedReducer<TransactionEntity?, UpdateTransaction>((transaction, action) {
    return action.transaction.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<TransactionEntity?, DiscardChanges>(_clearEditing),
]);

TransactionEntity _clearEditing(
    TransactionEntity? transaction, dynamic action) {
  return TransactionEntity();
}

TransactionEntity? _updateEditing(
    TransactionEntity? transaction, dynamic action) {
  return action.transaction;
}

final transactionListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortTransactions>(_sortTransactions),
  TypedReducer<ListUIState, FilterTransactionsByState>(
      _filterTransactionsByState),
  TypedReducer<ListUIState, FilterTransactionsByStatus>(
      _filterTransactionsByStatus),
  TypedReducer<ListUIState, FilterTransactions>(_filterTransactions),
  TypedReducer<ListUIState, FilterTransactionsByCustom1>(
      _filterTransactionsByCustom1),
  TypedReducer<ListUIState, FilterTransactionsByCustom2>(
      _filterTransactionsByCustom2),
  TypedReducer<ListUIState, StartTransactionMultiselect>(_startListMultiselect),
  TypedReducer<ListUIState, AddToTransactionMultiselect>(_addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromTransactionMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearTransactionMultiselect>(_clearListMultiselect),
  TypedReducer<ListUIState, ViewTransactionList>(_viewTransactionList),
  TypedReducer<ListUIState, FilterByEntity>(
      (state, action) => state.rebuild((b) => b
        ..filter = null
        ..filterClearedAt = DateTime.now().millisecondsSinceEpoch)),
]);

ListUIState _viewTransactionList(
    ListUIState transactionListState, ViewTransactionList action) {
  return transactionListState.rebuild((b) => b
    ..selectedIds = null
    ..filter = null
    ..filterClearedAt = DateTime.now().millisecondsSinceEpoch);
}

ListUIState _filterTransactionsByCustom1(
    ListUIState transactionListState, FilterTransactionsByCustom1 action) {
  if (transactionListState.custom1Filters.contains(action.value)) {
    return transactionListState
        .rebuild((b) => b..custom1Filters.remove(action.value));
  } else {
    return transactionListState
        .rebuild((b) => b..custom1Filters.add(action.value));
  }
}

ListUIState _filterTransactionsByCustom2(
    ListUIState transactionListState, FilterTransactionsByCustom2 action) {
  if (transactionListState.custom2Filters.contains(action.value)) {
    return transactionListState
        .rebuild((b) => b..custom2Filters.remove(action.value));
  } else {
    return transactionListState
        .rebuild((b) => b..custom2Filters.add(action.value));
  }
}

ListUIState _filterTransactionsByState(
    ListUIState transactionListState, FilterTransactionsByState action) {
  if (transactionListState.stateFilters.contains(action.state)) {
    return transactionListState
        .rebuild((b) => b..stateFilters.remove(action.state));
  } else {
    return transactionListState
        .rebuild((b) => b..stateFilters.add(action.state));
  }
}

ListUIState _filterTransactionsByStatus(
    ListUIState transactionListState, FilterTransactionsByStatus action) {
  if (transactionListState.statusFilters.contains(action.status)) {
    return transactionListState
        .rebuild((b) => b..statusFilters.remove(action.status));
  } else {
    return transactionListState
        .rebuild((b) => b..statusFilters.add(action.status));
  }
}

ListUIState _filterTransactions(
    ListUIState transactionListState, FilterTransactions action) {
  return transactionListState.rebuild((b) => b
    ..filter = action.filter
    ..filterClearedAt = action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : transactionListState.filterClearedAt);
}

ListUIState _sortTransactions(
    ListUIState transactionListState, SortTransactions action) {
  return transactionListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending!
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState productListState, StartTransactionMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState productListState, AddToTransactionMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds.add(action.entity!.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState productListState, RemoveFromTransactionMultiselect action) {
  return productListState
      .rebuild((b) => b..selectedIds.remove(action.entity!.id));
}

ListUIState _clearListMultiselect(
    ListUIState productListState, ClearTransactionMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = null);
}

final transactionsReducer = combineReducers<TransactionState>([
  TypedReducer<TransactionState, SaveTransactionSuccess>(_updateTransaction),
  TypedReducer<TransactionState, ConvertTransactionToPaymentSuccess>(
      _convertTransactionToPayment),
  TypedReducer<TransactionState, ConvertTransactionsToExpensesSuccess>(
      _convertTransactionToExpense),
  TypedReducer<TransactionState, LinkTransactionToPaymentSuccess>(
      _linkTransactionToPayment),
  TypedReducer<TransactionState, LinkTransactionToExpenseSuccess>(
      _linkTransactionToExpense),
  TypedReducer<TransactionState, ConvertTransactionsSuccess>(
      _convertTransactions),
  TypedReducer<TransactionState, AddTransactionSuccess>(_addTransaction),
  TypedReducer<TransactionState, LoadTransactionsSuccess>(
      _setLoadedTransactions),
  TypedReducer<TransactionState, LoadTransactionSuccess>(_setLoadedTransaction),
  TypedReducer<TransactionState, LoadCompanySuccess>(_setLoadedCompany),
  TypedReducer<TransactionState, ArchiveTransactionsSuccess>(
      _archiveTransactionSuccess),
  TypedReducer<TransactionState, DeleteTransactionsSuccess>(
      _deleteTransactionSuccess),
  TypedReducer<TransactionState, RestoreTransactionsSuccess>(
      _restoreTransactionSuccess),
]);

TransactionState _archiveTransactionSuccess(
    TransactionState transactionState, ArchiveTransactionsSuccess action) {
  return transactionState.rebuild((b) {
    for (final transaction in action.transactions) {
      b.map[transaction.id] = transaction;
    }
  });
}

TransactionState _deleteTransactionSuccess(
    TransactionState transactionState, DeleteTransactionsSuccess action) {
  return transactionState.rebuild((b) {
    for (final transaction in action.transactions) {
      b.map[transaction.id] = transaction;
    }
  });
}

TransactionState _restoreTransactionSuccess(
    TransactionState transactionState, RestoreTransactionsSuccess action) {
  return transactionState.rebuild((b) {
    for (final transaction in action.transactions) {
      b.map[transaction.id] = transaction;
    }
  });
}

TransactionState _addTransaction(
    TransactionState transactionState, AddTransactionSuccess action) {
  return transactionState.rebuild((b) => b
    ..map[action.transaction.id] = action.transaction
    ..list.add(action.transaction.id));
}

TransactionState _updateTransaction(
    TransactionState transactionState, SaveTransactionSuccess action) {
  return transactionState
      .rebuild((b) => b..map[action.transaction.id] = action.transaction);
}

TransactionState _convertTransactionToPayment(TransactionState transactionState,
    ConvertTransactionToPaymentSuccess action) {
  return transactionState
      .rebuild((b) => b..map[action.transaction.id] = action.transaction);
}

TransactionState _convertTransactionToExpense(TransactionState transactionState,
    ConvertTransactionsToExpensesSuccess action) {
  return transactionState.loadTransactions(action.transactions);
}

TransactionState _linkTransactionToPayment(
    TransactionState transactionState, LinkTransactionToPaymentSuccess action) {
  return transactionState
      .rebuild((b) => b..map[action.transaction.id] = action.transaction);
}

TransactionState _linkTransactionToExpense(
    TransactionState transactionState, LinkTransactionToExpenseSuccess action) {
  return transactionState
      .rebuild((b) => b..map[action.transaction.id] = action.transaction);
}

TransactionState _convertTransactions(
    TransactionState transactionState, ConvertTransactionsSuccess action) {
  return transactionState.loadTransactions(action.transactions);
}

TransactionState _setLoadedTransaction(
    TransactionState transactionState, LoadTransactionSuccess action) {
  return transactionState
      .rebuild((b) => b..map[action.transaction.id] = action.transaction);
}

TransactionState _setLoadedTransactions(
        TransactionState transactionState, LoadTransactionsSuccess action) =>
    transactionState.loadTransactions(action.transactions);

TransactionState _setLoadedCompany(
    TransactionState transactionState, LoadCompanySuccess action) {
  final company = action.userCompany.company;
  return transactionState.loadTransactions(company.transactions);
}
