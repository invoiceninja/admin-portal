// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';

// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/repositories/project_repository.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/project/edit/project_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/project/project_screen.dart';
import 'package:invoiceninja_flutter/ui/project/view/project_view_vm.dart';

List<Middleware<AppState>> createStoreProjectsMiddleware([
  ProjectRepository repository = const ProjectRepository(),
]) {
  final viewProjectList = _viewProjectList();
  final viewProject = _viewProject();
  final editProject = _editProject();
  final loadProjects = _loadProjects(repository);
  final loadProject = _loadProject(repository);
  final saveProject = _saveProject(repository);
  final archiveProject = _archiveProject(repository);
  final deleteProject = _deleteProject(repository);
  final restoreProject = _restoreProject(repository);
  final saveDocument = _saveDocument(repository);

  return [
    TypedMiddleware<AppState, ViewProjectList>(viewProjectList),
    TypedMiddleware<AppState, ViewProject>(viewProject),
    TypedMiddleware<AppState, EditProject>(editProject),
    TypedMiddleware<AppState, LoadProjects>(loadProjects),
    TypedMiddleware<AppState, LoadProject>(loadProject),
    TypedMiddleware<AppState, SaveProjectRequest>(saveProject),
    TypedMiddleware<AppState, ArchiveProjectRequest>(archiveProject),
    TypedMiddleware<AppState, DeleteProjectRequest>(deleteProject),
    TypedMiddleware<AppState, RestoreProjectRequest>(restoreProject),
    TypedMiddleware<AppState, SaveProjectDocumentRequest>(saveDocument),
  ];
}

Middleware<AppState> _editProject() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditProject?;

    next(action);

    store.dispatch(UpdateCurrentRoute(ProjectEditScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(ProjectEditScreen.route);
    }
  };
}

Middleware<AppState> _viewProject() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewProject?;

    next(action);

    store.dispatch(UpdateCurrentRoute(ProjectViewScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(ProjectViewScreen.route);
    }
  };
}

Middleware<AppState> _viewProjectList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewProjectList?;

    next(action);

    if (store.state.isStale) {
      store.dispatch(RefreshData());
    }

    store.dispatch(UpdateCurrentRoute(ProjectScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          ProjectScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _archiveProject(ProjectRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ArchiveProjectRequest;
    final prevProjects = action.projectIds
        .map((id) => store.state.projectState.map[id])
        .toList();

    repository
        .bulkAction(
            store.state.credentials, action.projectIds, EntityAction.archive)
        .then((List<ProjectEntity> projects) {
      store.dispatch(ArchiveProjectSuccess(projects));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveProjectFailure(prevProjects));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _deleteProject(ProjectRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DeleteProjectRequest;
    final prevProjects = action.projectIds
        .map((id) => store.state.projectState.map[id])
        .toList();

    repository
        .bulkAction(
            store.state.credentials, action.projectIds, EntityAction.delete)
        .then((List<ProjectEntity> projects) {
      store.dispatch(DeleteProjectSuccess(projects));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteProjectFailure(prevProjects));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _restoreProject(ProjectRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RestoreProjectRequest;
    final prevProjects = action.projectIds
        .map((id) => store.state.projectState.map[id])
        .toList();

    repository
        .bulkAction(
            store.state.credentials, action.projectIds, EntityAction.restore)
        .then((List<ProjectEntity> projects) {
      store.dispatch(RestoreProjectSuccess(projects));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreProjectFailure(prevProjects));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _saveProject(ProjectRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveProjectRequest;
    repository
        .saveData(store.state.credentials, action.project!)
        .then((ProjectEntity project) {
      if (action.project!.isNew) {
        store.dispatch(AddProjectSuccess(project));
      } else {
        store.dispatch(SaveProjectSuccess(project));
      }

      action.completer!.complete(project);

      final projectUIState = store.state.projectUIState;
      if (projectUIState.saveCompleter != null) {
        projectUIState.saveCompleter!.complete(project);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveProjectFailure(error));
      action.completer!.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _loadProject(ProjectRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadProject;

    store.dispatch(LoadProjectRequest());
    repository
        .loadItem(store.state.credentials, action.projectId)
        .then((project) {
      store.dispatch(LoadProjectSuccess(project));

      if (action.completer != null) {
        action.completer!.complete(null);
      }
      //store.dispatch(LoadClients());
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadProjectFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadProjects(ProjectRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadProjects?;
    final state = store.state;

    store.dispatch(LoadProjectsRequest());
    repository
        .loadList(
      state.credentials,
      state.filterDeletedClients,
    )
        .then((data) {
      store.dispatch(LoadProjectsSuccess(data));

      final documents = <DocumentEntity>[];
      data.forEach((project) {
        project.documents.forEach((document) {
          documents.add(document.rebuild((b) => b
            ..parentId = project.id
            ..parentType = EntityType.project));
        });
      });
      store.dispatch(LoadDocumentsSuccess(documents));

      if (action!.completer != null) {
        action.completer!.complete(null);
      }
      store.dispatch(LoadTasks());
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadProjectsFailure(error));
      if (action!.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _saveDocument(ProjectRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveProjectDocumentRequest?;
    if (store.state.isEnterprisePlan) {
      repository
          .uploadDocuments(
        store.state.credentials,
        action!.project,
        action.multipartFile,
        action.isPrivate,
      )
          .then((project) {
        store.dispatch(SaveProjectSuccess(project));

        final documents = <DocumentEntity>[];
        project.documents.forEach((document) {
          documents.add(document.rebuild((b) => b
            ..parentId = project.id
            ..parentType = EntityType.project));
        });
        store.dispatch(LoadDocumentsSuccess(documents));
        action.completer.complete(documents);
      }).catchError((Object error) {
        print(error);
        store.dispatch(SaveProjectDocumentFailure(error));
        action.completer.completeError(error);
      });
    } else {
      const error = 'Uploading documents requires an enterprise plan';
      store.dispatch(SaveProjectDocumentFailure(error));
      action!.completer.completeError(error);
    }

    next(action);
  };
}
