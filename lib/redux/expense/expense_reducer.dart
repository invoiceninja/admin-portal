import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_state.dart';

EntityUIState expenseUIReducer(ExpenseUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(expenseListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action))
    ..selectedId = selectedIdReducer(state.selectedId, action));
}

Reducer<int> selectedIdReducer = combineReducers([
  TypedReducer<int, ViewExpense>(
      (int selectedId, dynamic action) => action.expenseId),
  TypedReducer<int, AddExpenseSuccess>(
      (int selectedId, dynamic action) => action.expense.id),
]);

final editingReducer = combineReducers<ExpenseEntity>([
  TypedReducer<ExpenseEntity, SaveExpenseSuccess>(_updateEditing),
  TypedReducer<ExpenseEntity, AddExpenseSuccess>(_updateEditing),
  TypedReducer<ExpenseEntity, RestoreExpenseSuccess>(_updateEditing),
  TypedReducer<ExpenseEntity, ArchiveExpenseSuccess>(_updateEditing),
  TypedReducer<ExpenseEntity, DeleteExpenseSuccess>(_updateEditing),
  TypedReducer<ExpenseEntity, EditExpense>(_updateEditing),
  TypedReducer<ExpenseEntity, UpdateExpense>(_updateEditing),
  TypedReducer<ExpenseEntity, SelectCompany>(_clearEditing),
]);

ExpenseEntity _clearEditing(ExpenseEntity expense, dynamic action) {
  return ExpenseEntity();
}

ExpenseEntity _updateEditing(ExpenseEntity expense, dynamic action) {
  return action.expense;
}

final expenseListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortExpenses>(_sortExpenses),
  TypedReducer<ListUIState, FilterExpensesByState>(_filterExpensesByState),
  TypedReducer<ListUIState, FilterExpensesByStatus>(_filterExpensesByStatus),
  TypedReducer<ListUIState, FilterExpenses>(_filterExpenses),
  TypedReducer<ListUIState, FilterExpensesByCustom1>(_filterExpensesByCustom1),
  TypedReducer<ListUIState, FilterExpensesByCustom2>(_filterExpensesByCustom2),
  TypedReducer<ListUIState, FilterExpensesByEntity>(_filterExpensesByClient),
]);

ListUIState _filterExpensesByClient(
    ListUIState expenseListState, FilterExpensesByEntity action) {
  return expenseListState.rebuild((b) => b
    ..filterEntityId = action.entityId
    ..filterEntityType = action.entityType);
}

ListUIState _filterExpensesByCustom1(
    ListUIState expenseListState, FilterExpensesByCustom1 action) {
  if (expenseListState.custom1Filters.contains(action.value)) {
    return expenseListState
        .rebuild((b) => b..custom1Filters.remove(action.value));
  } else {
    return expenseListState.rebuild((b) => b..custom1Filters.add(action.value));
  }
}

ListUIState _filterExpensesByCustom2(
    ListUIState expenseListState, FilterExpensesByCustom2 action) {
  if (expenseListState.custom2Filters.contains(action.value)) {
    return expenseListState
        .rebuild((b) => b..custom2Filters.remove(action.value));
  } else {
    return expenseListState.rebuild((b) => b..custom2Filters.add(action.value));
  }
}

ListUIState _filterExpensesByState(
    ListUIState expenseListState, FilterExpensesByState action) {
  if (expenseListState.stateFilters.contains(action.state)) {
    return expenseListState
        .rebuild((b) => b..stateFilters.remove(action.state));
  } else {
    return expenseListState.rebuild((b) => b..stateFilters.add(action.state));
  }
}

ListUIState _filterExpensesByStatus(
    ListUIState expenseListState, FilterExpensesByStatus action) {
  if (expenseListState.statusFilters.contains(action.status)) {
    return expenseListState.rebuild((b) => b..statusFilters.remove(action.status));
  } else {
    return expenseListState.rebuild((b) => b..statusFilters.add(action.status));
  }
}


ListUIState _filterExpenses(
    ListUIState expenseListState, FilterExpenses action) {
  return expenseListState.rebuild((b) => b..filter = action.filter);
}

ListUIState _sortExpenses(ListUIState expenseListState, SortExpenses action) {
  return expenseListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending
    ..sortField = action.field);
}

