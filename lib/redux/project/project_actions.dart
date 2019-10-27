import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_selectors.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ViewProjectList implements PersistUI {
  ViewProjectList({@required this.context, this.force = false});

  final BuildContext context;
  final bool force;
}

class ViewProject implements PersistUI {
  ViewProject({
    @required this.projectId,
    @required this.context,
    this.force = false,
  });

  final String projectId;
  final BuildContext context;
  final bool force;
}

class EditProject implements PersistUI {
  EditProject(
      {@required this.project,
      @required this.context,
      this.completer,
      this.cancelCompleter,
      this.force = false});

  final ProjectEntity project;
  final BuildContext context;
  final Completer completer;
  final Completer cancelCompleter;
  final bool force;
}

class UpdateProject implements PersistUI {
  UpdateProject(this.project);

  final ProjectEntity project;
}

class LoadProject {
  LoadProject({this.completer, this.projectId, this.loadActivities = false});

  final Completer completer;
  final String projectId;
  final bool loadActivities;
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
  ArchiveProjectRequest(this.completer, this.projectId);

  final Completer completer;
  final String projectId;
}

class ArchiveProjectSuccess implements StopSaving, PersistData {
  ArchiveProjectSuccess(this.project);

  final ProjectEntity project;
}

class ArchiveProjectFailure implements StopSaving {
  ArchiveProjectFailure(this.project);

  final ProjectEntity project;
}

class DeleteProjectRequest implements StartSaving {
  DeleteProjectRequest(this.completer, this.projectId);

  final Completer completer;
  final String projectId;
}

class DeleteProjectSuccess implements StopSaving, PersistData {
  DeleteProjectSuccess(this.project);

  final ProjectEntity project;
}

class DeleteProjectFailure implements StopSaving {
  DeleteProjectFailure(this.project);

  final ProjectEntity project;
}

class RestoreProjectRequest implements StartSaving {
  RestoreProjectRequest(this.completer, this.projectId);

  final Completer completer;
  final String projectId;
}

class RestoreProjectSuccess implements StopSaving, PersistData {
  RestoreProjectSuccess(this.project);

  final ProjectEntity project;
}

class RestoreProjectFailure implements StopSaving {
  RestoreProjectFailure(this.project);

  final ProjectEntity project;
}

class FilterProjects {
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

  final store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final CompanyEntity company = state.selectedCompany;
  final project = projects.first as ProjectEntity;

  switch (action) {
    case EntityAction.edit:
      store.dispatch(EditProject(context: context, project: project));
      break;
    case EntityAction.newTask:
      store.dispatch(EditTask(
          task: TaskEntity(isRunning: state.uiState.autoStartTasks)
              .rebuild((b) => b
                ..projectId = project.id
                ..clientId = project.clientId),
          context: context));
      break;
    case EntityAction.newInvoice:
      final items =
          convertProjectToInvoiceItem(project: project, context: context);
      store.dispatch(EditInvoice(
          invoice: InvoiceEntity(company: company).rebuild((b) => b
            ..hasTasks = true
            ..clientId = project.clientId
            ..invoiceItems.addAll(items)),
          context: context));
      break;
    case EntityAction.clone:
      store.dispatch(EditProject(context: context, project: project.clone));
      break;
    case EntityAction.restore:
      store.dispatch(RestoreProjectRequest(
          snackBarCompleter(
              context, AppLocalization.of(context).restoredProject),
          project.id));
      break;
    case EntityAction.archive:
      store.dispatch(ArchiveProjectRequest(
          snackBarCompleter(
              context, AppLocalization.of(context).archivedProject),
          project.id));
      break;
    case EntityAction.delete:
      store.dispatch(DeleteProjectRequest(
          snackBarCompleter(
              context, AppLocalization.of(context).deletedProject),
          project.id));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.projectListState.isInMultiselect()) {
        store.dispatch(StartProjectMultiselect(context: context));
      }

      if (projects.isEmpty) {
        break;
      }

      for (final project in projects) {
        if (!store.state.projectListState.isSelected(project.id)) {
          store.dispatch(
              AddToProjectMultiselect(context: context, entity: project));
        } else {
          store.dispatch(
              RemoveFromProjectMultiselect(context: context, entity: project));
        }
      }
      break;
  }
}

class StartProjectMultiselect {
  StartProjectMultiselect({@required this.context});

  final BuildContext context;
}

class AddToProjectMultiselect {
  AddToProjectMultiselect({@required this.context, @required this.entity});

  final BuildContext context;
  final BaseEntity entity;
}

class RemoveFromProjectMultiselect {
  RemoveFromProjectMultiselect({@required this.context, @required this.entity});

  final BuildContext context;
  final BaseEntity entity;
}

class ClearProjectMultiselect {
  ClearProjectMultiselect({@required this.context});

  final BuildContext context;
}
