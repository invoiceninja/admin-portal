import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_actions.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_state.dart';

EntityUIState taxRateUIReducer(TaxRateUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(taxRateListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action))
    ..selectedId = selectedIdReducer(state.selectedId, action));
}

Reducer<String> selectedIdReducer = combineReducers([
  TypedReducer<String, ViewTaxRate>(
      (String selectedId, dynamic action) => action.taxRateId),
  TypedReducer<String, AddTaxRateSuccess>(
      (String selectedId, dynamic action) => action.taxRate.id),
  TypedReducer<String, FilterTaxRatesByEntity>(
      (selectedId, action) => action.entityId == null ? selectedId : '')
]);

final editingReducer = combineReducers<TaxRateEntity>([
  TypedReducer<TaxRateEntity, SaveTaxRateSuccess>(_updateEditing),
  TypedReducer<TaxRateEntity, AddTaxRateSuccess>(_updateEditing),
  TypedReducer<TaxRateEntity, RestoreTaxRateSuccess>(_updateEditing),
  TypedReducer<TaxRateEntity, ArchiveTaxRateSuccess>(_updateEditing),
  TypedReducer<TaxRateEntity, DeleteTaxRateSuccess>(_updateEditing),
  TypedReducer<TaxRateEntity, EditTaxRate>(_updateEditing),
  TypedReducer<TaxRateEntity, UpdateTaxRate>((taxRate, action) {
    return action.taxRate.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<TaxRateEntity, SelectCompany>(_clearEditing),
  TypedReducer<TaxRateEntity, DiscardChanges>(_clearEditing),
]);

TaxRateEntity _clearEditing(TaxRateEntity taxRate, dynamic action) {
  return TaxRateEntity();
}

TaxRateEntity _updateEditing(TaxRateEntity taxRate, dynamic action) {
  return action.taxRate;
}

final taxRateListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortTaxRates>(_sortTaxRates),
  TypedReducer<ListUIState, FilterTaxRatesByState>(_filterTaxRatesByState),
  TypedReducer<ListUIState, FilterTaxRates>(_filterTaxRates),
  TypedReducer<ListUIState, FilterTaxRatesByCustom1>(_filterTaxRatesByCustom1),
  TypedReducer<ListUIState, FilterTaxRatesByCustom2>(_filterTaxRatesByCustom2),
  TypedReducer<ListUIState, FilterTaxRatesByEntity>(_filterTaxRatesByClient),
]);

ListUIState _filterTaxRatesByClient(
    ListUIState taxRateListState, FilterTaxRatesByEntity action) {
  return taxRateListState.rebuild((b) => b
    ..filterEntityId = action.entityId
    ..filterEntityType = action.entityType);
}

ListUIState _filterTaxRatesByCustom1(
    ListUIState taxRateListState, FilterTaxRatesByCustom1 action) {
  if (taxRateListState.custom1Filters.contains(action.value)) {
    return taxRateListState
        .rebuild((b) => b..custom1Filters.remove(action.value));
  } else {
    return taxRateListState.rebuild((b) => b..custom1Filters.add(action.value));
  }
}

ListUIState _filterTaxRatesByCustom2(
    ListUIState taxRateListState, FilterTaxRatesByCustom2 action) {
  if (taxRateListState.custom2Filters.contains(action.value)) {
    return taxRateListState
        .rebuild((b) => b..custom2Filters.remove(action.value));
  } else {
    return taxRateListState.rebuild((b) => b..custom2Filters.add(action.value));
  }
}

ListUIState _filterTaxRatesByState(
    ListUIState taxRateListState, FilterTaxRatesByState action) {
  if (taxRateListState.stateFilters.contains(action.state)) {
    return taxRateListState
        .rebuild((b) => b..stateFilters.remove(action.state));
  } else {
    return taxRateListState.rebuild((b) => b..stateFilters.add(action.state));
  }
}

ListUIState _filterTaxRates(
    ListUIState taxRateListState, FilterTaxRates action) {
  return taxRateListState.rebuild((b) => b
    ..filter = action.filter
    ..filterClearedAt = action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : taxRateListState.filterClearedAt);
}

ListUIState _sortTaxRates(ListUIState taxRateListState, SortTaxRates action) {
  return taxRateListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending
    ..sortField = action.field);
}

