// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

InvoiceItemEntity convertTaskToInvoiceItem({
  required BuildContext context,
  required TaskEntity task,
  bool includeProjectHeader = false,
}) {
  final state = StoreProvider.of<AppState>(context).state;
  final project = state.projectState.get(task.projectId);
  final client = state.clientState.get(task.clientId);
  final group = state.groupState.get(client.groupId);
  final localization = AppLocalization.of(context)!;
  final company = state.company;

  var notes = '';
  final dates = <String, double>{};

  var lineBreak = '';
  if (company.markdownEnabled) {
    lineBreak += '<br/>';
  }
  lineBreak += '\n';

  if (company.invoiceTaskProjectHeader &&
      project.isOld &&
      includeProjectHeader) {
    if (state.company.markdownEnabled) {
      notes += '## ${project.name}\n';
    } else {
      notes += '<div class="project-header">${project.name}</div>\n';
    }
  }

  notes += task.description;

  if (company.invoiceTaskDatelog ||
      company.invoiceTaskTimelog ||
      company.invoiceTaskHours) {
    if (notes.trim().isNotEmpty) {
      notes += '\n';
    }
    notes += '<div class="task-time-details">\n';

    task
        .getTaskTimes()
        .where((time) =>
            time.startDate != null && time.endDate != null && time.isBillable)
        .forEach((time) {
      final hours = round(time.duration.inSeconds / 3600, 3);
      final hoursStr = hours == 1
          ? ' • 1 ${localization.hour}'
          : ' • $hours ${localization.hours}';

      if (company.invoiceTaskDatelog && company.invoiceTaskTimelog) {
        final start = formatDate(time.startDate!.toIso8601String(), context,
            showTime: true);
        final end = formatDate(time.endDate!.toIso8601String(), context,
            showTime: true, showDate: false, showSeconds: true);
        notes += '$start - $end';
        if (company.invoiceTaskHours) {
          notes += hoursStr;
        }
        notes += lineBreak;
        if (time.description.isNotEmpty && company.invoiceTaskItemDescription) {
          notes += time.description + lineBreak;
        }
      } else if (company.invoiceTaskDatelog) {
        final date = formatDate(time.startDate!.toIso8601String(), context,
            showTime: false);
        if (dates.containsKey(date)) {
          dates[date] = dates[date]! + hours;
        } else {
          dates[date] = hours;
        }
      } else if (company.invoiceTaskTimelog) {
        final start = formatDate(time.startDate!.toIso8601String(), context,
            showTime: true, showDate: false);
        final end = formatDate(time.endDate!.toIso8601String(), context,
            showTime: true, showDate: false, showSeconds: true);
        notes += '$start - $end';
        if (company.invoiceTaskHours) {
          notes += hoursStr;
        }
        notes += lineBreak;
        if (time.description.isNotEmpty && company.invoiceTaskItemDescription) {
          notes += time.description + lineBreak;
        }
      }
    });

    if (company.invoiceTaskDatelog && !company.invoiceTaskTimelog) {
      final sortedDates = dates.keys.toList()..sort((a, b) => b.compareTo(a));
      final datesStr = <String>[];
      for (var date in sortedDates) {
        if (company.invoiceTaskHours) {
          final hours = round(dates[date], 3);
          final hoursStr = hours == 1
              ? ' • 1 ${localization.hour}'
              : ' • $hours ${localization.hours}';

          datesStr.add(date + hoursStr);
        } else {
          datesStr.add(date);
        }
      }

      if (company.markdownEnabled) {
        notes += datesStr.join('<br/>\n');
      } else {
        notes += datesStr.join('\n');
      }
    }

    notes += '</div>\n';
    notes = notes.trim();
  }

  String? customValue1 = '';
  String? customValue2 = '';
  String? customValue3 = '';
  String? customValue4 = '';

  final fieldLabel1 = company.getCustomFieldLabel(CustomFieldType.task1);
  final fieldLabel2 = company.getCustomFieldLabel(CustomFieldType.task2);
  final fieldLabel3 = company.getCustomFieldLabel(CustomFieldType.task3);
  final fieldLabel4 = company.getCustomFieldLabel(CustomFieldType.task4);

  final customValues = {
    company.getCustomFieldLabel(CustomFieldType.task1): task.customValue1,
    company.getCustomFieldLabel(CustomFieldType.task2): task.customValue2,
    company.getCustomFieldLabel(CustomFieldType.task3): task.customValue3,
    company.getCustomFieldLabel(CustomFieldType.task4): task.customValue4,
    localization.project: state.projectState.get(task.projectId).name,
  };

  for (var label in customValues.keys) {
    final value = customValues[label];
    if (fieldLabel1.toLowerCase() == label.toLowerCase()) {
      customValue1 = value;
    } else if (fieldLabel2.toLowerCase() == label.toLowerCase()) {
      customValue2 = value;
    } else if (fieldLabel3.toLowerCase() == label.toLowerCase()) {
      customValue3 = value;
    } else if (fieldLabel4.toLowerCase() == label.toLowerCase()) {
      customValue4 = value;
    }
  }

  return InvoiceItemEntity().rebuild((b) => b
    ..typeId = InvoiceItemEntity.TYPE_TASK
    ..taskId = task.id
    ..productKey =
        company.invoiceTaskProject && !company.invoiceTaskProjectHeader
            ? project.name
            : ''
    ..notes = notes
    ..cost = taskRateSelector(
      company: company,
      project: project,
      client: client,
      task: task,
      group: group,
    )
    ..quantity =
        round(task.calculateDuration(onlyBillable: true).inSeconds / 3600, 3)
    ..customValue1 = customValue1
    ..customValue2 = customValue2
    ..customValue3 = customValue3
    ..customValue4 = customValue4);
}

