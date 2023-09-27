// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownGroupList = memo3((BuiltMap<String, GroupEntity> groupMap,
        BuiltList<String> groupList, String clientId) =>
    dropdownGroupsSelector(groupMap, groupList, clientId));

List<String> dropdownGroupsSelector(BuiltMap<String, GroupEntity> groupMap,
    BuiltList<String> groupList, String clientId) {
  final list = groupList.where((groupId) {
    final group = groupMap[groupId]!;
    /*
    if (clientId != null && clientId > 0 && group.clientId != clientId) {
      return false;
    }
    */
    return group.isActive;
  }).toList();

  list.sort((groupAId, groupBId) {
    final groupA = groupMap[groupAId]!;
    final groupB = groupMap[groupBId];
    return groupA.compareTo(groupB, GroupFields.name, true);
  });

  return list;
}

var memoizedFilteredGroupList = memo4((SelectionState selectionState,
        BuiltMap<String, GroupEntity> groupMap,
        BuiltList<String> groupList,
        ListUIState groupListState) =>
    filteredGroupsSelector(
        selectionState, groupMap, groupList, groupListState));

List<String> filteredGroupsSelector(
    SelectionState selectionState,
    BuiltMap<String, GroupEntity> groupMap,
    BuiltList<String> groupList,
    ListUIState groupListState) {
  final list = groupList.where((groupId) {
    final group = groupMap[groupId]!;

    if (group.id == selectionState.selectedId) {
      return true;
    }

    if (!group.matchesStates(groupListState.stateFilters)) {
      return false;
    }
    return group.matchesFilter(groupListState.filter);
  }).toList();

  list.sort((groupAId, groupBId) {
    final groupA = groupMap[groupAId]!;
    final groupB = groupMap[groupBId];
    return groupA.compareTo(
        groupB, groupListState.sortField, groupListState.sortAscending);
  });

  return list;
}

var memoizedClientStatsForGroup = memo2(
    (BuiltMap<String, ClientEntity> clientMap, String groupId) =>
        clientStatsForGroup(clientMap, groupId));

EntityStats clientStatsForGroup(
    BuiltMap<String, ClientEntity> clientMap, String groupId) {
  int countActive = 0;
  int countArchived = 0;
  clientMap.forEach((clientId, client) {
    if (client.groupId == groupId) {
      if (client.isActive) {
        countActive++;
      } else if (client.isArchived) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}
