import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownGroupList = memo3((BuiltMap<String, GroupEntity> groupMap,
        BuiltList<String> groupList, String clientId) =>
    dropdownGroupsSelector(groupMap, groupList, clientId));

List<String> dropdownGroupsSelector(BuiltMap<String, GroupEntity> groupMap,
    BuiltList<String> groupList, String clientId) {
  final list = groupList.where((groupId) {
    final group = groupMap[groupId];
    /*
    if (clientId != null && clientId > 0 && group.clientId != clientId) {
      return false;
    }
    */
    return group.isActive;
  }).toList();

  list.sort((groupAId, groupBId) {
    final groupA = groupMap[groupAId];
    final groupB = groupMap[groupBId];
    return groupA.compareTo(groupB, GroupFields.name, true);
  });

  return list;
}

var memoizedFilteredGroupList = memo3((BuiltMap<String, GroupEntity> groupMap,
        BuiltList<String> groupList, ListUIState groupListState) =>
    filteredGroupsSelector(groupMap, groupList, groupListState));

List<String> filteredGroupsSelector(BuiltMap<String, GroupEntity> groupMap,
    BuiltList<String> groupList, ListUIState groupListState) {
  final list = groupList.where((groupId) {
    final group = groupMap[groupId];

    if (!group.matchesStates(groupListState.stateFilters)) {
      return false;
    }
    if (groupListState.custom1Filters.isNotEmpty &&
        !groupListState.custom1Filters.contains(group.customValue1)) {
      return false;
    }
    if (groupListState.custom2Filters.isNotEmpty &&
        !groupListState.custom2Filters.contains(group.customValue2)) {
      return false;
    }
    return group.matchesFilter(groupListState.filter);
  }).toList();

  list.sort((groupAId, groupBId) {
    final groupA = groupMap[groupAId];
    final groupB = groupMap[groupBId];
    return groupA.compareTo(
        groupB, groupListState.sortField, groupListState.sortAscending);
  });

  return list;
}

bool hasGroupChanges(
        GroupEntity group, BuiltMap<String, GroupEntity> groupMap) =>
    group.isNew ? group.isChanged : group != groupMap[group.id];
