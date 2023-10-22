// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownTaxRateList = memo3(
    (BuiltMap<String, TaxRateEntity> taxRateMap, BuiltList<String> taxRateList,
            String clientId) =>
        dropdownTaxRatesSelector(taxRateMap, taxRateList, clientId));

List<String> dropdownTaxRatesSelector(
    BuiltMap<String, TaxRateEntity> taxRateMap,
    BuiltList<String> taxRateList,
    String clientId) {
  final list = taxRateList.where((taxRateId) {
    final taxRate = taxRateMap[taxRateId]!;
    /*
    if (clientId != null && clientId > 0 && taxRate.clientId != clientId) {
      return false;
    }
    */
    return taxRate.isActive;
  }).toList();

  list.sort((taxRateAId, taxRateBId) {
    final taxRateA = taxRateMap[taxRateAId]!;
    final taxRateB = taxRateMap[taxRateBId];
    return taxRateA.compareTo(taxRateB, TaxRateFields.name, true);
  });

  return list;
}

var memoizedFilteredTaxRateList = memo4((SelectionState selectionState,
        BuiltMap<String?, TaxRateEntity?> taxRateMap,
        BuiltList<String> taxRateList,
        ListUIState taxRateListState) =>
    filteredTaxRatesSelector(
        selectionState, taxRateMap, taxRateList, taxRateListState));

List<String> filteredTaxRatesSelector(
    SelectionState selectionState,
    BuiltMap<String?, TaxRateEntity?> taxRateMap,
    BuiltList<String> taxRateList,
    ListUIState taxRateListState) {
  final list = taxRateList.where((taxRateId) {
    final taxRate = taxRateMap[taxRateId]!;

    if (taxRate.id == selectionState.selectedId) {
      return true;
    }

    if (!taxRate.matchesStates(taxRateListState.stateFilters)) {
      return false;
    }
    return taxRate.matchesFilter(taxRateListState.filter);
  }).toList();

  list.sort((taxRateAId, taxRateBId) {
    final taxRateA = taxRateMap[taxRateAId]!;
    final taxRateB = taxRateMap[taxRateBId];
    return taxRateA.compareTo(
        taxRateB, taxRateListState.sortField, taxRateListState.sortAscending);
  });

  return list;
}
