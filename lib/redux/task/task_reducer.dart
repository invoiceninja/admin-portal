// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_state.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

EntityUIState taskUIReducer(TaskUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(taskListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action)!)
    ..editingTimeIndex = editingTimeReducer(state.editingTimeIndex, action)
    ..selectedId = selectedIdReducer(state.selectedId, action)
    ..forceSelected = forceSelectedReducer(state.forceSelected, action)
    ..tabIndex = tabIndexReducer(state.tabIndex, action)
    ..kanbanLastUpdated =
        kanbanLastUpdatedReducer(state.kanbanLastUpdated, action));
}

final forceSelectedReducer = combineReducers<bool?>([
  TypedReducer<bool?, ViewTask>((completer, action) => true),
  TypedReducer<bool?, ViewTaskList>((completer, action) => false),
  TypedReducer<bool?, FilterTasksByState>((completer, action) => false),
  TypedReducer<bool?, FilterTasksByStatus>((completer, action) => false),
  TypedReducer<bool?, FilterTasks>((completer, action) => false),
  TypedReducer<bool?, FilterTasksByCustom1>((completer, action) => false),
  TypedReducer<bool?, FilterTasksByCustom2>((completer, action) => false),
  TypedReducer<bool?, FilterTasksByCustom3>((completer, action) => false),
  TypedReducer<bool?, FilterTasksByCustom4>((completer, action) => false),
]);

final int? Function(int, dynamic) tabIndexReducer = combineReducers<int?>([
  TypedReducer<int?, UpdateTaskTab>((completer, action) {
    return action.tabIndex;
  }),
  TypedReducer<int?, PreviewEntity>((completer, action) {
    return 0;
  }),
]);

final kanbanLastUpdatedReducer = combineReducers<int?>([
  TypedReducer<int?, UpdateKanban>((completer, action) {
    return DateTime.now().millisecondsSinceEpoch;
  }),
]);

final editingTimeReducer = combineReducers<int?>([
  TypedReducer<int?, EditTask>((index, action) => action.taskTimeIndex),
  TypedReducer<int?, EditTaskTime>((index, action) => action.taskTimeIndex),

  /*
  TypedReducer<int, EditInvoice>((index, action) => action.invoiceItemIndex),
  TypedReducer<int, EditInvoiceItem>(
          (index, action) => action.invoiceItemIndex),
          
   */
]);

/*
TaskTime editTaskTime(TaskTime taskTime, dynamic action) {
  return action.taskTime ?? TaskTime(startDate: DateTime(2000).toUtc());
}
 */

Reducer<String?> selectedIdReducer = combineReducers([
  TypedReducer<String?, ArchiveTaskSuccess>((completer, action) => ''),
  TypedReducer<String?, DeleteTaskSuccess>((completer, action) => ''),
  TypedReducer<String?, PreviewEntity>((selectedId, action) =>
      action.entityType == EntityType.task ? action.entityId : selectedId),
  TypedReducer<String?, ViewTask>((selectedId, action) => action.taskId),
  TypedReducer<String?, AddTaskSuccess>((selectedId, action) =>
      selectedId!.isNotEmpty || action.autoSelect ? action.task.id : ''),
  TypedReducer<String?, SelectCompany>(
      (selectedId, action) => action.clearSelection ? '' : selectedId),
  TypedReducer<String?, ClearEntityFilter>((selectedId, action) => ''),
  TypedReducer<String?, SortTasks>((selectedId, action) => ''),
  TypedReducer<String?, FilterTasks>((selectedId, action) => ''),
  TypedReducer<String?, FilterTasksByState>((selectedId, action) => ''),
  TypedReducer<String?, FilterTasksByStatus>((selectedId, action) => ''),
  TypedReducer<String?, FilterTasksByCustom1>((selectedId, action) => ''),
  TypedReducer<String?, FilterTasksByCustom2>((selectedId, action) => ''),
  TypedReducer<String?, FilterTasksByCustom3>((selectedId, action) => ''),
  TypedReducer<String?, FilterTasksByCustom4>((selectedId, action) => ''),
]);

