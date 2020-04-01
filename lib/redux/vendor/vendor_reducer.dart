import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_state.dart';

EntityUIState vendorUIReducer(VendorUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(vendorListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action))
    ..editingContact
        .replace(editingVendorContactReducer(state.editingContact, action))
    ..selectedId = selectedIdReducer(state.selectedId, action)
    ..saveCompleter = saveCompleterReducer(state.saveCompleter, action)
    ..cancelCompleter = cancelCompleterReducer(state.cancelCompleter, action));
}

final saveCompleterReducer = combineReducers<Completer<SelectableEntity>>([
  TypedReducer<Completer<SelectableEntity>, EditVendor>((completer, action) {
    return action.completer;
  }),
]);

final cancelCompleterReducer = combineReducers<Completer<SelectableEntity>>([
  TypedReducer<Completer<SelectableEntity>, EditVendor>((completer, action) {
    return action.cancelCompleter;
  }),
]);

final editingVendorContactReducer = combineReducers<VendorContactEntity>([
  TypedReducer<VendorContactEntity, EditVendor>(editVendorContact),
  TypedReducer<VendorContactEntity, EditVendorContact>(editVendorContact),
]);

VendorContactEntity editVendorContact(
    VendorContactEntity contact, dynamic action) {
  return action.contact ?? VendorContactEntity();
}

Reducer<String> selectedIdReducer = combineReducers([
  TypedReducer<String, ViewVendor>((selectedId, action) => action.vendorId),
  TypedReducer<String, AddVendorSuccess>(
      (selectedId, action) => action.vendor.id),
  TypedReducer<String, SelectCompany>((selectedId, action) => ''),
]);

