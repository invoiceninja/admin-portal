import 'package:redux/redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/transaction_rule/transaction_rule_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/transaction_rule/transaction_rule_state.dart';

EntityUIState transactionRuleUIReducer(
    TransactionRuleUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(transactionRuleListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action)!)
    ..selectedId = selectedIdReducer(state.selectedId, action)
    ..forceSelected = forceSelectedReducer(state.forceSelected, action)
    ..tabIndex = tabIndexReducer(state.tabIndex, action));
}

final forceSelectedReducer = combineReducers<bool?>([
  TypedReducer<bool?, ViewTransactionRule>((completer, action) => true),
  TypedReducer<bool?, ViewTransactionRuleList>((completer, action) => false),
  TypedReducer<bool?, FilterTransactionRulesByState>(
      (completer, action) => false),
  TypedReducer<bool?, FilterTransactionRules>((completer, action) => false),
  TypedReducer<bool?, FilterTransactionRulesByCustom1>(
      (completer, action) => false),
  TypedReducer<bool?, FilterTransactionRulesByCustom2>(
      (completer, action) => false),
  TypedReducer<bool?, FilterTransactionRulesByCustom3>(
      (completer, action) => false),
  TypedReducer<bool?, FilterTransactionRulesByCustom4>(
      (completer, action) => false),
]);

final int? Function(int, dynamic) tabIndexReducer = combineReducers<int?>([
  TypedReducer<int?, UpdateTransactionRuleTab>((completer, action) {
    return action.tabIndex;
  }),
  TypedReducer<int?, PreviewEntity>((completer, action) {
    return 0;
  }),
]);

Reducer<String?> selectedIdReducer = combineReducers([
  TypedReducer<String?, ArchiveTransactionRulesSuccess>(
      (completer, action) => ''),
  TypedReducer<String?, DeleteTransactionRulesSuccess>(
      (completer, action) => ''),
  TypedReducer<String?, PreviewEntity>((selectedId, action) =>
      action.entityType == EntityType.transactionRule
          ? action.entityId
          : selectedId),
  TypedReducer<String?, ViewTransactionRule>(
      (String? selectedId, dynamic action) => action.transactionRuleId),
  TypedReducer<String?, AddTransactionRuleSuccess>(
      (String? selectedId, dynamic action) => action.transactionRule.id),
  TypedReducer<String?, SelectCompany>(
      (selectedId, action) => action.clearSelection ? '' : selectedId),
  TypedReducer<String?, ClearEntityFilter>((selectedId, action) => ''),
  TypedReducer<String?, SortTransactionRules>((selectedId, action) => ''),
  TypedReducer<String?, FilterTransactionRules>((selectedId, action) => ''),
  TypedReducer<String?, FilterTransactionRulesByState>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterTransactionRulesByCustom1>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterTransactionRulesByCustom2>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterTransactionRulesByCustom3>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterTransactionRulesByCustom4>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterByEntity>(
      (selectedId, action) => action.clearSelection
          ? ''
          : action.entityType == EntityType.transactionRule
              ? action.entityId
              : selectedId),
]);

