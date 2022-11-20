import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownTransactionRuleList = memo5(
    (BuiltMap<String, TransactionRuleEntity> transactionRuleMap,
            BuiltList<String> transactionRuleList,
            StaticState staticState,
            BuiltMap<String, UserEntity> userMap,
            String clientId) =>
        dropdownTransactionRulesSelector(transactionRuleMap,
            transactionRuleList, staticState, userMap, clientId));

List<String> dropdownTransactionRulesSelector(
    BuiltMap<String, TransactionRuleEntity> transactionRuleMap,
    BuiltList<String> transactionRuleList,
    StaticState staticState,
    BuiltMap<String, UserEntity> userMap,
    String clientId) {
  final list = transactionRuleList.where((transactionRuleId) {
    final transactionRule = transactionRuleMap[transactionRuleId];
    /*
    if (clientId != null && clientId > 0 && transactionRule.clientId != clientId) {
      return false;
    }
    */
    return transactionRule.isActive;
  }).toList();

  list.sort((transactionRuleAId, transactionRuleBId) {
    final transactionRuleA = transactionRuleMap[transactionRuleAId];
    final transactionRuleB = transactionRuleMap[transactionRuleBId];
    return transactionRuleA.compareTo(
        transactionRuleB, TransactionRuleFields.name, true);
  });

  return list;
}

var memoizedFilteredTransactionRuleList = memo4((SelectionState selectionState,
        BuiltMap<String, TransactionRuleEntity> transactionRuleMap,
        BuiltList<String> transactionRuleList,
        ListUIState transactionRuleListState) =>
    filteredTransactionRulesSelector(selectionState, transactionRuleMap,
        transactionRuleList, transactionRuleListState));

List<String> filteredTransactionRulesSelector(
    SelectionState selectionState,
    BuiltMap<String, TransactionRuleEntity> transactionRuleMap,
    BuiltList<String> transactionRuleList,
    ListUIState transactionRuleListState) {
  final filterEntityId = selectionState.filterEntityId;
  final filterEntityType = selectionState.filterEntityType;

  final list = transactionRuleList.where((transactionRuleId) {
    final transactionRule = transactionRuleMap[transactionRuleId];
    if (filterEntityId != null && transactionRule.id != filterEntityId) {
      return false;
    } else {}

    if (!transactionRule.matchesStates(transactionRuleListState.stateFilters)) {
      return false;
    }
    if (transactionRuleListState.custom1Filters.isNotEmpty &&
        !transactionRuleListState.custom1Filters
            .contains(transactionRule.customValue1)) {
      return false;
    } else if (transactionRuleListState.custom2Filters.isNotEmpty &&
        !transactionRuleListState.custom2Filters
            .contains(transactionRule.customValue2)) {
      return false;
    } else if (transactionRuleListState.custom3Filters.isNotEmpty &&
        !transactionRuleListState.custom3Filters
            .contains(transactionRule.customValue3)) {
      return false;
    } else if (transactionRuleListState.custom4Filters.isNotEmpty &&
        !transactionRuleListState.custom4Filters
            .contains(transactionRule.customValue4)) {
      return false;
    }

    return transactionRule.matchesFilter(transactionRuleListState.filter);
  }).toList();

  list.sort((transactionRuleAId, transactionRuleBId) {
    final transactionRuleA = transactionRuleMap[transactionRuleAId];
    final transactionRuleB = transactionRuleMap[transactionRuleBId];
    return transactionRuleA.compareTo(
        transactionRuleB,
        transactionRuleListState.sortField,
        transactionRuleListState.sortAscending);
  });

  return list;
}
