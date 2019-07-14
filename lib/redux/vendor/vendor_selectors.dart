import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownVendorList = memo2(
    (BuiltMap<int, VendorEntity> vendorMap, BuiltList<int> vendorList) =>
        dropdownVendorsSelector(vendorMap, vendorList));

List<int> dropdownVendorsSelector(
    BuiltMap<int, VendorEntity> vendorMap, BuiltList<int> vendorList) {
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

var memoizedFilteredVendorList = memo3((BuiltMap<int, VendorEntity> vendorMap,
        BuiltList<int> vendorList, ListUIState vendorListState) =>
    filteredVendorsSelector(vendorMap, vendorList, vendorListState));

List<int> filteredVendorsSelector(BuiltMap<int, VendorEntity> vendorMap,
    BuiltList<int> vendorList, ListUIState vendorListState) {
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

var memoizedCalculateVendorBalance = memo3((int vendorId,
        BuiltMap<int, ExpenseEntity> expenseMap, BuiltList<int> expenseList) =>
    calculateVendorBalance(vendorId, expenseMap, expenseList));

double calculateVendorBalance(int vendorId,
    BuiltMap<int, ExpenseEntity> expenseMap, BuiltList<int> expenseList) {
  double total = 0;

  expenseList.forEach((expenseId) {
    final expense = expenseMap[expenseId] ?? ExpenseEntity();
    if (expense.vendorId == vendorId && expense.isActive) {
      total += expense.amountWithTax;
    }
  });
  return total;
}
