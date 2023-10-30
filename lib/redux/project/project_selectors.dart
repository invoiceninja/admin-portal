// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_selectors.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

List<InvoiceItemEntity> convertProjectToInvoiceItem({
  required BuildContext context,
  ProjectEntity? project,
}) {
  final List<InvoiceItemEntity> items = [];
  final state = StoreProvider.of<AppState>(context).state;

  final tasks = <TaskEntity?>[];
  state.taskState.map.forEach((index, task) {
    if (task.isActive &&
        task.isStopped &&
        !task.isInvoiced &&
        task.projectId == project!.id) {
      tasks.add(task);
    }
  });

  final expenses = <ExpenseEntity?>[];
  state.expenseState.map.forEach((index, expense) {
    if (expense.isActive &&
        expense.projectId == project!.id &&
        expense.isPending) {
      expenses.add(expense);
    }
  });

  tasks.sort((taskA, taskB) {
    final taskTimesA = taskA!.getTaskTimes();
    final taskTimesB = taskB!.getTaskTimes();

    final taskADate = taskTimesA.isEmpty ? null : taskTimesA.first.startDate;
    final taskBDate = taskTimesB.isEmpty ? null : taskTimesB.first.startDate;

    if (taskADate == null) {
      return 1;
    } else if (taskBDate == null) {
      return -1;
    }

    return taskADate.compareTo(taskBDate);
  });

  expenses.sort((expenseA, expenseB) {
    return expenseA!.date!.compareTo(expenseB!.date!);
  });

  bool hasShownNotes = false;

  for (var i = 0; i < expenses.length; i++) {
    final expense = expenses[i]!;
    var item = convertExpenseToInvoiceItem(expense: expense, context: context);

    if (i == 0) {
      var notes = '';
      if (state.company.markdownEnabled) {
        notes = '## ${project!.name}\n';
      } else {
        notes = '<div class="project-header">${project!.name}</div>\n';
      }

      if (project.publicNotes.isNotEmpty) {
        notes += '${project.publicNotes}\n';
        hasShownNotes = true;
      }
      notes += item.notes;
      item = item.rebuild((b) => b.notes = notes);
    }

    items.add(item);
  }

  for (var i = 0; i < tasks.length; i++) {
    final task = tasks[i]!;
    var item = convertTaskToInvoiceItem(task: task, context: context);

    if (i == 0) {
      var notes = '';
      if (state.company.markdownEnabled) {
        notes = '## ${project!.name}\n';
      } else {
        notes = '<div class="project-header">${project!.name}</div>\n';
      }

      if (project.publicNotes.isNotEmpty && !hasShownNotes) {
        notes += '${project.publicNotes}\n';
      }
      notes += item.notes;

      item = item.rebuild((b) => b.notes = notes);
    }

    items.add(item);
  }

  return items;
}

var memoizedDropdownProjectList = memo5(
    (BuiltMap<String, ProjectEntity> projectMap,
            BuiltList<String> projectList,
            BuiltMap<String, ClientEntity> clientMap,
            BuiltMap<String, UserEntity> userMap,
            String? clientId) =>
        dropdownProjectsSelector(
            projectMap, projectList, clientMap, userMap, clientId));

List<String> dropdownProjectsSelector(
    BuiltMap<String, ProjectEntity> projectMap,
    BuiltList<String> projectList,
    BuiltMap<String, ClientEntity> clientMap,
    BuiltMap<String, UserEntity> userMap,
    String? clientId) {
  final list = projectList.where((projectId) {
    final project = projectMap[projectId];
    if (clientId != null &&
        clientId.isNotEmpty &&
        project!.clientId != clientId) {
      return false;
    }
    if (project!.hasClient &&
        clientMap.containsKey(project.clientId) &&
        !clientMap[project.clientId]!.isActive) {
      return false;
    }
    return project.isActive;
  }).toList();

  list.sort((projectAId, projectBId) {
    final projectA = projectMap[projectAId]!;
    final projectB = projectMap[projectBId]!;
    return projectA.compareTo(
        projectB, ProjectFields.name, true, userMap, clientMap);
  });

  return list;
}