final editingReducer = combineReducers<TaskEntity?>([
  TypedReducer<TaskEntity?, SaveTaskSuccess>(_updateEditing),
  TypedReducer<TaskEntity?, AddTaskSuccess>(_updateEditing),
  TypedReducer<TaskEntity?, RestoreTaskSuccess>((tasks, action) {
    return action.tasks[0];
  }),
  TypedReducer<TaskEntity?, ArchiveTaskSuccess>((tasks, action) {
    return action.tasks[0];
  }),
  TypedReducer<TaskEntity?, StartTasksSuccess>((tasks, action) {
    return action.tasks[0];
  }),
  TypedReducer<TaskEntity?, StopTasksSuccess>((tasks, action) {
    return action.tasks[0];
  }),
  TypedReducer<TaskEntity?, DeleteTaskSuccess>((tasks, action) {
    return action.tasks[0];
  }),
  TypedReducer<TaskEntity?, EditTask>(_updateEditing),
  TypedReducer<TaskEntity?, UpdateTask>((task, action) {
    return action.task.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<TaskEntity?, AddTaskTime>(_addTaskTime),
  TypedReducer<TaskEntity?, DeleteTaskTime>(_removeTaskTime),
  TypedReducer<TaskEntity?, UpdateTaskTime>(_updateTaskTime),
  TypedReducer<TaskEntity?, DiscardChanges>(_clearEditing),
]);

TaskEntity _clearEditing(TaskEntity? task, dynamic action) {
  return TaskEntity();
}

TaskEntity? _updateEditing(TaskEntity? task, dynamic action) {
  return action.task;
}

final taskListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortTasks>(_sortTasks),
  TypedReducer<ListUIState, FilterTasksByState>(_filterTasksByState),
  TypedReducer<ListUIState, FilterTasksByStatus>(_filterTasksByStatus),
  TypedReducer<ListUIState, FilterTasks>(_filterTasks),
  TypedReducer<ListUIState, FilterTasksByCustom1>(_filterTasksByCustom1),
  TypedReducer<ListUIState, FilterTasksByCustom2>(_filterTasksByCustom2),
  TypedReducer<ListUIState, StartTaskMultiselect>(_startListMultiselect),
  TypedReducer<ListUIState, AddToTaskMultiselect>(_addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromTaskMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearTaskMultiselect>(_clearListMultiselect),
  TypedReducer<ListUIState, ViewTaskList>(_viewTaskList),
  TypedReducer<ListUIState, FilterByEntity>(
      (state, action) => state.rebuild((b) => b
        ..filter = null
        ..filterClearedAt = DateTime.now().millisecondsSinceEpoch)),
]);

ListUIState _viewTaskList(ListUIState taskListState, ViewTaskList action) {
  return taskListState.rebuild((b) => b
    ..selectedIds = null
    ..filter = null
    ..filterClearedAt = DateTime.now().millisecondsSinceEpoch);
}

ListUIState _filterTasksByCustom1(
    ListUIState taskListState, FilterTasksByCustom1 action) {
  if (taskListState.custom1Filters.contains(action.value)) {
    return taskListState.rebuild((b) => b..custom1Filters.remove(action.value));
  } else {
    return taskListState.rebuild((b) => b..custom1Filters.add(action.value));
  }
}

ListUIState _filterTasksByCustom2(
    ListUIState taskListState, FilterTasksByCustom2 action) {
  if (taskListState.custom2Filters.contains(action.value)) {
    return taskListState.rebuild((b) => b..custom2Filters.remove(action.value));
  } else {
    return taskListState.rebuild((b) => b..custom2Filters.add(action.value));
  }
}

ListUIState _filterTasksByState(
    ListUIState taskListState, FilterTasksByState action) {
  if (taskListState.stateFilters.contains(action.state)) {
    return taskListState.rebuild((b) => b..stateFilters.remove(action.state));
  } else {
    return taskListState.rebuild((b) => b..stateFilters.add(action.state));
  }
}

ListUIState _filterTasksByStatus(
    ListUIState taskListState, FilterTasksByStatus action) {
  if (taskListState.statusFilters.contains(action.status)) {
    return taskListState.rebuild((b) => b..statusFilters.remove(action.status));
  } else {
    return taskListState.rebuild((b) => b..statusFilters.add(action.status));
  }
}

ListUIState _filterTasks(ListUIState taskListState, FilterTasks action) {
  return taskListState.rebuild((b) => b
    ..filter = action.filter
    ..filterClearedAt = action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : taskListState.filterClearedAt);
}

ListUIState _sortTasks(ListUIState taskListState, SortTasks action) {
  return taskListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending!
    ..sortField = action.field);
}

TaskEntity _addTaskTime(TaskEntity? task, AddTaskTime action) {
  return task!.addTaskTime(action.taskTime);
}

TaskEntity _removeTaskTime(TaskEntity? task, DeleteTaskTime action) {
  return task!.deleteTaskTime(action.index);
}

TaskEntity _updateTaskTime(TaskEntity? task, UpdateTaskTime action) {
  return task!.updateTaskTime(action.taskTime!, action.index!);
}

