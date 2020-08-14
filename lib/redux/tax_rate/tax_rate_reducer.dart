import 'package:built_collection/built_collection.dart';
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
      (String selectedId, action) => action.taxRateId),
  TypedReducer<String, AddTaxRateSuccess>(
      (String selectedId, action) => action.taxRate.id),
  TypedReducer<String, SelectCompany>(
      (selectedId, action) => action.clearSelection ? '' : selectedId),
  TypedReducer<String, DeleteTaxRatesSuccess>((selectedId, action) => ''),
  TypedReducer<String, ArchiveTaxRatesSuccess>((selectedId, action) => ''),
  TypedReducer<String, ClearEntityFilter>((selectedId, action) => ''),
]);

final editingReducer = combineReducers<TaxRateEntity>([
  TypedReducer<TaxRateEntity, SaveTaxRateSuccess>(_updateEditing),
  TypedReducer<TaxRateEntity, AddTaxRateSuccess>(_updateEditing),
  TypedReducer<TaxRateEntity, RestoreTaxRatesSuccess>((taxRates, action) {
    return action.taxRates[0];
  }),
  TypedReducer<TaxRateEntity, ArchiveTaxRatesSuccess>((taxRates, action) {
    return action.taxRates[0];
  }),
  TypedReducer<TaxRateEntity, DeleteTaxRatesSuccess>((taxRates, action) {
    return action.taxRates[0];
  }),
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
  TypedReducer<ListUIState, StartTaxRateMultiselect>(_startListMultiselect),
  TypedReducer<ListUIState, AddToTaxRateMultiselect>(_addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromTaxRateMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearTaxRateMultiselect>(_clearListMultiselect),
]);

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

ListUIState _startListMultiselect(
    ListUIState taxRateListState, StartTaxRateMultiselect action) {
  return taxRateListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState taxRateListState, AddToTaxRateMultiselect action) {
  return taxRateListState.rebuild((b) => b..selectedIds.add(action.entity.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState taxRateListState, RemoveFromTaxRateMultiselect action) {
  return taxRateListState
      .rebuild((b) => b..selectedIds.remove(action.entity.id));
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
  TypedReducer<TaxRateState, ArchiveTaxRateRequest>(_archiveTaxRateRequest),
  TypedReducer<TaxRateState, ArchiveTaxRatesSuccess>(_archiveTaxRateSuccess),
  TypedReducer<TaxRateState, ArchiveTaxRateFailure>(_archiveTaxRateFailure),
  TypedReducer<TaxRateState, DeleteTaxRateRequest>(_deleteTaxRateRequest),
  TypedReducer<TaxRateState, DeleteTaxRatesSuccess>(_deleteTaxRateSuccess),
  TypedReducer<TaxRateState, DeleteTaxRateFailure>(_deleteTaxRateFailure),
  TypedReducer<TaxRateState, RestoreTaxRateRequest>(_restoreTaxRateRequest),
  TypedReducer<TaxRateState, RestoreTaxRatesSuccess>(_restoreTaxRateSuccess),
  TypedReducer<TaxRateState, RestoreTaxRateFailure>(_restoreTaxRateFailure),
]);

TaxRateState _archiveTaxRateRequest(
    TaxRateState taxRateState, ArchiveTaxRateRequest action) {
  final taxRates = action.taxRateIds.map((id) => taxRateState.map[id]).toList();

  for (int i = 0; i < taxRates.length; i++) {
    taxRates[i] = taxRates[i]
        .rebuild((b) => b..archivedAt = DateTime.now().millisecondsSinceEpoch);
  }
  return taxRateState.rebuild((b) {
    for (final taxRate in taxRates) {
      b.map[taxRate.id] = taxRate;
    }
  });
}

TaxRateState _archiveTaxRateSuccess(
    TaxRateState taxRateState, ArchiveTaxRatesSuccess action) {
  return taxRateState.rebuild((b) {
    for (final taxRate in action.taxRates) {
      b.map[taxRate.id] = taxRate;
    }
  });
}

TaxRateState _archiveTaxRateFailure(
    TaxRateState taxRateState, ArchiveTaxRateFailure action) {
  return taxRateState.rebuild((b) {
    for (final taxRate in action.taxRates) {
      b.map[taxRate.id] = taxRate;
    }
  });
}

TaxRateState _deleteTaxRateRequest(
    TaxRateState taxRateState, DeleteTaxRateRequest action) {
  final taxRates = action.taxRateIds.map((id) => taxRateState.map[id]).toList();

  for (int i = 0; i < taxRates.length; i++) {
    taxRates[i] = taxRates[i].rebuild((b) => b
      ..archivedAt = DateTime.now().millisecondsSinceEpoch
      ..isDeleted = true);
  }
  return taxRateState.rebuild((b) {
    for (final taxRate in taxRates) {
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

TaxRateState _deleteTaxRateFailure(
    TaxRateState taxRateState, DeleteTaxRateFailure action) {
  return taxRateState.rebuild((b) {
    for (final taxRate in action.taxRates) {
      b.map[taxRate.id] = taxRate;
    }
  });
}

TaxRateState _restoreTaxRateRequest(
    TaxRateState taxRateState, RestoreTaxRateRequest action) {
  final taxRates = action.taxRateIds.map((id) => taxRateState.map[id]).toList();

  for (int i = 0; i < taxRates.length; i++) {
    taxRates[i] = taxRates[i].rebuild((b) => b
      ..archivedAt = 0
      ..isDeleted = false);
  }
  return taxRateState.rebuild((b) {
    for (final taxRate in taxRates) {
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

TaxRateState _restoreTaxRateFailure(
    TaxRateState taxRateState, RestoreTaxRateFailure action) {
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
