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

var memoizedFilteredProjectList = memo3((BuiltMap<int, ProjectEntity> projectMap,
        BuiltList<int> projectList, ListUIState projectListState) =>
    filteredProjectsSelector(projectMap, projectList, projectListState));

List<int> filteredProjectsSelector(BuiltMap<int, ProjectEntity> projectMap,
    BuiltList<int> projectList, ListUIState projectListState) {
  final list = projectList.where((projectId) {
    final project = projectMap[projectId];
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
