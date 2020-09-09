import 'package:redux/redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_state.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';

EntityUIState recurringInvoiceUIReducer(
    RecurringInvoiceUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState
        .replace(recurringInvoiceListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action))
    ..selectedId = selectedIdReducer(state.selectedId, action));
}

Reducer<String> selectedIdReducer = combineReducers([
  TypedReducer<String, ViewRecurringInvoice>(
      (String selectedId, dynamic action) => action.recurringInvoiceId),
  TypedReducer<String, AddRecurringInvoiceSuccess>(
      (String selectedId, dynamic action) => action.recurringInvoice.id),
  TypedReducer<String, SelectCompany>(
      (selectedId, action) => action.clearSelection ? '' : selectedId),
  TypedReducer<String, DeleteRecurringInvoicesSuccess>(
      (selectedId, action) => ''),
  TypedReducer<String, ArchiveRecurringInvoicesSuccess>(
      (selectedId, action) => ''),
  TypedReducer<String, ClearEntityFilter>((selectedId, action) => ''),
  TypedReducer<String, FilterByEntity>((selectedId, action) =>
      action.clearSelection
          ? ''
          : action.entityType == EntityType.recurringInvoice
              ? action.entityId
              : selectedId),
]);

final editingReducer = combineReducers<InvoiceEntity>([
  TypedReducer<InvoiceEntity, SaveRecurringInvoiceSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity, AddRecurringInvoiceSuccess>(_updateEditing),
  TypedReducer<InvoiceEntity, RestoreRecurringInvoicesSuccess>(
      (recurringInvoices, action) {
    return action.recurringInvoices[0];
  }),
  TypedReducer<InvoiceEntity, ArchiveRecurringInvoicesSuccess>(
      (recurringInvoices, action) {
    return action.recurringInvoices[0];
  }),
  TypedReducer<InvoiceEntity, DeleteRecurringInvoicesSuccess>(
      (recurringInvoices, action) {
    return action.recurringInvoices[0];
  }),
  TypedReducer<InvoiceEntity, EditRecurringInvoice>(_updateEditing),
  TypedReducer<InvoiceEntity, UpdateRecurringInvoice>(
      (recurringInvoice, action) {
    return action.recurringInvoice.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<InvoiceEntity, DiscardChanges>(_clearEditing),
]);

InvoiceEntity _clearEditing(InvoiceEntity recurringInvoice, dynamic action) {
  return InvoiceEntity();
}

InvoiceEntity _updateEditing(InvoiceEntity recurringInvoice, dynamic action) {
  return action.recurringInvoice;
}

final recurringInvoiceListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortRecurringInvoices>(_sortRecurringInvoices),
  TypedReducer<ListUIState, FilterRecurringInvoicesByState>(
      _filterRecurringInvoicesByState),
  TypedReducer<ListUIState, FilterRecurringInvoices>(_filterRecurringInvoices),
  TypedReducer<ListUIState, FilterRecurringInvoicesByCustom1>(
      _filterRecurringInvoicesByCustom1),
  TypedReducer<ListUIState, FilterRecurringInvoicesByCustom2>(
      _filterRecurringInvoicesByCustom2),
  TypedReducer<ListUIState, StartRecurringInvoiceMultiselect>(
      _startListMultiselect),
  TypedReducer<ListUIState, AddToRecurringInvoiceMultiselect>(
      _addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromRecurringInvoiceMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearRecurringInvoiceMultiselect>(
      _clearListMultiselect),
]);

ListUIState _filterRecurringInvoicesByCustom1(
    ListUIState recurringInvoiceListState,
    FilterRecurringInvoicesByCustom1 action) {
  if (recurringInvoiceListState.custom1Filters.contains(action.value)) {
    return recurringInvoiceListState
        .rebuild((b) => b..custom1Filters.remove(action.value));
  } else {
    return recurringInvoiceListState
        .rebuild((b) => b..custom1Filters.add(action.value));
  }
}

ListUIState _filterRecurringInvoicesByCustom2(
    ListUIState recurringInvoiceListState,
    FilterRecurringInvoicesByCustom2 action) {
  if (recurringInvoiceListState.custom2Filters.contains(action.value)) {
    return recurringInvoiceListState
        .rebuild((b) => b..custom2Filters.remove(action.value));
  } else {
    return recurringInvoiceListState
        .rebuild((b) => b..custom2Filters.add(action.value));
  }
}

ListUIState _filterRecurringInvoicesByState(
    ListUIState recurringInvoiceListState,
    FilterRecurringInvoicesByState action) {
  if (recurringInvoiceListState.stateFilters.contains(action.state)) {
    return recurringInvoiceListState
        .rebuild((b) => b..stateFilters.remove(action.state));
  } else {
    return recurringInvoiceListState
        .rebuild((b) => b..stateFilters.add(action.state));
  }
}

ListUIState _filterRecurringInvoices(
    ListUIState recurringInvoiceListState, FilterRecurringInvoices action) {
  return recurringInvoiceListState.rebuild((b) => b
    ..filter = action.filter
    ..filterClearedAt = action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : recurringInvoiceListState.filterClearedAt);
}

ListUIState _sortRecurringInvoices(
    ListUIState recurringInvoiceListState, SortRecurringInvoices action) {
  return recurringInvoiceListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState productListState, StartRecurringInvoiceMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState productListState, AddToRecurringInvoiceMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds.add(action.entity.id));
}

