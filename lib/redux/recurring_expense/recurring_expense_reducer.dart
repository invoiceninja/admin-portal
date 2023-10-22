// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/recurring_expense/recurring_expense_actions.dart';
import 'package:invoiceninja_flutter/redux/recurring_expense/recurring_expense_state.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

EntityUIState recurringExpenseUIReducer(
    RecurringExpenseUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState
        .replace(recurringExpenseListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action)!)
    ..selectedId = selectedIdReducer(state.selectedId, action)
    ..forceSelected = forceSelectedReducer(state.forceSelected, action)
    ..tabIndex = tabIndexReducer(state.tabIndex, action));
}

final forceSelectedReducer = combineReducers<bool?>([
  TypedReducer<bool?, ViewRecurringExpense>((completer, action) => true),
  TypedReducer<bool?, ViewRecurringExpenseList>((completer, action) => false),
  TypedReducer<bool?, FilterRecurringExpensesByState>(
      (completer, action) => false),
  TypedReducer<bool?, FilterRecurringExpensesByStatus>(
      (completer, action) => false),
  TypedReducer<bool?, FilterRecurringExpenses>((completer, action) => false),
  TypedReducer<bool?, FilterRecurringExpensesByCustom1>(
      (completer, action) => false),
  TypedReducer<bool?, FilterRecurringExpensesByCustom2>(
      (completer, action) => false),
  TypedReducer<bool?, FilterRecurringExpensesByCustom3>(
      (completer, action) => false),
  TypedReducer<bool?, FilterRecurringExpensesByCustom4>(
      (completer, action) => false),
]);

final int? Function(int, dynamic) tabIndexReducer = combineReducers<int?>([
  TypedReducer<int?, UpdateRecurringExpenseTab>((completer, action) {
    return action.tabIndex;
  }),
  TypedReducer<int?, PreviewEntity>((completer, action) {
    return 0;
  }),
]);

Reducer<String?> selectedIdReducer = combineReducers([
  TypedReducer<String?, ArchiveRecurringExpensesSuccess>(
      (completer, action) => ''),
  TypedReducer<String?, DeleteRecurringExpensesSuccess>(
      (completer, action) => ''),
  TypedReducer<String?, PreviewEntity>((selectedId, action) =>
      action.entityType == EntityType.recurringExpense
          ? action.entityId
          : selectedId),
  TypedReducer<String?, ViewRecurringExpense>(
      (String? selectedId, dynamic action) => action.recurringExpenseId),
  TypedReducer<String?, AddRecurringExpenseSuccess>(
      (String? selectedId, dynamic action) => action.recurringExpense.id),
  TypedReducer<String?, SelectCompany>(
      (selectedId, action) => action.clearSelection ? '' : selectedId),
  TypedReducer<String?, ClearEntityFilter>((selectedId, action) => ''),
  TypedReducer<String?, SortRecurringExpenses>((selectedId, action) => ''),
  TypedReducer<String?, FilterRecurringExpenses>((selectedId, action) => ''),
  TypedReducer<String?, FilterRecurringExpensesByState>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterRecurringExpensesByStatus>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterRecurringExpensesByCustom1>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterRecurringExpensesByCustom2>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterRecurringExpensesByCustom3>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterRecurringExpensesByCustom4>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterByEntity>(
      (selectedId, action) => action.clearSelection
          ? ''
          : action.entityType == EntityType.recurringExpense
              ? action.entityId
              : selectedId),
]);

