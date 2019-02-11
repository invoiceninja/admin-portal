import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

List<InvoiceItemEntity> convertProjectToInvoiceItem(
    {BuildContext context, ProjectEntity project}) {
  final List<InvoiceItemEntity> items = [];
  final state = StoreProvider.of<AppState>(context).state;
  state.taskState.map.forEach((index, task) {
    if (task.isStopped && !task.isInvoiced && task.projectId == project.id) {
      final item = convertTaskToInvoiceItem(task: task, context: context);
      items.add(item);
    }
  });

  return items;
}

var memoizedDropdownProjectList = memo4(
    (BuiltMap<int, ProjectEntity> projectMap, BuiltList<int> projectList,
            BuiltMap<int, ClientEntity> clientMap, int clientId) =>
        dropdownProjectsSelector(projectMap, projectList, clientMap, clientId));

List<int> dropdownProjectsSelector(
    BuiltMap<int, ProjectEntity> projectMap,
    BuiltList<int> projectList,
    BuiltMap<int, ClientEntity> clientMap,
    int clientId) {
  final list = projectList.where((projectId) {
    final project = projectMap[projectId];
    if (clientId != null && clientId > 0 && project.clientId != clientId) {
      return false;
    }
    if (project.clientId > 0 &&
        clientMap.containsKey(project.clientId) &&
        !clientMap[project.clientId].isActive) {
      return false;
    }
    return project.isActive;
  }).toList();

  list.sort((projectAId, projectBId) {
    final projectA = projectMap[projectAId];
    final projectB = projectMap[projectBId];
    return projectA.compareTo(projectB, ProjectFields.name, true);
  });

  return list;
}

var memoizedFilteredProjectList = memo4(
    (BuiltMap<int, ProjectEntity> projectMap,
            BuiltList<int> projectList,
            ListUIState projectListState,
            BuiltMap<int, ClientEntity> clientMap) =>
        filteredProjectsSelector(
            projectMap, projectList, projectListState, clientMap));

List<int> filteredProjectsSelector(
    BuiltMap<int, ProjectEntity> projectMap,
    BuiltList<int> projectList,
    ListUIState projectListState,
    BuiltMap<int, ClientEntity> clientMap) {
  final list = projectList.where((projectId) {
    final project = projectMap[projectId];
    final client =
        clientMap[project.clientId] ?? ClientEntity(id: project.clientId);

    if (!client.isActive) {
      return false;
    }

    if (!project.matchesFilter(projectListState.filter) &&
        !client.matchesFilter(projectListState.filter)) {
      return false;
    }

    if (!project.matchesStates(projectListState.stateFilters)) {
      return false;
    }
    if (projectListState.filterEntityId != null &&
        project.clientId != projectListState.filterEntityId) {
      return false;
    }
    if (projectListState.custom1Filters.isNotEmpty &&
        !projectListState.custom1Filters.contains(project.customValue1)) {
      return false;
    }
    if (projectListState.custom2Filters.isNotEmpty &&
        !projectListState.custom2Filters.contains(project.customValue2)) {
      return false;
    }
    /*
    if (projectListState.filterEntityId != null &&
        project.entityId != projectListState.filterEntityId) {
      return false;
    }
    */
    return true;
  }).toList();

  list.sort((projectAId, projectBId) {
    final projectA = projectMap[projectAId];
    final projectB = projectMap[projectBId];
    return projectA.compareTo(
        projectB, projectListState.sortField, projectListState.sortAscending);
  });

  return list;
}

Duration taskDurationForProject(
  ProjectEntity project,
  BuiltMap<int, TaskEntity> taskMap,
) {
  int total = 0;
  taskMap.forEach((index, task) {
    if (task.isActive && task.projectId == project.id) {
      total += task.calculateDuration.inSeconds;
    }
  });
  return Duration(seconds: total);
}

var memoizedProjectStatsForClient = memo4((int clientId,
        BuiltMap<int, ProjectEntity> projectMap,
        String activeLabel,
        String archivedLabel) =>
    projectStatsForClient(clientId, projectMap, activeLabel, archivedLabel));

String projectStatsForClient(
    int clientId,
    BuiltMap<int, ProjectEntity> projectMap,
    String activeLabel,
    String archivedLabel) {
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
