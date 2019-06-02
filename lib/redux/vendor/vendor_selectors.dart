import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownVendorList = memo3(
    (BuiltMap<int, VendorEntity> vendorMap, BuiltList<int> vendorList,
            int clientId) =>
        dropdownVendorsSelector(vendorMap, vendorList, clientId));

List<int> dropdownVendorsSelector(BuiltMap<int, VendorEntity> vendorMap,
    BuiltList<int> vendorList, int clientId) {
  final list = vendorList.where((vendorId) {
    final vendor = vendorMap[vendorId];
    /*
    if (clientId != null && clientId > 0 && vendor.clientId != clientId) {
      return false;
    }
    */
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
    /*
    if (vendorListState.filterEntityId != null &&
        vendor.clientId != vendorListState.filterEntityId) {
      return false;
    }
    */
    if (vendorListState.custom1Filters.isNotEmpty &&
        !vendorListState.custom1Filters.contains(vendor.customValue1)) {
      return false;
    }
    if (vendorListState.custom2Filters.isNotEmpty &&
        !vendorListState.custom2Filters.contains(vendor.customValue2)) {
      return false;
    }
    /*
    if (vendorListState.filterEntityId != null &&
        vendor.entityId != vendorListState.filterEntityId) {
      return false;
    }
    */
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