final editingReducer = combineReducers<ExpenseEntity?>([
  TypedReducer<ExpenseEntity?, LoadRecurringExpenseSuccess>(_updateEditing),
  TypedReducer<ExpenseEntity?, SaveRecurringExpenseSuccess>(_updateEditing),
  TypedReducer<ExpenseEntity?, AddRecurringExpenseSuccess>(_updateEditing),
  TypedReducer<ExpenseEntity?, RestoreRecurringExpensesSuccess>(
      (recurringExpenses, action) {
    return action.recurringExpenses[0];
  }),
  TypedReducer<ExpenseEntity?, ArchiveRecurringExpensesSuccess>(
      (recurringExpenses, action) {
    return action.recurringExpenses[0];
  }),
  TypedReducer<ExpenseEntity?, DeleteRecurringExpensesSuccess>(
      (recurringExpenses, action) {
    return action.recurringExpenses[0];
  }),
  TypedReducer<ExpenseEntity?, EditRecurringExpense>(_updateEditing),
  TypedReducer<ExpenseEntity?, UpdateRecurringExpense>(
      (recurringExpense, action) {
    return action.recurringExpense.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<ExpenseEntity?, DiscardChanges>(_clearEditing),
]);

ExpenseEntity _clearEditing(ExpenseEntity? recurringExpense, dynamic action) {
  return ExpenseEntity(entityType: EntityType.recurringExpense);
}

ExpenseEntity? _updateEditing(ExpenseEntity? recurringExpense, dynamic action) {
  return action.recurringExpense;
}

final recurringExpenseListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortRecurringExpenses>(_sortRecurringExpenses),
  TypedReducer<ListUIState, FilterRecurringExpensesByState>(
      _filterRecurringExpensesByState),
  TypedReducer<ListUIState, FilterRecurringExpensesByStatus>(
      _filterRecurringExpensesByStatus),
  TypedReducer<ListUIState, FilterRecurringExpenses>(_filterRecurringExpenses),
  TypedReducer<ListUIState, FilterRecurringExpensesByCustom1>(
      _filterRecurringExpensesByCustom1),
  TypedReducer<ListUIState, FilterRecurringExpensesByCustom2>(
      _filterRecurringExpensesByCustom2),
  TypedReducer<ListUIState, StartRecurringExpenseMultiselect>(
      _startListMultiselect),
  TypedReducer<ListUIState, AddToRecurringExpenseMultiselect>(
      _addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromRecurringExpenseMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearRecurringExpenseMultiselect>(
      _clearListMultiselect),
  TypedReducer<ListUIState, ViewRecurringExpenseList>(
      _viewRecurringExpenseList),
  TypedReducer<ListUIState, FilterByEntity>(
      (state, action) => state.rebuild((b) => b
        ..filter = null
        ..filterClearedAt = DateTime.now().millisecondsSinceEpoch)),
]);

ListUIState _viewRecurringExpenseList(
    ListUIState recurringExpenseListState, ViewRecurringExpenseList action) {
  return recurringExpenseListState.rebuild((b) => b
    ..selectedIds = null
    ..filter = null
    ..filterClearedAt = DateTime.now().millisecondsSinceEpoch);
}

ListUIState _filterRecurringExpensesByCustom1(
    ListUIState recurringExpenseListState,
    FilterRecurringExpensesByCustom1 action) {
  if (recurringExpenseListState.custom1Filters.contains(action.value)) {
    return recurringExpenseListState
        .rebuild((b) => b..custom1Filters.remove(action.value));
  } else {
    return recurringExpenseListState
        .rebuild((b) => b..custom1Filters.add(action.value));
  }
}

ListUIState _filterRecurringExpensesByCustom2(
    ListUIState recurringExpenseListState,
    FilterRecurringExpensesByCustom2 action) {
  if (recurringExpenseListState.custom2Filters.contains(action.value)) {
    return recurringExpenseListState
        .rebuild((b) => b..custom2Filters.remove(action.value));
  } else {
    return recurringExpenseListState
        .rebuild((b) => b..custom2Filters.add(action.value));
  }
}

ListUIState _filterRecurringExpensesByState(
    ListUIState recurringExpenseListState,
    FilterRecurringExpensesByState action) {
  if (recurringExpenseListState.stateFilters.contains(action.state)) {
    return recurringExpenseListState
        .rebuild((b) => b..stateFilters.remove(action.state));
  } else {
    return recurringExpenseListState
        .rebuild((b) => b..stateFilters.add(action.state));
  }
}

ListUIState _filterRecurringExpensesByStatus(
    ListUIState recurringExpenseListState,
    FilterRecurringExpensesByStatus action) {
  if (recurringExpenseListState.statusFilters.contains(action.status)) {
    return recurringExpenseListState
        .rebuild((b) => b..statusFilters.remove(action.status));
  } else {
    return recurringExpenseListState
        .rebuild((b) => b..statusFilters.add(action.status));
  }
}

ListUIState _filterRecurringExpenses(
    ListUIState recurringExpenseListState, FilterRecurringExpenses action) {
  return recurringExpenseListState.rebuild((b) => b
    ..filter = action.filter
    ..filterClearedAt = action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : recurringExpenseListState.filterClearedAt);
}

ListUIState _sortRecurringExpenses(
    ListUIState recurringExpenseListState, SortRecurringExpenses action) {
  return recurringExpenseListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending!
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState productListState, StartRecurringExpenseMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState productListState, AddToRecurringExpenseMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds.add(action.entity!.id));
}

ListUIState _removeFromListMultiselect(ListUIState productListState,
    RemoveFromRecurringExpenseMultiselect action) {
  return productListState
      .rebuild((b) => b..selectedIds.remove(action.entity!.id));
}

ListUIState _clearListMultiselect(
    ListUIState productListState, ClearRecurringExpenseMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = null);
}

