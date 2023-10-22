// Dart imports:
import 'dart:async';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_state.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

EntityUIState projectUIReducer(ProjectUIState state, dynamic action) {
  return state.rebuild(
    (b) => b
      ..listUIState.replace(projectListReducer(state.listUIState, action))
      ..editing.replace(editingReducer(state.editing, action)!)
      ..selectedId = selectedIdReducer(state.selectedId, action)
      ..forceSelected = forceSelectedReducer(state.forceSelected, action)
      ..tabIndex = tabIndexReducer(state.tabIndex, action)
      ..saveCompleter = saveCompleterReducer(state.saveCompleter, action)
      ..cancelCompleter = cancelCompleterReducer(state.cancelCompleter, action),
  );
}

final forceSelectedReducer = combineReducers<bool?>([
  TypedReducer<bool?, ViewProject>((completer, action) => true),
  TypedReducer<bool?, ViewProjectList>((completer, action) => false),
  TypedReducer<bool?, FilterProjectsByState>((completer, action) => false),
  TypedReducer<bool?, FilterProjects>((completer, action) => false),
  TypedReducer<bool?, FilterProjectsByCustom1>((completer, action) => false),
  TypedReducer<bool?, FilterProjectsByCustom2>((completer, action) => false),
  TypedReducer<bool?, FilterProjectsByCustom3>((completer, action) => false),
  TypedReducer<bool?, FilterProjectsByCustom4>((completer, action) => false),
]);

final int? Function(int, dynamic) tabIndexReducer = combineReducers<int?>([
  TypedReducer<int?, UpdateProjectTab>((completer, action) {
    return action.tabIndex;
  }),
  TypedReducer<int?, PreviewEntity>((completer, action) {
    return 0;
  }),
]);

final saveCompleterReducer = combineReducers<Completer<SelectableEntity>?>([
  TypedReducer<Completer<SelectableEntity>?, EditProject>((completer, action) {
    return action.completer as Completer<SelectableEntity>?;
  }),
]);

final cancelCompleterReducer = combineReducers<Completer<Null>?>([
  TypedReducer<Completer<Null>?, EditProject>((completer, action) {
    return action.cancelCompleter as Completer<Null>?;
  }),
]);

Reducer<String?> selectedIdReducer = combineReducers([
  TypedReducer<String?, ArchiveProjectSuccess>((completer, action) => ''),
  TypedReducer<String?, DeleteProjectSuccess>((completer, action) => ''),
  TypedReducer<String?, PreviewEntity>((selectedId, action) =>
      action.entityType == EntityType.project ? action.entityId : selectedId),
  TypedReducer<String?, ViewProject>((selectedId, action) => action.projectId),
  TypedReducer<String?, AddProjectSuccess>(
      (selectedId, action) => action.project.id),
  TypedReducer<String?, SelectCompany>(
      (selectedId, action) => action.clearSelection ? '' : selectedId),
  TypedReducer<String?, ClearEntityFilter>((selectedId, action) => ''),
  TypedReducer<String?, SortProjects>((selectedId, action) => ''),
  TypedReducer<String?, FilterProjects>((selectedId, action) => ''),
  TypedReducer<String?, FilterProjectsByState>((selectedId, action) => ''),
  TypedReducer<String?, FilterProjectsByCustom1>((selectedId, action) => ''),
  TypedReducer<String?, FilterProjectsByCustom2>((selectedId, action) => ''),
  TypedReducer<String?, FilterProjectsByCustom3>((selectedId, action) => ''),
  TypedReducer<String?, FilterProjectsByCustom4>((selectedId, action) => ''),
  TypedReducer<String?, FilterByEntity>(
      (selectedId, action) => action.clearSelection
          ? ''
          : action.entityType == EntityType.project
              ? action.entityId
              : selectedId),
]);

final editingReducer = combineReducers<ProjectEntity?>([
  TypedReducer<ProjectEntity?, SaveProjectSuccess>(_updateEditing),
  TypedReducer<ProjectEntity?, AddProjectSuccess>(_updateEditing),
  TypedReducer<ProjectEntity?, RestoreProjectSuccess>((projects, action) {
    return action.projects[0];
  }),
  TypedReducer<ProjectEntity?, ArchiveProjectSuccess>((projects, action) {
    return action.projects[0];
  }),
  TypedReducer<ProjectEntity?, DeleteProjectSuccess>((projects, action) {
    return action.projects[0];
  }),
  TypedReducer<ProjectEntity?, EditProject>(_updateEditing),
  TypedReducer<ProjectEntity?, UpdateProject>((project, action) {
    return action.project.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<ProjectEntity?, DiscardChanges>(_clearEditing),
]);

ProjectEntity _clearEditing(ProjectEntity? project, dynamic dynamicAction) {
  return ProjectEntity();
}

ProjectEntity? _updateEditing(ProjectEntity? project, dynamic action) {
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
  TypedReducer<ListUIState, ViewProjectList>(_viewProjectList),
  TypedReducer<ListUIState, FilterByEntity>(
      (state, action) => state.rebuild((b) => b
        ..filter = null
        ..filterClearedAt = DateTime.now().millisecondsSinceEpoch)),
]);

ListUIState _viewProjectList(
    ListUIState projectListState, ViewProjectList action) {
  return projectListState.rebuild((b) => b
    ..selectedIds = null
    ..filter = null
    ..filterClearedAt = DateTime.now().millisecondsSinceEpoch);
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
    ..sortAscending = b.sortField != action.field || !b.sortAscending!
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState projectListState, StartProjectMultiselect action) {
  return projectListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState projectListState, AddToProjectMultiselect action) {
  return projectListState.rebuild((b) => b..selectedIds.add(action.entity!.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState projectListState, RemoveFromProjectMultiselect action) {
  return projectListState
      .rebuild((b) => b..selectedIds.remove(action.entity!.id));
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
  TypedReducer<ProjectState, ArchiveProjectSuccess>(_archiveProjectSuccess),
  TypedReducer<ProjectState, DeleteProjectSuccess>(_deleteProjectSuccess),
  TypedReducer<ProjectState, RestoreProjectSuccess>(_restoreProjectSuccess),
  TypedReducer<ProjectState, PurgeClientSuccess>(_purgeClientSuccess),
]);

ProjectState _purgeClientSuccess(
    ProjectState projectState, PurgeClientSuccess action) {
  final ids = projectState.map.values
      .where((each) => each.clientId == action.clientId)
      .map((each) => each.id)
      .toList();

  return projectState.rebuild((b) => b
    ..map.removeWhere((p0, p1) => ids.contains(p0))
    ..list.removeWhere((p0) => ids.contains(p0)));
}

ProjectState _archiveProjectSuccess(
    ProjectState projectState, ArchiveProjectSuccess action) {
  return projectState.rebuild((b) {
    for (final project in action.projects) {
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

ProjectState _restoreProjectSuccess(
    ProjectState projectState, RestoreProjectSuccess action) {
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
