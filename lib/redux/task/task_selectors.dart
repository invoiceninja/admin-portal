import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

InvoiceItemEntity convertTaskToInvoiceItem(
    {BuildContext context, TaskEntity task}) {
  final state = StoreProvider.of<AppState>(context).state;
  final project = state.projectState.map[task.projectId];
  final client = state.clientState.map[task.clientId];

  var notes = task.description + '\n';
  task.taskTimes
      .where((time) => time.startDate != null && time.endDate != null)
      .forEach((time) {
    final start =
        formatDate(time.startDate.toIso8601String(), context, showTime: true);
    final end = formatDate(time.endDate.toIso8601String(), context,
        showTime: true, showDate: false, showSeconds: false);
    notes += '\n### $start - $end';
  });

  return InvoiceItemEntity().rebuild((b) => b
    ..taskId = task.id
    ..notes = notes
    ..cost = taskRateSelector(
        company: state.company, project: project, client: client)
    ..quantity = round(task.duration / 3600, 3));
}

var memoizedTaskList = memo5((BuiltMap<String, TaskEntity> taskMap,
        String clientId,
        BuiltMap<String, UserEntity> userMap,
        BuiltMap<String, ClientEntity> clientMap,
        BuiltMap<String, ProjectEntity> projectMap) =>
    taskList(taskMap, clientId, userMap, clientMap, projectMap));

List<String> taskList(
    BuiltMap<String, TaskEntity> taskMap,
    String clientId,
    BuiltMap<String, UserEntity> userMap,
    BuiltMap<String, ClientEntity> clientMap,
    BuiltMap<String, ProjectEntity> projectMap) {
  final list = taskMap.keys.where((taskId) {
    final task = taskMap[taskId];
    if (clientId != null && clientId != null && task.clientId != clientId) {
      return false;
    }
    return task.isActive && task.isStopped && !task.isInvoiced;
  }).toList();

  list.sort((idA, idB) =>
      taskMap[idA].listDisplayName.compareTo(taskMap[idB].listDisplayName));

  return list;
}

var memoizedDropdownTaskList = memo6((BuiltMap<String, TaskEntity> taskMap,
        BuiltList<String> taskList,
        BuiltMap<String, UserEntity> userMap,
        BuiltMap<String, ClientEntity> clientMap,
        BuiltMap<String, InvoiceEntity> invoiceMap,
        BuiltMap<String, ProjectEntity> projectMap) =>
    dropdownTasksSelector(
        taskMap, taskList, userMap, clientMap, invoiceMap, projectMap));

List<String> dropdownTasksSelector(
    BuiltMap<String, TaskEntity> taskMap,
    BuiltList<String> taskList,
    BuiltMap<String, UserEntity> userMap,
    BuiltMap<String, ClientEntity> clientMap,
    BuiltMap<String, InvoiceEntity> invoiceMap,
    BuiltMap<String, ProjectEntity> projectMap) {
  final list = taskList.where((taskId) => taskMap[taskId].isActive).toList();

  list.sort((taskAId, taskBId) {
    final taskA = taskMap[taskAId];
    final taskB = taskMap[taskBId];
    return taskA.compareTo(taskB, TaskFields.updatedAt, false, userMap,
        clientMap, projectMap, invoiceMap);
  });

  return list;
}

var memoizedFilteredTaskList = memo9((String filterEntityId,
        EntityType filterEntityType,
        BuiltMap<String, TaskEntity> taskMap,
        BuiltMap<String, ClientEntity> clientMap,
        BuiltMap<String, UserEntity> userMap,
        BuiltMap<String, ProjectEntity> projectMap,
        BuiltMap<String, InvoiceEntity> invoiceMap,
        BuiltList<String> taskList,
        ListUIState taskListState) =>
    filteredTasksSelector(filterEntityId, filterEntityType, taskMap, clientMap,
        userMap, projectMap, invoiceMap, taskList, taskListState));

List<String> filteredTasksSelector(
    String filterEntityId,
    EntityType filterEntityType,
    BuiltMap<String, TaskEntity> taskMap,
    BuiltMap<String, ClientEntity> clientMap,
    BuiltMap<String, UserEntity> userMap,
    BuiltMap<String, ProjectEntity> projectMap,
    BuiltMap<String, InvoiceEntity> invoiceMap,
    BuiltList<String> taskList,
    ListUIState taskListState) {
  final list = taskList.where((taskId) {
    final task = taskMap[taskId];
    final client = clientMap[task.clientId] ?? ClientEntity(id: task.clientId);
    final project =
        projectMap[task.projectId] ?? ProjectEntity(id: task.projectId);

    if (!client.isActive &&
        !client.matchesEntityFilter(filterEntityType, filterEntityId)) {
      return false;
    }

    if (!task.matchesFilter(taskListState.filter) &&
        !client.matchesFilter(taskListState.filter) &&
        !project.matchesFilter(taskListState.filter)) {
      return false;
    }

    if (!task.matchesStates(taskListState.stateFilters)) {
      return false;
    }
    if (!task.matchesStatuses(taskListState.statusFilters)) {
      return false;
    }

    if (filterEntityId != null) {
      if (filterEntityType == EntityType.client &&
          task.clientId != filterEntityId) {
        return false;
      } else if (filterEntityType == EntityType.project &&
          task.projectId != filterEntityId) {
        return false;
      }
    } else if (task.clientId != null && !client.isActive) {
      return false;
    } else if (task.projectId != null && !project.isActive) {
      return false;
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
    return true;
  }).toList();

  list.sort((taskAId, taskBId) {
    final taskA = taskMap[taskAId];
    final taskB = taskMap[taskBId];
    return taskA.compareTo(
        taskB,
        taskListState.sortField,
        taskListState.sortAscending,
        userMap,
        clientMap,
        projectMap,
        invoiceMap);
  });

  return list;
}

double taskRateSelector(
    {CompanyEntity company, ProjectEntity project, ClientEntity client}) {
  if (project != null && project.taskRate > 0) {
    return project.taskRate;
  } else if (client != null && (client.settings.defaultTaskRate ?? 0) > 0) {
    return client.settings.defaultTaskRate;
  } else if (company != null && (company.settings.defaultTaskRate ?? 0) > 0) {
    return company.settings.defaultTaskRate;
  }

  return 0;
}

var memoizedTaskStatsForClient = memo2(
    (String clientId, BuiltMap<String, TaskEntity> taskMap) =>
        taskStatsForClient(clientId, taskMap));

EntityStats taskStatsForClient(
    String clientId, BuiltMap<String, TaskEntity> taskMap) {
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

  return EntityStats(countActive: countActive, countArchived: countArchived);
}

var memoizedTaskStatsForProject = memo2((
  String projectId,
  BuiltMap<String, TaskEntity> taskMap,
) =>
    taskStatsForProject(projectId, taskMap));

EntityStats taskStatsForProject(
    String projectId, BuiltMap<String, TaskEntity> taskMap) {
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

  return EntityStats(countActive: countActive, countArchived: countArchived);
}

bool hasTaskChanges(TaskEntity task, BuiltMap<String, TaskEntity> taskMap) =>
    task.isNew ? task.isChanged : task != taskMap[task.id];
