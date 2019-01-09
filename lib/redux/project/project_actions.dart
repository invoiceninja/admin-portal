import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';

class ViewProjectList implements PersistUI {
  ViewProjectList(this.context);

  final BuildContext context;
}

class ViewProject implements PersistUI {
  ViewProject({this.projectId, this.context});

  final int projectId;
  final BuildContext context;
}

class EditProject implements PersistUI {
  EditProject({this.project, this.context, this.completer, this.trackRoute = true});

  final ProjectEntity project;
  final BuildContext context;
  final Completer completer;
  final bool trackRoute;
}

class UpdateProject implements PersistUI {
  UpdateProject(this.project);

  final ProjectEntity project;
}

class LoadProject {
  LoadProject({this.completer, this.projectId, this.loadActivities = false});

  final Completer completer;
  final int projectId;
  final bool loadActivities;
}

class LoadProjectActivity {
  LoadProjectActivity({this.completer, this.projectId});

  final Completer completer;
  final int projectId;
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
  SaveProjectFailure (this.error);

  final Object error;
}

class ArchiveProjectRequest implements StartSaving {
  ArchiveProjectRequest(this.completer, this.projectId);

  final Completer completer;
  final int projectId;
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
  final int projectId;
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
  final int projectId;
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

  final int entityId;
  final EntityType entityType;
}
