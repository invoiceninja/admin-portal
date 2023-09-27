// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedSortedActiveTaskStatusIds = memo2((
  BuiltList<String> taskStatusList,
  BuiltMap<String?, TaskStatusEntity?> taskStatusMap,
) =>
    sortedActiveTaskStatusIds(
      taskStatusList: taskStatusList,
      taskStatusMap: taskStatusMap,
    ));

List<String> sortedActiveTaskStatusIds({
  BuiltMap<String?, TaskStatusEntity?>? taskStatusMap,
  required BuiltList<String> taskStatusList,
}) {
  final statuses = taskStatusList
      .where((statusId) =>
          taskStatusMap!.containsKey(statusId) &&
          taskStatusMap[statusId]!.isActive)
      .toList();

  statuses.sort((statusIdA, statusIdB) {
    final statusA = taskStatusMap![statusIdA]!;
    final statusB = taskStatusMap[statusIdB]!;
    if (statusA.statusOrder == statusB.statusOrder) {
      return statusB.updatedAt.compareTo(statusA.updatedAt);
    } else {
      return (statusA.statusOrder ?? 99999)
          .compareTo(statusB.statusOrder ?? 99999);
    }
  });

  return statuses;
}

var memoizedDropdownTaskStatusList = memo4(
    (BuiltMap<String?, TaskStatusEntity?> taskStatusMap,
            BuiltList<String> taskStatusList,
            StaticState staticState,
            BuiltMap<String, UserEntity> userMap) =>
        dropdownTaskStatusesSelector(
            taskStatusMap, taskStatusList, staticState, userMap));

List<String> dropdownTaskStatusesSelector(
    BuiltMap<String?, TaskStatusEntity?> taskStatusMap,
    BuiltList<String> taskStatusList,
    StaticState staticState,
    BuiltMap<String, UserEntity> userMap) {
  final list = taskStatusList.where((taskStatusId) {
    final taskStatus = taskStatusMap[taskStatusId]!;
    return taskStatus.isActive;
  }).toList();

  list.sort((taskStatusAId, taskStatusBId) {
    final taskStatusA = taskStatusMap[taskStatusAId]!;
    final taskStatusB = taskStatusMap[taskStatusBId];
    return taskStatusA.compareTo(
      sortAscending: true,
      sortField: TaskStatusFields.order,
      taskStatus: taskStatusB,
    );
  });

  return list;
}

var memoizedFilteredTaskStatusList = memo4((SelectionState selectionState,
        BuiltMap<String?, TaskStatusEntity?> taskStatusMap,
        BuiltList<String> taskStatusList,
        ListUIState taskStatusListState) =>
    filteredTaskStatusesSelector(
        selectionState, taskStatusMap, taskStatusList, taskStatusListState));

List<String> filteredTaskStatusesSelector(
    SelectionState selectionState,
    BuiltMap<String?, TaskStatusEntity?> taskStatusMap,
    BuiltList<String> taskStatusList,
    ListUIState taskStatusListState) {
  final list = taskStatusList.where((taskStatusId) {
    final taskStatus = taskStatusMap[taskStatusId]!;

    if (taskStatus.id == selectionState.selectedId) {
      return true;
    }

    if (!taskStatus.matchesStates(taskStatusListState.stateFilters)) {
      return false;
    }
    if (!taskStatus.matchesStatuses(taskStatusListState.statusFilters)) {
      return false;
    }
    return taskStatus.matchesFilter(taskStatusListState.filter);
  }).toList();

  list.sort((taskStatusAId, taskStatusBId) {
    return taskStatusMap[taskStatusAId]!.compareTo(
      taskStatus: taskStatusMap[taskStatusBId],
      //sortField: taskStatusListState.sortField,
      //sortAscending: taskStatusListState.sortAscending,
      sortField: TaskStatusFields.order,
      sortAscending: true,
    );
  });

  return list;
}

var memoizedCalculateTaskStatusAmount = memo2((String taskStatusId,
        BuiltMap<String, TaskEntity> taskMap) =>
    calculateTaskStatusAmount(taskStatusId: taskStatusId, taskMap: taskMap));

int calculateTaskStatusAmount({
  String? taskStatusId,
  required BuiltMap<String, TaskEntity> taskMap,
}) {
  int total = 0;

  taskMap.forEach((taskId, task) {
    if (task.statusId == taskStatusId) {
      total += task.calculateDuration().inSeconds;
    }
  });

  return total;
}

var memoizedTaskStatsForTaskStatus = memo2(
    (String companyGatewayId, BuiltMap<String, TaskEntity> taskMap) =>
        taskStatsForTaskStatus(companyGatewayId, taskMap));

EntityStats taskStatsForTaskStatus(
  String statusId,
  BuiltMap<String, TaskEntity> taskMap,
) {
  int countActive = 0;
  int countArchived = 0;
  taskMap.forEach((taskId, task) {
    if (task.statusId == statusId) {
      if (task.isActive) {
        countActive++;
      } else if (task.isArchived) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}

String? defaultTaskStatusId(
    BuiltMap<String?, TaskStatusEntity?> taskStatusMap) {
  final statusIds = taskStatusMap.keys.where((statusId) {
    final status = taskStatusMap[statusId]!;
    return status.isActive;
  }).toList();

  statusIds.sort((statusIdA, statusIdB) {
    final statusA = taskStatusMap[statusIdA]!;
    final statusB = taskStatusMap[statusIdB]!;

    return (statusA.statusOrder ?? 9999).compareTo(statusB.statusOrder ?? 9999);
  });

  if (statusIds.isNotEmpty) {
    return statusIds.first;
  } else {
    return '';
  }
}
