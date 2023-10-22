// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_actions.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_state.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

EntityUIState companyGatewayUIReducer(
    CompanyGatewayUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(companyGatewayListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action)!)
    ..selectedId = selectedIdReducer(state.selectedId, action)
    ..forceSelected = forceSelectedReducer(state.forceSelected, action));
}

final forceSelectedReducer = combineReducers<bool?>([
  TypedReducer<bool?, ViewCompanyGateway>((completer, action) => true),
  TypedReducer<bool?, ViewCompanyGatewayList>((completer, action) => false),
  TypedReducer<bool?, FilterCompanyGatewaysByState>(
      (completer, action) => false),
  TypedReducer<bool?, FilterCompanyGateways>((completer, action) => false),
  TypedReducer<bool?, FilterCompanyGatewaysByCustom1>(
      (completer, action) => false),
  TypedReducer<bool?, FilterCompanyGatewaysByCustom2>(
      (completer, action) => false),
  TypedReducer<bool?, FilterCompanyGatewaysByCustom3>(
      (completer, action) => false),
  TypedReducer<bool?, FilterCompanyGatewaysByCustom4>(
      (completer, action) => false),
]);

Reducer<String?> selectedIdReducer = combineReducers([
  TypedReducer<String?, ArchiveCompanyGatewaySuccess>(
      (completer, action) => ''),
  TypedReducer<String?, DeleteCompanyGatewaySuccess>((completer, action) => ''),
  TypedReducer<String?, PreviewEntity>((selectedId, action) =>
      action.entityType == EntityType.companyGateway
          ? action.entityId
          : selectedId),
  TypedReducer<String?, ViewCompanyGateway>(
      (String? selectedId, action) => action.companyGatewayId),
  TypedReducer<String?, AddCompanyGatewaySuccess>(
      (String? selectedId, action) => action.companyGateway.id),
  TypedReducer<String?, SelectCompany>(
      (selectedId, action) => action.clearSelection ? '' : selectedId),
  TypedReducer<String?, ClearEntityFilter>((selectedId, action) => ''),
  TypedReducer<String?, SortCompanyGateways>((selectedId, action) => ''),
  TypedReducer<String?, FilterCompanyGateways>((selectedId, action) => ''),
  TypedReducer<String?, FilterCompanyGatewaysByState>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterCompanyGatewaysByCustom1>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterCompanyGatewaysByCustom2>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterCompanyGatewaysByCustom3>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterCompanyGatewaysByCustom4>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterByEntity>(
      (selectedId, action) => action.clearSelection
          ? ''
          : action.entityType == EntityType.companyGateway
              ? action.entityId
              : selectedId),
]);

