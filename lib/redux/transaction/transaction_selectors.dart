import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownTransactionList = memo9(
    (BuiltMap<String, TransactionEntity> transactionMap,
            BuiltList<String> transactionList,
            StaticState staticState,
            BuiltMap<String, UserEntity> userMap,
            BuiltMap<String, InvoiceEntity> invoiceMap,
            BuiltMap<String, ExpenseEntity> expenseMap,
            BuiltMap<String, ExpenseCategoryEntity> expenseCategoryMap,
            BuiltMap<String, BankAccountEntity> bankAccountMap,
            String clientId) =>
        dropdownTransactionsSelector(
            transactionMap,
            transactionList,
            staticState,
            userMap,
            invoiceMap,
            expenseMap,
            expenseCategoryMap,
            bankAccountMap,
            clientId));

List<String> dropdownTransactionsSelector(
    BuiltMap<String, TransactionEntity> transactionMap,
    BuiltList<String> transactionList,
    StaticState staticState,
    BuiltMap<String, UserEntity> userMap,
    BuiltMap<String, InvoiceEntity> invoiceMap,
    BuiltMap<String, ExpenseEntity> expenseMap,
    BuiltMap<String, ExpenseCategoryEntity> expenseCategoryMap,
    BuiltMap<String, BankAccountEntity> bankAccountMap,
    String clientId) {
  final list = transactionList.where((transactionId) {
    final transaction = transactionMap[transactionId];
    /*
    if (clientId != null && clientId > 0 && transaction.clientId != clientId) {
      return false;
    }
    */
    return transaction.isActive;
  }).toList();

  list.sort((transactionAId, transactionBId) {
    final transactionA = transactionMap[transactionAId];
    final transactionB = transactionMap[transactionBId];
    return transactionA.compareTo(transactionB, TransactionFields.date, true,
        invoiceMap, expenseMap, expenseCategoryMap, bankAccountMap);
  });

  return list;
}

var memoizedFilteredTransactionList = memo8((SelectionState selectionState,
        BuiltMap<String, TransactionEntity> transactionMap,
        BuiltList<String> transactionList,
        BuiltMap<String, InvoiceEntity> invoiceMap,
        BuiltMap<String, ExpenseEntity> expenseMap,
        BuiltMap<String, ExpenseCategoryEntity> expenseCategoryMap,
        BuiltMap<String, BankAccountEntity> bankAccountMap,
        ListUIState transactionListState) =>
    filteredTransactionsSelector(
        selectionState,
        transactionMap,
        transactionList,
        invoiceMap,
        expenseMap,
        expenseCategoryMap,
        bankAccountMap,
        transactionListState));

List<String> filteredTransactionsSelector(
    SelectionState selectionState,
    BuiltMap<String, TransactionEntity> transactionMap,
    BuiltList<String> transactionList,
    BuiltMap<String, InvoiceEntity> invoiceMap,
    BuiltMap<String, ExpenseEntity> expenseMap,
    BuiltMap<String, ExpenseCategoryEntity> expenseCategoryMap,
    BuiltMap<String, BankAccountEntity> bankAccountMap,
    ListUIState transactionListState) {
  final filterEntityId = selectionState.filterEntityId;
  //final filterEntityType = selectionState.filterEntityType;

  final list = transactionList.where((transactionId) {
    final transaction = transactionMap[transactionId];
    if (filterEntityId != null && transaction.id != filterEntityId) {
      return false;
    } else {
      //
    }

    if (!transaction.matchesStates(transactionListState.stateFilters)) {
      return false;
    }

    if (!transaction.matchesStatuses(transactionListState.statusFilters)) {
      return false;
    }

    return transaction.matchesFilter(transactionListState.filter);
  }).toList();

  list.sort((transactionAId, transactionBId) {
    final transactionA = transactionMap[transactionAId];
    final transactionB = transactionMap[transactionBId];
    return transactionA.compareTo(
        transactionB,
        transactionListState.sortField,
        transactionListState.sortAscending,
        invoiceMap,
        expenseMap,
        expenseCategoryMap,
        bankAccountMap);
  });

  return list;
}
