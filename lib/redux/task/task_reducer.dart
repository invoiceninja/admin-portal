import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_state.dart';

EntityUIState taskUIReducer(TaskUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(taskListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action))
    ..editingTime.replace(editingTimeReducer(state.editingTime, action))
    ..selectedId = selectedIdReducer(state.selectedId, action));
}

final editingTimeReducer = combineReducers<TaskTime>([
  TypedReducer<TaskTime, EditTask>(editTaskTime),
  TypedReducer<TaskTime, EditTaskTime>(editTaskTime),
]);

TaskTime editTaskTime(TaskTime taskTime, dynamic action) {
  return action.taskTime ?? TaskTime(startDate: DateTime(2000).toUtc());
}

Reducer<String> selectedIdReducer = combineReducers([
  TypedReducer<String, ViewTask>((selectedId, action) => action.taskId),
  TypedReducer<String, AddTaskSuccess>((selectedId, action) => action.task.id),
  TypedReducer<String, FilterTasksByEntity>(
      (selectedId, action) => action.entityId == null ? selectedId : '')
]);

final editingReducer = combineReducers<TaskEntity>([
  TypedReducer<TaskEntity, SaveTaskSuccess>(_updateEditing),
  TypedReducer<TaskEntity, AddTaskSuccess>(_updateEditing),
  TypedReducer<TaskEntity, RestoreTaskSuccess>(_updateEditing),
  TypedReducer<TaskEntity, ArchiveTaskSuccess>(_updateEditing),
  TypedReducer<TaskEntity, DeleteTaskSuccess>(_updateEditing),
  TypedReducer<TaskEntity, EditTask>(_updateEditing),
  TypedReducer<TaskEntity, UpdateTask>((task, action) {
    return action.task.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<TaskEntity, AddTaskTime>(_addTaskTime),
  TypedReducer<TaskEntity, DeleteTaskTime>(_removeTaskTime),
  TypedReducer<TaskEntity, UpdateTaskTime>(_updateTaskTime),
  TypedReducer<TaskEntity, SelectCompany>(_clearEditing),
  TypedReducer<TaskEntity, DiscardChanges>(_clearEditing),
]);

TaskEntity _clearEditing(TaskEntity task, dynamic action) {
  return TaskEntity();
}

TaskEntity _updateEditing(TaskEntity task, dynamic action) {
  return action.task;
}

final taskListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortTasks>(_sortTasks),
  TypedReducer<ListUIState, FilterTasksByState>(_filterTasksByState),
  TypedReducer<ListUIState, FilterTasksByStatus>(_filterTasksByStatus),
  TypedReducer<ListUIState, FilterTasks>(_filterTasks),
  TypedReducer<ListUIState, FilterTasksByCustom1>(_filterTasksByCustom1),
  TypedReducer<ListUIState, FilterTasksByCustom2>(_filterTasksByCustom2),
  TypedReducer<ListUIState, FilterTasksByEntity>(_filterTasksByClient),
  TypedReducer<ListUIState, StartTaskMultiselect>(_startListMultiselect),
  TypedReducer<ListUIState, AddToTaskMultiselect>(_addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromTaskMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearTaskMultiselect>(_clearListMultiselect),
]);

ListUIState _filterTasksByClient(
    ListUIState taskListState, FilterTasksByEntity action) {
  return taskListState.rebuild((b) => b
    ..filterEntityId = action.entityId
    ..filterEntityType = action.entityType);
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
    ..sortAscending = b.sortField != action.field || !b.sortAscending
    ..sortField = action.field);
}

TaskEntity _addTaskTime(TaskEntity task, AddTaskTime action) {
  return task.addTaskTime(action.taskTime);
}

TaskEntity _removeTaskTime(TaskEntity task, DeleteTaskTime action) {
  return task.deleteTaskTime(action.index);
}

TaskEntity _updateTaskTime(TaskEntity task, UpdateTaskTime action) {
  return task.updateTaskTime(action.taskTime, action.index);
}

ListUIState _startListMultiselect(
    ListUIState taskListState, StartTaskMultiselect action) {
  return taskListState.rebuild((b) => b..selectedEntities = <BaseEntity>[]);
}

