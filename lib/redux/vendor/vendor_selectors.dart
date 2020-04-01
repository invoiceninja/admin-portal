import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownVendorList = memo2(
    (BuiltMap<String, VendorEntity> vendorMap, BuiltList<String> vendorList) =>
        dropdownVendorsSelector(vendorMap, vendorList));

List<String> dropdownVendorsSelector(
    BuiltMap<String, VendorEntity> vendorMap, BuiltList<String> vendorList) {
  final list = vendorList.where((vendorId) {
    final vendor = vendorMap[vendorId];
    return vendor.isActive;
  }).toList();

  list.sort((vendorAId, vendorBId) {
    final vendorA = vendorMap[vendorAId];
    final vendorB = vendorMap[vendorBId];
    return vendorA.compareTo(vendorB, VendorFields.name, true);
  });

  return list;
}

var memoizedFilteredVendorList = memo3(
    (BuiltMap<String, VendorEntity> vendorMap, BuiltList<String> vendorList,
            ListUIState vendorListState) =>
        filteredVendorsSelector(vendorMap, vendorList, vendorListState));

List<String> filteredVendorsSelector(BuiltMap<String, VendorEntity> vendorMap,
    BuiltList<String> vendorList, ListUIState vendorListState) {
  final list = vendorList.where((vendorId) {
    final vendor = vendorMap[vendorId];

    if (!vendor.matchesStates(vendorListState.stateFilters)) {
      return false;
    }

    if (vendorListState.custom1Filters.isNotEmpty &&
        !vendorListState.custom1Filters.contains(vendor.customValue1)) {
      return false;
    }

    if (vendorListState.custom2Filters.isNotEmpty &&
        !vendorListState.custom2Filters.contains(vendor.customValue2)) {
      return false;
    }

    return vendor.matchesFilter(vendorListState.filter);
  }).toList();

  list.sort((vendorAId, vendorBId) {
    final vendorA = vendorMap[vendorAId];
    final vendorB = vendorMap[vendorBId];
    return vendorA.compareTo(
        vendorB, vendorListState.sortField, vendorListState.sortAscending);
  });

  return list;
}

var memoizedCalculateVendorBalance = memo4((String vendorId,
        String currencyId,
        BuiltMap<String, ExpenseEntity> expenseMap,
        BuiltList<String> expenseList) =>
    calculateVendorBalance(vendorId, currencyId, expenseMap, expenseList));

double calculateVendorBalance(String vendorId, String currencyId,
    BuiltMap<String, ExpenseEntity> expenseMap, BuiltList<String> expenseList) {
  double total = 0;

  expenseList.forEach((expenseId) {
    final expense = expenseMap[expenseId] ?? ExpenseEntity();
    if (expense.vendorId == vendorId &&
        expense.isActive &&
        (currencyId == null || expense.expenseCurrencyId == currencyId)) {
      total += expense.amountWithTax;
    }
  });

  return total;
}

bool hasVendorChanges(
        VendorEntity vendor, BuiltMap<String, VendorEntity> vendorMap) =>
    vendor.isNew ? vendor.isChanged : vendor != vendorMap[vendor.id];