final editingReducer = combineReducers<VendorEntity>([
  TypedReducer<VendorEntity, SaveVendorSuccess>(_updateEditing),
  TypedReducer<VendorEntity, AddVendorSuccess>(_updateEditing),
  TypedReducer<VendorEntity, RestoreVendorSuccess>((vendors, action) {
    return action.vendors[0];
  }),
  TypedReducer<VendorEntity, ArchiveVendorSuccess>((vendors, action) {
    return action.vendors[0];
  }),
  TypedReducer<VendorEntity, DeleteVendorSuccess>((vendors, action) {
    return action.vendors[0];
  }),
  TypedReducer<VendorEntity, EditVendor>(_updateEditing),
  TypedReducer<VendorEntity, UpdateVendor>((vendor, action) {
    return action.vendor.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<VendorEntity, AddVendorContact>(_addContact),
  TypedReducer<VendorEntity, DeleteVendorContact>(_removeContact),
  TypedReducer<VendorEntity, UpdateVendorContact>(_updateContact),
  TypedReducer<VendorEntity, SelectCompany>(_clearEditing),
  TypedReducer<VendorEntity, DiscardChanges>(_clearEditing),
]);

VendorEntity _clearEditing(VendorEntity vendor, dynamic action) {
  return VendorEntity();
}

VendorEntity _updateEditing(VendorEntity vendor, dynamic action) {
  return action.vendor;
}

VendorEntity _addContact(VendorEntity vendor, AddVendorContact action) {
  return vendor
      .rebuild((b) => b..contacts.add(action.contact ?? VendorContactEntity()));
}

VendorEntity _removeContact(VendorEntity vendor, DeleteVendorContact action) {
  return vendor.rebuild((b) => b..contacts.removeAt(action.index));
}

VendorEntity _updateContact(VendorEntity vendor, UpdateVendorContact action) {
  return vendor.rebuild((b) => b..contacts[action.index] = action.contact);
}

final vendorListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortVendors>(_sortVendors),
  TypedReducer<ListUIState, FilterVendorsByState>(_filterVendorsByState),
  TypedReducer<ListUIState, FilterVendors>(_filterVendors),
  TypedReducer<ListUIState, FilterVendorsByCustom1>(_filterVendorsByCustom1),
  TypedReducer<ListUIState, FilterVendorsByCustom2>(_filterVendorsByCustom2),
  TypedReducer<ListUIState, FilterVendorsByCustom3>(_filterVendorsByCustom3),
  TypedReducer<ListUIState, FilterVendorsByCustom4>(_filterVendorsByCustom4),
  TypedReducer<ListUIState, FilterVendorsByEntity>(_filterVendorsByClient),
  TypedReducer<ListUIState, StartVendorMultiselect>(_startListMultiselect),
  TypedReducer<ListUIState, AddToVendorMultiselect>(_addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromVendorMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearVendorMultiselect>(_clearListMultiselect),
]);

ListUIState _filterVendorsByClient(
    ListUIState vendorListState, FilterVendorsByEntity action) {
  return vendorListState.rebuild((b) => b
    ..filterEntityId = action.entityId
    ..filterEntityType = action.entityType);
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
    ..sortAscending = b.sortField != action.field || !b.sortAscending
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState vendorListState, StartVendorMultiselect action) {
  return vendorListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState vendorListState, AddToVendorMultiselect action) {
  return vendorListState.rebuild((b) => b..selectedIds.add(action.entity.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState vendorListState, RemoveFromVendorMultiselect action) {
  return vendorListState
      .rebuild((b) => b..selectedIds.remove(action.entity.id));
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
  TypedReducer<VendorState, ArchiveVendorRequest>(_archiveVendorRequest),
  TypedReducer<VendorState, ArchiveVendorSuccess>(_archiveVendorSuccess),
  TypedReducer<VendorState, ArchiveVendorFailure>(_archiveVendorFailure),
  TypedReducer<VendorState, DeleteVendorRequest>(_deleteVendorRequest),
  TypedReducer<VendorState, DeleteVendorSuccess>(_deleteVendorSuccess),
  TypedReducer<VendorState, DeleteVendorFailure>(_deleteVendorFailure),
  TypedReducer<VendorState, RestoreVendorRequest>(_restoreVendorRequest),
  TypedReducer<VendorState, RestoreVendorSuccess>(_restoreVendorSuccess),
  TypedReducer<VendorState, RestoreVendorFailure>(_restoreVendorFailure),
]);

VendorState _archiveVendorRequest(
    VendorState vendorState, ArchiveVendorRequest action) {
  final vendors = action.vendorIds.map((id) => vendorState.map[id]).toList();

  for (int i = 0; i < vendors.length; i++) {
    vendors[i] = vendors[i]
        .rebuild((b) => b..archivedAt = DateTime.now().millisecondsSinceEpoch);
  }
  return vendorState.rebuild((b) {
    for (final vendor in vendors) {
      b.map[vendor.id] = vendor;
    }
  });
}

VendorState _archiveVendorSuccess(
    VendorState vendorState, ArchiveVendorSuccess action) {
  return vendorState.rebuild((b) {
    for (final vendor in action.vendors) {
      b.map[vendor.id] = vendor;
    }
  });
}

VendorState _archiveVendorFailure(
    VendorState vendorState, ArchiveVendorFailure action) {
  return vendorState.rebuild((b) {
    for (final vendor in action.vendors) {
      b.map[vendor.id] = vendor;
    }
  });
}

VendorState _deleteVendorRequest(
    VendorState vendorState, DeleteVendorRequest action) {
  final vendors = action.vendorIds.map((id) => vendorState.map[id]).toList();

  for (int i = 0; i < vendors.length; i++) {
    vendors[i] = vendors[i].rebuild((b) => b
      ..archivedAt = DateTime.now().millisecondsSinceEpoch
      ..isDeleted = true);
  }
  return vendorState.rebuild((b) {
    for (final vendor in vendors) {
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

VendorState _deleteVendorFailure(
    VendorState vendorState, DeleteVendorFailure action) {
  return vendorState.rebuild((b) {
    for (final vendor in action.vendors) {
      b.map[vendor.id] = vendor;
    }
  });
}

VendorState _restoreVendorRequest(
    VendorState vendorState, RestoreVendorRequest action) {
  final vendors = action.vendorIds.map((id) => vendorState.map[id]).toList();

  for (int i = 0; i < vendors.length; i++) {
    vendors[i] = vendors[i].rebuild((b) => b
      ..archivedAt = null
      ..isDeleted = false);
  }
  return vendorState.rebuild((b) {
    for (final vendor in vendors) {
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

VendorState _restoreVendorFailure(
    VendorState vendorState, RestoreVendorFailure action) {
  return vendorState.rebuild((b) {
    for (final vendor in action.vendors) {
      b.map[vendor.id] = vendor;
    }
  });
}

VendorState _addVendor(VendorState vendorState, AddVendorSuccess action) {
  return vendorState.rebuild((b) => b
    ..map[action.vendor.id] = action.vendor
    ..list.add(action.vendor.id));
}

VendorState _updateVendor(VendorState vendorState, SaveVendorSuccess action) {
  return vendorState.rebuild((b) => b..map[action.vendor.id] = action.vendor);
}

VendorState _setLoadedVendor(
    VendorState vendorState, LoadVendorSuccess action) {
  return vendorState.rebuild((b) => b..map[action.vendor.id] = action.vendor);
}

VendorState _setLoadedVendors(
        VendorState vendorState, LoadVendorsSuccess action) =>
    vendorState.loadVendors(action.vendors);
