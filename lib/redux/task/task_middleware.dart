import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
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
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);

    store.dispatch(UpdateCurrentRoute(TaskEditScreen.route));
    final task =
        await Navigator.of(action.context).pushNamed(TaskEditScreen.route);

    if (action.completer != null && task != null) {
      action.completer.complete(task);
    }
  };
}

Middleware<AppState> _viewTask() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);

    store.dispatch(UpdateCurrentRoute(TaskViewScreen.route));
    Navigator.of(action.context).pushNamed(TaskViewScreen.route);
  };
}

Middleware<AppState> _viewTaskList() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    next(action);

    store.dispatch(UpdateCurrentRoute(TaskScreen.route));

    Navigator.of(action.context).pushNamedAndRemoveUntil(TaskScreen.route, (Route<dynamic> route) => false);
  };
}

Middleware<AppState> _archiveTask(TaskRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    final origTask = store.state.taskState.map[action.taskId];
    repository
        .saveData(store.state.selectedCompany, store.state.authState,
            origTask, EntityAction.archive)
        .then((TaskEntity task) {
      store.dispatch(ArchiveTaskSuccess(task));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveTaskFailure(origTask));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _deleteTask(TaskRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    final origTask = store.state.taskState.map[action.taskId];
    repository
        .saveData(store.state.selectedCompany, store.state.authState,
            origTask, EntityAction.delete)
        .then((TaskEntity task) {
      store.dispatch(DeleteTaskSuccess(task));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteTaskFailure(origTask));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _restoreTask(TaskRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    final origTask = store.state.taskState.map[action.taskId];
    repository
        .saveData(store.state.selectedCompany, store.state.authState,
            origTask, EntityAction.restore)
        .then((TaskEntity task) {
      store.dispatch(RestoreTaskSuccess(task));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreTaskFailure(origTask));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _saveTask(TaskRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    repository
        .saveData(
            store.state.selectedCompany, store.state.authState, action.task)
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
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    final AppState state = store.state;

    if (state.isLoading) {
      next(action);
      return;
    }

    store.dispatch(LoadTaskRequest());
    repository
        .loadItem(state.selectedCompany, state.authState, action.taskId)
        .then((task) {
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
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
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
    repository
        .loadList(state.selectedCompany, state.authState, updatedAt)
        .then((data) {
      store.dispatch(LoadTasksSuccess(data));

      if (action.completer != null) {
        action.completer.complete(null);
      }
      if (state.productState.isStale) {
        store.dispatch(LoadProducts());
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