ListUIState _startListMultiselect(
    ListUIState taskListState, StartTaskMultiselect action) {
  return taskListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState taskListState, AddToTaskMultiselect action) {
  return taskListState.rebuild((b) => b..selectedIds.add(action.entity!.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState taskListState, RemoveFromTaskMultiselect action) {
  return taskListState.rebuild((b) => b..selectedIds.remove(action.entity!.id));
}

ListUIState _clearListMultiselect(
    ListUIState taskListState, ClearTaskMultiselect action) {
  return taskListState.rebuild((b) => b..selectedIds = null);
}

final tasksReducer = combineReducers<TaskState>([
  TypedReducer<TaskState, SaveTaskSuccess>(_updateTask),
  TypedReducer<TaskState, AddTaskSuccess>(_addTask),
  TypedReducer<TaskState, LoadTasksSuccess>(_setLoadedTasks),
  TypedReducer<TaskState, LoadCompanySuccess>(_setLoadedCompany),
  TypedReducer<TaskState, LoadTaskSuccess>(_setLoadedTask),
  TypedReducer<TaskState, ArchiveTaskSuccess>(_archiveTaskSuccess),
  TypedReducer<TaskState, StartTasksSuccess>(_startTaskSuccess),
  TypedReducer<TaskState, StopTasksSuccess>(_stopTaskSuccess),
  TypedReducer<TaskState, DeleteTaskSuccess>(_deleteTaskSuccess),
  TypedReducer<TaskState, RestoreTaskSuccess>(_restoreTaskSuccess),
  TypedReducer<TaskState, SortTasksSuccess>(_sortTasksSuccess),
  TypedReducer<TaskState, PurgeClientSuccess>(_purgeClientSuccess),
]);

TaskState _purgeClientSuccess(TaskState taskState, PurgeClientSuccess action) {
  final ids = taskState.map.values
      .where((each) => each.clientId == action.clientId)
      .map((each) => each.id)
      .toList();

  return taskState.rebuild((b) => b
    ..map.removeWhere((p0, p1) => ids.contains(p0))
    ..list.removeWhere((p0) => ids.contains(p0)));
}

TaskState _sortTasksSuccess(TaskState taskState, SortTasksSuccess action) {
  return taskState.rebuild((b) {
    for (final statusId in action.taskIds!.keys) {
      for (final taskId in action.taskIds![statusId]!) {
        b.map[taskId] = taskState.map[taskId]!.rebuild((b) => b
          ..statusId = statusId
          ..statusOrder = action.taskIds![statusId]!.indexOf(taskId));
      }
    }
  });
}

TaskState _archiveTaskSuccess(TaskState taskState, ArchiveTaskSuccess action) {
  return taskState.rebuild((b) {
    for (final task in action.tasks) {
      b.map[task.id] = task;
    }
  });
}

TaskState _startTaskSuccess(TaskState taskState, StartTasksSuccess action) {
  return taskState.rebuild((b) {
    for (final task in action.tasks) {
      b.map[task.id] = task;
    }
  });
}

TaskState _stopTaskSuccess(TaskState taskState, StopTasksSuccess action) {
  return taskState.rebuild((b) {
    for (final task in action.tasks) {
      b.map[task.id] = task;
    }
  });
}

TaskState _deleteTaskSuccess(TaskState taskState, DeleteTaskSuccess action) {
  return taskState.rebuild((b) {
    for (final task in action.tasks) {
      b.map[task.id] = task;
    }
  });
}

TaskState _restoreTaskSuccess(TaskState taskState, RestoreTaskSuccess action) {
  return taskState.rebuild((b) {
    for (final task in action.tasks) {
      b.map[task.id] = task;
    }
  });
}

TaskState _addTask(TaskState taskState, AddTaskSuccess action) {
  return taskState.rebuild((b) => b
    ..map[action.task.id] = action.task
    ..list.add(action.task.id));
}

TaskState _updateTask(TaskState taskState, SaveTaskSuccess action) {
  return taskState.rebuild((b) => b..map[action.task.id] = action.task);
}

TaskState _setLoadedTask(TaskState taskState, LoadTaskSuccess action) {
  return taskState.rebuild((b) => b..map[action.task.id] = action.task);
}

TaskState _setLoadedTasks(TaskState taskState, LoadTasksSuccess action) =>
    taskState.loadTasks(action.tasks);

TaskState _setLoadedCompany(TaskState taskState, LoadCompanySuccess action) {
  final company = action.userCompany.company;
  return taskState.loadTasks(company.tasks);
}
