// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/repositories/task_status_repository.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/task_status/task_status_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/task_status/edit/task_status_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/task_status/task_status_screen.dart';
import 'package:invoiceninja_flutter/ui/task_status/view/task_status_view_vm.dart';

List<Middleware<AppState>> createStoreTaskStatusesMiddleware([
  TaskStatusRepository repository = const TaskStatusRepository(),
]) {
  final viewTaskStatusList = _viewTaskStatusList();
  final viewTaskStatus = _viewTaskStatus();
  final editTaskStatus = _editTaskStatus();
  final loadTaskStatuses = _loadTaskStatuses(repository);
  final loadTaskStatus = _loadTaskStatus(repository);
  final saveTaskStatus = _saveTaskStatus(repository);
  final archiveTaskStatus = _archiveTaskStatus(repository);
  final deleteTaskStatus = _deleteTaskStatus(repository);
  final restoreTaskStatus = _restoreTaskStatus(repository);

  return [
    TypedMiddleware<AppState, ViewTaskStatusList>(viewTaskStatusList),
    TypedMiddleware<AppState, ViewTaskStatus>(viewTaskStatus),
    TypedMiddleware<AppState, EditTaskStatus>(editTaskStatus),
    TypedMiddleware<AppState, LoadTaskStatuses>(loadTaskStatuses),
    TypedMiddleware<AppState, LoadTaskStatus>(loadTaskStatus),
    TypedMiddleware<AppState, SaveTaskStatusRequest>(saveTaskStatus),
    TypedMiddleware<AppState, ArchiveTaskStatusesRequest>(archiveTaskStatus),
    TypedMiddleware<AppState, DeleteTaskStatusesRequest>(deleteTaskStatus),
    TypedMiddleware<AppState, RestoreTaskStatusesRequest>(restoreTaskStatus),
  ];
}

Middleware<AppState> _editTaskStatus() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditTaskStatus?;

    next(action);

    store.dispatch(UpdateCurrentRoute(TaskStatusEditScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(TaskStatusEditScreen.route);
    }
  };
}

Middleware<AppState> _viewTaskStatus() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewTaskStatus?;

    next(action);

    store.dispatch(UpdateCurrentRoute(TaskStatusViewScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(TaskStatusViewScreen.route);
    }
  };
}

Middleware<AppState> _viewTaskStatusList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewTaskStatusList?;

    next(action);

    if (store.state.staticState.isStale) {
      store.dispatch(RefreshData());
    }

    store.dispatch(UpdateCurrentRoute(TaskStatusScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          TaskStatusScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _archiveTaskStatus(TaskStatusRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ArchiveTaskStatusesRequest;
    final prevTaskStatuses = action.taskStatusIds
        .map((id) => store.state.taskStatusState.map[id])
        .toList();
    repository
        .bulkAction(
            store.state.credentials, action.taskStatusIds, EntityAction.archive)
        .then((List<TaskStatusEntity> taskStatuses) {
      store.dispatch(ArchiveTaskStatusesSuccess(taskStatuses));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveTaskStatusesFailure(prevTaskStatuses));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _deleteTaskStatus(TaskStatusRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DeleteTaskStatusesRequest;
    final prevTaskStatuses = action.taskStatusIds
        .map((id) => store.state.taskStatusState.map[id])
        .toList();
    repository
        .bulkAction(
            store.state.credentials, action.taskStatusIds, EntityAction.delete)
        .then((List<TaskStatusEntity> taskStatuses) {
      store.dispatch(DeleteTaskStatusesSuccess(taskStatuses));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteTaskStatusesFailure(prevTaskStatuses));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _restoreTaskStatus(TaskStatusRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RestoreTaskStatusesRequest;
    final prevTaskStatuses = action.taskStatusIds
        .map((id) => store.state.taskStatusState.map[id])
        .toList();
    repository
        .bulkAction(
            store.state.credentials, action.taskStatusIds, EntityAction.restore)
        .then((List<TaskStatusEntity> taskStatuses) {
      store.dispatch(RestoreTaskStatusesSuccess(taskStatuses));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreTaskStatusesFailure(prevTaskStatuses));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _saveTaskStatus(TaskStatusRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveTaskStatusRequest;
    repository
        .saveData(store.state.credentials, action.taskStatus!)
        .then((TaskStatusEntity taskStatus) {
      if (action.taskStatus!.isNew) {
        store.dispatch(AddTaskStatusSuccess(taskStatus));
      } else {
        store.dispatch(SaveTaskStatusSuccess(taskStatus));
      }

      store.dispatch(RefreshData());
      action.completer!.complete(taskStatus);
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveTaskStatusFailure(error));
      action.completer!.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _loadTaskStatus(TaskStatusRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadTaskStatus;
    final AppState state = store.state;

    store.dispatch(LoadTaskStatusRequest());
    repository
        .loadItem(state.credentials, action.taskStatusId)
        .then((taskStatus) {
      store.dispatch(LoadTaskStatusSuccess(taskStatus));

      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadTaskStatusFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadTaskStatuses(TaskStatusRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadTaskStatuses?;
    final AppState state = store.state;

    store.dispatch(LoadTaskStatusesRequest());
    repository.loadList(state.credentials).then((data) {
      store.dispatch(LoadTaskStatusesSuccess(data));

      if (action!.completer != null) {
        action.completer!.complete(null);
      }
      /*
      if (state.productState.isStale) {
        store.dispatch(LoadProducts());
      }
      */
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadTaskStatusesFailure(error));
      if (action!.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}
