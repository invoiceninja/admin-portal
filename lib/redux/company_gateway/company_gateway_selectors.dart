import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/data/models/payment_model.dart';
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

var memoizedFilteredCompanyGatewayList = memo5(
    (BuiltMap<String, CompanyGatewayEntity> companyGatewayMap,
            BuiltList<String> companyGatewayList,
            ListUIState companyGatewayListState,
            String companyGatewayIds,
            bool includeAll) =>
        filteredCompanyGatewaysSelector(companyGatewayMap, companyGatewayList,
            companyGatewayListState, companyGatewayIds, includeAll));

List<String> filteredCompanyGatewaysSelector(
    BuiltMap<String, CompanyGatewayEntity> companyGatewayMap,
    BuiltList<String> companyGatewayList,
    ListUIState companyGatewayListState,
    String companyGatewayIds,
    bool includeAll) {
  final list = companyGatewayList.where((companyGatewayId) {
    final companyGateway = companyGatewayMap[companyGatewayId];

    if (!companyGateway.matchesStates(companyGatewayListState.stateFilters)) {
      return false;
    }

    return true;
  }).toList();

  final List<String> gatewaysIds = (companyGatewayIds ?? '')
      .split(',')
      .where((id) =>
          id.isNotEmpty &&
          companyGatewayMap.containsKey(id) &&
          companyGatewayMap[id]
              .matchesStates(companyGatewayListState.stateFilters))
      .toList();

  if (includeAll) {
    list.forEach((id) {
      if (!gatewaysIds.contains(id)) {
        gatewaysIds.add(id);
      }
    });
  }

  return gatewaysIds;
}

bool hasCompanyGatewayChanges(CompanyGatewayEntity companyGateway,
        BuiltMap<String, CompanyGatewayEntity> companyGatewayMap) =>
    companyGateway.isNew
        ? companyGateway.isChanged
        : companyGateway != companyGatewayMap[companyGateway.id];

var memoizedCalculateCompanyGatewayProcessed = memo2(
    (String companyGatewayId, BuiltMap<String, PaymentEntity> paymentMap) =>
        calculateCompanyGatewayProcessed(
            companyGatewayId: companyGatewayId, paymentMap: paymentMap));

double calculateCompanyGatewayProcessed({
  String companyGatewayId,
  BuiltMap<String, PaymentEntity> paymentMap,
}) {
  double total = 0;

  paymentMap.forEach((paymentId, payment) {
    if (payment.companyGatewayId == companyGatewayId) {
      total += payment.completedAmount * payment.exchangeRate;
    }
  });

  return total;
}
