import 'package:invoiceninja_flutter/data/models/payment_term_model.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownPaymentTermList = memo3((BuiltMap<String, PaymentTermEntity>
            paymentTermMap,
        BuiltList<String> paymentTermList,
        String clientId) =>
    dropdownPaymentTermsSelector(paymentTermMap, paymentTermList, clientId));

List<String> dropdownPaymentTermsSelector(
    BuiltMap<String, PaymentTermEntity> paymentTermMap,
    BuiltList<String> paymentTermList,
    String clientId) {
  final list = paymentTermList.where((paymentTermId) {
    final paymentTerm = paymentTermMap[paymentTermId];
    /*
    if (clientId != null && clientId > 0 && paymentTerm.clientId != clientId) {
      return false;
    }
    */
    return paymentTerm.isActive;
  }).toList();

  list.sort((paymentTermAId, paymentTermBId) {
    final paymentTermA = paymentTermMap[paymentTermAId];
    final paymentTermB = paymentTermMap[paymentTermBId];
    return paymentTermA.compareTo(paymentTermB, PaymentTermFields.name, true);
  });

  return list;
}

var memoizedFilteredPaymentTermList = memo3(
    (BuiltMap<String, PaymentTermEntity> paymentTermMap,
            BuiltList<String> paymentTermList,
            ListUIState paymentTermListState) =>
        filteredPaymentTermsSelector(
            paymentTermMap, paymentTermList, paymentTermListState));

List<String> filteredPaymentTermsSelector(
    BuiltMap<String, PaymentTermEntity> paymentTermMap,
    BuiltList<String> paymentTermList,
    ListUIState paymentTermListState) {
  final list = paymentTermList.where((paymentTermId) {
    final paymentTerm = paymentTermMap[paymentTermId];
    if (!paymentTerm.matchesStates(paymentTermListState.stateFilters)) {
      return false;
    }
    return paymentTerm.matchesFilter(paymentTermListState.filter);
  }).toList();

  list.sort((paymentTermAId, paymentTermBId) {
    final paymentTermA = paymentTermMap[paymentTermAId];
    final paymentTermB = paymentTermMap[paymentTermBId];
    return paymentTermA.compareTo(paymentTermB, paymentTermListState.sortField,
        paymentTermListState.sortAscending);
  });

  return list;
}

bool hasPaymentTermChanges(PaymentTermEntity paymentTerm,
        BuiltMap<String, PaymentTermEntity> paymentTermMap) =>
    paymentTerm.isNew
        ? paymentTerm.isChanged
        : paymentTerm != paymentTermMap[paymentTerm.id];
