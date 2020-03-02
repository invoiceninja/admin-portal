import 'package:invoiceninja_flutter/data/models/credit_model.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownCreditList = memo3(
    (BuiltMap<String, InvoiceEntity> creditMap, BuiltList<String> creditList,
            String clientId) =>
        dropdownCreditsSelector(creditMap, creditList, clientId));

List<String> dropdownCreditsSelector(BuiltMap<String, InvoiceEntity> creditMap,
    BuiltList<String> creditList, String clientId) {
  final list = creditList.where((creditId) {
    final credit = creditMap[creditId];
    /*
    if (clientId != null && clientId > 0 && credit.clientId != clientId) {
      return false;
    }
    */
    return credit.isActive;
  }).toList();

  list.sort((creditAId, creditBId) {
    final creditA = creditMap[creditAId];
    final creditB = creditMap[creditBId];
    return creditA.compareTo(creditB, CreditFields.name, true);
  });

  return list;
}

var memoizedFilteredCreditList = memo3(
    (BuiltMap<String, InvoiceEntity> creditMap, BuiltList<String> creditList,
            ListUIState creditListState) =>
        filteredCreditsSelector(creditMap, creditList, creditListState));

List<String> filteredCreditsSelector(BuiltMap<String, InvoiceEntity> creditMap,
    BuiltList<String> creditList, ListUIState creditListState) {
  final list = creditList.where((creditId) {
    final credit = creditMap[creditId];
    if (creditListState.filterEntityId != null &&
        credit.entityId != creditListState.filterEntityId) {
      return false;
    } else {}

    if (!credit.matchesStates(creditListState.stateFilters)) {
      return false;
    }
    if (creditListState.custom1Filters.isNotEmpty &&
        !creditListState.custom1Filters.contains(credit.customValue1)) {
      return false;
    }
    if (creditListState.custom2Filters.isNotEmpty &&
        !creditListState.custom2Filters.contains(credit.customValue2)) {
      return false;
    }
    return credit.matchesFilter(creditListState.filter);
  }).toList();

  list.sort((creditAId, creditBId) {
    final creditA = creditMap[creditAId];
    final creditB = creditMap[creditBId];
    return creditA.compareTo(
        creditB, creditListState.sortField, creditListState.sortAscending);
  });

  return list;
}

bool hasCreditChanges(
        InvoiceEntity credit, BuiltMap<String, InvoiceEntity> creditMap) =>
    credit.isNew ? credit.isChanged : credit != creditMap[credit.id];
