// Dart imports:
import 'dart:async';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_state.dart';

EntityUIState vendorUIReducer(VendorUIState state, dynamic action) {
  return state.rebuild(
    (b) => b
      ..listUIState.replace(vendorListReducer(state.listUIState, action))
      ..editing.replace(editingReducer(state.editing, action)!)
      ..editingContact
          .replace(editingVendorContactReducer(state.editingContact, action)!)
      ..selectedId = selectedIdReducer(state.selectedId, action)
      ..forceSelected = forceSelectedReducer(state.forceSelected, action)
      ..tabIndex = tabIndexReducer(state.tabIndex, action)
      ..saveCompleter = saveCompleterReducer(state.saveCompleter, action)
      ..cancelCompleter = cancelCompleterReducer(state.cancelCompleter, action),
  );
}

final forceSelectedReducer = combineReducers<bool?>([
  TypedReducer<bool?, ViewVendor>((completer, action) => true),
  TypedReducer<bool?, ViewVendorList>((completer, action) => false),
  TypedReducer<bool?, FilterVendorsByState>((completer, action) => false),
  TypedReducer<bool?, FilterVendors>((completer, action) => false),
  TypedReducer<bool?, FilterVendorsByCustom1>((completer, action) => false),
  TypedReducer<bool?, FilterVendorsByCustom2>((completer, action) => false),
  TypedReducer<bool?, FilterVendorsByCustom3>((completer, action) => false),
  TypedReducer<bool?, FilterVendorsByCustom4>((completer, action) => false),
]);

final int? Function(int, dynamic) tabIndexReducer = combineReducers<int?>([
  TypedReducer<int?, UpdateVendorTab>((completer, action) {
    return action.tabIndex;
  }),
  TypedReducer<int?, PreviewEntity>((completer, action) {
    return 0;
  }),
]);

final saveCompleterReducer = combineReducers<Completer<SelectableEntity>?>([
  TypedReducer<Completer<SelectableEntity>?, EditVendor>((completer, action) {
    return action.completer as Completer<SelectableEntity>?;
  }),
]);

final cancelCompleterReducer = combineReducers<Completer<Null>?>([
  TypedReducer<Completer<Null>?, EditVendor>((completer, action) {
    return action.cancelCompleter as Completer<Null>?;
  }),
]);

final editingVendorContactReducer = combineReducers<VendorContactEntity?>([
  TypedReducer<VendorContactEntity?, EditVendor>(editVendorContact),
  TypedReducer<VendorContactEntity?, EditVendorContact>(editVendorContact),
]);

VendorContactEntity editVendorContact(
    VendorContactEntity? contact, dynamic action) {
  return action.contact ?? VendorContactEntity();
}

Reducer<String?> selectedIdReducer = combineReducers([
  TypedReducer<String?, ArchiveVendorSuccess>((completer, action) => ''),
  TypedReducer<String?, DeleteVendorSuccess>((completer, action) => ''),
  TypedReducer<String?, PreviewEntity>((selectedId, action) =>
      action.entityType == EntityType.vendor ? action.entityId : selectedId),
  TypedReducer<String?, ViewVendor>((selectedId, action) => action.vendorId),
  TypedReducer<String?, AddVendorSuccess>(
      (selectedId, action) => action.vendor.id),
  TypedReducer<String?, SelectCompany>(
      (selectedId, action) => action.clearSelection ? '' : selectedId),
  TypedReducer<String?, ClearEntityFilter>((selectedId, action) => ''),
  TypedReducer<String?, SortVendors>((selectedId, action) => ''),
  TypedReducer<String?, FilterVendors>((selectedId, action) => ''),
  TypedReducer<String?, FilterVendorsByState>((selectedId, action) => ''),
  TypedReducer<String?, FilterVendorsByCustom1>((selectedId, action) => ''),
  TypedReducer<String?, FilterVendorsByCustom2>((selectedId, action) => ''),
  TypedReducer<String?, FilterVendorsByCustom3>((selectedId, action) => ''),
  TypedReducer<String?, FilterVendorsByCustom4>((selectedId, action) => ''),
  TypedReducer<String?, FilterByEntity>(
      (selectedId, action) => action.clearSelection
          ? ''
          : action.entityType == EntityType.vendor
              ? action.entityId
              : selectedId),
]);

