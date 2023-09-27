// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/payment_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
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
    final companyGateway = companyGatewayMap[companyGatewayId]!;
    /*
    if (clientId != null && clientId > 0 && companyGateway.clientId != clientId) {
      return false;
    }
    */
    return companyGateway.isActive;
  }).toList();

  list.sort((companyGatewayAId, companyGatewayBId) {
    final companyGatewayA = companyGatewayMap[companyGatewayAId]!;
    final companyGatewayB = companyGatewayMap[companyGatewayBId];
    return companyGatewayA.compareTo(
        companyGatewayB, CompanyGatewayFields.name, true);
  });

  return list;
}

var memoizedFilteredCompanyGatewayList = memo5(
    (BuiltMap<String?, CompanyGatewayEntity?> companyGatewayMap,
            BuiltList<String> companyGatewayList,
            ListUIState companyGatewayListState,
            String? companyGatewayIds,
            bool includeAll) =>
        filteredCompanyGatewaysSelector(companyGatewayMap, companyGatewayList,
            companyGatewayListState, companyGatewayIds, includeAll));

List<String> filteredCompanyGatewaysSelector(
    BuiltMap<String?, CompanyGatewayEntity?> companyGatewayMap,
    BuiltList<String> companyGatewayList,
    ListUIState companyGatewayListState,
    String? companyGatewayIds,
    bool includeAll) {
  final list = companyGatewayList.where((companyGatewayId) {
    final companyGateway = companyGatewayMap[companyGatewayId]!;

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
          companyGatewayMap[id]!
              .matchesStates(companyGatewayListState.stateFilters))
      .toList();

  if (includeAll) {
    list.forEach((id) {
      if (!gatewaysIds.contains(id)) {
        gatewaysIds.add(id);
      }
    });
  }

  return gatewaysIds.toSet().toList();
}

var memoizedCalculateCompanyGatewayProcessed = memo2(
    (String companyGatewayId, BuiltMap<String, PaymentEntity> paymentMap) =>
        calculateCompanyGatewayProcessed(
            companyGatewayId: companyGatewayId, paymentMap: paymentMap));

double calculateCompanyGatewayProcessed({
  String? companyGatewayId,
  required BuiltMap<String, PaymentEntity> paymentMap,
}) {
  double total = 0;

  paymentMap.forEach((paymentId, payment) {
    if (payment.companyGatewayId == companyGatewayId) {
      total += payment.completedAmount * payment.exchangeRate;
    }
  });

  return total;
}

var memoizedClientStatsForCompanyGateway = memo2(
    (String companyGatewayId, BuiltMap<String, ClientEntity> clientMap) =>
        clientStatsForCompanyGateway(companyGatewayId, clientMap));

EntityStats clientStatsForCompanyGateway(
  String companyGatewayId,
  BuiltMap<String, ClientEntity> clientMap,
) {
  int countActive = 0;
  int countArchived = 0;
  clientMap.forEach((clientId, client) {
    if (client.gatewayTokens
        .where((token) => token.companyGatewayId == companyGatewayId)
        .isNotEmpty) {
      if (client.isActive) {
        countActive++;
      } else if (client.isArchived) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}

var memoizedPaymentStatsForCompanyGateway = memo2(
    (String companyGatewayId, BuiltMap<String, PaymentEntity> paymentMap) =>
        paymentStatsForCompanyGateway(companyGatewayId, paymentMap));

EntityStats paymentStatsForCompanyGateway(
  String companyGatewayId,
  BuiltMap<String, PaymentEntity> paymentMap,
) {
  int countActive = 0;
  int countArchived = 0;
  paymentMap.forEach((paymentId, payment) {
    if (payment.companyGatewayId == companyGatewayId) {
      if (payment.isActive) {
        countActive++;
      } else if (payment.isArchived) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}

bool hasUnconnectedStripeAccount(AppState state) =>
    getUnconnectedStripeAccount(state) != null;

CompanyGatewayEntity? getUnconnectedStripeAccount(AppState state) {
  CompanyGatewayEntity? unconnectedGateway;

  state.companyGatewayState.map.forEach((id, gateway) {
    if (gateway.gatewayId == kGatewayStripeConnect && gateway.isActive) {
      final accountId = (gateway.parsedConfig!['account_id'] ?? '').toString();
      if (accountId.isEmpty) {
        unconnectedGateway = gateway;
      }
    }
  });

  return unconnectedGateway;
}