final recurringExpensesReducer = combineReducers<RecurringExpenseState>([
  TypedReducer<RecurringExpenseState, SaveRecurringExpenseSuccess>(
      _updateRecurringExpense),
  TypedReducer<RecurringExpenseState, AddRecurringExpenseSuccess>(
      _addRecurringExpense),
  TypedReducer<RecurringExpenseState, LoadRecurringExpensesSuccess>(
      _setLoadedRecurringExpenses),
  TypedReducer<RecurringExpenseState, LoadRecurringExpenseSuccess>(
      _setLoadedRecurringExpense),
  TypedReducer<RecurringExpenseState, StartRecurringExpensesSuccess>(
      _startRecurringExpensesSuccess),
  TypedReducer<RecurringExpenseState, StopRecurringExpensesSuccess>(
      _stopRecurringExpensesSuccess),
  TypedReducer<RecurringExpenseState, LoadCompanySuccess>(_setLoadedCompany),
  TypedReducer<RecurringExpenseState, ArchiveRecurringExpensesSuccess>(
      _archiveRecurringExpenseSuccess),
  TypedReducer<RecurringExpenseState, DeleteRecurringExpensesSuccess>(
      _deleteRecurringExpenseSuccess),
  TypedReducer<RecurringExpenseState, RestoreRecurringExpensesSuccess>(
      _restoreRecurringExpenseSuccess),
  TypedReducer<RecurringExpenseState, PurgeClientSuccess>(_purgeClientSuccess),
]);

RecurringExpenseState _purgeClientSuccess(
    RecurringExpenseState expenseState, PurgeClientSuccess action) {
  final ids = expenseState.map.values
      .where((each) => each.clientId == action.clientId)
      .map((each) => each.id)
      .toList();

  return expenseState.rebuild((b) => b
    ..map.removeWhere((p0, p1) => ids.contains(p0))
    ..list.removeWhere((p0) => ids.contains(p0)));
}

RecurringExpenseState _archiveRecurringExpenseSuccess(
    RecurringExpenseState recurringExpenseState,
    ArchiveRecurringExpensesSuccess action) {
  return recurringExpenseState.rebuild((b) {
    for (final recurringExpense in action.recurringExpenses) {
      b.map[recurringExpense.id] = recurringExpense;
    }
  });
}

RecurringExpenseState _deleteRecurringExpenseSuccess(
    RecurringExpenseState recurringExpenseState,
    DeleteRecurringExpensesSuccess action) {
  return recurringExpenseState.rebuild((b) {
    for (final recurringExpense in action.recurringExpenses) {
      b.map[recurringExpense.id] = recurringExpense;
    }
  });
}

RecurringExpenseState _restoreRecurringExpenseSuccess(
    RecurringExpenseState recurringExpenseState,
    RestoreRecurringExpensesSuccess action) {
  return recurringExpenseState.rebuild((b) {
    for (final recurringExpense in action.recurringExpenses) {
      b.map[recurringExpense.id] = recurringExpense;
    }
  });
}

RecurringExpenseState _addRecurringExpense(
    RecurringExpenseState recurringExpenseState,
    AddRecurringExpenseSuccess action) {
  return recurringExpenseState.rebuild((b) => b
    ..map[action.recurringExpense.id] = action.recurringExpense
        .rebuild((b) => b..loadedAt = DateTime.now().millisecondsSinceEpoch)
    ..list.add(action.recurringExpense.id));
}

RecurringExpenseState _updateRecurringExpense(
    RecurringExpenseState recurringExpenseState,
    SaveRecurringExpenseSuccess action) {
  return recurringExpenseState.rebuild((b) => b
    ..map[action.recurringExpense.id] = action.recurringExpense
        .rebuild((b) => b..loadedAt = DateTime.now().millisecondsSinceEpoch));
}

RecurringExpenseState _startRecurringExpensesSuccess(
    RecurringExpenseState recurringExpenseState,
    StartRecurringExpensesSuccess action) {
  return recurringExpenseState.rebuild((b) {
    for (final recurringExpense in action.expenses) {
      b.map[recurringExpense.id] = recurringExpense;
    }
  });
}

RecurringExpenseState _stopRecurringExpensesSuccess(
    RecurringExpenseState recurringExpenseState,
    StopRecurringExpensesSuccess action) {
  return recurringExpenseState.rebuild((b) {
    for (final recurringExpense in action.expenses) {
      b.map[recurringExpense.id] = recurringExpense;
    }
  });
}

RecurringExpenseState _setLoadedRecurringExpense(
    RecurringExpenseState recurringExpenseState,
    LoadRecurringExpenseSuccess action) {
  return recurringExpenseState.rebuild((b) => b
    ..map[action.recurringExpense.id] = action.recurringExpense
        .rebuild((b) => b..loadedAt = DateTime.now().millisecondsSinceEpoch));
}

RecurringExpenseState _setLoadedRecurringExpenses(
        RecurringExpenseState recurringExpenseState,
        LoadRecurringExpensesSuccess action) =>
    recurringExpenseState.loadRecurringExpenses(action.recurringExpenses);

RecurringExpenseState _setLoadedCompany(
    RecurringExpenseState recurringExpenseState, LoadCompanySuccess action) {
  final company = action.userCompany.company;
  return recurringExpenseState.loadRecurringExpenses(company.recurringExpenses);
}