var memoizedFilteredProjectList = memo6((SelectionState selectionState,
        BuiltMap<String, ProjectEntity> projectMap,
        BuiltList<String> projectList,
        ListUIState projectListState,
        BuiltMap<String, ClientEntity> clientMap,
        BuiltMap<String, UserEntity> userMap) =>
    filteredProjectsSelector(selectionState, projectMap, projectList,
        projectListState, clientMap, userMap));

List<String> filteredProjectsSelector(
    SelectionState selectionState,
    BuiltMap<String, ProjectEntity> projectMap,
    BuiltList<String> projectList,
    ListUIState projectListState,
    BuiltMap<String, ClientEntity> clientMap,
    BuiltMap<String, UserEntity> userMap) {
  final filterEntityId = selectionState.filterEntityId;
  final filterEntityType = selectionState.filterEntityType;

  final list = projectList.where((projectId) {
    final project = projectMap[projectId]!;
    final client =
        clientMap[project.clientId] ?? ClientEntity(id: project.clientId);
    final user = userMap[project.assignedUserId] ??
        UserEntity(id: project.assignedUserId);

    if (project.id == selectionState.selectedId) {
      return true;
    }

    if (filterEntityId != null) {
      if (filterEntityType == EntityType.client &&
          !client.matchesEntityFilter(filterEntityType, filterEntityId)) {
        return false;
      } else if (filterEntityType == EntityType.user &&
          !user.matchesEntityFilter(filterEntityType, filterEntityId)) {
        return false;
      } else if (filterEntityType == EntityType.group &&
          client.groupId != filterEntityId) {
        return false;
      }
    } else if (!client.isActive) {
      return false;
    }

    if (!project.matchesFilter(projectListState.filter) &&
        !client.matchesNameOrEmail(projectListState.filter)) {
      return false;
    }

    if (!project.matchesStates(projectListState.stateFilters)) {
      return false;
    }

    if (projectListState.custom1Filters.isNotEmpty &&
        !projectListState.custom1Filters.contains(project.customValue1)) {
      return false;
    } else if (projectListState.custom2Filters.isNotEmpty &&
        !projectListState.custom2Filters.contains(project.customValue2)) {
      return false;
    } else if (projectListState.custom3Filters.isNotEmpty &&
        !projectListState.custom3Filters.contains(project.customValue3)) {
      return false;
    } else if (projectListState.custom4Filters.isNotEmpty &&
        !projectListState.custom4Filters.contains(project.customValue4)) {
      return false;
    }

    return true;
  }).toList();

  list.sort((projectAId, projectBId) {
    final projectA = projectMap[projectAId]!;
    final projectB = projectMap[projectBId]!;
    return projectA.compareTo(projectB, projectListState.sortField,
        projectListState.sortAscending, userMap, clientMap);
  });

  return list;
}

Duration taskDurationForProject(
  ProjectEntity project,
  BuiltMap<String, TaskEntity> taskMap,
) {
  int total = 0;
  taskMap.forEach((index, task) {
    if (!task.isDeleted! && task.projectId == project.id) {
      total += task.calculateDuration().inSeconds;
    }
  });
  return Duration(seconds: total);
}

var memoizedProjectStatsForClient = memo2(
    (String clientId, BuiltMap<String, ProjectEntity> projectMap) =>
        projectStatsForClient(clientId, projectMap));

EntityStats projectStatsForClient(
    String clientId, BuiltMap<String, ProjectEntity> projectMap) {
  int countActive = 0;
  int countArchived = 0;
  projectMap.forEach((projectId, project) {
    if (project.clientId == clientId) {
      if (project.isActive) {
        countActive++;
      } else if (project.isArchived) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}

var memoizedProjectStatsForUser = memo2(
    (String userId, BuiltMap<String, ProjectEntity> projectMap) =>
        projectStatsForClient(userId, projectMap));

EntityStats projectStatsForUser(
    String userId, BuiltMap<String, ProjectEntity> projectMap) {
  int countActive = 0;
  int countArchived = 0;
  projectMap.forEach((projectId, project) {
    if (project.assignedUserId == userId) {
      if (project.isActive) {
        countActive++;
      } else if (project.isArchived) {
        countArchived++;
      }
    }
  });

  return EntityStats(countActive: countActive, countArchived: countArchived);
}
