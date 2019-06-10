import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

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
    /*
    if (expenseListState.filterEntityId != null &&
        expense.clientId != expenseListState.filterEntityId) {
      return false;
    }
    */
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


var memoizedExpenseStatsForVendor = memo4((int vendorId,
    BuiltMap<int, ExpenseEntity> expenseMap,
    String activeLabel,
    String archivedLabel) =>
    expenseStatsForVendor(vendorId, expenseMap, activeLabel, archivedLabel));

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
