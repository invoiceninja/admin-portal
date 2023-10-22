// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';

// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/repositories/task_repository.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/ui/task/edit/task_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/task/task_screen.dart';
import 'package:invoiceninja_flutter/ui/task/view/task_view_vm.dart';

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
  final startTask = _startTask(repository);
  final stopTask = _stopTask(repository);
  final deleteTask = _deleteTask(repository);
  final restoreTask = _restoreTask(repository);
  final saveDocument = _saveDocument(repository);
  final sortTasks = _sortTasks(repository);

  return [
    TypedMiddleware<AppState, ViewTaskList>(viewTaskList),
    TypedMiddleware<AppState, ViewTask>(viewTask),
    TypedMiddleware<AppState, EditTask>(editTask),
    TypedMiddleware<AppState, LoadTasks>(loadTasks),
    TypedMiddleware<AppState, LoadTask>(loadTask),
    TypedMiddleware<AppState, SaveTaskRequest>(saveTask),
    TypedMiddleware<AppState, ArchiveTaskRequest>(archiveTask),
    TypedMiddleware<AppState, StartTasksRequest>(startTask),
    TypedMiddleware<AppState, StopTasksRequest>(stopTask),
    TypedMiddleware<AppState, DeleteTaskRequest>(deleteTask),
    TypedMiddleware<AppState, RestoreTaskRequest>(restoreTask),
    TypedMiddleware<AppState, SaveTaskDocumentRequest>(saveDocument),
    TypedMiddleware<AppState, SortTasksRequest>(sortTasks),
  ];
}

Middleware<AppState> _editTask() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditTask?;

    next(action);

    store.dispatch(UpdateCurrentRoute(TaskEditScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(TaskEditScreen.route);
    }
  };
}

Middleware<AppState> _viewTask() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewTask?;

    next(action);

    store.dispatch(UpdateCurrentRoute(TaskViewScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(TaskViewScreen.route);
    }
  };
}

Middleware<AppState> _viewTaskList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewTaskList?;

    next(action);

    if (store.state.isStale) {
      store.dispatch(RefreshData());
    }

    store.dispatch(UpdateCurrentRoute(TaskScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
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
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveTaskFailure(prevTasks));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _startTask(TaskRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as StartTasksRequest;
    final prevTasks =
        action.taskIds.map((id) => store.state.taskState.map[id]).toList();

    repository
        .bulkAction(store.state.credentials, action.taskIds, EntityAction.start)
        .then((List<TaskEntity> tasks) {
      store.dispatch(StartTasksSuccess(tasks));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(StartTasksFailure(prevTasks));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _stopTask(TaskRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as StopTasksRequest;
    final prevTasks =
        action.taskIds.map((id) => store.state.taskState.map[id]).toList();

    repository
        .bulkAction(store.state.credentials, action.taskIds, EntityAction.stop)
        .then((List<TaskEntity> tasks) {
      store.dispatch(StopTasksSuccess(tasks));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(StopTasksFailure(prevTasks));
      action.completer.completeError(error);
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
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteTaskFailure(prevTasks));
      action.completer.completeError(error);
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
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreTaskFailure(prevTasks));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _saveTask(TaskRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveTaskRequest;
    repository
        .saveData(store.state.credentials, action.task!, action: action.action)
        .then((TaskEntity task) {
      if (action.task!.isNew) {
        store.dispatch(
            AddTaskSuccess(task: task, autoSelect: action.autoSelect));
      } else {
        store.dispatch(SaveTaskSuccess(task));
      }
      action.completer!.complete(task);
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveTaskFailure(error));
      action.completer!.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _loadTask(TaskRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadTask;
    final AppState state = store.state;

    store.dispatch(LoadTaskRequest());
    repository.loadItem(state.credentials, action.taskId).then((task) {
      store.dispatch(LoadTaskSuccess(task));

      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadTaskFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadTasks(TaskRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadTasks;
    final state = store.state;

    store.dispatch(LoadTasksRequest());
    repository
        .loadList(
      state.credentials,
      action.page,
      state.createdAtLimit,
      state.filterDeletedClients,
    )
        .then((data) {
      store.dispatch(LoadTasksSuccess(data));

      final documents = <DocumentEntity>[];
      data.forEach((task) {
        task.documents.forEach((document) {
          documents.add(document.rebuild((b) => b
            ..parentId = task.id
            ..parentType = EntityType.task));
        });
      });
      store.dispatch(LoadDocumentsSuccess(documents));

      if (data.length == kMaxRecordsPerPage) {
        store.dispatch(LoadTasks(
          completer: action.completer,
          page: action.page + 1,
        ));
      } else {
        if (action.completer != null) {
          action.completer!.complete(null);
        }
        store.dispatch(LoadVendors());
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadTasksFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _saveDocument(TaskRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveTaskDocumentRequest?;
    if (store.state.isEnterprisePlan) {
      repository
          .uploadDocument(
        store.state.credentials,
        action!.task,
        action.multipartFiles,
        action.isPrivate,
      )
          .then((task) {
        store.dispatch(SaveTaskSuccess(task));

        final documents = <DocumentEntity>[];
        task.documents.forEach((document) {
          documents.add(document.rebuild((b) => b
            ..parentId = task.id
            ..parentType = EntityType.task));
        });
        store.dispatch(LoadDocumentsSuccess(documents));
        action.completer.complete(documents);
      }).catchError((Object error) {
        print(error);
        store.dispatch(SaveTaskDocumentFailure(error));
        action.completer.completeError(error);
      });
    } else {
      const error = 'Uploading documents requires an enterprise plan';
      store.dispatch(SaveTaskDocumentFailure(error));
      action!.completer.completeError(error);
    }

    next(action);
  };
}

Middleware<AppState> _sortTasks(TaskRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SortTasksRequest;

    repository
        .sortTasks(store.state.credentials, action.statusIds, action.taskIds)
        .then((_) {
      store.dispatch(SortTasksSuccess(
        statusIds: action.statusIds,
        taskIds: action.taskIds,
      ));
      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(SortTasksFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}
