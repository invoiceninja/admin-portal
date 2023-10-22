// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/payment_term_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownPaymentTermList = memo2(
    (BuiltMap<String, PaymentTermEntity> paymentTermMap,
            BuiltList<String> paymentTermList) =>
        dropdownPaymentTermsSelector(paymentTermMap, paymentTermList));

List<String> dropdownPaymentTermsSelector(
    BuiltMap<String, PaymentTermEntity> paymentTermMap,
    BuiltList<String> paymentTermList) {
  final Map<int, bool> numDays = {};
  final list = paymentTermList.where((paymentTermId) {
    final paymentTerm = paymentTermMap[paymentTermId]!;
    if (!paymentTerm.isActive) {
      return false;
    }
    if (numDays.containsKey(paymentTerm.numDays)) {
      return false;
    }
    numDays[paymentTerm.numDays] = true;
    return true;
  }).toList();

  list.sort((paymentTermAId, paymentTermBId) {
    final paymentTermA = paymentTermMap[paymentTermAId]!;
    final paymentTermB = paymentTermMap[paymentTermBId]!;
    return paymentTermA.compareTo(paymentTermB, PaymentTermFields.name, true);
  });

  return list;
}

var memoizedFilteredPaymentTermList = memo4((SelectionState selectionState,
        BuiltMap<String, PaymentTermEntity> paymentTermMap,
        BuiltList<String> paymentTermList,
        ListUIState paymentTermListState) =>
    filteredPaymentTermsSelector(
        selectionState, paymentTermMap, paymentTermList, paymentTermListState));

List<String> filteredPaymentTermsSelector(
    SelectionState selectionState,
    BuiltMap<String, PaymentTermEntity> paymentTermMap,
    BuiltList<String> paymentTermList,
    ListUIState paymentTermListState) {
  final list = paymentTermList.where((paymentTermId) {
    final paymentTerm = paymentTermMap[paymentTermId]!;

    if (paymentTerm.id == selectionState.selectedId) {
      return true;
    }

    if (!paymentTerm.matchesStates(paymentTermListState.stateFilters)) {
      return false;
    }
    return paymentTerm.matchesFilter(paymentTermListState.filter);
  }).toList();

  list.sort((paymentTermAId, paymentTermBId) {
    final paymentTermA = paymentTermMap[paymentTermAId]!;
    final paymentTermB = paymentTermMap[paymentTermBId]!;
    return paymentTermA.compareTo(paymentTermB, paymentTermListState.sortField,
        paymentTermListState.sortAscending);
  });

  return list;
}
