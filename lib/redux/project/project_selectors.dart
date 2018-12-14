import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownProjectList = memo2(
    (BuiltMap<int, ProjectEntity> projectMap, BuiltList<int> projectList) =>
        dropdownProjectsSelector(projectMap, projectList));

List<int> dropdownProjectsSelector(
    BuiltMap<int, ProjectEntity> projectMap, BuiltList<int> projectList) {
  final list =
      projectList.where((projectId) => projectMap[projectId].isActive).toList();

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

    if (project.clientId > 0 && clientMap[project.clientId].isArchived) {
      return false;
    }

    if (!project.matchesStates(projectListState.stateFilters)) {
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
    return project.matchesFilter(projectListState.filter);
  }).toList();

  list.sort((projectAId, projectBId) {
    final projectA = projectMap[projectAId];
    final projectB = projectMap[projectBId];
    return projectA.compareTo(
        projectB, projectListState.sortField, projectListState.sortAscending);
  });

  return list;
}
