import 'package:invoiceninja_flutter/data/models/recurring_expense_model.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownRecurringExpenseList = memo9(
    (BuiltMap<String, ExpenseEntity> recurringExpenseMap,
            BuiltList<String> expenseList,
            BuiltMap<String, ClientEntity> clientMap,
            BuiltMap<String, UserEntity> userMap,
            BuiltMap<String, VendorEntity> vendorMap,
            BuiltMap<String, InvoiceEntity> invoiceMap,
            BuiltMap<String, ExpenseCategoryEntity> expenseCategoryMap,
            StaticState staticState,
            String clientId) =>
        dropdownRecurringExpensesSelector(
            recurringExpenseMap,
            expenseList,
            clientMap,
            userMap,
            vendorMap,
            invoiceMap,
            expenseCategoryMap,
            staticState,
            clientId));

List<String> dropdownRecurringExpensesSelector(
    BuiltMap<String, ExpenseEntity> recurringExpenseMap,
    BuiltList<String> recurringExpenseList,
    BuiltMap<String, ClientEntity> clientMap,
    BuiltMap<String, UserEntity> userMap,
    BuiltMap<String, VendorEntity> vendorMap,
    BuiltMap<String, InvoiceEntity> invoiceMap,
    BuiltMap<String, ExpenseCategoryEntity> expenseCategoryMap,
    StaticState staticState,
    String clientId) {
  final list = recurringExpenseList.where((recurringExpenseId) {
    final recurringExpense = recurringExpenseMap[recurringExpenseId];
    /*
    if (clientId != null && clientId > 0 && recurringExpense.clientId != clientId) {
      return false;
    }
    */
    return recurringExpense.isActive;
  }).toList();

  list.sort((recurringExpenseAId, recurringExpenseBId) {
    final recurringExpenseA = recurringExpenseMap[recurringExpenseAId];
    final recurringExpenseB = recurringExpenseMap[recurringExpenseBId];
    return recurringExpenseA.compareTo(
        recurringExpenseB,
        RecurringExpenseFields.number,
        true,
        clientMap,
        userMap,
        vendorMap,
        invoiceMap,
        expenseCategoryMap,
        staticState);
  });

  return list;
}

var memoizedFilteredRecurringExpenseList = memo9((SelectionState selectionState,
        BuiltMap<String, ExpenseEntity> expenseMap,
        BuiltMap<String, ClientEntity> clientMap,
        BuiltMap<String, VendorEntity> vendorMap,
        BuiltMap<String, UserEntity> userMap,
        ListUIState expenseListState,
        BuiltMap<String, InvoiceEntity> invoiceMap,
        BuiltMap<String, ExpenseCategoryEntity> expenseCategoryMap,
        StaticState staticState) =>
    filteredRecurringExpensesSelector(
        selectionState,
        expenseMap,
        clientMap,
        vendorMap,
        userMap,
        expenseListState,
        invoiceMap,
        expenseCategoryMap,
        staticState));

List<String> filteredRecurringExpensesSelector(
    SelectionState selectionState,
    BuiltMap<String, ExpenseEntity> expenseMap,
    BuiltMap<String, ClientEntity> clientMap,
    BuiltMap<String, VendorEntity> vendorMap,
    BuiltMap<String, UserEntity> userMap,
    ListUIState expenseListState,
    BuiltMap<String, InvoiceEntity> invoiceMap,
    BuiltMap<String, ExpenseCategoryEntity> expenseCategoryMap,
    StaticState staticState) {
  final filterEntityId = selectionState.filterEntityId;
  final filterEntityType = selectionState.filterEntityType;

  final list = expenseMap.keys.where((expenseId) {
    final expense = expenseMap[expenseId];
    final expenseCategory =
        expenseCategoryMap[expense.categoryId] ?? ExpenseCategoryEntity();
    final vendor =
        vendorMap[expense.vendorId] ?? VendorEntity(id: expense.vendorId);
    final client =
        clientMap[expense.clientId] ?? ClientEntity(id: expense.clientId);

    if (expense.id == selectionState.selectedId) {
      return true;
    }

    if (filterEntityType != null) {
      if (filterEntityType == EntityType.client &&
          expense.clientId != filterEntityId) {
        return false;
      } else if (filterEntityType == EntityType.vendor &&
          expense.vendorId != filterEntityId) {
        return false;
      } else if (filterEntityType == EntityType.expenseCategory &&
          expense.categoryId != filterEntityId) {
        return false;
      } else if (filterEntityType == EntityType.user &&
          expense.assignedUserId != filterEntityId) {
        return false;
      } else if (filterEntityType == EntityType.project &&
          expense.projectId != filterEntityId) {
        return false;
      } else if (filterEntityType == EntityType.invoice &&
          expense.invoiceId != filterEntityId) {
        return false;
      } else if (filterEntityType == EntityType.group &&
          client.groupId != filterEntityId) {
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
    } else if (expenseListState.custom2Filters.isNotEmpty &&
        !expenseListState.custom2Filters.contains(expense.customValue2)) {
      return false;
    } else if (expenseListState.custom3Filters.isNotEmpty &&
        !expenseListState.custom3Filters.contains(expense.customValue3)) {
      return false;
    } else if (expenseListState.custom4Filters.isNotEmpty &&
        !expenseListState.custom4Filters.contains(expense.customValue4)) {
      return false;
    }

    return expense.matchesFilter(expenseListState.filter) ||
        expenseCategory.matchesFilter(expenseListState.filter);
  }).toList();

  list.sort((expenseAId, expenseBId) {
    final expenseA = expenseMap[expenseAId];
    final expenseB = expenseMap[expenseBId];
    return expenseA.compareTo(
        expenseB,
        expenseListState.sortField,
        expenseListState.sortAscending,
        clientMap,
        userMap,
        vendorMap,
        invoiceMap,
        expenseCategoryMap,
        staticState);
  });

  return list;
}

bool hasRecurringExpenseChanges(ExpenseEntity recurringExpense,
        BuiltMap<String, ExpenseEntity> recurringExpenseMap) =>
    recurringExpense.isNew
        ? recurringExpense.isChanged
        : recurringExpense != recurringExpenseMap[recurringExpense.id];
