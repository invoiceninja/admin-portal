// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedExpensePurchaseOrderSelector = memo2(
    (ExpenseEntity expense, BuiltMap<String, InvoiceEntity> purchaseOrderMap) =>
        expensePurchaseOrderSelector(expense, purchaseOrderMap));

InvoiceEntity? expensePurchaseOrderSelector(
    ExpenseEntity expense, BuiltMap<String, InvoiceEntity> purchaseOrderMap) {
  InvoiceEntity? purchaseOrder;
  purchaseOrderMap.forEach((purchaseOrderId, purchaseOrder) {
    if (purchaseOrder.expenseId == expense.id) {
      purchaseOrder = purchaseOrder;
    }
  });
  return purchaseOrder;
}

InvoiceItemEntity convertExpenseToInvoiceItem({
  required ExpenseEntity expense,
  required BuildContext context,
}) {
  final state = StoreProvider.of<AppState>(context).state;
  final company = state.company;
  final categoryMap = state.expenseCategoryState.map;
  final localization = AppLocalization.of(context)!;

  String? customValue1 = '';
  String? customValue2 = '';
  String? customValue3 = '';
  String? customValue4 = '';

  final fieldLabel1 = company.getCustomFieldLabel(CustomFieldType.product1);
  final fieldLabel2 = company.getCustomFieldLabel(CustomFieldType.product2);
  final fieldLabel3 = company.getCustomFieldLabel(CustomFieldType.product3);
  final fieldLabel4 = company.getCustomFieldLabel(CustomFieldType.product4);

  final customValues = {
    company.getCustomFieldLabel(CustomFieldType.expense1): expense.customValue1,
    company.getCustomFieldLabel(CustomFieldType.expense2): expense.customValue2,
    company.getCustomFieldLabel(CustomFieldType.expense3): expense.customValue3,
    company.getCustomFieldLabel(CustomFieldType.expense4): expense.customValue4,
    localization.category:
        state.expenseCategoryState.get(expense.categoryId).name,
    localization.vendor: state.vendorState.get(expense.vendorId!).name,
    localization.date: formatDate(expense.date, context),
    localization.project: state.projectState.get(expense.projectId!).name,
  };

  for (var label in customValues.keys) {
    final value = customValues[label];
    if (fieldLabel1.toLowerCase() == label.toLowerCase()) {
      customValue1 = value;
    } else if (fieldLabel2.toLowerCase() == label.toLowerCase()) {
      customValue2 = value;
    } else if (fieldLabel3.toLowerCase() == label.toLowerCase()) {
      customValue3 = value;
    } else if (fieldLabel4.toLowerCase() == label.toLowerCase()) {
      customValue4 = value;
    }
  }

  return InvoiceItemEntity().rebuild((b) => b
    ..typeId = InvoiceItemEntity.TYPE_EXPENSE
    ..expenseId = expense.id
    ..productKey = categoryMap[expense.categoryId]?.name ?? ''
    ..notes = expense.publicNotes
    ..quantity = 1
    ..cost = company.settings.enableInclusiveTaxes!
        ? expense.convertedAmount
        : expense.convertedNetAmount
    ..customValue1 = customValue1
    ..customValue2 = customValue2
    ..customValue3 = customValue3
    ..customValue4 = customValue4
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
    final expense = expenseMap[expenseId]!;
    /*
    if (clientId != null && clientId > 0 && expense.clientId != clientId) {
      return false;
    }
    */
    return expense.isActive;
  }).toList();

  list.sort((expenseAId, expenseBId) {
    final expenseA = expenseMap[expenseAId]!;
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

List<String?> filteredExpensesSelector(
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
    final expense = expenseMap[expenseId]!;
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
      } else if (filterEntityType == EntityType.recurringExpense &&
          expense.recurringExpenseId != filterEntityId) {
        return false;
      } else if (filterEntityType == EntityType.transaction &&
          expense.transactionId != filterEntityId) {
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
        expenseCategory.matchesFilter(expenseListState.filter) ||
        client.matchesNameOrEmail(expenseListState.filter) ||
        vendor.matchesNameOrEmail(expenseListState.filter);
  }).toList();

  list.sort((expenseAId, expenseBId) {
    final expenseA = expenseMap[expenseAId]!;
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
    (BuiltMap<String, ExpenseEntity> expenseMap, String? clientId) =>
        clientExpenseList(expenseMap, clientId));

List<String?> clientExpenseList(
    BuiltMap<String, ExpenseEntity> expenseMap, String? clientId) {
  final list = expenseMap.keys.where((expenseid) {
    final expense = expenseMap[expenseid];
    if ((clientId ?? '').isNotEmpty &&
        (expense!.clientId ?? '').isNotEmpty &&
        expense.clientId != clientId) {
      return false;
    }
    return expense!.isActive && !expense.isInvoiced && expense.shouldBeInvoiced;
  }).toList();

  list.sort((idA, idB) => expenseMap[idA]!
      .listDisplayName
      .compareTo(expenseMap[idB]!.listDisplayName));

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