final expensesReducer = combineReducers<ExpenseState>([
  TypedReducer<ExpenseState, SaveExpenseSuccess>(_updateExpense),
  TypedReducer<ExpenseState, AddExpenseSuccess>(_addExpense),
  TypedReducer<ExpenseState, LoadExpensesSuccess>(_setLoadedExpenses),
  TypedReducer<ExpenseState, LoadExpenseSuccess>(_setLoadedExpense),
  TypedReducer<ExpenseState, ArchiveExpenseRequest>(_archiveExpenseRequest),
  TypedReducer<ExpenseState, ArchiveExpenseSuccess>(_archiveExpenseSuccess),
  TypedReducer<ExpenseState, ArchiveExpenseFailure>(_archiveExpenseFailure),
  TypedReducer<ExpenseState, DeleteExpenseRequest>(_deleteExpenseRequest),
  TypedReducer<ExpenseState, DeleteExpenseSuccess>(_deleteExpenseSuccess),
  TypedReducer<ExpenseState, DeleteExpenseFailure>(_deleteExpenseFailure),
  TypedReducer<ExpenseState, RestoreExpenseRequest>(_restoreExpenseRequest),
  TypedReducer<ExpenseState, RestoreExpenseSuccess>(_restoreExpenseSuccess),
  TypedReducer<ExpenseState, RestoreExpenseFailure>(_restoreExpenseFailure),
]);

ExpenseState _archiveExpenseRequest(
    ExpenseState expenseState, ArchiveExpenseRequest action) {
  final expense = expenseState.map[action.expenseId]
      .rebuild((b) => b..archivedAt = DateTime.now().millisecondsSinceEpoch);

  return expenseState.rebuild((b) => b..map[action.expenseId] = expense);
}

ExpenseState _archiveExpenseSuccess(
    ExpenseState expenseState, ArchiveExpenseSuccess action) {
  return expenseState
      .rebuild((b) => b..map[action.expense.id] = action.expense);
}

ExpenseState _archiveExpenseFailure(
    ExpenseState expenseState, ArchiveExpenseFailure action) {
  return expenseState
      .rebuild((b) => b..map[action.expense.id] = action.expense);
}

ExpenseState _deleteExpenseRequest(
    ExpenseState expenseState, DeleteExpenseRequest action) {
  final expense = expenseState.map[action.expenseId].rebuild((b) => b
    ..archivedAt = DateTime.now().millisecondsSinceEpoch
    ..isDeleted = true);

  return expenseState.rebuild((b) => b..map[action.expenseId] = expense);
}

ExpenseState _deleteExpenseSuccess(
    ExpenseState expenseState, DeleteExpenseSuccess action) {
  return expenseState
      .rebuild((b) => b..map[action.expense.id] = action.expense);
}

ExpenseState _deleteExpenseFailure(
    ExpenseState expenseState, DeleteExpenseFailure action) {
  return expenseState
      .rebuild((b) => b..map[action.expense.id] = action.expense);
}

ExpenseState _restoreExpenseRequest(
    ExpenseState expenseState, RestoreExpenseRequest action) {
  final expense = expenseState.map[action.expenseId].rebuild((b) => b
    ..archivedAt = null
    ..isDeleted = false);
  return expenseState.rebuild((b) => b..map[action.expenseId] = expense);
}

ExpenseState _restoreExpenseSuccess(
    ExpenseState expenseState, RestoreExpenseSuccess action) {
  return expenseState
      .rebuild((b) => b..map[action.expense.id] = action.expense);
}

ExpenseState _restoreExpenseFailure(
    ExpenseState expenseState, RestoreExpenseFailure action) {
  return expenseState
      .rebuild((b) => b..map[action.expense.id] = action.expense);
}

ExpenseState _addExpense(ExpenseState expenseState, AddExpenseSuccess action) {
  return expenseState.rebuild((b) => b
    ..map[action.expense.id] = action.expense
    ..list.add(action.expense.id));
}

ExpenseState _updateExpense(
    ExpenseState expenseState, SaveExpenseSuccess action) {
  return expenseState
      .rebuild((b) => b..map[action.expense.id] = action.expense);
}

ExpenseState _setLoadedExpense(
    ExpenseState expenseState, LoadExpenseSuccess action) {
  return expenseState
      .rebuild((b) => b..map[action.expense.id] = action.expense);
}

ExpenseState _setLoadedExpenses(
    ExpenseState expenseState, LoadExpensesSuccess action) {
  final state = expenseState.rebuild((b) => b
    ..lastUpdated = DateTime.now().millisecondsSinceEpoch
    ..map.addAll(Map.fromIterable(
      action.expenses,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    )));

  return state.rebuild((b) => b..list.replace(state.map.keys));
}
