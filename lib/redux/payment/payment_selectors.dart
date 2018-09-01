import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

InvoiceEntity paymentInvoiceSelector(int paymentId, AppState state) {
  final payment = state.paymentState.map[paymentId];
  return state.invoiceState.map[payment.invoiceId];
}

ClientEntity paymentClientSelector(int paymentId, AppState state) {
  final invoice = paymentInvoiceSelector(paymentId, state);
  return state.clientState.map[invoice.clientId];
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

var memoizedFilteredPaymentList = memo3((BuiltMap<int, PaymentEntity> paymentMap,
        BuiltList<int> paymentList, ListUIState paymentListState) =>
    filteredPaymentsSelector(paymentMap, paymentList, paymentListState));

List<int> filteredPaymentsSelector(BuiltMap<int, PaymentEntity> paymentMap,
    BuiltList<int> paymentList, ListUIState paymentListState) {
  final list = paymentList.where((paymentId) {
    final payment = paymentMap[paymentId];
    if (!payment.matchesStates(paymentListState.stateFilters)) {
      return false;
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
