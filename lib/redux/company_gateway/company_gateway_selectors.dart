import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownCompanyGatewayList = memo3(
    (BuiltMap<String, CompanyGatewayEntity> companyGatewayMap,
            BuiltList<String> companyGatewayList, String clientId) =>
        dropdownCompanyGatewaysSelector(
            companyGatewayMap, companyGatewayList, clientId));

List<String> dropdownCompanyGatewaysSelector(
    BuiltMap<String, CompanyGatewayEntity> companyGatewayMap,
    BuiltList<String> companyGatewayList,
    String clientId) {
  final list = companyGatewayList.where((companyGatewayId) {
    final companyGateway = companyGatewayMap[companyGatewayId];
    /*
    if (clientId != null && clientId > 0 && companyGateway.clientId != clientId) {
      return false;
    }
    */
    return companyGateway.isActive;
  }).toList();

  list.sort((companyGatewayAId, companyGatewayBId) {
    final companyGatewayA = companyGatewayMap[companyGatewayAId];
    final companyGatewayB = companyGatewayMap[companyGatewayBId];
    return companyGatewayA.compareTo(
        companyGatewayB, CompanyGatewayFields.name, true);
  });

  return list;
}

var memoizedFilteredCompanyGatewayList = memo3(
    (BuiltMap<String, CompanyGatewayEntity> companyGatewayMap,
            BuiltList<String> companyGatewayList,
            ListUIState companyGatewayListState) =>
        filteredCompanyGatewaysSelector(
            companyGatewayMap, companyGatewayList, companyGatewayListState));

List<String> filteredCompanyGatewaysSelector(
    BuiltMap<String, CompanyGatewayEntity> companyGatewayMap,
    BuiltList<String> companyGatewayList,
    ListUIState companyGatewayListState) {
  final list = companyGatewayList.where((companyGatewayId) {
    final companyGateway = companyGatewayMap[companyGatewayId];

    if (!companyGateway.matchesStates(companyGatewayListState.stateFilters)) {
      return false;
    }
    if (companyGatewayListState.custom1Filters.isNotEmpty &&
        !companyGatewayListState.custom1Filters
            .contains(companyGateway.customValue1)) {
      return false;
    }
    if (companyGatewayListState.custom2Filters.isNotEmpty &&
        !companyGatewayListState.custom2Filters
            .contains(companyGateway.customValue2)) {
      return false;
    }
    return companyGateway.matchesFilter(companyGatewayListState.filter);
  }).toList();

  list.sort((companyGatewayAId, companyGatewayBId) {
    final companyGatewayA = companyGatewayMap[companyGatewayAId];
    final companyGatewayB = companyGatewayMap[companyGatewayBId];
    return companyGatewayA.compareTo(
        companyGatewayB,
        companyGatewayListState.sortField,
        companyGatewayListState.sortAscending);
  });

  return list;
}

bool hasCompanyGatewayChanges(CompanyGatewayEntity companyGateway,
        BuiltMap<String, CompanyGatewayEntity> companyGatewayMap) =>
    companyGateway.isNew
        ? companyGateway.isChanged
        : companyGateway != companyGatewayMap[companyGateway.id];
