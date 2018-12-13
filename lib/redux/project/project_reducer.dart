import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_state.dart';

EntityUIState projectUIReducer(ProjectUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(projectListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action))
    ..selectedId = selectedIdReducer(state.selectedId, action));
}

Reducer<int> selectedIdReducer = combineReducers([
  TypedReducer<int, ViewProject>(
      (int selectedId, dynamic action) => action.projectId),
  TypedReducer<int, AddProjectSuccess>(
      (int selectedId, dynamic action) => action.project.id),
]);

final editingReducer = combineReducers<ProjectEntity>([
  TypedReducer<ProjectEntity, SaveProjectSuccess>(_updateEditing),
  TypedReducer<ProjectEntity, AddProjectSuccess>(_updateEditing),
  TypedReducer<ProjectEntity, RestoreProjectSuccess>(_updateEditing),
  TypedReducer<ProjectEntity, ArchiveProjectSuccess>(_updateEditing),
  TypedReducer<ProjectEntity, DeleteProjectSuccess>(_updateEditing),
  TypedReducer<ProjectEntity, EditProject>(_updateEditing),
  TypedReducer<ProjectEntity, UpdateProject>(_updateEditing),
  TypedReducer<ProjectEntity, SelectCompany>(_clearEditing),
]);

ProjectEntity _clearEditing(ProjectEntity project, dynamic action) {
  return ProjectEntity();
}

ProjectEntity _updateEditing(ProjectEntity project, dynamic action) {
  return action.project;
}


final projectListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortProjects>(_sortProjects),
  TypedReducer<ListUIState, FilterProjectsByState>(_filterProjectsByState),
  TypedReducer<ListUIState, FilterProjects>(_filterProjects),
  TypedReducer<ListUIState, FilterProjectsByCustom1>(_filterProjectsByCustom1),
  TypedReducer<ListUIState, FilterProjectsByCustom2>(_filterProjectsByCustom2),
  TypedReducer<ListUIState, FilterProjectsByEntity>(_filterProjectsByClient),
]);

ListUIState _filterProjectsByClient(
    ListUIState projectListState, FilterProjectsByEntity action) {
  return projectListState.rebuild((b) => b
  ..filterEntityId = action.entityId
  ..filterEntityType = action.entityType);
}

ListUIState _filterProjectsByCustom1(
    ListUIState projectListState, FilterProjectsByCustom1 action) {
  if (projectListState.custom1Filters.contains(action.value)) {
    return projectListState
        .rebuild((b) => b..custom1Filters.remove(action.value));
  } else {
    return projectListState.rebuild((b) => b..custom1Filters.add(action.value));
  }
}

ListUIState _filterProjectsByCustom2(
    ListUIState projectListState, FilterProjectsByCustom2 action) {
  if (projectListState.custom2Filters.contains(action.value)) {
    return projectListState
        .rebuild((b) => b..custom2Filters.remove(action.value));
  } else {
    return projectListState.rebuild((b) => b..custom2Filters.add(action.value));
  }
}

ListUIState _filterProjectsByState(
    ListUIState projectListState, FilterProjectsByState action) {
  if (projectListState.stateFilters.contains(action.state)) {
    return projectListState.rebuild((b) => b..stateFilters.remove(action.state));
  } else {
    return projectListState.rebuild((b) => b..stateFilters.add(action.state));
  }
}

ListUIState _filterProjects(ListUIState projectListState, FilterProjects action) {
  return projectListState.rebuild((b) => b..filter = action.filter);
}

ListUIState _sortProjects(ListUIState projectListState, SortProjects action) {
  return projectListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending
    ..sortField = action.field);
}

