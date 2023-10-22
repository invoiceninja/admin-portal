// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
import 'package:invoiceninja_flutter/redux/group/group_state.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

EntityUIState groupUIReducer(GroupUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(groupListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action)!)
    ..selectedId = selectedIdReducer(state.selectedId, action)
    ..forceSelected = forceSelectedReducer(state.forceSelected, action));
}

final forceSelectedReducer = combineReducers<bool?>([
  TypedReducer<bool?, ViewGroup>((completer, action) => true),
  TypedReducer<bool?, ViewGroupList>((completer, action) => false),
  TypedReducer<bool?, FilterGroupsByState>((completer, action) => false),
  TypedReducer<bool?, FilterGroups>((completer, action) => false),
]);

Reducer<String?> selectedIdReducer = combineReducers([
  TypedReducer<String?, ArchiveGroupSuccess>((completer, action) => ''),
  TypedReducer<String?, DeleteGroupSuccess>((completer, action) => ''),
  TypedReducer<String?, PreviewEntity>((selectedId, action) =>
      action.entityType == EntityType.group ? action.entityId : selectedId),
  TypedReducer<String?, ViewGroup>(
      (String? selectedId, action) => action.groupId),
  TypedReducer<String?, AddGroupSuccess>(
      (String? selectedId, action) => action.group.id),
  TypedReducer<String?, SelectCompany>(
      (selectedId, action) => action.clearSelection ? '' : selectedId),
  TypedReducer<String?, ClearEntityFilter>((selectedId, action) => ''),
  TypedReducer<String?, SortGroups>((selectedId, action) => ''),
  TypedReducer<String?, FilterGroups>((selectedId, action) => ''),
  TypedReducer<String?, FilterGroupsByState>((selectedId, action) => ''),
  TypedReducer<String?, ClearEntitySelection>((selectedId, action) =>
      action.entityType == EntityType.group ? '' : selectedId),
  TypedReducer<String?, FilterByEntity>(
      (selectedId, action) => action.clearSelection
          ? ''
          : action.entityType == EntityType.group
              ? action.entityId
              : selectedId),
]);

final editingReducer = combineReducers<GroupEntity?>([
  TypedReducer<GroupEntity?, SaveGroupSuccess>(_updateEditing),
  TypedReducer<GroupEntity?, AddGroupSuccess>(_updateEditing),
  TypedReducer<GroupEntity?, RestoreGroupSuccess>((groups, action) {
    return action.groups[0];
  }),
  TypedReducer<GroupEntity?, ArchiveGroupSuccess>((groups, action) {
    return action.groups[0];
  }),
  TypedReducer<GroupEntity?, DeleteGroupSuccess>((groups, action) {
    return action.groups[0];
  }),
  TypedReducer<GroupEntity?, EditGroup>(_updateEditing),
  TypedReducer<GroupEntity?, UpdateGroup>((group, action) {
    return action.group.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<GroupEntity?, DiscardChanges>(_clearEditing),
]);

GroupEntity _clearEditing(GroupEntity? group, dynamic action) {
  return GroupEntity();
}

GroupEntity? _updateEditing(GroupEntity? group, dynamic action) {
  return action.group;
}

final groupListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortGroups>(_sortGroups),
  TypedReducer<ListUIState, FilterGroupsByState>(_filterGroupsByState),
  TypedReducer<ListUIState, FilterGroups>(_filterGroups),
  TypedReducer<ListUIState, StartGroupMultiselect>(_startListMultiselect),
  TypedReducer<ListUIState, AddToGroupMultiselect>(_addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromGroupMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearGroupMultiselect>(_clearListMultiselect),
  TypedReducer<ListUIState, ViewGroupList>(_viewGroupList),
  TypedReducer<ListUIState, FilterByEntity>(
      (state, action) => state.rebuild((b) => b
        ..filter = null
        ..filterClearedAt = DateTime.now().millisecondsSinceEpoch)),
]);

ListUIState _viewGroupList(ListUIState groupListState, ViewGroupList action) {
  return groupListState.rebuild((b) => b
    ..selectedIds = null
    ..filter = null
    ..filterClearedAt = DateTime.now().millisecondsSinceEpoch);
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
    ..sortAscending = b.sortField != action.field || !b.sortAscending!
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState groupListState, StartGroupMultiselect action) {
  return groupListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState groupListState, AddToGroupMultiselect action) {
  return groupListState.rebuild((b) => b..selectedIds.add(action.entity!.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState groupListState, RemoveFromGroupMultiselect action) {
  return groupListState
      .rebuild((b) => b..selectedIds.remove(action.entity!.id));
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
  TypedReducer<GroupState, ArchiveGroupSuccess>(_archiveGroupSuccess),
  TypedReducer<GroupState, DeleteGroupSuccess>(_deleteGroupSuccess),
  TypedReducer<GroupState, RestoreGroupSuccess>(_restoreGroupSuccess),
]);

GroupState _archiveGroupSuccess(
    GroupState groupState, ArchiveGroupSuccess action) {
  return groupState.rebuild((b) {
    for (final group in action.groups) {
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

GroupState _restoreGroupSuccess(
    GroupState groupState, RestoreGroupSuccess action) {
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
