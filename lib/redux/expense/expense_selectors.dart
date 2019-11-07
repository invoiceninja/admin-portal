import 'package:flutter/foundation.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

InvoiceItemEntity convertExpenseToInvoiceItem(
    {@required ExpenseEntity expense,
    @required BuiltMap<String, ExpenseCategoryEntity> categoryMap}) {
  return InvoiceItemEntity().rebuild((b) => b
    ..expenseId = expense.id
    ..productKey = categoryMap[expense.categoryId]?.name ?? ''
    ..notes = expense.publicNotes
    ..quantity = 1
    ..cost = expense.convertedAmount
    ..taxName1 = expense.taxName1
    ..taxRate1 = expense.taxRate1
    ..taxName2 = expense.taxName2
    ..taxRate2 = expense.taxRate2);
}

var memoizedDropdownExpenseList = memo3(
    (BuiltMap<String, ExpenseEntity> expenseMap, BuiltList<String> expenseList,
            String clientId) =>
        dropdownExpensesSelector(expenseMap, expenseList, clientId));

List<String> dropdownExpensesSelector(
    BuiltMap<String, ExpenseEntity> expenseMap,
    BuiltList<String> expenseList,
    String clientId) {
  final list = expenseList.where((expenseId) {
    final expense = expenseMap[expenseId];
    /*
    if (clientId != null && clientId > 0 && expense.clientId != clientId) {
      return false;
    }
    */
    return expense.isActive;
  }).toList();

  list.sort((expenseAId, expenseBId) {
    final expenseA = expenseMap[expenseAId];
    final expenseB = expenseMap[expenseBId];
    return expenseA.compareTo(expenseB, ExpenseFields.expenseDate, true);
  });

  return list;
}

var memoizedFilteredExpenseList = memo5(
    (BuiltMap<String, ExpenseEntity> expenseMap,
            BuiltMap<String, ClientEntity> clientMap,
            BuiltMap<String, VendorEntity> vendorMap,
            BuiltList<String> expenseList,
            ListUIState expenseListState) =>
        filteredExpensesSelector(
            expenseMap, clientMap, vendorMap, expenseList, expenseListState));

List<String> filteredExpensesSelector(
    BuiltMap<String, ExpenseEntity> expenseMap,
    BuiltMap<String, ClientEntity> clientMap,
    BuiltMap<String, VendorEntity> vendorMap,
    BuiltList<String> expenseList,
    ListUIState expenseListState) {
  final list = expenseList.where((expenseId) {
    final expense = expenseMap[expenseId];
    final vendor =
        vendorMap[expense.vendorId] ?? VendorEntity(id: expense.vendorId);
    final client =
        clientMap[expense.clientId] ?? ClientEntity(id: expense.clientId);

    if (expenseListState.filterEntityType != null) {
      if (expenseListState.filterEntityType == EntityType.client &&
          expense.clientId != expenseListState.filterEntityId) {
        return false;
      } else if (expenseListState.filterEntityType == EntityType.vendor &&
          expense.vendorId != expenseListState.filterEntityId) {
        return false;
      }
    } else if (expense.vendorId != null && !vendor.isActive) {
      return false;
    } else if (expense.clientId != null && !client.isActive) {
      return false;
    }

    if (!expense.matchesStates(expenseListState.stateFilters)) {
      return false;
    }
    if (!expense.matchesStatuses(expenseListState.statusFilters)) {
      return false;
    }

    if (expenseListState.custom1Filters.isNotEmpty &&
        !expenseListState.custom1Filters.contains(expense.customValue1)) {
      return false;
    }
    if (expenseListState.custom2Filters.isNotEmpty &&
        !expenseListState.custom2Filters.contains(expense.customValue2)) {
      return false;
    }
    return expense.matchesFilter(expenseListState.filter);
  }).toList();

  list.sort((expenseAId, expenseBId) {
    final expenseA = expenseMap[expenseAId];
    final expenseB = expenseMap[expenseBId];
    return expenseA.compareTo(
        expenseB, expenseListState.sortField, expenseListState.sortAscending);
  });

  return list;
}

var memoizedExpenseStatsForVendor = memo2((String vendorId,
    BuiltMap<String, ExpenseEntity> expenseMap) =>
    expenseStatsForVendor(vendorId, expenseMap));

EntityStats expenseStatsForVendor(
    String vendorId,
    BuiltMap<String, ExpenseEntity> expenseMap) {
  int countActive = 0;
  int countArchived = 0;
  expenseMap.forEach((expenseId, expense) {
    if (expense.vendorId == vendorId) {
      if (expense.isActive) {
        countActive++;
      } else if (expense.isArchived) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}

var memoizedExpenseStatsForClient = memo2((String clientId,
        BuiltMap<String, ExpenseEntity> expenseMap) =>
    expenseStatsForClient(clientId, expenseMap));

EntityStats expenseStatsForClient(
    String clientId,
    BuiltMap<String, ExpenseEntity> expenseMap) {
  int countActive = 0;
  int countArchived = 0;
  expenseMap.forEach((expenseId, expense) {
    if (expense.clientId == clientId) {
      if (expense.isActive) {
        countActive++;
      } else if (expense.isArchived) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}

var memoizedClientExpenseList = memo2(
    (BuiltMap<String, ExpenseEntity> expenseMap, String clientId) =>
        clientExpenseList(expenseMap, clientId));

List<String> clientExpenseList(
    BuiltMap<String, ExpenseEntity> expenseMap, String clientId) {
  final list = expenseMap.keys.where((expenseid) {
    final expense = expenseMap[expenseid];
    if (clientId != null && clientId != null && expense.clientId != clientId) {
      return false;
    }
    return expense.isActive && !expense.isInvoiced;
  }).toList();

  list.sort((idA, idB) => expenseMap[idA]
      .listDisplayName
      .compareTo(expenseMap[idB].listDisplayName));

  return list;
}

bool hasExpenseChanges(
        ExpenseEntity expense, BuiltMap<String, ExpenseEntity> expenseMap) =>
    expense.isNew ? expense.isChanged : expense != expenseMap[expense.id];
