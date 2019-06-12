import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

InvoiceItemEntity convertExpenseToInvoiceItem({ExpenseEntity expense}) {
  return InvoiceItemEntity().rebuild((b) => b
    ..expenseId = expense.id
    ..notes = expense.publicNotes
    ..qty = 1
    ..cost = expense.amount
    ..taxName1 = expense.taxName1
    ..taxRate1 = expense.taxRate1
    ..taxName2 = expense.taxName2
    ..taxRate2 = expense.taxRate2);
}

var memoizedDropdownExpenseList = memo3(
    (BuiltMap<int, ExpenseEntity> expenseMap, BuiltList<int> expenseList,
            int clientId) =>
        dropdownExpensesSelector(expenseMap, expenseList, clientId));

List<int> dropdownExpensesSelector(BuiltMap<int, ExpenseEntity> expenseMap,
    BuiltList<int> expenseList, int clientId) {
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

var memoizedFilteredExpenseList = memo3(
    (BuiltMap<int, ExpenseEntity> expenseMap, BuiltList<int> expenseList,
            ListUIState expenseListState) =>
        filteredExpensesSelector(expenseMap, expenseList, expenseListState));

List<int> filteredExpensesSelector(BuiltMap<int, ExpenseEntity> expenseMap,
    BuiltList<int> expenseList, ListUIState expenseListState) {
  final list = expenseList.where((expenseId) {
    final expense = expenseMap[expenseId];
    if (!expense.matchesStates(expenseListState.stateFilters)) {
      return false;
    }

    if (expenseListState.filterEntityId != null &&
        expenseListState.filterEntityType == EntityType.client &&
        expense.clientId != expenseListState.filterEntityId) {
      return false;
    }

    if (expenseListState.filterEntityId != null &&
        expenseListState.filterEntityType == EntityType.vendor &&
        expense.vendorId != expenseListState.filterEntityId) {
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
    /*
    if (expenseListState.filterEntityId != null &&
        expense.entityId != expenseListState.filterEntityId) {
      return false;
    }
    */
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

String expenseStatsForVendor(
    int vendorId,
    BuiltMap<int, ExpenseEntity> expenseMap,
    String activeLabel,
    String archivedLabel) {
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

  String str = '';
  if (countActive > 0) {
    str = '$countActive $activeLabel';
    if (countArchived > 0) {
      str += ' • ';
    }
  }
  if (countArchived > 0) {
    str += '$countArchived $archivedLabel';
  }

  return str;
}

var memoizedExpenseStatsForClient = memo4((int clientId,
        BuiltMap<int, ExpenseEntity> expenseMap,
        String activeLabel,
        String archivedLabel) =>
    expenseStatsForClient(clientId, expenseMap, activeLabel, archivedLabel));

String expenseStatsForClient(
    int clientId,
    BuiltMap<int, ExpenseEntity> expenseMap,
    String activeLabel,
    String archivedLabel) {
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

  String str = '';
  if (countActive > 0) {
    str = '$countActive $activeLabel';
    if (countArchived > 0) {
      str += ' • ';
    }
  }
  if (countArchived > 0) {
    str += '$countArchived $archivedLabel';
  }

  return str;
}

var memoizedExpenseStatsForVendor = memo4((int vendorId,
        BuiltMap<int, ExpenseEntity> expenseMap,
        String activeLabel,
        String archivedLabel) =>
    expenseStatsForVendor(vendorId, expenseMap, activeLabel, archivedLabel));

var memoizedClientExpenseList = memo2(
    (BuiltMap<int, ExpenseEntity> expenseMap, int clientId) =>
        clientExpenseList(expenseMap, clientId));

List<int> clientExpenseList(
    BuiltMap<int, ExpenseEntity> expenseMap, int clientId) {
  final list = expenseMap.keys.where((expenseid) {
    final expense = expenseMap[expenseid];
    if (clientId != null && clientId != 0 && expense.clientId != clientId) {
      return false;
    }
    return expense.isActive && !expense.isInvoiced;
  }).toList();

  list.sort((idA, idB) => expenseMap[idA]
      .listDisplayName
      .compareTo(expenseMap[idB].listDisplayName));

  return list;
}