final projectsReducer = combineReducers<ProjectState>([
  TypedReducer<ProjectState, SaveProjectSuccess>(_updateProject),
  TypedReducer<ProjectState, AddProjectSuccess>(_addProject),
  TypedReducer<ProjectState, LoadProjectsSuccess>(_setLoadedProjects),
  TypedReducer<ProjectState, LoadProjectSuccess>(_setLoadedProject),
  TypedReducer<ProjectState, ArchiveProjectRequest>(_archiveProjectRequest),
  TypedReducer<ProjectState, ArchiveProjectSuccess>(_archiveProjectSuccess),
  TypedReducer<ProjectState, ArchiveProjectFailure>(_archiveProjectFailure),
  TypedReducer<ProjectState, DeleteProjectRequest>(_deleteProjectRequest),
  TypedReducer<ProjectState, DeleteProjectSuccess>(_deleteProjectSuccess),
  TypedReducer<ProjectState, DeleteProjectFailure>(_deleteProjectFailure),
  TypedReducer<ProjectState, RestoreProjectRequest>(_restoreProjectRequest),
  TypedReducer<ProjectState, RestoreProjectSuccess>(_restoreProjectSuccess),
  TypedReducer<ProjectState, RestoreProjectFailure>(_restoreProjectFailure),
]);

ProjectState _archiveProjectRequest(
    ProjectState projectState, ArchiveProjectRequest action) {
  final project = projectState.map[action.projectId]
      .rebuild((b) => b..archivedAt = DateTime.now().millisecondsSinceEpoch);

  return projectState.rebuild((b) => b..map[action.projectId] = project);
}

ProjectState _archiveProjectSuccess(
    ProjectState projectState, ArchiveProjectSuccess action) {
  return projectState.rebuild((b) => b..map[action.project.id] = action.project);
}

ProjectState _archiveProjectFailure(
    ProjectState projectState, ArchiveProjectFailure action) {
  return projectState.rebuild((b) => b..map[action.project.id] = action.project);
}

ProjectState _deleteProjectRequest(
    ProjectState projectState, DeleteProjectRequest action) {
  final project = projectState.map[action.projectId].rebuild((b) => b
    ..archivedAt = DateTime.now().millisecondsSinceEpoch
    ..isDeleted = true);

  return projectState.rebuild((b) => b..map[action.projectId] = project);
}

ProjectState _deleteProjectSuccess(
    ProjectState projectState, DeleteProjectSuccess action) {
  return projectState.rebuild((b) => b..map[action.project.id] = action.project);
}

ProjectState _deleteProjectFailure(
    ProjectState projectState, DeleteProjectFailure action) {
  return projectState.rebuild((b) => b..map[action.project.id] = action.project);
}

ProjectState _restoreProjectRequest(
    ProjectState projectState, RestoreProjectRequest action) {
  final project = projectState.map[action.projectId].rebuild((b) => b
    ..archivedAt = null
    ..isDeleted = false);
  return projectState.rebuild((b) => b..map[action.projectId] = project);
}

ProjectState _restoreProjectSuccess(
    ProjectState projectState, RestoreProjectSuccess action) {
  return projectState.rebuild((b) => b..map[action.project.id] = action.project);
}

ProjectState _restoreProjectFailure(
    ProjectState projectState, RestoreProjectFailure action) {
  return projectState.rebuild((b) => b..map[action.project.id] = action.project);
}

ProjectState _addProject(ProjectState projectState, AddProjectSuccess action) {
  return projectState.rebuild((b) => b
    ..map[action.project.id] = action.project
    ..list.add(action.project.id));
}

ProjectState _updateProject(ProjectState projectState, SaveProjectSuccess action) {
  return projectState.rebuild((b) => b
    ..map[action.project.id] = action.project);
}

ProjectState _setLoadedProject(
    ProjectState projectState, LoadProjectSuccess action) {
  return projectState.rebuild((b) => b
    ..map[action.project.id] = action.project);
}

ProjectState _setLoadedProjects(
    ProjectState projectState, LoadProjectsSuccess action) {
  final state = projectState.rebuild((b) => b
    ..lastUpdated = DateTime.now().millisecondsSinceEpoch
    ..map.addAll(Map.fromIterable(
      action.projects,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    )));

  return state.rebuild((b) => b..list.replace(state.map.keys));
}
