// Package imports:
import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/expense_category/expense_category_actions.dart';
import 'package:invoiceninja_flutter/redux/expense_category/expense_category_state.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

EntityUIState expenseCategoryUIReducer(
    ExpenseCategoryUIState state, dynamic action) {
  return state.rebuild(
    (b) => b
      ..listUIState
          .replace(expenseCategoryListReducer(state.listUIState, action))
      ..editing.replace(editingReducer(state.editing, action)!)
      ..selectedId = selectedIdReducer(state.selectedId, action)
      ..forceSelected = forceSelectedReducer(state.forceSelected, action)
      ..saveCompleter = saveCompleterReducer(state.saveCompleter, action)
      ..cancelCompleter = cancelCompleterReducer(state.cancelCompleter, action),
  );
}

final saveCompleterReducer = combineReducers<Completer<SelectableEntity>?>([
  TypedReducer<Completer<SelectableEntity>?, EditExpenseCategory>(
      (completer, action) {
    return action.completer as Completer<SelectableEntity>?;
  }),
]);

final cancelCompleterReducer = combineReducers<Completer<Null>?>([
  TypedReducer<Completer<Null>?, EditExpenseCategory>((completer, action) {
    return action.cancelCompleter as Completer<Null>?;
  }),
]);

final forceSelectedReducer = combineReducers<bool?>([
  TypedReducer<bool?, ViewExpenseCategory>((completer, action) => true),
  TypedReducer<bool?, ViewExpenseCategoryList>((completer, action) => false),
  TypedReducer<bool?, FilterExpenseCategoriesByState>(
      (completer, action) => false),
  TypedReducer<bool?, FilterExpenseCategories>((completer, action) => false),
  TypedReducer<bool?, FilterExpenseCategoriesByCustom1>(
      (completer, action) => false),
  TypedReducer<bool?, FilterExpenseCategoriesByCustom2>(
      (completer, action) => false),
  TypedReducer<bool?, FilterExpenseCategoriesByCustom3>(
      (completer, action) => false),
  TypedReducer<bool?, FilterExpenseCategoriesByCustom4>(
      (completer, action) => false),
]);

Reducer<String?> selectedIdReducer = combineReducers([
  TypedReducer<String?, ArchiveExpenseCategoriesSuccess>(
      (completer, action) => ''),
  TypedReducer<String?, DeleteExpenseCategoriesSuccess>(
      (completer, action) => ''),
  TypedReducer<String?, PreviewEntity>((selectedId, action) =>
      action.entityType == EntityType.expenseCategory
          ? action.entityId
          : selectedId),
  TypedReducer<String?, ViewExpenseCategory>(
      (String? selectedId, dynamic action) => action.expenseCategoryId),
  TypedReducer<String?, AddExpenseCategorySuccess>(
      (String? selectedId, dynamic action) => action.expenseCategory.id),
  TypedReducer<String?, SelectCompany>(
      (selectedId, action) => action.clearSelection ? '' : selectedId),
  TypedReducer<String?, ClearEntityFilter>((selectedId, action) => ''),
  TypedReducer<String?, SortExpenseCategories>((selectedId, action) => ''),
  TypedReducer<String?, FilterExpenseCategories>((selectedId, action) => ''),
  TypedReducer<String?, FilterExpenseCategoriesByState>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterExpenseCategoriesByCustom1>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterExpenseCategoriesByCustom2>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterExpenseCategoriesByCustom3>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterExpenseCategoriesByCustom4>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterByEntity>(
      (selectedId, action) => action.clearSelection
          ? ''
          : action.entityType == EntityType.expenseCategory
              ? action.entityId
              : selectedId),
]);