final taxRatesReducer = combineReducers<TaxRateState>([
  TypedReducer<TaxRateState, SaveTaxRateSuccess>(_updateTaxRate),
  TypedReducer<TaxRateState, AddTaxRateSuccess>(_addTaxRate),
  TypedReducer<TaxRateState, LoadTaxRatesSuccess>(_setLoadedTaxRates),
  TypedReducer<TaxRateState, LoadTaxRateSuccess>(_setLoadedTaxRate),
  TypedReducer<TaxRateState, ArchiveTaxRateRequest>(_archiveTaxRateRequest),
  TypedReducer<TaxRateState, ArchiveTaxRateSuccess>(_archiveTaxRateSuccess),
  TypedReducer<TaxRateState, ArchiveTaxRateFailure>(_archiveTaxRateFailure),
  TypedReducer<TaxRateState, DeleteTaxRateRequest>(_deleteTaxRateRequest),
  TypedReducer<TaxRateState, DeleteTaxRateSuccess>(_deleteTaxRateSuccess),
  TypedReducer<TaxRateState, DeleteTaxRateFailure>(_deleteTaxRateFailure),
  TypedReducer<TaxRateState, RestoreTaxRateRequest>(_restoreTaxRateRequest),
  TypedReducer<TaxRateState, RestoreTaxRateSuccess>(_restoreTaxRateSuccess),
  TypedReducer<TaxRateState, RestoreTaxRateFailure>(_restoreTaxRateFailure),
]);

TaxRateState _archiveTaxRateRequest(
    TaxRateState taxRateState, ArchiveTaxRateRequest action) {
  final taxRate = taxRateState.map[action.taxRateId]
      .rebuild((b) => b..archivedAt = DateTime.now().millisecondsSinceEpoch);

  return taxRateState.rebuild((b) => b..map[action.taxRateId] = taxRate);
}

TaxRateState _archiveTaxRateSuccess(
    TaxRateState taxRateState, ArchiveTaxRateSuccess action) {
  return taxRateState
      .rebuild((b) => b..map[action.taxRate.id] = action.taxRate);
}

TaxRateState _archiveTaxRateFailure(
    TaxRateState taxRateState, ArchiveTaxRateFailure action) {
  return taxRateState
      .rebuild((b) => b..map[action.taxRate.id] = action.taxRate);
}

TaxRateState _deleteTaxRateRequest(
    TaxRateState taxRateState, DeleteTaxRateRequest action) {
  final taxRate = taxRateState.map[action.taxRateId].rebuild((b) => b
    ..archivedAt = DateTime.now().millisecondsSinceEpoch
    ..isDeleted = true);

  return taxRateState.rebuild((b) => b..map[action.taxRateId] = taxRate);
}

TaxRateState _deleteTaxRateSuccess(
    TaxRateState taxRateState, DeleteTaxRateSuccess action) {
  return taxRateState
      .rebuild((b) => b..map[action.taxRate.id] = action.taxRate);
}

TaxRateState _deleteTaxRateFailure(
    TaxRateState taxRateState, DeleteTaxRateFailure action) {
  return taxRateState
      .rebuild((b) => b..map[action.taxRate.id] = action.taxRate);
}

TaxRateState _restoreTaxRateRequest(
    TaxRateState taxRateState, RestoreTaxRateRequest action) {
  final taxRate = taxRateState.map[action.taxRateId].rebuild((b) => b
    ..archivedAt = null
    ..isDeleted = false);
  return taxRateState.rebuild((b) => b..map[action.taxRateId] = taxRate);
}

TaxRateState _restoreTaxRateSuccess(
    TaxRateState taxRateState, RestoreTaxRateSuccess action) {
  return taxRateState
      .rebuild((b) => b..map[action.taxRate.id] = action.taxRate);
}

TaxRateState _restoreTaxRateFailure(
    TaxRateState taxRateState, RestoreTaxRateFailure action) {
  return taxRateState
      .rebuild((b) => b..map[action.taxRate.id] = action.taxRate);
}

TaxRateState _addTaxRate(TaxRateState taxRateState, AddTaxRateSuccess action) {
  return taxRateState.rebuild((b) => b
    ..map[action.taxRate.id] = action.taxRate
    ..list.add(action.taxRate.id));
}

TaxRateState _updateTaxRate(
    TaxRateState taxRateState, SaveTaxRateSuccess action) {
  return taxRateState
      .rebuild((b) => b..map[action.taxRate.id] = action.taxRate);
}

TaxRateState _setLoadedTaxRate(
    TaxRateState taxRateState, LoadTaxRateSuccess action) {
  return taxRateState
      .rebuild((b) => b..map[action.taxRate.id] = action.taxRate);
}

TaxRateState _setLoadedTaxRates(
    TaxRateState taxRateState, LoadTaxRatesSuccess action) {
  final state = taxRateState.rebuild((b) => b
    ..lastUpdated = DateTime.now().millisecondsSinceEpoch
    ..map.addAll(Map.fromIterable(
      action.taxRates,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    )));

  return state.rebuild((b) => b..list.replace(state.map.keys));
}
