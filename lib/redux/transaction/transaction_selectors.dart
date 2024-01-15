import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownTransactionList = memo10(
    (BuiltMap<String, TransactionEntity> transactionMap,
            BuiltList<String> transactionList,
            StaticState staticState,
            BuiltMap<String, UserEntity> userMap,
            BuiltMap<String, InvoiceEntity> invoiceMap,
            BuiltMap<String, VendorEntity> vendorMap,
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
            vendorMap,
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
    BuiltMap<String, VendorEntity> vendorMap,
    BuiltMap<String, ExpenseEntity> expenseMap,
    BuiltMap<String, ExpenseCategoryEntity> expenseCategoryMap,
    BuiltMap<String, BankAccountEntity> bankAccountMap,
    String clientId) {
  final list = transactionList.where((transactionId) {
    final transaction = transactionMap[transactionId]!;
    /*
    if (clientId != null && clientId > 0 && transaction.clientId != clientId) {
      return false;
    }
    */
    return transaction.isActive;
  }).toList();

  list.sort((transactionAId, transactionBId) {
    final transactionA = transactionMap[transactionAId]!;
    final transactionB = transactionMap[transactionBId];
    return transactionA.compareTo(transactionB, TransactionFields.date, true,
        vendorMap, invoiceMap, expenseMap, expenseCategoryMap, bankAccountMap);
  });

  return list;
}

var memoizedFilteredTransactionList = memo9((SelectionState selectionState,
        BuiltMap<String, TransactionEntity> transactionMap,
        BuiltList<String> transactionList,
        BuiltMap<String, InvoiceEntity> invoiceMap,
        BuiltMap<String, VendorEntity> vendorMap,
        BuiltMap<String, ExpenseEntity> expenseMap,
        BuiltMap<String, ExpenseCategoryEntity> expenseCategoryMap,
        BuiltMap<String, BankAccountEntity> bankAccountMap,
        ListUIState transactionListState) =>
    filteredTransactionsSelector(
        selectionState,
        transactionMap,
        transactionList,
        invoiceMap,
        vendorMap,
        expenseMap,
        expenseCategoryMap,
        bankAccountMap,
        transactionListState));

List<String> filteredTransactionsSelector(
    SelectionState selectionState,
    BuiltMap<String, TransactionEntity> transactionMap,
    BuiltList<String> transactionList,
    BuiltMap<String, InvoiceEntity> invoiceMap,
    BuiltMap<String, VendorEntity> vendorMap,
    BuiltMap<String, ExpenseEntity> expenseMap,
    BuiltMap<String, ExpenseCategoryEntity> expenseCategoryMap,
    BuiltMap<String, BankAccountEntity> bankAccountMap,
    ListUIState transactionListState) {
  final filterEntityId = selectionState.filterEntityId;
  final filterEntityType = selectionState.filterEntityType;

  final list = transactionList.where((transactionId) {
    final transaction = transactionMap[transactionId]!;

    if (transaction.id == selectionState.selectedId) {
      return true;
    }

    final bankAccount =
        bankAccountMap[transaction.bankAccountId] ?? BankAccountEntity();
    if (!bankAccount.isActive &&
        !bankAccount.matchesEntityFilter(filterEntityType, filterEntityId)) {
      return false;
    }

    if (filterEntityType != null) {
      if (filterEntityType == EntityType.expenseCategory &&
          transaction.categoryId != filterEntityId) {
        return false;
      } else if (filterEntityType == EntityType.vendor &&
          transaction.vendorId != filterEntityId) {
        return false;
      } else if (filterEntityType == EntityType.invoice &&
          !transaction.invoiceIds.split(',').contains(filterEntityId)) {
        return false;
      } else if (filterEntityType == EntityType.expense &&
          transaction.expenseId != filterEntityId) {
        return false;
      } else if (filterEntityType == EntityType.bankAccount &&
          transaction.bankAccountId != filterEntityId) {
        return false;
      } else if (filterEntityType == EntityType.transactionRule &&
          transaction.transactionRuleId != filterEntityId) {
        return false;
      } else if (filterEntityType == EntityType.payment &&
          transaction.paymentId != filterEntityId) {
        return false;
      }
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
    final transactionA = transactionMap[transactionAId]!;
    final transactionB = transactionMap[transactionBId];
    return transactionA.compareTo(
        transactionB,
        transactionListState.sortField,
        transactionListState.sortAscending,
        vendorMap,
        invoiceMap,
        expenseMap,
        expenseCategoryMap,
        bankAccountMap);
  });

  return list;
}

var memoizedTransactionStatsForBankAccount = memo2((String bankAccountId,
        BuiltMap<String, TransactionEntity> transactionMap) =>
    transactionStatsForBankAccount(bankAccountId, transactionMap));

EntityStats transactionStatsForBankAccount(
    String bankAccountId, BuiltMap<String, TransactionEntity> transactionMap) {
  int countActive = 0;
  int countArchived = 0;
  transactionMap.forEach((transactionId, transaction) {
    if (transaction.bankAccountId == bankAccountId) {
      if (transaction.isActive) {
        countActive++;
      } else if (transaction.isArchived) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}