ListUIState _addToListMultiselect(
    ListUIState taskListState, AddToTaskMultiselect action) {
  return taskListState
      .rebuild((b) => b..selectedEntities.add(action.entity));
}

ListUIState _removeFromListMultiselect(
    ListUIState taskListState, RemoveFromTaskMultiselect action) {
  return taskListState
      .rebuild((b) => b..selectedEntities.remove(action.entity));
}

ListUIState _clearListMultiselect(
    ListUIState taskListState, ClearTaskMultiselect action) {
  return taskListState.rebuild((b) => b..selectedEntities = null);
}

final tasksReducer = combineReducers<TaskState>([
  TypedReducer<TaskState, SaveTaskSuccess>(_updateTask),
  TypedReducer<TaskState, AddTaskSuccess>(_addTask),
  TypedReducer<TaskState, LoadTasksSuccess>(_setLoadedTasks),
  TypedReducer<TaskState, LoadTaskSuccess>(_setLoadedTask),
  TypedReducer<TaskState, ArchiveTaskRequest>(_archiveTaskRequest),
  TypedReducer<TaskState, ArchiveTaskSuccess>(_archiveTaskSuccess),
  TypedReducer<TaskState, ArchiveTaskFailure>(_archiveTaskFailure),
  TypedReducer<TaskState, DeleteTaskRequest>(_deleteTaskRequest),
  TypedReducer<TaskState, DeleteTaskSuccess>(_deleteTaskSuccess),
  TypedReducer<TaskState, DeleteTaskFailure>(_deleteTaskFailure),
  TypedReducer<TaskState, RestoreTaskRequest>(_restoreTaskRequest),
  TypedReducer<TaskState, RestoreTaskSuccess>(_restoreTaskSuccess),
  TypedReducer<TaskState, RestoreTaskFailure>(_restoreTaskFailure),
]);

TaskState _archiveTaskRequest(TaskState taskState, ArchiveTaskRequest action) {
  final task = taskState.map[action.taskId]
      .rebuild((b) => b..archivedAt = DateTime.now().millisecondsSinceEpoch);

  return taskState.rebuild((b) => b..map[action.taskId] = task);
}

TaskState _archiveTaskSuccess(TaskState taskState, ArchiveTaskSuccess action) {
  return taskState.rebuild((b) => b..map[action.task.id] = action.task);
}

TaskState _archiveTaskFailure(TaskState taskState, ArchiveTaskFailure action) {
  return taskState.rebuild((b) => b..map[action.task.id] = action.task);
}

TaskState _deleteTaskRequest(TaskState taskState, DeleteTaskRequest action) {
  final task = taskState.map[action.taskId].rebuild((b) => b
    ..archivedAt = DateTime.now().millisecondsSinceEpoch
    ..isDeleted = true);

  return taskState.rebuild((b) => b..map[action.taskId] = task);
}

TaskState _deleteTaskSuccess(TaskState taskState, DeleteTaskSuccess action) {
  return taskState.rebuild((b) => b..map[action.task.id] = action.task);
}

TaskState _deleteTaskFailure(TaskState taskState, DeleteTaskFailure action) {
  return taskState.rebuild((b) => b..map[action.task.id] = action.task);
}

TaskState _restoreTaskRequest(TaskState taskState, RestoreTaskRequest action) {
  final task = taskState.map[action.taskId].rebuild((b) => b
    ..archivedAt = null
    ..isDeleted = false);
  return taskState.rebuild((b) => b..map[action.taskId] = task);
}

TaskState _restoreTaskSuccess(TaskState taskState, RestoreTaskSuccess action) {
  return taskState.rebuild((b) => b..map[action.task.id] = action.task);
}

TaskState _restoreTaskFailure(TaskState taskState, RestoreTaskFailure action) {
  return taskState.rebuild((b) => b..map[action.task.id] = action.task);
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

TaskState _setLoadedTasks(TaskState taskState, LoadTasksSuccess action) {
  final state = taskState.rebuild((b) => b
    ..lastUpdated = DateTime.now().millisecondsSinceEpoch
    ..map.addAll(Map.fromIterable(
      action.tasks,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    )));

  return state.rebuild((b) => b..list.replace(state.map.keys));
}