var memoizedTaskList = memo5((BuiltMap<String, TaskEntity> taskMap,
        String? clientId,
        BuiltMap<String, UserEntity> userMap,
        BuiltMap<String, ClientEntity> clientMap,
        BuiltMap<String, ProjectEntity> projectMap) =>
    taskList(taskMap, clientId, userMap, clientMap, projectMap));

List<String?> taskList(
    BuiltMap<String, TaskEntity> taskMap,
    String? clientId,
    BuiltMap<String, UserEntity> userMap,
    BuiltMap<String, ClientEntity> clientMap,
    BuiltMap<String, ProjectEntity> projectMap) {
  final list = taskMap.keys.where((taskId) {
    final task = taskMap[taskId];
    if ((clientId ?? '').isNotEmpty &&
        task!.clientId.isNotEmpty &&
        task.clientId != clientId) {
      return false;
    }
    return task!.isActive && task.isStopped && !task.isInvoiced;
  }).toList();

  list.sort((idA, idB) =>
      taskMap[idA]!.listDisplayName.compareTo(taskMap[idB]!.listDisplayName));

  return list;
}

var memoizedDropdownTaskList = memo7((
  BuiltMap<String, TaskEntity> taskMap,
  BuiltList<String> taskList,
  BuiltMap<String, UserEntity> userMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ProjectEntity> projectMap,
  BuiltMap<String, TaskStatusEntity> taskStatusMap,
) =>
    dropdownTasksSelector(
      taskMap,
      taskList,
      userMap,
      clientMap,
      invoiceMap,
      projectMap,
      taskStatusMap,
    ));

List<String> dropdownTasksSelector(
  BuiltMap<String, TaskEntity> taskMap,
  BuiltList<String> taskList,
  BuiltMap<String, UserEntity> userMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ProjectEntity> projectMap,
  BuiltMap<String, TaskStatusEntity> taskStatusMap,
) {
  final list = taskList.where((taskId) => taskMap[taskId]!.isActive).toList();

  list.sort((taskAId, taskBId) {
    final taskA = taskMap[taskAId]!;
    final taskB = taskMap[taskBId]!;
    return taskA.compareTo(
      taskB,
      TaskFields.updatedAt,
      false,
      userMap,
      clientMap,
      projectMap,
      invoiceMap,
      taskStatusMap,
    );
  });

  return list;
}

var memoizedKanbanTaskList = memo9((SelectionState selectionState,
        BuiltMap<String, TaskEntity> taskMap,
        BuiltMap<String, ClientEntity> clientMap,
        BuiltMap<String, UserEntity> userMap,
        BuiltMap<String, ProjectEntity> projectMap,
        BuiltMap<String, InvoiceEntity> invoiceMap,
        BuiltMap<String, TaskStatusEntity> taskStatusMap,
        BuiltList<String> taskList,
        ListUIState taskListState) =>
    kanbanTasksSelector(selectionState, taskMap, clientMap, userMap, projectMap,
        invoiceMap, taskStatusMap, taskList, taskListState));

List<String> kanbanTasksSelector(
    SelectionState selectionState,
    BuiltMap<String, TaskEntity> taskMap,
    BuiltMap<String, ClientEntity> clientMap,
    BuiltMap<String, UserEntity> userMap,
    BuiltMap<String, ProjectEntity> projectMap,
    BuiltMap<String, InvoiceEntity> invoiceMap,
    BuiltMap<String, TaskStatusEntity> taskStatusMap,
    BuiltList<String> taskList,
    ListUIState taskListState) {
  final filterEntityId = selectionState.filterEntityId;
  final filterEntityType = selectionState.filterEntityType;

  final list = taskList.where((taskId) {
    final task = taskMap[taskId]!;
    final client = clientMap[task.clientId] ?? ClientEntity(id: task.clientId);

    if (!client.isActive &&
        !client.matchesEntityFilter(filterEntityType, filterEntityId)) {
      return false;
    }

    if (task.isInvoiced) {
      return false;
    }

    return true;
  }).toList();

  list.sort((taskAId, taskBId) {
    final taskA = taskMap[taskAId]!;
    final taskB = taskMap[taskBId]!;
    return taskA.compareTo(
      taskB,
      taskListState.sortField,
      taskListState.sortAscending,
      userMap,
      clientMap,
      projectMap,
      invoiceMap,
      taskStatusMap,
    );
  });

  return list;
}

