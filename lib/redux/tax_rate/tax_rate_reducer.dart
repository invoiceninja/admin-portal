// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_actions.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_state.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

EntityUIState taxRateUIReducer(TaxRateUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(taxRateListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action)!)
    ..selectedId = selectedIdReducer(state.selectedId, action)
    ..forceSelected = forceSelectedReducer(state.forceSelected, action));
}

final forceSelectedReducer = combineReducers<bool?>([
  TypedReducer<bool?, ViewTaxRate>((completer, action) => true),
  TypedReducer<bool?, ViewTaxRateList>((completer, action) => false),
  TypedReducer<bool?, FilterTaxRatesByState>((completer, action) => false),
  TypedReducer<bool?, FilterTaxRates>((completer, action) => false),
]);

Reducer<String?> selectedIdReducer = combineReducers([
  TypedReducer<String?, ArchiveTaxRatesSuccess>((completer, action) => ''),
  TypedReducer<String?, DeleteTaxRatesSuccess>((completer, action) => ''),
  TypedReducer<String?, PreviewEntity>((selectedId, action) =>
      action.entityType == EntityType.taxRate ? action.entityId : selectedId),
  TypedReducer<String?, ViewTaxRate>(
      (String? selectedId, action) => action.taxRateId),
  TypedReducer<String?, AddTaxRateSuccess>(
      (String? selectedId, action) => action.taxRate.id),
  TypedReducer<String?, SelectCompany>(
      (selectedId, action) => action.clearSelection ? '' : selectedId),
  TypedReducer<String?, ClearEntityFilter>((selectedId, action) => ''),
  TypedReducer<String?, SortTaxRates>((selectedId, action) => ''),
  TypedReducer<String?, FilterTaxRates>((selectedId, action) => ''),
  TypedReducer<String?, FilterTaxRatesByState>((selectedId, action) => ''),
]);

final editingReducer = combineReducers<TaxRateEntity?>([
  TypedReducer<TaxRateEntity?, SaveTaxRateSuccess>(_updateEditing),
  TypedReducer<TaxRateEntity?, AddTaxRateSuccess>(_updateEditing),
  TypedReducer<TaxRateEntity?, RestoreTaxRatesSuccess>((taxRates, action) {
    return action.taxRates[0];
  }),
  TypedReducer<TaxRateEntity?, ArchiveTaxRatesSuccess>((taxRates, action) {
    return action.taxRates[0];
  }),
  TypedReducer<TaxRateEntity?, DeleteTaxRatesSuccess>((taxRates, action) {
    return action.taxRates[0];
  }),
  TypedReducer<TaxRateEntity?, EditTaxRate>(_updateEditing),
  TypedReducer<TaxRateEntity?, UpdateTaxRate>((taxRate, action) {
    return action.taxRate.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<TaxRateEntity?, DiscardChanges>(_clearEditing),
]);

TaxRateEntity _clearEditing(TaxRateEntity? taxRate, dynamic action) {
  return TaxRateEntity();
}

TaxRateEntity? _updateEditing(TaxRateEntity? taxRate, dynamic action) {
  return action.taxRate;
}

final taxRateListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortTaxRates>(_sortTaxRates),
  TypedReducer<ListUIState, FilterTaxRatesByState>(_filterTaxRatesByState),
  TypedReducer<ListUIState, FilterTaxRates>(_filterTaxRates),
  TypedReducer<ListUIState, StartTaxRateMultiselect>(_startListMultiselect),
  TypedReducer<ListUIState, AddToTaxRateMultiselect>(_addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromTaxRateMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearTaxRateMultiselect>(_clearListMultiselect),
  TypedReducer<ListUIState, ViewTaxRateList>(_viewTaxRateList),
  TypedReducer<ListUIState, FilterByEntity>(
      (state, action) => state.rebuild((b) => b
        ..filter = null
        ..filterClearedAt = DateTime.now().millisecondsSinceEpoch)),
]);

ListUIState _viewTaxRateList(
    ListUIState taxRateListState, ViewTaxRateList action) {
  return taxRateListState.rebuild((b) => b
    ..selectedIds = null
    ..filter = null
    ..filterClearedAt = DateTime.now().millisecondsSinceEpoch);
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
    ..sortAscending = b.sortField != action.field || !b.sortAscending!
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState taxRateListState, StartTaxRateMultiselect action) {
  return taxRateListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState taxRateListState, AddToTaxRateMultiselect action) {
  return taxRateListState.rebuild((b) => b..selectedIds.add(action.entity!.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState taxRateListState, RemoveFromTaxRateMultiselect action) {
  return taxRateListState
      .rebuild((b) => b..selectedIds.remove(action.entity!.id));
}

ListUIState _clearListMultiselect(
    ListUIState taxRateListState, ClearTaxRateMultiselect action) {
  return taxRateListState.rebuild((b) => b..selectedIds = null);
}

final taxRatesReducer = combineReducers<TaxRateState>([
  TypedReducer<TaxRateState, SaveTaxRateSuccess>(_updateTaxRate),
  TypedReducer<TaxRateState, AddTaxRateSuccess>(_addTaxRate),
  TypedReducer<TaxRateState, LoadTaxRatesSuccess>(_setLoadedTaxRates),
  TypedReducer<TaxRateState, LoadTaxRateSuccess>(_setLoadedTaxRate),
  TypedReducer<TaxRateState, LoadCompanySuccess>(_setLoadedCompany),
  TypedReducer<TaxRateState, ArchiveTaxRatesSuccess>(_archiveTaxRateSuccess),
  TypedReducer<TaxRateState, DeleteTaxRatesSuccess>(_deleteTaxRateSuccess),
  TypedReducer<TaxRateState, RestoreTaxRatesSuccess>(_restoreTaxRateSuccess),
]);

TaxRateState _archiveTaxRateSuccess(
    TaxRateState taxRateState, ArchiveTaxRatesSuccess action) {
  return taxRateState.rebuild((b) {
    for (final taxRate in action.taxRates) {
      b.map[taxRate.id] = taxRate;
    }
  });
}

TaxRateState _deleteTaxRateSuccess(
    TaxRateState taxRateState, DeleteTaxRatesSuccess action) {
  return taxRateState.rebuild((b) {
    for (final taxRate in action.taxRates) {
      b.map[taxRate.id] = taxRate;
    }
  });
}

TaxRateState _restoreTaxRateSuccess(
    TaxRateState taxRateState, RestoreTaxRatesSuccess action) {
  return taxRateState.rebuild((b) {
    for (final taxRate in action.taxRates) {
      b.map[taxRate.id] = taxRate;
    }
  });
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
    ..map.addAll(Map.fromIterable(
      action.taxRates,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    )));

  return state.rebuild((b) => b..list.replace(state.map.keys));
}

TaxRateState _setLoadedCompany(
    TaxRateState taxRateState, LoadCompanySuccess action) {
  final state = taxRateState.rebuild((b) => b
    ..map.addAll(Map.fromIterable(
      action.userCompany.company.taxRates,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    )));

  return state.rebuild((b) => b..list.replace(state.map.keys));
}