final editingReducer = combineReducers<ExpenseCategoryEntity?>([
  TypedReducer<ExpenseCategoryEntity?, SaveExpenseCategorySuccess>(
      _updateEditing),
  TypedReducer<ExpenseCategoryEntity?, AddExpenseCategorySuccess>(
      _updateEditing),
  TypedReducer<ExpenseCategoryEntity?, RestoreExpenseCategoriesSuccess>(
      (expenseCategories, action) {
    return action.expenseCategories[0];
  }),
  TypedReducer<ExpenseCategoryEntity?, ArchiveExpenseCategoriesSuccess>(
      (expenseCategories, action) {
    return action.expenseCategories[0];
  }),
  TypedReducer<ExpenseCategoryEntity?, DeleteExpenseCategoriesSuccess>(
      (expenseCategories, action) {
    return action.expenseCategories[0];
  }),
  TypedReducer<ExpenseCategoryEntity?, EditExpenseCategory>(_updateEditing),
  TypedReducer<ExpenseCategoryEntity?, UpdateExpenseCategory>(
      (expenseCategory, action) {
    return action.expenseCategory.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<ExpenseCategoryEntity?, DiscardChanges>(_clearEditing),
]);

ExpenseCategoryEntity _clearEditing(
    ExpenseCategoryEntity? expenseCategory, dynamic action) {
  return ExpenseCategoryEntity();
}

ExpenseCategoryEntity? _updateEditing(
    ExpenseCategoryEntity? expenseCategory, dynamic action) {
  return action.expenseCategory;
}

final expenseCategoryListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortExpenseCategories>(_sortExpenseCategories),
  TypedReducer<ListUIState, FilterExpenseCategoriesByState>(
      _filterExpenseCategoriesByState),
  TypedReducer<ListUIState, FilterExpenseCategories>(_filterExpenseCategories),
  TypedReducer<ListUIState, FilterExpenseCategoriesByCustom1>(
      _filterExpenseCategoriesByCustom1),
  TypedReducer<ListUIState, FilterExpenseCategoriesByCustom2>(
      _filterExpenseCategoriesByCustom2),
  TypedReducer<ListUIState, StartExpenseCategoryMultiselect>(
      _startListMultiselect),
  TypedReducer<ListUIState, AddToExpenseCategoryMultiselect>(
      _addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromExpenseCategoryMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearExpenseCategoryMultiselect>(
      _clearListMultiselect),
  TypedReducer<ListUIState, FilterByEntity>(
      (state, action) => state.rebuild((b) => b
        ..filter = null
        ..filterClearedAt = DateTime.now().millisecondsSinceEpoch)),
]);

ListUIState _filterExpenseCategoriesByCustom1(
    ListUIState expenseCategoryListState,
    FilterExpenseCategoriesByCustom1 action) {
  if (expenseCategoryListState.custom1Filters.contains(action.value)) {
    return expenseCategoryListState
        .rebuild((b) => b..custom1Filters.remove(action.value));
  } else {
    return expenseCategoryListState
        .rebuild((b) => b..custom1Filters.add(action.value));
  }
}

ListUIState _filterExpenseCategoriesByCustom2(
    ListUIState expenseCategoryListState,
    FilterExpenseCategoriesByCustom2 action) {
  if (expenseCategoryListState.custom2Filters.contains(action.value)) {
    return expenseCategoryListState
        .rebuild((b) => b..custom2Filters.remove(action.value));
  } else {
    return expenseCategoryListState
        .rebuild((b) => b..custom2Filters.add(action.value));
  }
}

ListUIState _filterExpenseCategoriesByState(
    ListUIState expenseCategoryListState,
    FilterExpenseCategoriesByState action) {
  if (expenseCategoryListState.stateFilters.contains(action.state)) {
    return expenseCategoryListState
        .rebuild((b) => b..stateFilters.remove(action.state));
  } else {
    return expenseCategoryListState
        .rebuild((b) => b..stateFilters.add(action.state));
  }
}

ListUIState _filterExpenseCategories(
    ListUIState expenseCategoryListState, FilterExpenseCategories action) {
  return expenseCategoryListState.rebuild((b) => b
    ..filter = action.filter
    ..filterClearedAt = action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : expenseCategoryListState.filterClearedAt);
}

ListUIState _sortExpenseCategories(
    ListUIState expenseCategoryListState, SortExpenseCategories action) {
  return expenseCategoryListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending!
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState productListState, StartExpenseCategoryMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState productListState, AddToExpenseCategoryMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds.add(action.entity!.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState productListState, RemoveFromExpenseCategoryMultiselect action) {
  return productListState
      .rebuild((b) => b..selectedIds.remove(action.entity!.id));
}

ListUIState _clearListMultiselect(
    ListUIState productListState, ClearExpenseCategoryMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = null);
}

final expenseCategoriesReducer = combineReducers<ExpenseCategoryState>([
  TypedReducer<ExpenseCategoryState, SaveExpenseCategorySuccess>(
      _updateExpenseCategory),
  TypedReducer<ExpenseCategoryState, AddExpenseCategorySuccess>(
      _addExpenseCategory),
  TypedReducer<ExpenseCategoryState, LoadExpenseCategoriesSuccess>(
      _setLoadedExpenseCategories),
  TypedReducer<ExpenseCategoryState, LoadExpenseCategorySuccess>(
      _setLoadedExpenseCategory),
  TypedReducer<ExpenseCategoryState, LoadCompanySuccess>(_setLoadedCompany),
  TypedReducer<ExpenseCategoryState, ArchiveExpenseCategoriesSuccess>(
      _archiveExpenseCategorySuccess),
  TypedReducer<ExpenseCategoryState, DeleteExpenseCategoriesSuccess>(
      _deleteExpenseCategorySuccess),
  TypedReducer<ExpenseCategoryState, RestoreExpenseCategoriesSuccess>(
      _restoreExpenseCategorySuccess),
]);

ExpenseCategoryState _archiveExpenseCategorySuccess(
    ExpenseCategoryState expenseCategoryState,
    ArchiveExpenseCategoriesSuccess action) {
  return expenseCategoryState.rebuild((b) {
    for (final expenseCategory in action.expenseCategories) {
      b.map[expenseCategory.id] = expenseCategory;
    }
  });
}

ExpenseCategoryState _deleteExpenseCategorySuccess(
    ExpenseCategoryState expenseCategoryState,
    DeleteExpenseCategoriesSuccess action) {
  return expenseCategoryState.rebuild((b) {
    for (final expenseCategory in action.expenseCategories) {
      b.map[expenseCategory.id] = expenseCategory;
    }
  });
}

ExpenseCategoryState _restoreExpenseCategorySuccess(
    ExpenseCategoryState expenseCategoryState,
    RestoreExpenseCategoriesSuccess action) {
  return expenseCategoryState.rebuild((b) {
    for (final expenseCategory in action.expenseCategories) {
      b.map[expenseCategory.id] = expenseCategory;
    }
  });
}

ExpenseCategoryState _addExpenseCategory(
    ExpenseCategoryState expenseCategoryState,
    AddExpenseCategorySuccess action) {
  return expenseCategoryState.rebuild((b) => b
    ..map[action.expenseCategory.id] = action.expenseCategory
    ..list.add(action.expenseCategory.id));
}

ExpenseCategoryState _updateExpenseCategory(
    ExpenseCategoryState expenseCategoryState,
    SaveExpenseCategorySuccess action) {
  return expenseCategoryState.rebuild(
      (b) => b..map[action.expenseCategory.id] = action.expenseCategory);
}

ExpenseCategoryState _setLoadedExpenseCategory(
    ExpenseCategoryState expenseCategoryState,
    LoadExpenseCategorySuccess action) {
  return expenseCategoryState.rebuild(
      (b) => b..map[action.expenseCategory.id] = action.expenseCategory);
}

ExpenseCategoryState _setLoadedExpenseCategories(
        ExpenseCategoryState expenseCategoryState,
        LoadExpenseCategoriesSuccess action) =>
    expenseCategoryState.loadExpenseCategories(action.expenseCategories);

ExpenseCategoryState _setLoadedCompany(
    ExpenseCategoryState expenseCategoryState, LoadCompanySuccess action) {
  final company = action.userCompany.company;
  return expenseCategoryState.loadExpenseCategories(company.expenseCategories);
}
