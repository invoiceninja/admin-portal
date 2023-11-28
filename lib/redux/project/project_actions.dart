// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ViewProjectList implements PersistUI {
  ViewProjectList({
    this.force = false,
    this.page = 0,
  });

  final bool force;
  final int? page;
}

class ViewProject implements PersistUI, PersistPrefs {
  ViewProject({
    required this.projectId,
    this.force = false,
  });

  final String? projectId;
  final bool force;
}

class EditProject implements PersistUI, PersistPrefs {
  EditProject(
      {required this.project,
      this.completer,
      this.cancelCompleter,
      this.force = false});

  final ProjectEntity project;
  final Completer? completer;
  final Completer? cancelCompleter;
  final bool force;
}

class UpdateProject implements PersistUI {
  UpdateProject(this.project);

  final ProjectEntity project;
}

class LoadProject {
  LoadProject({this.completer, this.projectId});

  final Completer? completer;
  final String? projectId;
}

class LoadProjectActivity {
  LoadProjectActivity({this.completer, this.projectId});

  final Completer? completer;
  final String? projectId;
}

class LoadProjects {
  LoadProjects({this.completer});

  final Completer? completer;
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

class LoadProjectsSuccess implements StopLoading {
  LoadProjectsSuccess(this.projects);

  final BuiltList<ProjectEntity> projects;

  @override
  String toString() {
    return 'LoadProjectsSuccess{projects: $projects}';
  }
}

class SaveProjectRequest implements StartSaving {
  SaveProjectRequest({this.completer, this.project});

  final Completer? completer;
  final ProjectEntity? project;
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

  final List<ProjectEntity?> projects;
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

  final List<ProjectEntity?> projects;
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

  final List<ProjectEntity?> projects;
}

class FilterProjects implements PersistUI {
  FilterProjects(this.filter);

  final String? filter;
}

class SortProjects implements PersistUI, PersistPrefs {
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

void handleProjectAction(
    BuildContext? context, List<BaseEntity> projects, EntityAction? action) {
  if (projects.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context!);
  final state = store.state;
  final project = projects.first as ProjectEntity;
  final projectIds = projects.map((project) => project.id).toList();
  final client = state.clientState.get(project.clientId);
  final localization = AppLocalization.of(context);

  switch (action) {
    case EntityAction.edit:
      editEntity(entity: project);
      break;
    case EntityAction.newTask:
      createEntity(
          entity: TaskEntity(state: state).rebuild((b) => b
            ..projectId = project.id
            ..clientId = project.clientId));
      break;
    case EntityAction.newInvoice:
      createEntity(
          entity: InvoiceEntity(state: state, client: client)
              .rebuild((b) => b..projectId = project.id));
      break;
    case EntityAction.newQuote:
      createEntity(
          entity: InvoiceEntity(
                  state: state, client: client, entityType: EntityType.quote)
              .rebuild((b) => b..projectId = project.id));
      break;
    case EntityAction.invoiceProject:
      String lastClientId = '';
      bool hasMultipleClients = false;
      projects.forEach((project) {
        final clientId = (project as ProjectEntity).clientId;
        if (clientId.isNotEmpty) {
          if (lastClientId.isNotEmpty && lastClientId != clientId) {
            hasMultipleClients = true;
          }
          lastClientId = clientId;
        }
      });
      if (hasMultipleClients) {
        showErrorDialog(message: localization!.multipleClientError);
        return;
      }

      final items = <InvoiceItemEntity>[];
      projects.forEach((project) {
        items.addAll(convertProjectToInvoiceItem(
            project: project as ProjectEntity?, context: context));
      });
      createEntity(
          entity: InvoiceEntity(state: state, client: client).rebuild((b) => b
            ..lineItems.addAll(items)
            ..projectId = project.id));
      break;
    case EntityAction.newExpense:
      createEntity(
          entity: ExpenseEntity(state: state, client: client)
              .rebuild((b) => b..projectId = project.id));
      break;
    case EntityAction.clone:
      createEntity(entity: project.clone);
      break;
    case EntityAction.restore:
      final message = projectIds.length > 1
          ? localization!.restoredProjects
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', projectIds.length.toString())
          : localization!.restoredProject;
      store.dispatch(
          RestoreProjectRequest(snackBarCompleter<Null>(message), projectIds));
      break;
    case EntityAction.archive:
      final message = projectIds.length > 1
          ? localization!.archivedProjects
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', projectIds.length.toString())
          : localization!.archivedProject;
      store.dispatch(
          ArchiveProjectRequest(snackBarCompleter<Null>(message), projectIds));
      break;
    case EntityAction.delete:
      final message = projectIds.length > 1
          ? localization!.deletedProjects
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', projectIds.length.toString())
          : localization!.deletedProject;
      store.dispatch(
          DeleteProjectRequest(snackBarCompleter<Null>(message), projectIds));
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
    case EntityAction.more:
      showEntityActionsDialog(
        entities: [project],
      );
      break;
    case EntityAction.documents:
      final documentIds = <String>[];
      for (var project in projects) {
        for (var document in (project as ProjectEntity).documents) {
          documentIds.add(document.id);
        }
      }
      if (documentIds.isEmpty) {
        showMessageDialog(message: localization!.noDocumentsToDownload);
      } else {
        store.dispatch(
          DownloadDocumentsRequest(
            documentIds: documentIds,
            completer: snackBarCompleter<Null>(
              localization!.exportedData,
            ),
          ),
        );
      }
      break;
    case EntityAction.runTemplate:
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => RunTemplateDialog(
          entityType: EntityType.project,
          entities: projects,
        ),
      );
      break;
    default:
      print('## Error: action $action not handled in project_actions');
  }
}

class StartProjectMultiselect {}

class AddToProjectMultiselect {
  AddToProjectMultiselect({required this.entity});

  final BaseEntity? entity;
}

class RemoveFromProjectMultiselect {
  RemoveFromProjectMultiselect({required this.entity});

  final BaseEntity? entity;
}

class ClearProjectMultiselect {}

class SaveProjectDocumentRequest implements StartSaving {
  SaveProjectDocumentRequest({
    required this.isPrivate,
    required this.completer,
    required this.multipartFile,
    required this.project,
  });

  final bool isPrivate;
  final Completer completer;
  final List<MultipartFile> multipartFile;
  final ProjectEntity project;
}

class SaveProjectDocumentSuccess implements StopSaving, PersistData, PersistUI {
  SaveProjectDocumentSuccess(this.document);

  final DocumentEntity document;
}

class SaveProjectDocumentFailure implements StopSaving {
  SaveProjectDocumentFailure(this.error);

  final Object error;
}

class UpdateProjectTab implements PersistUI {
  UpdateProjectTab({this.tabIndex});

  final int? tabIndex;
}
