import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
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
    ..selectedId = selectedIdReducer(state.selectedId, action)
    ..saveCompleter = saveCompleterReducer(state.saveCompleter, action)
    ..cancelCompleter = cancelCompleterReducer(state.cancelCompleter, action));
}

final saveCompleterReducer = combineReducers<Completer<SelectableEntity>>([
  TypedReducer<Completer<SelectableEntity>, EditProject>((completer, action) {
    return action.completer;
  }),
]);

final cancelCompleterReducer = combineReducers<Completer<SelectableEntity>>([
  TypedReducer<Completer<SelectableEntity>, EditProject>((completer, action) {
    return action.cancelCompleter;
  }),
]);

Reducer<String> selectedIdReducer = combineReducers([
  TypedReducer<String, ViewProject>((selectedId, action) => action.projectId),
  TypedReducer<String, AddProjectSuccess>(
      (selectedId, action) => action.project.id),
  TypedReducer<String, SelectCompany>(
      (selectedId, action) => action.clearSelection ? '' : selectedId),
  TypedReducer<String, DeleteProjectSuccess>((selectedId, action) => ''),
  TypedReducer<String, ArchiveProjectSuccess>((selectedId, action) => ''),
  TypedReducer<String, ClearEntityFilter>((selectedId, action) => ''),
]);

