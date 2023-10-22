// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownExpenseCategoryList = memo5(
    (BuiltMap<String, ExpenseCategoryEntity> expenseCategoryMap,
            BuiltList<String> expenseCategoryList,
            StaticState staticState,
            BuiltMap<String, UserEntity> userMap,
            String categoryId) =>
        dropdownExpenseCategoriesSelector(expenseCategoryMap,
            expenseCategoryList, staticState, userMap, categoryId));

List<String> dropdownExpenseCategoriesSelector(
    BuiltMap<String, ExpenseCategoryEntity> expenseCategoryMap,
    BuiltList<String> expenseCategoryList,
    StaticState staticState,
    BuiltMap<String, UserEntity> userMap,
    String clientId) {
  final list = expenseCategoryList.where((expenseCategoryId) {
    final expenseCategory = expenseCategoryMap[expenseCategoryId]!;
    /*
    if (clientId != null && clientId > 0 && expenseCategory.clientId != clientId) {
      return false;
    }
    */
    return expenseCategory.isActive;
  }).toList();

  list.sort((expenseCategoryAId, expenseCategoryBId) {
    final expenseCategoryA = expenseCategoryMap[expenseCategoryAId]!;
    final expenseCategoryB = expenseCategoryMap[expenseCategoryBId];
    return expenseCategoryA.compareTo(
        expenseCategory: expenseCategoryB,
        sortField: ExpenseCategoryFields.name,
        sortAscending: true);
  });

  return list;
}

var memoizedFilteredExpenseCategoryList = memo4((SelectionState selectionState,
        BuiltMap<String, ExpenseCategoryEntity> expenseCategoryMap,
        BuiltList<String> expenseCategoryList,
        ListUIState expenseCategoryListState) =>
    filteredExpenseCategoriesSelector(selectionState, expenseCategoryMap,
        expenseCategoryList, expenseCategoryListState));

List<String> filteredExpenseCategoriesSelector(
    SelectionState selectionState,
    BuiltMap<String, ExpenseCategoryEntity> expenseCategoryMap,
    BuiltList<String> expenseCategoryList,
    ListUIState expenseCategoryListState) {
  final list = expenseCategoryList.where((expenseCategoryId) {
    final expenseCategory = expenseCategoryMap[expenseCategoryId]!;

    if (expenseCategory.id == selectionState.selectedId) {
      return true;
    }

    if (!expenseCategory.matchesStates(expenseCategoryListState.stateFilters)) {
      return false;
    }
    return expenseCategory.matchesFilter(expenseCategoryListState.filter);
  }).toList();

  list.sort((expenseCategoryAId, expenseCategoryBId) {
    return expenseCategoryMap[expenseCategoryAId]!.compareTo(
      expenseCategory: expenseCategoryMap[expenseCategoryBId],
      sortField: expenseCategoryListState.sortField,
      sortAscending: expenseCategoryListState.sortAscending,
    );
  });

  return list;
}

var memoizedCalculateExpenseCategoryAmount = memo2(
    (String categoryId, BuiltMap<String, ExpenseEntity> expenseMap) =>
        calculateExpenseCategoryAmount(
            categoryId: categoryId, expenseMap: expenseMap));

double calculateExpenseCategoryAmount({
  String? categoryId,
  required BuiltMap<String, ExpenseEntity> expenseMap,
}) {
  double total = 0;

  expenseMap.forEach((expenseId, expense) {
    if (expense.categoryId == categoryId) {
      total += expense.grossAmount;
    }
  });

  return total;
}

var memoizedExpenseStatsForExpenseCategory = memo2(
    (String companyGatewayId, BuiltMap<String, ExpenseEntity> expenseMap) =>
        expenseStatsForExpenseCategory(companyGatewayId, expenseMap));

EntityStats expenseStatsForExpenseCategory(
  String categoryId,
  BuiltMap<String, ExpenseEntity> expenseMap,
) {
  int countActive = 0;
  int countArchived = 0;
  expenseMap.forEach((expenseId, expense) {
    if (expense.categoryId == categoryId) {
      if (expense.isActive) {
        countActive++;
      } else if (expense.isArchived) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}

var memoizedTransactionStatsForExpenseCategory = memo2((String companyGatewayId,
        BuiltMap<String, TransactionEntity> transactionMap) =>
    transactionStatsForExpenseCategory(companyGatewayId, transactionMap));

EntityStats transactionStatsForExpenseCategory(
  String categoryId,
  BuiltMap<String, TransactionEntity> transactionMap,
) {
  int countActive = 0;
  int countArchived = 0;
  transactionMap.forEach((transactionId, transaction) {
    if (transaction.categoryId == categoryId) {
      if (transaction.isActive) {
        countActive++;
      } else if (transaction.isArchived) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}
