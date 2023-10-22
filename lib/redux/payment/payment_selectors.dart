// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedPaymentsByInvoice = memo3((String invoiceId,
        BuiltMap<String, PaymentEntity> paymentMap,
        BuiltList<String> paymentList) =>
    paymentsByInvoiceSelector(invoiceId, paymentMap, paymentList));

List<PaymentEntity?> paymentsByInvoiceSelector(String invoiceId,
    BuiltMap<String, PaymentEntity> paymentMap, BuiltList<String> paymentList) {
  return paymentList.map((paymentId) => paymentMap[paymentId]).where((payment) {
    return payment!.paymentables.map((p) => p.invoiceId).contains(invoiceId) &&
        !payment.isDeleted!;
  }).toList();
}

var memoizedPaymentsByCredit = memo3((String invoiceId,
        BuiltMap<String, PaymentEntity> paymentMap,
        BuiltList<String> paymentList) =>
    paymentsByCreditSelector(invoiceId, paymentMap, paymentList));

List<PaymentEntity?> paymentsByCreditSelector(String creditId,
    BuiltMap<String, PaymentEntity> paymentMap, BuiltList<String> paymentList) {
  return paymentList.map((paymentId) => paymentMap[paymentId]).where((payment) {
    return payment!.paymentables.map((p) => p.creditId).contains(creditId) &&
        !payment.isDeleted!;
  }).toList();
}

var memoizedDropdownPaymentList = memo6((
  BuiltMap<String, PaymentEntity> paymentMap,
  BuiltList<String> paymentList,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, UserEntity> userMap,
  BuiltMap<String, PaymentTypeEntity> paymentTypeMap,
) =>
    dropdownPaymentsSelector(paymentMap, paymentList, invoiceMap, clientMap,
        userMap, paymentTypeMap));

List<String> dropdownPaymentsSelector(
  BuiltMap<String, PaymentEntity> paymentMap,
  BuiltList<String> paymentList,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, UserEntity> userMap,
  BuiltMap<String, PaymentTypeEntity> paymentTypeMap,
) {
  final list = paymentList
      .where((paymentId) => paymentMap[paymentId]!.isActive)
      .toList();

  list.sort((paymentAId, paymentBId) {
    final paymentA = paymentMap[paymentAId]!;
    final paymentB = paymentMap[paymentBId];

    return paymentA.compareTo(
      payment: paymentB,
      sortAscending: true,
      sortField: PaymentFields.date,
      invoiceMap: invoiceMap,
      clientMap: clientMap,
      userMap: userMap,
      paymentTypeMap: paymentTypeMap,
    );
  });

  return list;
}

var memoizedFilteredPaymentList = memo8((SelectionState selectionState,
        BuiltMap<String, PaymentEntity> paymentMap,
        BuiltList<String> paymentList,
        BuiltMap<String, InvoiceEntity> invoiceMap,
        BuiltMap<String, ClientEntity> clientMap,
        BuiltMap<String, UserEntity> userMap,
        BuiltMap<String?, PaymentTypeEntity?> paymentTypeMap,
        ListUIState paymentListState) =>
    filteredPaymentsSelector(
      selectionState,
      paymentMap,
      paymentList,
      invoiceMap,
      clientMap,
      userMap,
      paymentTypeMap,
      paymentListState,
    ));

List<String> filteredPaymentsSelector(
    SelectionState selectionState,
    BuiltMap<String, PaymentEntity> paymentMap,
    BuiltList<String> paymentList,
    BuiltMap<String, InvoiceEntity> invoiceMap,
    BuiltMap<String, ClientEntity> clientMap,
    BuiltMap<String, UserEntity> userMap,
    BuiltMap<String?, PaymentTypeEntity?> paymentTypeMap,
    ListUIState paymentListState) {
  final filterEntityId = selectionState.filterEntityId;
  final filterEntityType = selectionState.filterEntityType;

  final list = paymentList.where((paymentId) {
    final payment = paymentMap[paymentId]!;
    if (!payment.matchesStates(paymentListState.stateFilters)) {
      return false;
    }

    if (!payment.matchesStatuses(paymentListState.statusFilters)) {
      return false;
    }

    final client =
        clientMap[payment.clientId] ?? ClientEntity(id: payment.clientId);

    if (payment.id == selectionState.selectedId) {
      return true;
    }

    if (!client.isActive &&
        !client.matchesEntityFilter(filterEntityType, filterEntityId)) {
      return false;
    }

    if (filterEntityType == EntityType.client &&
        payment.clientId != filterEntityId) {
      return false;
    } else if (filterEntityType == EntityType.invoice) {
      if (!payment.paymentables
          .map((p) => p.invoiceId)
          .contains(filterEntityId)) {
        return false;
      }
    } else if (filterEntityType == EntityType.user &&
        payment.assignedUserId != filterEntityId) {
      return false;
    } else if (filterEntityType == EntityType.companyGateway &&
        payment.companyGatewayId != filterEntityId) {
      return false;
    }

    if (!payment.matchesFilter(paymentListState.filter) &&
        !client.matchesNameOrEmail(paymentListState.filter)) {
      return false;
    }

    return true;
  }).toList();

  list.sort((paymentAId, paymentBId) {
    final paymentA = paymentMap[paymentAId]!;
    final paymentB = paymentMap[paymentBId];
    return paymentA.compareTo(
      payment: paymentB,
      sortAscending: paymentListState.sortAscending,
      sortField: paymentListState.sortField,
      invoiceMap: invoiceMap,
      clientMap: clientMap,
      userMap: userMap,
      paymentTypeMap: paymentTypeMap,
    );
  });

  return list;
}

var memoizedPaymentStatsForClient = memo3((String clientId,
        BuiltMap<String, PaymentEntity> paymentMap,
        BuiltMap<String, InvoiceEntity> invoiceMap) =>
    paymentStatsForClient(clientId, paymentMap, invoiceMap));

EntityStats paymentStatsForClient(
    String clientId,
    BuiltMap<String, PaymentEntity> paymentMap,
    BuiltMap<String, InvoiceEntity> invoiceMap) {
  int countActive = 0;
  int countArchived = 0;
  paymentMap.forEach((paymentId, payment) {
    if (payment.clientId == clientId) {
      if (payment.isActive) {
        countActive++;
      } else if (payment.isArchived) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}

var memoizedPaymentStatsForUser = memo3((String userId,
        BuiltMap<String, PaymentEntity> paymentMap,
        BuiltMap<String, InvoiceEntity> invoiceMap) =>
    paymentStatsForClient(userId, paymentMap, invoiceMap));

EntityStats paymentStatsForUser(
    String userId,
    BuiltMap<String, PaymentEntity> paymentMap,
    BuiltMap<String, InvoiceEntity> invoiceMap) {
  int countActive = 0;
  int countArchived = 0;
  paymentMap.forEach((paymentId, payment) {
    if (payment.assignedUserId == userId) {
      if (payment.isActive) {
        countActive++;
      } else if (payment.isArchived) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}
