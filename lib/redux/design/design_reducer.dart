import 'package:redux/redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/design/design_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/design/design_state.dart';

EntityUIState designUIReducer(DesignUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(designListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action))
    ..selectedId = selectedIdReducer(state.selectedId, action));
}

Reducer<String> selectedIdReducer = combineReducers([
  TypedReducer<String, ViewDesign>(
      (String selectedId, dynamic action) => action.designId),
  TypedReducer<String, AddDesignSuccess>(
      (String selectedId, dynamic action) => action.design.id),
  TypedReducer<String, SelectCompany>((selectedId, action) => ''),
]);

final editingReducer = combineReducers<DesignEntity>([
  TypedReducer<DesignEntity, SaveDesignSuccess>(_updateEditing),
  TypedReducer<DesignEntity, AddDesignSuccess>(_updateEditing),
  TypedReducer<DesignEntity, RestoreDesignsSuccess>((designs, action) {
    return action.designs[0];
  }),
  TypedReducer<DesignEntity, ArchiveDesignsSuccess>((designs, action) {
    return action.designs[0];
  }),
  TypedReducer<DesignEntity, DeleteDesignsSuccess>((designs, action) {
    return action.designs[0];
  }),
  TypedReducer<DesignEntity, EditDesign>(_updateEditing),
  TypedReducer<DesignEntity, UpdateDesign>((design, action) {
    return action.design.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<DesignEntity, SelectCompany>(_clearEditing),
  TypedReducer<DesignEntity, DiscardChanges>(_clearEditing),
]);

DesignEntity _clearEditing(DesignEntity design, dynamic action) {
  return DesignEntity();
}

DesignEntity _updateEditing(DesignEntity design, dynamic action) {
  return action.design;
}

final designListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortDesigns>(_sortDesigns),
  TypedReducer<ListUIState, FilterDesignsByState>(_filterDesignsByState),
  TypedReducer<ListUIState, FilterDesigns>(_filterDesigns),
  TypedReducer<ListUIState, FilterDesignsByCustom1>(_filterDesignsByCustom1),
  TypedReducer<ListUIState, FilterDesignsByCustom2>(_filterDesignsByCustom2),
  TypedReducer<ListUIState, FilterDesignsByEntity>(_filterDesignsByClient),
  TypedReducer<ListUIState, StartDesignMultiselect>(_startListMultiselect),
  TypedReducer<ListUIState, AddToDesignMultiselect>(_addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromDesignMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearDesignMultiselect>(_clearListMultiselect),
]);

ListUIState _filterDesignsByClient(
    ListUIState designListState, FilterDesignsByEntity action) {
  return designListState.rebuild((b) => b
    ..filterEntityId = action.entityId
    ..filterEntityType = action.entityType);
}

ListUIState _filterDesignsByCustom1(
    ListUIState designListState, FilterDesignsByCustom1 action) {
  if (designListState.custom1Filters.contains(action.value)) {
    return designListState
        .rebuild((b) => b..custom1Filters.remove(action.value));
  } else {
    return designListState.rebuild((b) => b..custom1Filters.add(action.value));
  }
}

ListUIState _filterDesignsByCustom2(
    ListUIState designListState, FilterDesignsByCustom2 action) {
  if (designListState.custom2Filters.contains(action.value)) {
    return designListState
        .rebuild((b) => b..custom2Filters.remove(action.value));
  } else {
    return designListState.rebuild((b) => b..custom2Filters.add(action.value));
  }
}

ListUIState _filterDesignsByState(
    ListUIState designListState, FilterDesignsByState action) {
  if (designListState.stateFilters.contains(action.state)) {
    return designListState.rebuild((b) => b..stateFilters.remove(action.state));
  } else {
    return designListState.rebuild((b) => b..stateFilters.add(action.state));
  }
}

ListUIState _filterDesigns(ListUIState designListState, FilterDesigns action) {
  return designListState.rebuild((b) => b
    ..filter = action.filter
    ..filterClearedAt = action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : designListState.filterClearedAt);
}

ListUIState _sortDesigns(ListUIState designListState, SortDesigns action) {
  return designListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState productListState, StartDesignMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState productListState, AddToDesignMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds.add(action.entity.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState productListState, RemoveFromDesignMultiselect action) {
  return productListState
      .rebuild((b) => b..selectedIds.remove(action.entity.id));
}

ListUIState _clearListMultiselect(
    ListUIState productListState, ClearDesignMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = null);
}

final designsReducer = combineReducers<DesignState>([
  TypedReducer<DesignState, SaveDesignSuccess>(_updateDesign),
  TypedReducer<DesignState, AddDesignSuccess>(_addDesign),
  TypedReducer<DesignState, LoadDesignsSuccess>(_setLoadedDesigns),
  TypedReducer<DesignState, LoadDesignSuccess>(_setLoadedDesign),
  TypedReducer<DesignState, LoadCompanySuccess>(_setLoadedCompany),
  TypedReducer<DesignState, ArchiveDesignsRequest>(_archiveDesignRequest),
  TypedReducer<DesignState, ArchiveDesignsSuccess>(_archiveDesignSuccess),
  TypedReducer<DesignState, ArchiveDesignsFailure>(_archiveDesignFailure),
  TypedReducer<DesignState, DeleteDesignsRequest>(_deleteDesignRequest),
  TypedReducer<DesignState, DeleteDesignsSuccess>(_deleteDesignSuccess),
  TypedReducer<DesignState, DeleteDesignsFailure>(_deleteDesignFailure),
  TypedReducer<DesignState, RestoreDesignsRequest>(_restoreDesignRequest),
  TypedReducer<DesignState, RestoreDesignsSuccess>(_restoreDesignSuccess),
  TypedReducer<DesignState, RestoreDesignsFailure>(_restoreDesignFailure),
]);

DesignState _archiveDesignRequest(
    DesignState designState, ArchiveDesignsRequest action) {
  final designs = action.designIds.map((id) => designState.map[id]).toList();

  for (int i = 0; i < designs.length; i++) {
    designs[i] = designs[i]
        .rebuild((b) => b..archivedAt = DateTime.now().millisecondsSinceEpoch);
  }
  return designState.rebuild((b) {
    for (final design in designs) {
      b.map[design.id] = design;
    }
  });
}

DesignState _archiveDesignSuccess(
    DesignState designState, ArchiveDesignsSuccess action) {
  return designState.rebuild((b) {
    for (final design in action.designs) {
      b.map[design.id] = design;
    }
  });
}

DesignState _archiveDesignFailure(
    DesignState designState, ArchiveDesignsFailure action) {
  return designState.rebuild((b) {
    for (final design in action.designs) {
      b.map[design.id] = design;
    }
  });
}

DesignState _deleteDesignRequest(
    DesignState designState, DeleteDesignsRequest action) {
  final designs = action.designIds.map((id) => designState.map[id]).toList();

  for (int i = 0; i < designs.length; i++) {
    designs[i] = designs[i].rebuild((b) => b
      ..archivedAt = DateTime.now().millisecondsSinceEpoch
      ..isDeleted = true);
  }
  return designState.rebuild((b) {
    for (final design in designs) {
      b.map[design.id] = design;
    }
  });
}

DesignState _deleteDesignSuccess(
    DesignState designState, DeleteDesignsSuccess action) {
  return designState.rebuild((b) {
    for (final design in action.designs) {
      b.map[design.id] = design;
    }
  });
}

DesignState _deleteDesignFailure(
    DesignState designState, DeleteDesignsFailure action) {
  return designState.rebuild((b) {
    for (final design in action.designs) {
      b.map[design.id] = design;
    }
  });
}

DesignState _restoreDesignRequest(
    DesignState designState, RestoreDesignsRequest action) {
  final designs = action.designIds.map((id) => designState.map[id]).toList();

  for (int i = 0; i < designs.length; i++) {
    designs[i] = designs[i].rebuild((b) => b
      ..archivedAt = null
      ..isDeleted = false);
  }
  return designState.rebuild((b) {
    for (final design in designs) {
      b.map[design.id] = design;
    }
  });
}

DesignState _restoreDesignSuccess(
    DesignState designState, RestoreDesignsSuccess action) {
  return designState.rebuild((b) {
    for (final design in action.designs) {
      b.map[design.id] = design;
    }
  });
}

DesignState _restoreDesignFailure(
    DesignState designState, RestoreDesignsFailure action) {
  return designState.rebuild((b) {
    for (final design in action.designs) {
      b.map[design.id] = design;
    }
  });
}

DesignState _addDesign(DesignState designState, AddDesignSuccess action) {
  return designState.rebuild((b) => b
    ..map[action.design.id] = action.design
    ..list.add(action.design.id));
}

DesignState _updateDesign(DesignState designState, SaveDesignSuccess action) {
  return designState.rebuild((b) => b..map[action.design.id] = action.design);
}

DesignState _setLoadedDesign(
    DesignState designState, LoadDesignSuccess action) {
  return designState.rebuild((b) => b..map[action.design.id] = action.design);
}

DesignState _setLoadedDesigns(
        DesignState designState, LoadDesignsSuccess action) =>
    designState.loadDesigns(action.designs);

DesignState _setLoadedCompany(
        DesignState designState, LoadCompanySuccess action) =>
    designState.loadDesigns(action.userCompany.company.designs);