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
    final transactionRule = transactionRuleMap[transactionRuleId]!;
    /*
    if (clientId != null && clientId > 0 && transactionRule.clientId != clientId) {
      return false;
    }
    */
    return transactionRule.isActive;
  }).toList();

  list.sort((transactionRuleAId, transactionRuleBId) {
    final transactionRuleA = transactionRuleMap[transactionRuleAId]!;
    final transactionRuleB = transactionRuleMap[transactionRuleBId];
    return transactionRuleA.compareTo(
        transactionRuleB, TransactionRuleFields.name, true);
  });

  return list;
}

var memoizedFilteredTransactionRuleList = memo4((SelectionState selectionState,
        BuiltMap<String?, TransactionRuleEntity?> transactionRuleMap,
        BuiltList<String> transactionRuleList,
        ListUIState transactionRuleListState) =>
    filteredTransactionRulesSelector(selectionState, transactionRuleMap,
        transactionRuleList, transactionRuleListState));

List<String> filteredTransactionRulesSelector(
    SelectionState selectionState,
    BuiltMap<String?, TransactionRuleEntity?> transactionRuleMap,
    BuiltList<String> transactionRuleList,
    ListUIState transactionRuleListState) {
  final filterEntityId = selectionState.filterEntityId;
  //final filterEntityType = selectionState.filterEntityType;

  final list = transactionRuleList.where((transactionRuleId) {
    final transactionRule = transactionRuleMap[transactionRuleId];
    if (filterEntityId != null && transactionRule!.id != filterEntityId) {
      return false;
    } else {}

    if (!transactionRule!
        .matchesStates(transactionRuleListState.stateFilters)) {
      return false;
    }

    return transactionRule.matchesFilter(transactionRuleListState.filter);
  }).toList();

  list.sort((transactionRuleAId, transactionRuleBId) {
    final transactionRuleA = transactionRuleMap[transactionRuleAId]!;
    final transactionRuleB = transactionRuleMap[transactionRuleBId];
    return transactionRuleA.compareTo(
        transactionRuleB,
        transactionRuleListState.sortField,
        transactionRuleListState.sortAscending);
  });

  return list;
}

var memoizedTransactionStatsForTransactionRule = memo2(
    (String userId, BuiltMap<String, TransactionEntity> transactionMap) =>
        transactionStatsForTransactionRule(userId, transactionMap));

EntityStats transactionStatsForTransactionRule(
  String transactionRuleId,
  BuiltMap<String, TransactionEntity> transactionMap,
) {
  int countActive = 0;
  int countArchived = 0;
  double total = 0;
  String? currencyId;

  transactionMap.forEach((transactionId, transaction) {
    if (transaction.transactionRuleId == transactionRuleId) {
      if (transaction.isActive) {
        countActive++;
      } else if (transaction.isDeleted!) {
        countArchived++;
      }

      currencyId ??= transaction.currencyId;
      total += transaction.amount;
    }
  });

  return EntityStats(
    countActive: countActive,
    countArchived: countArchived,
    total: total,
    currencyId: currencyId,
  );
}
