import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/project/project_selectors.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ViewProjectList extends AbstractNavigatorAction implements PersistUI {
  ViewProjectList({@required NavigatorState navigator, this.force = false})
      : super(navigator: navigator);

  final bool force;
}

class ViewProject extends AbstractNavigatorAction
    implements PersistUI, PersistPrefs {
  ViewProject({
    @required this.projectId,
    @required NavigatorState navigator,
    this.force = false,
  }) : super(navigator: navigator);

  final String projectId;
  final bool force;
}

class EditProject extends AbstractNavigatorAction
    implements PersistUI, PersistPrefs {
  EditProject(
      {@required this.project,
      @required NavigatorState navigator,
      this.completer,
      this.cancelCompleter,
      this.force = false})
      : super(navigator: navigator);

  final ProjectEntity project;
  final Completer completer;
  final Completer cancelCompleter;
  final bool force;
}

class UpdateProject implements PersistUI {
  UpdateProject(this.project);

  final ProjectEntity project;
}

class LoadProject {
  LoadProject({this.completer, this.projectId});

  final Completer completer;
  final String projectId;
}

class LoadProjectActivity {
  LoadProjectActivity({this.completer, this.projectId});

  final Completer completer;
  final String projectId;
}

class LoadProjects {
  LoadProjects({this.completer, this.force = false});

  final Completer completer;
  final bool force;
}

class LoadProjectRequest implements StartLoading {}

class LoadProjectFailure implements StopLoading {
  LoadProjectFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadProjectFailure{error: $error}';
  }
}

class LoadProjectSuccess implements StopLoading, PersistData {
  LoadProjectSuccess(this.project);

  final ProjectEntity project;

  @override
  String toString() {
    return 'LoadProjectSuccess{project: $project}';
  }
}

class LoadProjectsRequest implements StartLoading {}

class LoadProjectsFailure implements StopLoading {
  LoadProjectsFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadProjectsFailure{error: $error}';
  }
}

class LoadProjectsSuccess implements StopLoading, PersistData {
  LoadProjectsSuccess(this.projects);

  final BuiltList<ProjectEntity> projects;

  @override
  String toString() {
    return 'LoadProjectsSuccess{projects: $projects}';
  }
}

class SaveProjectRequest implements StartSaving {
  SaveProjectRequest({this.completer, this.project});

  final Completer completer;
  final ProjectEntity project;
}

class SaveProjectSuccess implements StopSaving, PersistData, PersistUI {
  SaveProjectSuccess(this.project);

  final ProjectEntity project;
}

class AddProjectSuccess implements StopSaving, PersistData, PersistUI {
  AddProjectSuccess(this.project);

  final ProjectEntity project;
}

class SaveProjectFailure implements StopSaving {
  SaveProjectFailure(this.error);

  final Object error;
}

class ArchiveProjectRequest implements StartSaving {
  ArchiveProjectRequest(this.completer, this.projectIds);

  final Completer completer;
  final List<String> projectIds;
}

class ArchiveProjectSuccess implements StopSaving, PersistData {
  ArchiveProjectSuccess(this.projects);

  final List<ProjectEntity> projects;
}

class ArchiveProjectFailure implements StopSaving {
  ArchiveProjectFailure(this.projects);

  final List<ProjectEntity> projects;
}

class DeleteProjectRequest implements StartSaving {
  DeleteProjectRequest(this.completer, this.projectIds);

  final Completer completer;
  final List<String> projectIds;
}

class DeleteProjectSuccess implements StopSaving, PersistData {
  DeleteProjectSuccess(this.projects);

  final List<ProjectEntity> projects;
}

class DeleteProjectFailure implements StopSaving {
  DeleteProjectFailure(this.projects);

  final List<ProjectEntity> projects;
}

class RestoreProjectRequest implements StartSaving {
  RestoreProjectRequest(this.completer, this.projectIds);

  final Completer completer;
  final List<String> projectIds;
}

class RestoreProjectSuccess implements StopSaving, PersistData {
  RestoreProjectSuccess(this.projects);

  final List<ProjectEntity> projects;
}

class RestoreProjectFailure implements StopSaving {
  RestoreProjectFailure(this.projects);

  final List<ProjectEntity> projects;
}

class FilterProjects implements PersistUI {
  FilterProjects(this.filter);

  final String filter;
}

class SortProjects implements PersistUI {
  SortProjects(this.field);

  final String field;
}

class FilterProjectsByState implements PersistUI {
  FilterProjectsByState(this.state);

  final EntityState state;
}

class FilterProjectsByCustom1 implements PersistUI {
  FilterProjectsByCustom1(this.value);

  final String value;
}

class FilterProjectsByCustom2 implements PersistUI {
  FilterProjectsByCustom2(this.value);

  final String value;
}

class FilterProjectsByCustom3 implements PersistUI {
  FilterProjectsByCustom3(this.value);

  final String value;
}

class FilterProjectsByCustom4 implements PersistUI {
  FilterProjectsByCustom4(this.value);

  final String value;
}

class FilterProjectsByEntity implements PersistUI {
  FilterProjectsByEntity({this.entityId, this.entityType});

  final String entityId;
  final EntityType entityType;
}

void handleProjectAction(
    BuildContext context, List<BaseEntity> projects, EntityAction action) {
  assert(
      [
            EntityAction.restore,
            EntityAction.archive,
            EntityAction.delete,
            EntityAction.toggleMultiselect
          ].contains(action) ||
          projects.length == 1,
      'Cannot perform this action on more than one project');

  if (projects.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final project = projects.first as ProjectEntity;
  final projectIds = projects.map((project) => project.id).toList();

  switch (action) {
    case EntityAction.edit:
      editEntity(context: context, entity: project);
      break;
    case EntityAction.newTask:
      createEntity(
          context: context,
          entity: TaskEntity(state: state).rebuild((b) => b
            ..projectId = project.id
            ..clientId = project.clientId));
      break;
    case EntityAction.newInvoice:
      final items =
          convertProjectToInvoiceItem(project: project, context: context);
      createEntity(
          context: context,
          entity: InvoiceEntity(state: state).rebuild((b) => b
            ..hasTasks = true
            ..clientId = project.clientId
            ..lineItems.addAll(items)));
      break;
    case EntityAction.clone:
      createEntity(context: context, entity: project.clone);
      break;
    case EntityAction.restore:
      store.dispatch(RestoreProjectRequest(
          snackBarCompleter<Null>(
              context, AppLocalization.of(context).restoredProject),
          projectIds));
      break;
    case EntityAction.archive:
      store.dispatch(ArchiveProjectRequest(
          snackBarCompleter<Null>(
              context, AppLocalization.of(context).archivedProject),
          projectIds));
      break;
    case EntityAction.delete:
      store.dispatch(DeleteProjectRequest(
          snackBarCompleter<Null>(
              context, AppLocalization.of(context).deletedProject),
          projectIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.projectListState.isInMultiselect()) {
        store.dispatch(StartProjectMultiselect());
      }

      if (projects.isEmpty) {
        break;
      }

      for (final project in projects) {
        if (!store.state.projectListState.isSelected(project.id)) {
          store.dispatch(AddToProjectMultiselect(entity: project));
        } else {
          store.dispatch(RemoveFromProjectMultiselect(entity: project));
        }
      }
      break;
  }
}

class StartProjectMultiselect {}

class AddToProjectMultiselect {
  AddToProjectMultiselect({@required this.entity});

  final BaseEntity entity;
}

class RemoveFromProjectMultiselect {
  RemoveFromProjectMultiselect({@required this.entity});

  final BaseEntity entity;
}

class ClearProjectMultiselect {}