final editingReducer = combineReducers<VendorEntity?>([
  TypedReducer<VendorEntity?, SaveVendorSuccess>(_updateEditing),
  TypedReducer<VendorEntity?, AddVendorSuccess>(_updateEditing),
  TypedReducer<VendorEntity?, RestoreVendorSuccess>((vendors, action) {
    return action.vendors[0];
  }),
  TypedReducer<VendorEntity?, ArchiveVendorSuccess>((vendors, action) {
    return action.vendors[0];
  }),
  TypedReducer<VendorEntity?, DeleteVendorSuccess>((vendors, action) {
    return action.vendors[0];
  }),
  TypedReducer<VendorEntity?, EditVendor>(_updateEditing),
  TypedReducer<VendorEntity?, UpdateVendor>((vendor, action) {
    return action.vendor.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<VendorEntity?, AddVendorContact>(_addContact),
  TypedReducer<VendorEntity?, DeleteVendorContact>(_removeContact),
  TypedReducer<VendorEntity?, UpdateVendorContact>(_updateContact),
  TypedReducer<VendorEntity?, DiscardChanges>(_clearEditing),
]);

VendorEntity _clearEditing(VendorEntity? vendor, dynamic action) {
  return VendorEntity();
}

VendorEntity? _updateEditing(VendorEntity? vendor, dynamic action) {
  return action.vendor;
}

VendorEntity _addContact(VendorEntity? vendor, AddVendorContact action) {
  return vendor!.rebuild((b) => b
    ..contacts.add(action.contact ?? VendorContactEntity())
    ..isChanged = true);
}

VendorEntity _removeContact(VendorEntity? vendor, DeleteVendorContact action) {
  return vendor!.rebuild((b) => b
    ..contacts.removeAt(action.index)
    ..isChanged = true);
}

VendorEntity _updateContact(VendorEntity? vendor, UpdateVendorContact action) {
  return vendor!.rebuild((b) => b
    ..contacts[action.index] = action.contact
    ..isChanged = true);
}

final vendorListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortVendors>(_sortVendors),
  TypedReducer<ListUIState, FilterVendorsByState>(_filterVendorsByState),
  TypedReducer<ListUIState, FilterVendors>(_filterVendors),
  TypedReducer<ListUIState, FilterVendorsByCustom1>(_filterVendorsByCustom1),
  TypedReducer<ListUIState, FilterVendorsByCustom2>(_filterVendorsByCustom2),
  TypedReducer<ListUIState, FilterVendorsByCustom3>(_filterVendorsByCustom3),
  TypedReducer<ListUIState, FilterVendorsByCustom4>(_filterVendorsByCustom4),
  TypedReducer<ListUIState, StartVendorMultiselect>(_startListMultiselect),
  TypedReducer<ListUIState, AddToVendorMultiselect>(_addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromVendorMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearVendorMultiselect>(_clearListMultiselect),
  TypedReducer<ListUIState, ViewVendorList>(_viewVendorList),
  TypedReducer<ListUIState, FilterByEntity>(
      (state, action) => state.rebuild((b) => b
        ..filter = null
        ..filterClearedAt = DateTime.now().millisecondsSinceEpoch)),
]);

ListUIState _viewVendorList(
    ListUIState vendorListState, ViewVendorList action) {
  return vendorListState.rebuild((b) => b
    ..selectedIds = null
    ..filter = null
    ..filterClearedAt = DateTime.now().millisecondsSinceEpoch);
}

ListUIState _filterVendorsByCustom1(
    ListUIState vendorListState, FilterVendorsByCustom1 action) {
  if (vendorListState.custom1Filters.contains(action.value)) {
    return vendorListState
        .rebuild((b) => b..custom1Filters.remove(action.value));
  } else {
    return vendorListState.rebuild((b) => b..custom1Filters.add(action.value));
  }
}

ListUIState _filterVendorsByCustom2(
    ListUIState vendorListState, FilterVendorsByCustom2 action) {
  if (vendorListState.custom2Filters.contains(action.value)) {
    return vendorListState
        .rebuild((b) => b..custom2Filters.remove(action.value));
  } else {
    return vendorListState.rebuild((b) => b..custom2Filters.add(action.value));
  }
}

ListUIState _filterVendorsByCustom3(
    ListUIState vendorListState, FilterVendorsByCustom3 action) {
  if (vendorListState.custom3Filters.contains(action.value)) {
    return vendorListState
        .rebuild((b) => b..custom3Filters.remove(action.value));
  } else {
    return vendorListState.rebuild((b) => b..custom3Filters.add(action.value));
  }
}

ListUIState _filterVendorsByCustom4(
    ListUIState vendorListState, FilterVendorsByCustom4 action) {
  if (vendorListState.custom4Filters.contains(action.value)) {
    return vendorListState
        .rebuild((b) => b..custom4Filters.remove(action.value));
  } else {
    return vendorListState.rebuild((b) => b..custom4Filters.add(action.value));
  }
}

ListUIState _filterVendorsByState(
    ListUIState vendorListState, FilterVendorsByState action) {
  if (vendorListState.stateFilters.contains(action.state)) {
    return vendorListState.rebuild((b) => b..stateFilters.remove(action.state));
  } else {
    return vendorListState.rebuild((b) => b..stateFilters.add(action.state));
  }
}

ListUIState _filterVendors(ListUIState vendorListState, FilterVendors action) {
  return vendorListState.rebuild((b) => b
    ..filter = action.filter
    ..filterClearedAt = action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : vendorListState.filterClearedAt);
}

ListUIState _sortVendors(ListUIState vendorListState, SortVendors action) {
  return vendorListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending!
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState vendorListState, StartVendorMultiselect action) {
  return vendorListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState vendorListState, AddToVendorMultiselect action) {
  return vendorListState.rebuild((b) => b..selectedIds.add(action.entity!.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState vendorListState, RemoveFromVendorMultiselect action) {
  return vendorListState
      .rebuild((b) => b..selectedIds.remove(action.entity!.id));
}

ListUIState _clearListMultiselect(
    ListUIState vendorListState, ClearVendorMultiselect action) {
  return vendorListState.rebuild((b) => b..selectedIds = null);
}

final vendorsReducer = combineReducers<VendorState>([
  TypedReducer<VendorState, SaveVendorSuccess>(_updateVendor),
  TypedReducer<VendorState, AddVendorSuccess>(_addVendor),
  TypedReducer<VendorState, LoadVendorsSuccess>(_setLoadedVendors),
  TypedReducer<VendorState, LoadVendorSuccess>(_setLoadedVendor),
  TypedReducer<VendorState, LoadCompanySuccess>(_setLoadedCompany),
  TypedReducer<VendorState, ArchiveVendorSuccess>(_archiveVendorSuccess),
  TypedReducer<VendorState, DeleteVendorSuccess>(_deleteVendorSuccess),
  TypedReducer<VendorState, RestoreVendorSuccess>(_restoreVendorSuccess),
]);

VendorState _archiveVendorSuccess(
    VendorState vendorState, ArchiveVendorSuccess action) {
  return vendorState.rebuild((b) {
    for (final vendor in action.vendors) {
      b.map[vendor.id] = vendor;
    }
  });
}

VendorState _deleteVendorSuccess(
    VendorState vendorState, DeleteVendorSuccess action) {
  return vendorState.rebuild((b) {
    for (final vendor in action.vendors) {
      b.map[vendor.id] = vendor;
    }
  });
}

VendorState _restoreVendorSuccess(
    VendorState vendorState, RestoreVendorSuccess action) {
  return vendorState.rebuild((b) {
    for (final vendor in action.vendors) {
      b.map[vendor.id] = vendor;
    }
  });
}

VendorState _addVendor(VendorState vendorState, AddVendorSuccess action) {
  return vendorState.rebuild((b) => b
    ..map[action.vendor.id] = action.vendor
        .rebuild((b) => b..loadedAt = DateTime.now().millisecondsSinceEpoch)
    ..list.add(action.vendor.id));
}

VendorState _updateVendor(VendorState vendorState, SaveVendorSuccess action) {
  return vendorState.rebuild((b) => b
    ..map[action.vendor.id] = action.vendor
        .rebuild((b) => b..loadedAt = DateTime.now().millisecondsSinceEpoch));
}

VendorState _setLoadedVendor(
    VendorState vendorState, LoadVendorSuccess action) {
  return vendorState.rebuild((b) => b
    ..map[action.vendor.id] = action.vendor
        .rebuild((b) => b..loadedAt = DateTime.now().millisecondsSinceEpoch));
}

VendorState _setLoadedVendors(
        VendorState vendorState, LoadVendorsSuccess action) =>
    vendorState.loadVendors(action.vendors);

VendorState _setLoadedCompany(
    VendorState vendorState, LoadCompanySuccess action) {
  final company = action.userCompany.company;
  return vendorState.loadVendors(company.vendors);
}