ListUIState _removeFromListMultiselect(ListUIState productListState,
    RemoveFromRecurringInvoiceMultiselect action) {
  return productListState
      .rebuild((b) => b..selectedIds.remove(action.entity.id));
}

ListUIState _clearListMultiselect(
    ListUIState productListState, ClearRecurringInvoiceMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = null);
}

final recurringInvoicesReducer = combineReducers<RecurringInvoiceState>([
  TypedReducer<RecurringInvoiceState, SaveRecurringInvoiceSuccess>(
      _updateRecurringInvoice),
  TypedReducer<RecurringInvoiceState, AddRecurringInvoiceSuccess>(
      _addRecurringInvoice),
  TypedReducer<RecurringInvoiceState, LoadRecurringInvoicesSuccess>(
      _setLoadedRecurringInvoices),
  TypedReducer<RecurringInvoiceState, LoadRecurringInvoiceSuccess>(
      _setLoadedRecurringInvoice),
  TypedReducer<RecurringInvoiceState, LoadCompanySuccess>(_setLoadedCompany),
  TypedReducer<RecurringInvoiceState, ArchiveRecurringInvoicesSuccess>(
      _archiveRecurringInvoiceSuccess),
  TypedReducer<RecurringInvoiceState, DeleteRecurringInvoicesSuccess>(
      _deleteRecurringInvoiceSuccess),
  TypedReducer<RecurringInvoiceState, RestoreRecurringInvoicesSuccess>(
      _restoreRecurringInvoiceSuccess),
]);

RecurringInvoiceState _archiveRecurringInvoiceSuccess(
    RecurringInvoiceState recurringInvoiceState,
    ArchiveRecurringInvoicesSuccess action) {
  return recurringInvoiceState.rebuild((b) {
    for (final recurringInvoice in action.recurringInvoices) {
      b.map[recurringInvoice.id] = recurringInvoice;
    }
  });
}

RecurringInvoiceState _deleteRecurringInvoiceSuccess(
    RecurringInvoiceState recurringInvoiceState,
    DeleteRecurringInvoicesSuccess action) {
  return recurringInvoiceState.rebuild((b) {
    for (final recurringInvoice in action.recurringInvoices) {
      b.map[recurringInvoice.id] = recurringInvoice;
    }
  });
}

RecurringInvoiceState _restoreRecurringInvoiceSuccess(
    RecurringInvoiceState recurringInvoiceState,
    RestoreRecurringInvoicesSuccess action) {
  return recurringInvoiceState.rebuild((b) {
    for (final recurringInvoice in action.recurringInvoices) {
      b.map[recurringInvoice.id] = recurringInvoice;
    }
  });
}

RecurringInvoiceState _addRecurringInvoice(
    RecurringInvoiceState recurringInvoiceState,
    AddRecurringInvoiceSuccess action) {
  return recurringInvoiceState.rebuild((b) => b
    ..map[action.recurringInvoice.id] = action.recurringInvoice
    ..list.add(action.recurringInvoice.id));
}

RecurringInvoiceState _updateRecurringInvoice(
    RecurringInvoiceState recurringInvoiceState,
    SaveRecurringInvoiceSuccess action) {
  return recurringInvoiceState.rebuild(
      (b) => b..map[action.recurringInvoice.id] = action.recurringInvoice);
}

RecurringInvoiceState _setLoadedRecurringInvoice(
    RecurringInvoiceState recurringInvoiceState,
    LoadRecurringInvoiceSuccess action) {
  return recurringInvoiceState.rebuild(
      (b) => b..map[action.recurringInvoice.id] = action.recurringInvoice);
}

RecurringInvoiceState _setLoadedRecurringInvoices(
        RecurringInvoiceState recurringInvoiceState,
        LoadRecurringInvoicesSuccess action) =>
    recurringInvoiceState.loadRecurringInvoices(action.recurringInvoices);

RecurringInvoiceState _setLoadedCompany(
    RecurringInvoiceState recurringInvoiceState, LoadCompanySuccess action) {
  final company = action.userCompany.company;
  return recurringInvoiceState.loadRecurringInvoices(company.recurringInvoices);
}
