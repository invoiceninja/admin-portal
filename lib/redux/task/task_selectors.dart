import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedTaskList = memo2(
    (BuiltMap<int, TaskEntity> taskMap, int clientId) =>
        taskList(taskMap, clientId));

List<int> taskList(BuiltMap<int, TaskEntity> taskMap, int clientId) {
  final list = taskMap.keys.where((taskId) {
    final task = taskMap[taskId];
    return task.isActive &&
        task.isStopped &&
        !task.isInvoiced &&
        task.clientId == clientId;
  }).toList();

  list.sort((idA, idB) =>
      taskMap[idA].listDisplayName.compareTo(taskMap[idB].listDisplayName));

  return list;
}

var memoizedDropdownTaskList = memo2(
    (BuiltMap<int, TaskEntity> taskMap, BuiltList<int> taskList) =>
        dropdownTasksSelector(taskMap, taskList));

List<int> dropdownTasksSelector(
    BuiltMap<int, TaskEntity> taskMap, BuiltList<int> taskList) {
  final list = taskList.where((taskId) => taskMap[taskId].isActive).toList();

  list.sort((taskAId, taskBId) {
    final taskA = taskMap[taskAId];
    final taskB = taskMap[taskBId];
    return taskA.compareTo(taskB, TaskFields.updatedAt, false);
  });

  return list;
}

var memoizedFilteredTaskList = memo3((BuiltMap<int, TaskEntity> taskMap,
        BuiltList<int> taskList, ListUIState taskListState) =>
    filteredTasksSelector(taskMap, taskList, taskListState));

List<int> filteredTasksSelector(BuiltMap<int, TaskEntity> taskMap,
    BuiltList<int> taskList, ListUIState taskListState) {
  final list = taskList.where((taskId) {
    final task = taskMap[taskId];
    if (!task.matchesStates(taskListState.stateFilters)) {
      return false;
    }
    if (taskListState.filterEntityId != null) {
      if (taskListState.filterEntityType == EntityType.client &&
          task.clientId != taskListState.filterEntityId) {
        return false;
      } else if (taskListState.filterEntityType == EntityType.project &&
          task.projectId != taskListState.filterEntityId) {
        return false;
      }
    }
    if (taskListState.custom1Filters.isNotEmpty &&
        !taskListState.custom1Filters.contains(task.customValue1)) {
      return false;
    }
    if (taskListState.custom2Filters.isNotEmpty &&
        !taskListState.custom2Filters.contains(task.customValue2)) {
      return false;
    }
    /*
    if (taskListState.filterEntityId != null &&
        task.entityId != taskListState.filterEntityId) {
      return false;
    }
    */
    return task.matchesFilter(taskListState.filter);
  }).toList();

  list.sort((taskAId, taskBId) {
    final taskA = taskMap[taskAId];
    final taskB = taskMap[taskBId];
    return taskA.compareTo(
        taskB, taskListState.sortField, taskListState.sortAscending);
  });

  return list;
}

double taskRateSelector({CompanyEntity company, ProjectEntity project}) {
  if (project != null && project.taskRate > 0) {
    return project.taskRate;
  } else if (company != null && company.defaultTaskRate > 0) {
    return company.defaultTaskRate;
  }

  return 0;
}

var memoizedTaskStatsForClient = memo4((int clientId,
        BuiltMap<int, TaskEntity> taskMap,
        String activeLabel,
        String archivedLabel) =>
    taskStatsForClient(clientId, taskMap, activeLabel, archivedLabel));

String taskStatsForClient(int clientId, BuiltMap<int, TaskEntity> taskMap,
    String activeLabel, String archivedLabel) {
  int countActive = 0;
  int countArchived = 0;
  taskMap.forEach((taskId, task) {
    if (task.clientId == clientId) {
      if (task.isActive) {
        countActive++;
      } else if (task.isArchived) {
        countArchived++;
      }
    }
  });

  String str = '';
  if (countActive > 0) {
    str = '$countActive $activeLabel';
    if (countArchived > 0) {
      str += ' • ';
    }
  }
  if (countArchived > 0) {
    str += '$countArchived $archivedLabel';
  }

  return str;
}

var memoizedTaskStatsForProject = memo4((int projectId,
        BuiltMap<int, TaskEntity> taskMap,
        String activeLabel,
        String archivedLabel) =>
    taskStatsForProject(projectId, taskMap, activeLabel, archivedLabel));

String taskStatsForProject(int projectId, BuiltMap<int, TaskEntity> taskMap,
    String activeLabel, String archivedLabel) {
  int countActive = 0;
  int countArchived = 0;
  taskMap.forEach((taskId, task) {
    if (task.projectId == projectId) {
      if (task.isActive) {
        countActive++;
      } else if (task.isArchived) {
        countArchived++;
      }
    }
  });

  String str = '';
  if (countActive > 0) {
    str = '$countActive $activeLabel';
    if (countArchived > 0) {
      str += ' • ';
    }
  }
  if (countArchived > 0) {
    str += '$countArchived $archivedLabel';
  }

  return str;
}
