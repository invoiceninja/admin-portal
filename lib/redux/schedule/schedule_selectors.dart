import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownScheduleList = memo5(
    (BuiltMap<String, ScheduleEntity> scheduleMap,
            BuiltList<String> scheduleList,
            StaticState staticState,
            BuiltMap<String, UserEntity> userMap,
            String clientId) =>
        dropdownSchedulesSelector(
            scheduleMap, scheduleList, staticState, userMap, clientId));

List<String> dropdownSchedulesSelector(
    BuiltMap<String, ScheduleEntity> scheduleMap,
    BuiltList<String> scheduleList,
    StaticState staticState,
    BuiltMap<String, UserEntity> userMap,
    String clientId) {
  final list = scheduleList.where((scheduleId) {
    final schedule = scheduleMap[scheduleId]!;
    /*
    if (clientId != null && clientId > 0 && schedule.clientId != clientId) {
      return false;
    }
    */
    return schedule.isActive;
  }).toList();

  list.sort((scheduleAId, scheduleBId) {
    final scheduleA = scheduleMap[scheduleAId]!;
    final scheduleB = scheduleMap[scheduleBId];
    return scheduleA.compareTo(scheduleB, ScheduleFields.template, true);
  });

  return list;
}

var memoizedFilteredScheduleList = memo4((SelectionState selectionState,
        BuiltMap<String, ScheduleEntity> scheduleMap,
        BuiltList<String> scheduleList,
        ListUIState scheduleListState) =>
    filteredSchedulesSelector(
        selectionState, scheduleMap, scheduleList, scheduleListState));

List<String> filteredSchedulesSelector(
    SelectionState selectionState,
    BuiltMap<String, ScheduleEntity> scheduleMap,
    BuiltList<String> scheduleList,
    ListUIState scheduleListState) {
  final filterEntityId = selectionState.filterEntityId;
  //final filterEntityType = selectionState.filterEntityType;

  final list = scheduleList.where((scheduleId) {
    final schedule = scheduleMap[scheduleId];
    if (filterEntityId != null && schedule!.id != filterEntityId) {
      return false;
    } else {}

    if (!schedule!.matchesStates(scheduleListState.stateFilters)) {
      return false;
    }

    return schedule.matchesFilter(scheduleListState.filter);
  }).toList();

  list.sort((scheduleAId, scheduleBId) {
    final scheduleA = scheduleMap[scheduleAId]!;
    final scheduleB = scheduleMap[scheduleBId];
    return scheduleA.compareTo(scheduleB, scheduleListState.sortField,
        scheduleListState.sortAscending);
  });

  return list;
}
