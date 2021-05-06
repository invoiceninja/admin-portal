import 'package:flutter/foundation.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

InvoiceItemEntity convertExpenseToInvoiceItem({
  @required ExpenseEntity expense,
  @required BuiltMap<String, ExpenseCategoryEntity> categoryMap,
  @required CompanyEntity company,
}) {
  return InvoiceItemEntity().rebuild((b) => b
    ..typeId = InvoiceItemEntity.TYPE_EXPENSE
    ..expenseId = expense.id
    ..productKey = categoryMap[expense.categoryId]?.name ?? ''
    ..notes = expense.publicNotes
    ..quantity =
        company.defaultQuantity || !company.enableProductQuantity ? 1 : null
    ..cost = company.settings.enableInclusiveTaxes
        ? expense.convertedAmount
        : expense.convertedNetAmount
    ..customValue1 = expense.customValue1
    ..customValue2 = expense.customValue2
    ..customValue3 = expense.customValue3
    ..customValue4 = expense.customValue4
    ..taxName1 = company.numberOfItemTaxRates >= 1 ? expense.taxName1 : ''
    ..taxRate1 =
        company.numberOfItemTaxRates >= 1 ? expense.calculatetaxRate1 : 0
    ..taxName2 = company.numberOfItemTaxRates >= 2 ? expense.taxName2 : ''
    ..taxRate2 =
        company.numberOfItemTaxRates >= 2 ? expense.calculatetaxRate2 : 0
    ..taxName3 = company.numberOfItemTaxRates >= 3 ? expense.taxName3 : ''
    ..taxRate3 =
        company.numberOfItemTaxRates >= 3 ? expense.calculatetaxRate3 : 0);
}

var memoizedDropdownExpenseList = memo9(
    (BuiltMap<String, ExpenseEntity> expenseMap,
            BuiltList<String> expenseList,
            BuiltMap<String, ClientEntity> clientMap,
            BuiltMap<String, UserEntity> userMap,
            BuiltMap<String, VendorEntity> vendorMap,
            BuiltMap<String, InvoiceEntity> invoiceMap,
            BuiltMap<String, ExpenseCategoryEntity> expenseCategoryMap,
            StaticState staticState,
            String clientId) =>
        dropdownExpensesSelector(expenseMap, expenseList, clientMap, userMap,
            vendorMap, invoiceMap, expenseCategoryMap, staticState, clientId));

List<String> dropdownExpensesSelector(
    BuiltMap<String, ExpenseEntity> expenseMap,
    BuiltList<String> expenseList,
    BuiltMap<String, ClientEntity> clientMap,
    BuiltMap<String, UserEntity> userMap,
    BuiltMap<String, VendorEntity> vendorMap,
    BuiltMap<String, InvoiceEntity> invoiceMap,
    BuiltMap<String, ExpenseCategoryEntity> expenseCategoryMap,
    StaticState staticState,
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
    return expenseA.compareTo(
        expenseB,
        ExpenseFields.expenseDate,
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

var memoizedFilteredExpenseList = memo9((SelectionState selectionState,
        BuiltMap<String, ExpenseEntity> expenseMap,
        BuiltMap<String, ClientEntity> clientMap,
        BuiltMap<String, VendorEntity> vendorMap,
        BuiltMap<String, UserEntity> userMap,
        ListUIState expenseListState,
        BuiltMap<String, InvoiceEntity> invoiceMap,
        BuiltMap<String, ExpenseCategoryEntity> expenseCategoryMap,
        StaticState staticState) =>
    filteredExpensesSelector(
        selectionState,
        expenseMap,
        clientMap,
        vendorMap,
        userMap,
        expenseListState,
        invoiceMap,
        expenseCategoryMap,
        staticState));

List<String> filteredExpensesSelector(
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

var memoizedExpenseStatsForVendor = memo2(
    (String vendorId, BuiltMap<String, ExpenseEntity> expenseMap) =>
        expenseStatsForVendor(vendorId, expenseMap));

EntityStats expenseStatsForVendor(
    String vendorId, BuiltMap<String, ExpenseEntity> expenseMap) {
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

var memoizedExpenseStatsForClient = memo2(
    (String clientId, BuiltMap<String, ExpenseEntity> expenseMap) =>
        expenseStatsForClient(clientId, expenseMap));

EntityStats expenseStatsForClient(
    String clientId, BuiltMap<String, ExpenseEntity> expenseMap) {
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

var memoizedExpenseStatsForProject = memo2((
  String projectId,
  BuiltMap<String, ExpenseEntity> expenseMap,
) =>
    expenseStatsForProject(projectId, expenseMap));

EntityStats expenseStatsForProject(
    String projectId, BuiltMap<String, ExpenseEntity> expenseMap) {
  int countActive = 0;
  int countArchived = 0;
  expenseMap.forEach((expenseId, expense) {
    if (expense.projectId == projectId) {
      if (expense.isActive) {
        countActive++;
      } else if (expense.isArchived) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}

var memoizedExpenseStatsForUser = memo2((
  String userId,
  BuiltMap<String, ExpenseEntity> expenseMap,
) =>
    expenseStatsForUser(userId, expenseMap));

EntityStats expenseStatsForUser(
    String userId, BuiltMap<String, ExpenseEntity> expenseMap) {
  int countActive = 0;
  int countArchived = 0;
  expenseMap.forEach((expenseId, expense) {
    if (expense.assignedUserId == userId) {
      if (expense.isActive) {
        countActive++;
      } else if (expense.isArchived) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}

bool hasExpenseChanges(
        ExpenseEntity expense, BuiltMap<String, ExpenseEntity> expenseMap) =>
    expense.isNew ? expense.isChanged : expense != expenseMap[expense.id];
