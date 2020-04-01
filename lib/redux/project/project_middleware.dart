import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/redux/app/app_middleware.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/project/project_screen.dart';
import 'package:invoiceninja_flutter/ui/project/edit/project_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/project/view/project_view_vm.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/repositories/project_repository.dart';

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
  ];
}

Middleware<AppState> _editProject() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditProject;

    if (!action.force &&
        hasChanges(store: store, context: action.context, action: action)) {
      return;
    }

    next(action);

    store.dispatch(UpdateCurrentRoute(ProjectEditScreen.route));

    if (isMobile(action.context)) {
      action.navigator.pushNamed(ProjectEditScreen.route);
    }
  };
}

Middleware<AppState> _viewProject() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewProject;

    if (!action.force &&
        hasChanges(store: store, context: action.context, action: action)) {
      return;
    }

    next(action);

    store.dispatch(UpdateCurrentRoute(ProjectViewScreen.route));

    if (isMobile(action.context)) {
      action.navigator.pushNamed(ProjectViewScreen.route);
    }
  };
}

Middleware<AppState> _viewProjectList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewProjectList;

    if (!action.force &&
        hasChanges(store: store, context: action.context, action: action)) {
      return;
    }

    next(action);

    if (store.state.projectState.isStale) {
      store.dispatch(LoadProjects());
    }

    store.dispatch(UpdateCurrentRoute(ProjectScreen.route));

    if (isMobile(action.context)) {
      action.navigator.pushNamedAndRemoveUntil(
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
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveProjectFailure(prevProjects));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
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
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteProjectFailure(prevProjects));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
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
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreProjectFailure(prevProjects));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _saveProject(ProjectRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveProjectRequest;
    repository
        .saveData(store.state.credentials, action.project)
        .then((ProjectEntity project) {
      if (action.project.isNew) {
        store.dispatch(AddProjectSuccess(project));
      } else {
        store.dispatch(SaveProjectSuccess(project));
      }

      action.completer.complete(project);

      final projectUIState = store.state.projectUIState;
      if (projectUIState.saveCompleter != null) {
        projectUIState.saveCompleter.complete(project);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveProjectFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _loadProject(ProjectRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadProject;
    final AppState state = store.state;

    if (state.isLoading) {
      next(action);
      return;
    }

    store.dispatch(LoadProjectRequest());
    repository
        .loadItem(store.state.credentials, action.projectId)
        .then((project) {
      store.dispatch(LoadProjectSuccess(project));

      if (action.completer != null) {
        action.completer.complete(null);
      }
      if (state.clientState.isStale) {
        store.dispatch(LoadClients());
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadProjectFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadProjects(ProjectRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadProjects;
    final AppState state = store.state;

    if (!state.projectState.isStale && !action.force) {
      next(action);
      return;
    }

    if (state.isLoading) {
      next(action);
      return;
    }

    final int updatedAt = (state.projectState.lastUpdated / 1000).round();

    store.dispatch(LoadProjectsRequest());
    repository.loadList(store.state.credentials, updatedAt).then((data) {
      store.dispatch(LoadProjectsSuccess(data));

      if (action.completer != null) {
        action.completer.complete(null);
      }
      if (state.taskState.isStale) {
        store.dispatch(LoadTasks());
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadProjectsFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}
