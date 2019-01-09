import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
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
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);

    if (action.trackRoute) {
      store.dispatch(UpdateCurrentRoute(ProjectEditScreen.route));
    }

    final project =
        await Navigator.of(action.context).pushNamed(ProjectEditScreen.route);

    if (action.completer != null && project != null) {
      action.completer.complete(project);
    }
  };
}

Middleware<AppState> _viewProject() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);

    store.dispatch(UpdateCurrentRoute(ProjectViewScreen.route));
    Navigator.of(action.context).pushNamed(ProjectViewScreen.route);
  };
}

Middleware<AppState> _viewProjectList() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    next(action);

    store.dispatch(UpdateCurrentRoute(ProjectScreen.route));

    Navigator.of(action.context).pushNamedAndRemoveUntil(ProjectScreen.route, (Route<dynamic> route) => false);
  };
}

Middleware<AppState> _archiveProject(ProjectRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    final origProject = store.state.projectState.map[action.projectId];
    repository
        .saveData(store.state.selectedCompany, store.state.authState,
            origProject, EntityAction.archive)
        .then((ProjectEntity project) {
      store.dispatch(ArchiveProjectSuccess(project));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveProjectFailure(origProject));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _deleteProject(ProjectRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    final origProject = store.state.projectState.map[action.projectId];
    repository
        .saveData(store.state.selectedCompany, store.state.authState,
            origProject, EntityAction.delete)
        .then((ProjectEntity project) {
      store.dispatch(DeleteProjectSuccess(project));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteProjectFailure(origProject));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _restoreProject(ProjectRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    final origProject = store.state.projectState.map[action.projectId];
    repository
        .saveData(store.state.selectedCompany, store.state.authState,
            origProject, EntityAction.restore)
        .then((ProjectEntity project) {
      store.dispatch(RestoreProjectSuccess(project));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreProjectFailure(origProject));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _saveProject(ProjectRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    repository
        .saveData(
            store.state.selectedCompany, store.state.authState, action.project)
        .then((ProjectEntity project) {
      if (action.project.isNew) {
        store.dispatch(AddProjectSuccess(project));
      } else {
        store.dispatch(SaveProjectSuccess(project));
      }
      action.completer.complete(project);
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveProjectFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _loadProject(ProjectRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    final AppState state = store.state;

    if (state.isLoading) {
      next(action);
      return;
    }

    store.dispatch(LoadProjectRequest());
    repository
        .loadItem(state.selectedCompany, state.authState, action.projectId)
        .then((project) {
      store.dispatch(LoadProjectSuccess(project));

      if (action.completer != null) {
        action.completer.complete(null);
      }
      if (state.dashboardState.isStale) {
        store.dispatch(LoadDashboard());
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
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
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
    repository
        .loadList(state.selectedCompany, state.authState, updatedAt)
        .then((data) {
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
