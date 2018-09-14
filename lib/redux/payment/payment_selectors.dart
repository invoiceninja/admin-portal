import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedPaymentsByInvoice = memo3((int invoiceId,
        BuiltMap<int, PaymentEntity> paymentMap, BuiltList<int> paymentList) =>
    paymentsByInvoiceSelector(invoiceId, paymentMap, paymentList));

List<PaymentEntity> paymentsByInvoiceSelector(int invoiceId,
    BuiltMap<int, PaymentEntity> paymentMap, BuiltList<int> paymentList) {
  return paymentList
      .map((paymentId) => paymentMap[paymentId])
      .where((payment) => payment.invoiceId == invoiceId && !payment.isDeleted)
      .toList();
}

InvoiceEntity paymentInvoiceSelector(int paymentId, AppState state) {
  final payment = state.paymentState.map[paymentId];
  return state.invoiceState.map[payment.invoiceId];
}

ClientEntity paymentClientSelector(int paymentId, AppState state) {
  final invoice = paymentInvoiceSelector(paymentId, state);
  return state.clientState.map[invoice.clientId] ?? ClientEntity();
}

var memoizedDropdownPaymentList = memo2(
    (BuiltMap<int, PaymentEntity> paymentMap, BuiltList<int> paymentList) =>
        dropdownPaymentsSelector(paymentMap, paymentList));

List<int> dropdownPaymentsSelector(
    BuiltMap<int, PaymentEntity> paymentMap, BuiltList<int> paymentList) {
  final list =
      paymentList.where((paymentId) => paymentMap[paymentId].isActive).toList();

  list.sort((paymentAId, paymentBId) {
    final paymentA = paymentMap[paymentAId];
    final paymentB = paymentMap[paymentBId];
    return paymentA.compareTo(paymentB, PaymentFields.paymentDate, true);
  });

  return list;
}

var memoizedFilteredPaymentList = memo4(
    (BuiltMap<int, PaymentEntity> paymentMap,
            BuiltList<int> paymentList,
            BuiltMap<int, InvoiceEntity> invoiceMap,
            ListUIState paymentListState) =>
        filteredPaymentsSelector(
            paymentMap, paymentList, invoiceMap, paymentListState));

List<int> filteredPaymentsSelector(
    BuiltMap<int, PaymentEntity> paymentMap,
    BuiltList<int> paymentList,
    BuiltMap<int, InvoiceEntity> invoiceMap,
    ListUIState paymentListState) {
  final list = paymentList.where((paymentId) {
    final payment = paymentMap[paymentId];
    if (!payment.matchesStates(paymentListState.stateFilters)) {
      return false;
    }
    if (paymentListState.filterEntityId != null) {
      if (paymentListState.filterEntityType == EntityType.client &&
          invoiceMap[payment.invoiceId].clientId !=
              paymentListState.filterEntityId) {
        return false;
      } else if (paymentListState.filterEntityType == EntityType.invoice &&
          payment.invoiceId != paymentListState.filterEntityId) {
        return false;
      }
    }
    return payment.matchesFilter(paymentListState.filter);
  }).toList();

  list.sort((paymentAId, paymentBId) {
    final paymentA = paymentMap[paymentAId];
    final paymentB = paymentMap[paymentBId];
    return paymentA.compareTo(
        paymentB, paymentListState.sortField, paymentListState.sortAscending);
  });

  return list;
}

var memoizedPaymentStatsForClient = memo5((int clientId,
        BuiltMap<int, PaymentEntity> paymentMap,
        BuiltMap<int, InvoiceEntity> invoiceMap,
        String activeLabel,
        String archivedLabel) =>
    invoiceStatsForClient(
        clientId, paymentMap, invoiceMap, activeLabel, archivedLabel));

String invoiceStatsForClient(
    int clientId,
    BuiltMap<int, PaymentEntity> paymentMap,
    BuiltMap<int, InvoiceEntity> invoiceMap,
    String activeLabel,
    String archivedLabel) {
  int countActive = 0;
  int countArchived = 0;
  paymentMap.forEach((paymentId, payment) {
    if (invoiceMap[payment.invoiceId].clientId == clientId) {
      if (payment.isActive) {
        countActive++;
      } else if (payment.isArchived) {
        countArchived++;
      }
    }
  });

  String str = '';
  if (countActive > 0) {
    str = '$countActive $activeLabel';
    if (countArchived > 0) {
      str += ' • ';
    }
  }
  if (countArchived > 0) {
    str += '$countArchived $archivedLabel';
  }

  return str;
}