final editingReducer = combineReducers<TransactionRuleEntity?>([
  TypedReducer<TransactionRuleEntity?, SaveTransactionRuleSuccess>(
      _updateEditing),
  TypedReducer<TransactionRuleEntity?, AddTransactionRuleSuccess>(
      _updateEditing),
  TypedReducer<TransactionRuleEntity?, RestoreTransactionRulesSuccess>(
      (transactionRules, action) {
    return action.transactionRules[0];
  }),
  TypedReducer<TransactionRuleEntity?, ArchiveTransactionRulesSuccess>(
      (transactionRules, action) {
    return action.transactionRules[0];
  }),
  TypedReducer<TransactionRuleEntity?, DeleteTransactionRulesSuccess>(
      (transactionRules, action) {
    return action.transactionRules[0];
  }),
  TypedReducer<TransactionRuleEntity?, EditTransactionRule>(_updateEditing),
  TypedReducer<TransactionRuleEntity?, UpdateTransactionRule>(
      (transactionRule, action) {
    return action.transactionRule.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<TransactionRuleEntity?, DiscardChanges>(_clearEditing),
]);

TransactionRuleEntity _clearEditing(
    TransactionRuleEntity? transactionRule, dynamic action) {
  return TransactionRuleEntity();
}

TransactionRuleEntity? _updateEditing(
    TransactionRuleEntity? transactionRule, dynamic action) {
  return action.transactionRule;
}

final transactionRuleListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortTransactionRules>(_sortTransactionRules),
  TypedReducer<ListUIState, FilterTransactionRulesByState>(
      _filterTransactionRulesByState),
  TypedReducer<ListUIState, FilterTransactionRules>(_filterTransactionRules),
  TypedReducer<ListUIState, FilterTransactionRulesByCustom1>(
      _filterTransactionRulesByCustom1),
  TypedReducer<ListUIState, FilterTransactionRulesByCustom2>(
      _filterTransactionRulesByCustom2),
  TypedReducer<ListUIState, StartTransactionRuleMultiselect>(
      _startListMultiselect),
  TypedReducer<ListUIState, AddToTransactionRuleMultiselect>(
      _addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromTransactionRuleMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearTransactionRuleMultiselect>(
      _clearListMultiselect),
  TypedReducer<ListUIState, ViewTransactionRuleList>(_viewTransactionRuleList),
  TypedReducer<ListUIState, FilterByEntity>(
      (state, action) => state.rebuild((b) => b
        ..filter = null
        ..filterClearedAt = DateTime.now().millisecondsSinceEpoch)),
]);

ListUIState _viewTransactionRuleList(
    ListUIState transactionRuleListState, ViewTransactionRuleList action) {
  return transactionRuleListState.rebuild((b) => b
    ..selectedIds = null
    ..filter = null
    ..filterClearedAt = DateTime.now().millisecondsSinceEpoch);
}

ListUIState _filterTransactionRulesByCustom1(
    ListUIState transactionRuleListState,
    FilterTransactionRulesByCustom1 action) {
  if (transactionRuleListState.custom1Filters.contains(action.value)) {
    return transactionRuleListState
        .rebuild((b) => b..custom1Filters.remove(action.value));
  } else {
    return transactionRuleListState
        .rebuild((b) => b..custom1Filters.add(action.value));
  }
}

ListUIState _filterTransactionRulesByCustom2(
    ListUIState transactionRuleListState,
    FilterTransactionRulesByCustom2 action) {
  if (transactionRuleListState.custom2Filters.contains(action.value)) {
    return transactionRuleListState
        .rebuild((b) => b..custom2Filters.remove(action.value));
  } else {
    return transactionRuleListState
        .rebuild((b) => b..custom2Filters.add(action.value));
  }
}

ListUIState _filterTransactionRulesByState(ListUIState transactionRuleListState,
    FilterTransactionRulesByState action) {
  if (transactionRuleListState.stateFilters.contains(action.state)) {
    return transactionRuleListState
        .rebuild((b) => b..stateFilters.remove(action.state));
  } else {
    return transactionRuleListState
        .rebuild((b) => b..stateFilters.add(action.state));
  }
}

ListUIState _filterTransactionRules(
    ListUIState transactionRuleListState, FilterTransactionRules action) {
  return transactionRuleListState.rebuild((b) => b
    ..filter = action.filter
    ..filterClearedAt = action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : transactionRuleListState.filterClearedAt);
}

ListUIState _sortTransactionRules(
    ListUIState transactionRuleListState, SortTransactionRules action) {
  return transactionRuleListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending!
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState productListState, StartTransactionRuleMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState productListState, AddToTransactionRuleMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds.add(action.entity!.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState productListState, RemoveFromTransactionRuleMultiselect action) {
  return productListState
      .rebuild((b) => b..selectedIds.remove(action.entity!.id));
}

ListUIState _clearListMultiselect(
    ListUIState productListState, ClearTransactionRuleMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = null);
}

final transactionRulesReducer = combineReducers<TransactionRuleState>([
  TypedReducer<TransactionRuleState, SaveTransactionRuleSuccess>(
      _updateTransactionRule),
  TypedReducer<TransactionRuleState, AddTransactionRuleSuccess>(
      _addTransactionRule),
  TypedReducer<TransactionRuleState, LoadTransactionRulesSuccess>(
      _setLoadedTransactionRules),
  TypedReducer<TransactionRuleState, LoadTransactionRuleSuccess>(
      _setLoadedTransactionRule),
  TypedReducer<TransactionRuleState, LoadCompanySuccess>(_setLoadedCompany),
  TypedReducer<TransactionRuleState, ArchiveTransactionRulesSuccess>(
      _archiveTransactionRuleSuccess),
  TypedReducer<TransactionRuleState, DeleteTransactionRulesSuccess>(
      _deleteTransactionRuleSuccess),
  TypedReducer<TransactionRuleState, RestoreTransactionRulesSuccess>(
      _restoreTransactionRuleSuccess),
]);

TransactionRuleState _archiveTransactionRuleSuccess(
    TransactionRuleState transactionRuleState,
    ArchiveTransactionRulesSuccess action) {
  return transactionRuleState.rebuild((b) {
    for (final transactionRule in action.transactionRules) {
      b.map[transactionRule.id] = transactionRule;
    }
  });
}

TransactionRuleState _deleteTransactionRuleSuccess(
    TransactionRuleState transactionRuleState,
    DeleteTransactionRulesSuccess action) {
  return transactionRuleState.rebuild((b) {
    for (final transactionRule in action.transactionRules) {
      b.map[transactionRule.id] = transactionRule;
    }
  });
}

TransactionRuleState _restoreTransactionRuleSuccess(
    TransactionRuleState transactionRuleState,
    RestoreTransactionRulesSuccess action) {
  return transactionRuleState.rebuild((b) {
    for (final transactionRule in action.transactionRules) {
      b.map[transactionRule.id] = transactionRule;
    }
  });
}

TransactionRuleState _addTransactionRule(
    TransactionRuleState transactionRuleState,
    AddTransactionRuleSuccess action) {
  return transactionRuleState.rebuild((b) => b
    ..map[action.transactionRule.id] = action.transactionRule
    ..list.add(action.transactionRule.id));
}

TransactionRuleState _updateTransactionRule(
    TransactionRuleState transactionRuleState,
    SaveTransactionRuleSuccess action) {
  return transactionRuleState.rebuild(
      (b) => b..map[action.transactionRule.id] = action.transactionRule);
}

TransactionRuleState _setLoadedTransactionRule(
    TransactionRuleState transactionRuleState,
    LoadTransactionRuleSuccess action) {
  return transactionRuleState.rebuild(
      (b) => b..map[action.transactionRule.id] = action.transactionRule);
}

TransactionRuleState _setLoadedTransactionRules(
        TransactionRuleState transactionRuleState,
        LoadTransactionRulesSuccess action) =>
    transactionRuleState.loadTransactionRules(action.transactionRules);

TransactionRuleState _setLoadedCompany(
    TransactionRuleState transactionRuleState, LoadCompanySuccess action) {
  final company = action.userCompany.company;
  return transactionRuleState.loadTransactionRules(company.transactionRules);
}