var memoizedFilteredTaskList = memo9((
  SelectionState selectionState,
  BuiltMap<String, TaskEntity> taskMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, UserEntity> userMap,
  BuiltMap<String, ProjectEntity> projectMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, TaskStatusEntity> taskStatusMap,
  BuiltList<String> taskList,
  ListUIState taskListState,
) =>
    filteredTasksSelector(
      selectionState,
      taskMap,
      clientMap,
      userMap,
      projectMap,
      invoiceMap,
      taskStatusMap,
      taskList,
      taskListState,
    ));

List<String> filteredTasksSelector(
    SelectionState selectionState,
    BuiltMap<String, TaskEntity> taskMap,
    BuiltMap<String, ClientEntity> clientMap,
    BuiltMap<String, UserEntity> userMap,
    BuiltMap<String, ProjectEntity> projectMap,
    BuiltMap<String, InvoiceEntity> invoiceMap,
    BuiltMap<String, TaskStatusEntity> taskStatusMap,
    BuiltList<String> taskList,
    ListUIState taskListState) {
  final filterEntityId = selectionState.filterEntityId;
  final filterEntityType = selectionState.filterEntityType;

  final list = taskList.where((taskId) {
    final task = taskMap[taskId]!;
    final client = clientMap[task.clientId] ?? ClientEntity(id: task.clientId);
    final project =
        projectMap[task.projectId] ?? ProjectEntity(id: task.projectId);

    if (task.id == selectionState.selectedId) {
      return true;
    }

    if (!client.isActive &&
        !client.matchesEntityFilter(filterEntityType, filterEntityId)) {
      return false;
    }

    if (!task.matchesFilter(taskListState.filter) &&
        !client.matchesNameOrEmail(taskListState.filter) &&
        !project.matchesName(taskListState.filter!)) {
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
      } else if (filterEntityType == EntityType.invoice &&
          task.invoiceId != filterEntityId) {
        return false;
      } else if (filterEntityType == EntityType.user &&
          task.assignedUserId != filterEntityId) {
        return false;
      } else if (filterEntityType == EntityType.taskStatus &&
          task.statusId != filterEntityId) {
        return false;
      } else if (filterEntityType == EntityType.group &&
          client.groupId != filterEntityId) {
        return false;
      }
    } else if (!client.isActive) {
      return false;
    }

    if (taskListState.custom1Filters.isNotEmpty &&
        !taskListState.custom1Filters.contains(task.customValue1)) {
      return false;
    } else if (taskListState.custom2Filters.isNotEmpty &&
        !taskListState.custom2Filters.contains(task.customValue2)) {
      return false;
    } else if (taskListState.custom3Filters.isNotEmpty &&
        !taskListState.custom3Filters.contains(task.customValue3)) {
      return false;
    } else if (taskListState.custom4Filters.isNotEmpty &&
        !taskListState.custom4Filters.contains(task.customValue4)) {
      return false;
    }

    return true;
  }).toList();

  list.sort((taskAId, taskBId) {
    final taskA = taskMap[taskAId]!;
    final taskB = taskMap[taskBId]!;
    return taskA.compareTo(
      taskB,
      taskListState.sortField,
      taskListState.sortAscending,
      userMap,
      clientMap,
      projectMap,
      invoiceMap,
      taskStatusMap,
    );
  });

  return list;
}

double? taskRateSelector({
  required CompanyEntity? company,
  required ProjectEntity? project,
  required ClientEntity? client,
  required TaskEntity? task,
  required GroupEntity? group,
}) {
  if (task != null && task.rate > 0) {
    return task.rate;
  } else if (project != null && project.taskRate > 0) {
    return project.taskRate;
  } else if (client != null && (client.settings.defaultTaskRate ?? 0) > 0) {
    return client.settings.defaultTaskRate;
  } else if (group != null && (group.settings.defaultTaskRate ?? 0) > 0) {
    return group.settings.defaultTaskRate;
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

var memoizedTaskStatsForUser = memo2((
  String userId,
  BuiltMap<String, TaskEntity> taskMap,
) =>
    taskStatsForProject(userId, taskMap));

EntityStats taskStatsForUser(
    String userId, BuiltMap<String, TaskEntity> taskMap) {
  int countActive = 0;
  int countArchived = 0;
  taskMap.forEach((taskId, task) {
    if (task.assignedUserId == userId) {
      if (task.isActive) {
        countActive++;
      } else if (task.isArchived) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}