final editingReducer = combineReducers<CompanyGatewayEntity?>([
  TypedReducer<CompanyGatewayEntity?, SaveCompanyGatewaySuccess>(
      _updateEditing),
  TypedReducer<CompanyGatewayEntity?, AddCompanyGatewaySuccess>(_updateEditing),
  TypedReducer<CompanyGatewayEntity?, RestoreCompanyGatewaySuccess>(
      (companyGateways, action) {
    return action.companyGateways[0];
  }),
  TypedReducer<CompanyGatewayEntity?, ArchiveCompanyGatewaySuccess>(
      (companyGateways, action) {
    return action.companyGateways[0];
  }),
  TypedReducer<CompanyGatewayEntity?, DeleteCompanyGatewaySuccess>(
      (companyGateways, action) {
    return action.companyGateways[0];
  }),
  TypedReducer<CompanyGatewayEntity?, EditCompanyGateway>(_updateEditing),
  TypedReducer<CompanyGatewayEntity?, UpdateCompanyGateway>(
      (companyGateway, action) {
    return action.companyGateway.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<CompanyGatewayEntity?, DiscardChanges>(_clearEditing),
]);

CompanyGatewayEntity _clearEditing(
    CompanyGatewayEntity? companyGateway, dynamic action) {
  return CompanyGatewayEntity();
}

CompanyGatewayEntity? _updateEditing(
    CompanyGatewayEntity? companyGateway, dynamic action) {
  return action.companyGateway;
}

final companyGatewayListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortCompanyGateways>(_sortCompanyGateways),
  TypedReducer<ListUIState, FilterCompanyGatewaysByState>(
      _filterCompanyGatewaysByState),
  TypedReducer<ListUIState, FilterCompanyGateways>(_filterCompanyGateways),
  TypedReducer<ListUIState, FilterCompanyGatewaysByCustom1>(
      _filterCompanyGatewaysByCustom1),
  TypedReducer<ListUIState, FilterCompanyGatewaysByCustom2>(
      _filterCompanyGatewaysByCustom2),
  TypedReducer<ListUIState, StartCompanyGatewayMultiselect>(
      _startListMultiselect),
  TypedReducer<ListUIState, AddToCompanyGatewayMultiselect>(
      _addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromCompanyGatewayMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearCompanyGatewayMultiselect>(
      _clearListMultiselect),
  TypedReducer<ListUIState, FilterByEntity>(
      (state, action) => state.rebuild((b) => b
        ..filter = null
        ..filterClearedAt = DateTime.now().millisecondsSinceEpoch)),
]);

ListUIState _filterCompanyGatewaysByCustom1(ListUIState companyGatewayListState,
    FilterCompanyGatewaysByCustom1 action) {
  if (companyGatewayListState.custom1Filters.contains(action.value)) {
    return companyGatewayListState
        .rebuild((b) => b..custom1Filters.remove(action.value));
  } else {
    return companyGatewayListState
        .rebuild((b) => b..custom1Filters.add(action.value));
  }
}

ListUIState _filterCompanyGatewaysByCustom2(ListUIState companyGatewayListState,
    FilterCompanyGatewaysByCustom2 action) {
  if (companyGatewayListState.custom2Filters.contains(action.value)) {
    return companyGatewayListState
        .rebuild((b) => b..custom2Filters.remove(action.value));
  } else {
    return companyGatewayListState
        .rebuild((b) => b..custom2Filters.add(action.value));
  }
}

ListUIState _filterCompanyGatewaysByState(
    ListUIState companyGatewayListState, FilterCompanyGatewaysByState action) {
  if (companyGatewayListState.stateFilters.contains(action.state)) {
    return companyGatewayListState
        .rebuild((b) => b..stateFilters.remove(action.state));
  } else {
    return companyGatewayListState
        .rebuild((b) => b..stateFilters.add(action.state));
  }
}

ListUIState _filterCompanyGateways(
    ListUIState companyGatewayListState, FilterCompanyGateways action) {
  return companyGatewayListState.rebuild((b) => b
    ..filter = action.filter
    ..filterClearedAt = action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : companyGatewayListState.filterClearedAt);
}

ListUIState _sortCompanyGateways(
    ListUIState companyGatewayListState, SortCompanyGateways action) {
  return companyGatewayListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending!
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState productListState, StartCompanyGatewayMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState productListState, AddToCompanyGatewayMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds.add(action.entity!.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState productListState, RemoveFromCompanyGatewayMultiselect action) {
  return productListState
      .rebuild((b) => b..selectedIds.remove(action.entity!.id));
}

ListUIState _clearListMultiselect(
    ListUIState productListState, ClearCompanyGatewayMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = null);
}

final companyGatewaysReducer = combineReducers<CompanyGatewayState>([
  TypedReducer<CompanyGatewayState, SaveCompanyGatewaySuccess>(
      _updateCompanyGateway),
  TypedReducer<CompanyGatewayState, AddCompanyGatewaySuccess>(
      _addCompanyGateway),
  TypedReducer<CompanyGatewayState, LoadCompanyGatewaysSuccess>(
      _setLoadedCompanyGateways),
  TypedReducer<CompanyGatewayState, LoadCompanyGatewaySuccess>(
      _setLoadedCompanyGateway),
  TypedReducer<CompanyGatewayState, LoadCompanySuccess>(_setLoadedCompany),
  TypedReducer<CompanyGatewayState, ArchiveCompanyGatewaySuccess>(
      _archiveCompanyGatewaySuccess),
  TypedReducer<CompanyGatewayState, DeleteCompanyGatewaySuccess>(
      _deleteCompanyGatewaySuccess),
  TypedReducer<CompanyGatewayState, RestoreCompanyGatewaySuccess>(
      _restoreCompanyGatewaySuccess),
]);

CompanyGatewayState _archiveCompanyGatewaySuccess(
    CompanyGatewayState companyGatewayState,
    ArchiveCompanyGatewaySuccess action) {
  return companyGatewayState.rebuild((b) {
    for (final companyGateway in action.companyGateways) {
      b.map[companyGateway.id] = companyGateway;
    }
  });
}

CompanyGatewayState _deleteCompanyGatewaySuccess(
    CompanyGatewayState companyGatewayState,
    DeleteCompanyGatewaySuccess action) {
  return companyGatewayState.rebuild((b) {
    for (final companyGateway in action.companyGateways) {
      b.map[companyGateway.id] = companyGateway;
    }
  });
}

CompanyGatewayState _restoreCompanyGatewaySuccess(
    CompanyGatewayState companyGatewayState,
    RestoreCompanyGatewaySuccess action) {
  return companyGatewayState.rebuild((b) {
    for (final companyGateway in action.companyGateways) {
      b.map[companyGateway.id] = companyGateway;
    }
  });
}

CompanyGatewayState _addCompanyGateway(
    CompanyGatewayState companyGatewayState, AddCompanyGatewaySuccess action) {
  return companyGatewayState.rebuild((b) => b
    ..map[action.companyGateway.id] = action.companyGateway
        .rebuild((b) => b..loadedAt = DateTime.now().millisecondsSinceEpoch)
    ..list.add(action.companyGateway.id));
}

CompanyGatewayState _updateCompanyGateway(
    CompanyGatewayState companyGatewayState, SaveCompanyGatewaySuccess action) {
  return companyGatewayState.rebuild((b) => b
    ..map[action.companyGateway.id] = action.companyGateway
        .rebuild((b) => b..loadedAt = DateTime.now().millisecondsSinceEpoch));
}

CompanyGatewayState _setLoadedCompanyGateway(
    CompanyGatewayState companyGatewayState, LoadCompanyGatewaySuccess action) {
  return companyGatewayState.rebuild((b) => b
    ..map[action.companyGateway.id] = action.companyGateway
        .rebuild((b) => b..loadedAt = DateTime.now().millisecondsSinceEpoch));
}

CompanyGatewayState _setLoadedCompany(
    CompanyGatewayState companyGatewayState, LoadCompanySuccess action) {
  final state = companyGatewayState.rebuild((b) => b
    ..map.addAll(Map.fromIterable(
      action.userCompany.company.companyGateways,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    )));

  return state.rebuild((b) => b..list.replace(state.map.keys));
}

CompanyGatewayState _setLoadedCompanyGateways(
    CompanyGatewayState companyGatewayState,
    LoadCompanyGatewaysSuccess action) {
  final state = companyGatewayState.rebuild((b) => b
    ..map.addAll(Map.fromIterable(
      action.companyGateways,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    )));

  return state.rebuild((b) => b..list.replace(state.map.keys));
}
