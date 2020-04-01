import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/redux/app/app_middleware.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/task/task_screen.dart';
import 'package:invoiceninja_flutter/ui/task/edit/task_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/task/view/task_view_vm.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/repositories/task_repository.dart';

List<Middleware<AppState>> createStoreTasksMiddleware([
  TaskRepository repository = const TaskRepository(),
]) {
  final viewTaskList = _viewTaskList();
  final viewTask = _viewTask();
  final editTask = _editTask();
  final loadTasks = _loadTasks(repository);
  final loadTask = _loadTask(repository);
  final saveTask = _saveTask(repository);
  final archiveTask = _archiveTask(repository);
  final deleteTask = _deleteTask(repository);
  final restoreTask = _restoreTask(repository);

  return [
    TypedMiddleware<AppState, ViewTaskList>(viewTaskList),
    TypedMiddleware<AppState, ViewTask>(viewTask),
    TypedMiddleware<AppState, EditTask>(editTask),
    TypedMiddleware<AppState, LoadTasks>(loadTasks),
    TypedMiddleware<AppState, LoadTask>(loadTask),
    TypedMiddleware<AppState, SaveTaskRequest>(saveTask),
    TypedMiddleware<AppState, ArchiveTaskRequest>(archiveTask),
    TypedMiddleware<AppState, DeleteTaskRequest>(deleteTask),
    TypedMiddleware<AppState, RestoreTaskRequest>(restoreTask),
  ];
}

Middleware<AppState> _editTask() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditTask;

    if (!action.force &&
        hasChanges(store: store, context: action.context, action: action)) {
      return;
    }

    next(action);

    store.dispatch(UpdateCurrentRoute(TaskEditScreen.route));

    if (isMobile(action.context)) {
      action.navigator.pushNamed(TaskEditScreen.route);
    }
  };
}

Middleware<AppState> _viewTask() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewTask;

    if (!action.force &&
        hasChanges(store: store, context: action.context, action: action)) {
      return;
    }

    next(action);

    store.dispatch(UpdateCurrentRoute(TaskViewScreen.route));

    if (isMobile(action.context)) {
      action.navigator.pushNamed(TaskViewScreen.route);
    }
  };
}

Middleware<AppState> _viewTaskList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewTaskList;

    if (!action.force &&
        hasChanges(store: store, context: action.context, action: action)) {
      return;
    }

    next(action);

    if (store.state.taskState.isStale) {
      store.dispatch(LoadTasks());
    }

    store.dispatch(UpdateCurrentRoute(TaskScreen.route));

    if (isMobile(action.context)) {
      action.navigator.pushNamedAndRemoveUntil(
          TaskScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _archiveTask(TaskRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ArchiveTaskRequest;
    final prevTasks =
        action.taskIds.map((id) => store.state.taskState.map[id]).toList();

    repository
        .bulkAction(
            store.state.credentials, action.taskIds, EntityAction.archive)
        .then((List<TaskEntity> tasks) {
      store.dispatch(ArchiveTaskSuccess(tasks));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveTaskFailure(prevTasks));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _deleteTask(TaskRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DeleteTaskRequest;
    final prevTasks =
        action.taskIds.map((id) => store.state.taskState.map[id]).toList();

    repository
        .bulkAction(
            store.state.credentials, action.taskIds, EntityAction.delete)
        .then((List<TaskEntity> tasks) {
      store.dispatch(DeleteTaskSuccess(tasks));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteTaskFailure(prevTasks));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _restoreTask(TaskRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RestoreTaskRequest;
    final prevTasks =
        action.taskIds.map((id) => store.state.taskState.map[id]).toList();

    repository
        .bulkAction(
            store.state.credentials, action.taskIds, EntityAction.restore)
        .then((List<TaskEntity> tasks) {
      store.dispatch(RestoreTaskSuccess(tasks));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreTaskFailure(prevTasks));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _saveTask(TaskRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveTaskRequest;
    repository
        .saveData(store.state.credentials, action.task)
        .then((TaskEntity task) {
      if (action.task.isNew) {
        store.dispatch(AddTaskSuccess(task));
      } else {
        store.dispatch(SaveTaskSuccess(task));
      }
      action.completer.complete(task);
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveTaskFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _loadTask(TaskRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadTask;
    final AppState state = store.state;

    if (state.isLoading) {
      next(action);
      return;
    }

    store.dispatch(LoadTaskRequest());
    repository.loadItem(state.credentials, action.taskId).then((task) {
      store.dispatch(LoadTaskSuccess(task));

      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadTaskFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadTasks(TaskRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadTasks;
    final AppState state = store.state;

    if (!state.taskState.isStale && !action.force) {
      next(action);
      return;
    }

    if (state.isLoading) {
      next(action);
      return;
    }

    final int updatedAt = (state.taskState.lastUpdated / 1000).round();

    store.dispatch(LoadTasksRequest());
    repository.loadList(store.state.credentials, updatedAt).then((data) {
      store.dispatch(LoadTasksSuccess(data));

      if (action.completer != null) {
        action.completer.complete(null);
      }
      if (state.vendorState.isStale) {
        store.dispatch(LoadVendors());
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadTasksFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}