final editingReducer = combineReducers<ProjectEntity>([
  TypedReducer<ProjectEntity, SaveProjectSuccess>(_updateEditing),
  TypedReducer<ProjectEntity, AddProjectSuccess>(_updateEditing),
  TypedReducer<ProjectEntity, RestoreProjectSuccess>((projects, action) {
    return action.projects[0];
  }),
  TypedReducer<ProjectEntity, ArchiveProjectSuccess>((projects, action) {
    return action.projects[0];
  }),
  TypedReducer<ProjectEntity, DeleteProjectSuccess>((projects, action) {
    return action.projects[0];
  }),
  TypedReducer<ProjectEntity, EditProject>(_updateEditing),
  TypedReducer<ProjectEntity, UpdateProject>((project, action) {
    return action.project.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<ProjectEntity, SelectCompany>(_clearEditing),
  TypedReducer<ProjectEntity, DiscardChanges>(_clearEditing),
]);

ProjectEntity _clearEditing(ProjectEntity project, dynamic dynamicAction) {
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
  TypedReducer<ListUIState, FilterProjectsByCustom3>(_filterProjectsByCustom3),
  TypedReducer<ListUIState, FilterProjectsByCustom4>(_filterProjectsByCustom4),
  TypedReducer<ListUIState, StartProjectMultiselect>(_startListMultiselect),
  TypedReducer<ListUIState, AddToProjectMultiselect>(_addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromProjectMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearProjectMultiselect>(_clearListMultiselect),
]);

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

ListUIState _filterProjectsByCustom3(
    ListUIState projectListState, FilterProjectsByCustom3 action) {
  if (projectListState.custom3Filters.contains(action.value)) {
    return projectListState
        .rebuild((b) => b..custom3Filters.remove(action.value));
  } else {
    return projectListState.rebuild((b) => b..custom3Filters.add(action.value));
  }
}

ListUIState _filterProjectsByCustom4(
    ListUIState projectListState, FilterProjectsByCustom4 action) {
  if (projectListState.custom4Filters.contains(action.value)) {
    return projectListState
        .rebuild((b) => b..custom4Filters.remove(action.value));
  } else {
    return projectListState.rebuild((b) => b..custom4Filters.add(action.value));
  }
}

ListUIState _filterProjectsByState(
    ListUIState projectListState, FilterProjectsByState action) {
  if (projectListState.stateFilters.contains(action.state)) {
    return projectListState
        .rebuild((b) => b..stateFilters.remove(action.state));
  } else {
    return projectListState.rebuild((b) => b..stateFilters.add(action.state));
  }
}

ListUIState _filterProjects(
    ListUIState projectListState, FilterProjects action) {
  return projectListState.rebuild((b) => b
    ..filter = action.filter
    ..filterClearedAt = action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : projectListState.filterClearedAt);
}

ListUIState _sortProjects(ListUIState projectListState, SortProjects action) {
  return projectListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState projectListState, StartProjectMultiselect action) {
  return projectListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState projectListState, AddToProjectMultiselect action) {
  return projectListState.rebuild((b) => b..selectedIds.add(action.entity.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState projectListState, RemoveFromProjectMultiselect action) {
  return projectListState
      .rebuild((b) => b..selectedIds.remove(action.entity.id));
}

ListUIState _clearListMultiselect(
    ListUIState projectListState, ClearProjectMultiselect action) {
  return projectListState.rebuild((b) => b..selectedIds = null);
}

final projectsReducer = combineReducers<ProjectState>([
  TypedReducer<ProjectState, SaveProjectSuccess>(_updateProject),
  TypedReducer<ProjectState, AddProjectSuccess>(_addProject),
  TypedReducer<ProjectState, LoadProjectsSuccess>(_setLoadedProjects),
  TypedReducer<ProjectState, LoadCompanySuccess>(_setLoadedCompany),
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
  final projects = action.projectIds.map((id) => projectState.map[id]).toList();

  for (int i = 0; i < projects.length; i++) {
    projects[i] = projects[i]
        .rebuild((b) => b..archivedAt = DateTime.now().millisecondsSinceEpoch);
  }
  return projectState.rebuild((b) {
    for (final project in projects) {
      b.map[project.id] = project;
    }
  });
}

ProjectState _archiveProjectSuccess(
    ProjectState projectState, ArchiveProjectSuccess action) {
  return projectState.rebuild((b) {
    for (final project in action.projects) {
      b.map[project.id] = project;
    }
  });
}

ProjectState _archiveProjectFailure(
    ProjectState projectState, ArchiveProjectFailure action) {
  return projectState.rebuild((b) {
    for (final project in action.projects) {
      b.map[project.id] = project;
    }
  });
}

ProjectState _deleteProjectRequest(
    ProjectState projectState, DeleteProjectRequest action) {
  final projects = action.projectIds.map((id) => projectState.map[id]).toList();

  for (int i = 0; i < projects.length; i++) {
    projects[i] = projects[i].rebuild((b) => b
      ..archivedAt = DateTime.now().millisecondsSinceEpoch
      ..isDeleted = true);
  }
  return projectState.rebuild((b) {
    for (final project in projects) {
      b.map[project.id] = project;
    }
  });
}

ProjectState _deleteProjectSuccess(
    ProjectState projectState, DeleteProjectSuccess action) {
  return projectState.rebuild((b) {
    for (final project in action.projects) {
      b.map[project.id] = project;
    }
  });
}

ProjectState _deleteProjectFailure(
    ProjectState projectState, DeleteProjectFailure action) {
  return projectState.rebuild((b) {
    for (final project in action.projects) {
      b.map[project.id] = project;
    }
  });
}

ProjectState _restoreProjectRequest(
    ProjectState projectState, RestoreProjectRequest action) {
  final projects = action.projectIds.map((id) => projectState.map[id]).toList();

  for (int i = 0; i < projects.length; i++) {
    projects[i] = projects[i].rebuild((b) => b
      ..archivedAt = 0
      ..isDeleted = false);
  }
  return projectState.rebuild((b) {
    for (final project in projects) {
      b.map[project.id] = project;
    }
  });
}

ProjectState _restoreProjectSuccess(
    ProjectState projectState, RestoreProjectSuccess action) {
  return projectState.rebuild((b) {
    for (final project in action.projects) {
      b.map[project.id] = project;
    }
  });
}

ProjectState _restoreProjectFailure(
    ProjectState projectState, RestoreProjectFailure action) {
  return projectState.rebuild((b) {
    for (final project in action.projects) {
      b.map[project.id] = project;
    }
  });
}

ProjectState _addProject(ProjectState projectState, AddProjectSuccess action) {
  return projectState.rebuild((b) => b
    ..map[action.project.id] = action.project
    ..list.add(action.project.id));
}

ProjectState _updateProject(
    ProjectState projectState, SaveProjectSuccess action) {
  return projectState
      .rebuild((b) => b..map[action.project.id] = action.project);
}

ProjectState _setLoadedProject(
    ProjectState projectState, LoadProjectSuccess action) {
  return projectState
      .rebuild((b) => b..map[action.project.id] = action.project);
}

ProjectState _setLoadedProjects(
        ProjectState projectState, LoadProjectsSuccess action) =>
    projectState.loadProjects(action.projects);

ProjectState _setLoadedCompany(
    ProjectState projectState, LoadCompanySuccess action) {
  final company = action.userCompany.company;
  return projectState.loadProjects(company.projects);
}
