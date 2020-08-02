import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
import 'package:invoiceninja_flutter/redux/group/group_state.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:redux/redux.dart';

EntityUIState groupUIReducer(GroupUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(groupListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action))
    ..selectedId = selectedIdReducer(state.selectedId, action));
}

Reducer<String> selectedIdReducer = combineReducers([
  TypedReducer<String, ViewGroup>(
      (String selectedId, action) => action.groupId),
  TypedReducer<String, AddGroupSuccess>(
      (String selectedId, action) => action.group.id),
  TypedReducer<String, SelectCompany>(
      (selectedId, action) => action.clearSelection ? '' : selectedId),
  TypedReducer<String, DeleteGroupSuccess>((selectedId, action) => ''),
  TypedReducer<String, ArchiveGroupSuccess>((selectedId, action) => ''),
  TypedReducer<String, ClearEntityFilter>((selectedId, action) => ''),
  TypedReducer<String, ClearEntitySelection>((selectedId, action) =>
      action.entityType == EntityType.group ? '' : selectedId),
  TypedReducer<String, FilterByEntity>((selectedId, action) => action
          .clearSelection
      ? ''
      : action.entityType == EntityType.group ? action.entityId : selectedId),
]);

final editingReducer = combineReducers<GroupEntity>([
  TypedReducer<GroupEntity, SaveGroupSuccess>(_updateEditing),
  TypedReducer<GroupEntity, AddGroupSuccess>(_updateEditing),
  TypedReducer<GroupEntity, RestoreGroupSuccess>((groups, action) {
    return action.groups[0];
  }),
  TypedReducer<GroupEntity, ArchiveGroupSuccess>((groups, action) {
    return action.groups[0];
  }),
  TypedReducer<GroupEntity, DeleteGroupSuccess>((groups, action) {
    return action.groups[0];
  }),
  TypedReducer<GroupEntity, EditGroup>(_updateEditing),
  TypedReducer<GroupEntity, UpdateGroup>((group, action) {
    return action.group.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<GroupEntity, SelectCompany>(_clearEditing),
  TypedReducer<GroupEntity, DiscardChanges>(_clearEditing),
]);

GroupEntity _clearEditing(GroupEntity group, dynamic action) {
  return GroupEntity();
}

GroupEntity _updateEditing(GroupEntity group, dynamic action) {
  return action.group;
}

final groupListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortGroups>(_sortGroups),
  TypedReducer<ListUIState, FilterGroupsByState>(_filterGroupsByState),
  TypedReducer<ListUIState, FilterGroups>(_filterGroups),
  TypedReducer<ListUIState, FilterGroupsByCustom1>(_filterGroupsByCustom1),
  TypedReducer<ListUIState, FilterGroupsByCustom2>(_filterGroupsByCustom2),
  TypedReducer<ListUIState, StartGroupMultiselect>(_startListMultiselect),
  TypedReducer<ListUIState, AddToGroupMultiselect>(_addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromGroupMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearGroupMultiselect>(_clearListMultiselect),
]);

ListUIState _filterGroupsByCustom1(
    ListUIState groupListState, FilterGroupsByCustom1 action) {
  if (groupListState.custom1Filters.contains(action.value)) {
    return groupListState
        .rebuild((b) => b..custom1Filters.remove(action.value));
  } else {
    return groupListState.rebuild((b) => b..custom1Filters.add(action.value));
  }
}

ListUIState _filterGroupsByCustom2(
    ListUIState groupListState, FilterGroupsByCustom2 action) {
  if (groupListState.custom2Filters.contains(action.value)) {
    return groupListState
        .rebuild((b) => b..custom2Filters.remove(action.value));
  } else {
    return groupListState.rebuild((b) => b..custom2Filters.add(action.value));
  }
}

ListUIState _filterGroupsByState(
    ListUIState groupListState, FilterGroupsByState action) {
  if (groupListState.stateFilters.contains(action.state)) {
    return groupListState.rebuild((b) => b..stateFilters.remove(action.state));
  } else {
    return groupListState.rebuild((b) => b..stateFilters.add(action.state));
  }
}

ListUIState _filterGroups(ListUIState groupListState, FilterGroups action) {
  return groupListState.rebuild((b) => b
    ..filter = action.filter
    ..filterClearedAt = action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : groupListState.filterClearedAt);
}

ListUIState _sortGroups(ListUIState groupListState, SortGroups action) {
  return groupListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState groupListState, StartGroupMultiselect action) {
  return groupListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState groupListState, AddToGroupMultiselect action) {
  return groupListState.rebuild((b) => b..selectedIds.add(action.entity.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState groupListState, RemoveFromGroupMultiselect action) {
  return groupListState.rebuild((b) => b..selectedIds.remove(action.entity.id));
}

ListUIState _clearListMultiselect(
    ListUIState groupListState, ClearGroupMultiselect action) {
  return groupListState.rebuild((b) => b..selectedIds = null);
}

final groupsReducer = combineReducers<GroupState>([
  TypedReducer<GroupState, SaveGroupSuccess>(_updateGroup),
  TypedReducer<GroupState, AddGroupSuccess>(_addGroup),
  TypedReducer<GroupState, LoadGroupsSuccess>(_setLoadedGroups),
  TypedReducer<GroupState, LoadGroupSuccess>(_setLoadedGroup),
  TypedReducer<GroupState, LoadCompanySuccess>(_setLoadedCompany),
  TypedReducer<GroupState, ArchiveGroupRequest>(_archiveGroupRequest),
  TypedReducer<GroupState, ArchiveGroupSuccess>(_archiveGroupSuccess),
  TypedReducer<GroupState, ArchiveGroupFailure>(_archiveGroupFailure),
  TypedReducer<GroupState, DeleteGroupRequest>(_deleteGroupRequest),
  TypedReducer<GroupState, DeleteGroupSuccess>(_deleteGroupSuccess),
  TypedReducer<GroupState, DeleteGroupFailure>(_deleteGroupFailure),
  TypedReducer<GroupState, RestoreGroupRequest>(_restoreGroupRequest),
  TypedReducer<GroupState, RestoreGroupSuccess>(_restoreGroupSuccess),
  TypedReducer<GroupState, RestoreGroupFailure>(_restoreGroupFailure),
]);

GroupState _archiveGroupRequest(
    GroupState groupState, ArchiveGroupRequest action) {
  final groups = action.groupIds.map((id) => groupState.map[id]).toList();

  for (int i = 0; i < groups.length; i++) {
    groups[i] = groups[i]
        .rebuild((b) => b..archivedAt = DateTime.now().millisecondsSinceEpoch);
  }
  return groupState.rebuild((b) {
    for (final group in groups) {
      b.map[group.id] = group;
    }
  });
}

GroupState _archiveGroupSuccess(
    GroupState groupState, ArchiveGroupSuccess action) {
  return groupState.rebuild((b) {
    for (final group in action.groups) {
      b.map[group.id] = group;
    }
  });
}

GroupState _archiveGroupFailure(
    GroupState groupState, ArchiveGroupFailure action) {
  return groupState.rebuild((b) {
    for (final group in action.groups) {
      b.map[group.id] = group;
    }
  });
}

GroupState _deleteGroupRequest(
    GroupState groupState, DeleteGroupRequest action) {
  final groups = action.groupIds.map((id) => groupState.map[id]).toList();

  for (int i = 0; i < groups.length; i++) {
    groups[i] = groups[i].rebuild((b) => b
      ..archivedAt = DateTime.now().millisecondsSinceEpoch
      ..isDeleted = true);
  }
  return groupState.rebuild((b) {
    for (final group in groups) {
      b.map[group.id] = group;
    }
  });
}

GroupState _deleteGroupSuccess(
    GroupState groupState, DeleteGroupSuccess action) {
  return groupState.rebuild((b) {
    for (final group in action.groups) {
      b.map[group.id] = group;
    }
  });
}

GroupState _deleteGroupFailure(
    GroupState groupState, DeleteGroupFailure action) {
  return groupState.rebuild((b) {
    for (final group in action.groups) {
      b.map[group.id] = group;
    }
  });
}

GroupState _restoreGroupRequest(
    GroupState groupState, RestoreGroupRequest action) {
  final groups = action.groupIds.map((id) => groupState.map[id]).toList();

  for (int i = 0; i < groups.length; i++) {
    groups[i] = groups[i].rebuild((b) => b
      ..archivedAt = 0
      ..isDeleted = false);
  }
  return groupState.rebuild((b) {
    for (final group in groups) {
      b.map[group.id] = group;
    }
  });
}

GroupState _restoreGroupSuccess(
    GroupState groupState, RestoreGroupSuccess action) {
  return groupState.rebuild((b) {
    for (final group in action.groups) {
      b.map[group.id] = group;
    }
  });
}

GroupState _restoreGroupFailure(
    GroupState groupState, RestoreGroupFailure action) {
  return groupState.rebuild((b) {
    for (final group in action.groups) {
      b.map[group.id] = group;
    }
  });
}

GroupState _addGroup(GroupState groupState, AddGroupSuccess action) {
  return groupState.rebuild((b) => b
    ..map[action.group.id] = action.group
    ..list.add(action.group.id));
}

GroupState _updateGroup(GroupState groupState, SaveGroupSuccess action) {
  return groupState.rebuild((b) => b..map[action.group.id] = action.group);
}

GroupState _setLoadedGroup(GroupState groupState, LoadGroupSuccess action) {
  return groupState.rebuild((b) => b..map[action.group.id] = action.group);
}

GroupState _setLoadedGroups(GroupState groupState, LoadGroupsSuccess action) {
  final state = groupState.rebuild((b) => b
    ..map.addAll(Map.fromIterable(
      action.groups,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    )));

  return state.rebuild((b) => b..list.replace(state.map.keys));
}

GroupState _setLoadedCompany(GroupState groupState, LoadCompanySuccess action) {
  final state = groupState.rebuild((b) => b
    ..map.addAll(Map.fromIterable(
      action.userCompany.company.groups,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    )));

  return state.rebuild((b) => b..list.replace(state.map.keys));
}
