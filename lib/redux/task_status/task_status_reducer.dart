// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/redux/task_status/task_status_actions.dart';
import 'package:invoiceninja_flutter/redux/task_status/task_status_state.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

EntityUIState taskStatusUIReducer(TaskStatusUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(taskStatusListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action)!)
    ..selectedId = selectedIdReducer(state.selectedId, action)
    ..forceSelected = forceSelectedReducer(state.forceSelected, action));
}

final forceSelectedReducer = combineReducers<bool?>([
  TypedReducer<bool?, ViewTaskStatus>((completer, action) => true),
  TypedReducer<bool?, ViewTaskStatusList>((completer, action) => false),
  TypedReducer<bool?, FilterTaskStatusesByState>((completer, action) => false),
  TypedReducer<bool?, FilterTaskStatuses>((completer, action) => false),
  TypedReducer<bool?, FilterTaskStatusesByCustom1>(
      (completer, action) => false),
  TypedReducer<bool?, FilterTaskStatusesByCustom2>(
      (completer, action) => false),
  TypedReducer<bool?, FilterTaskStatusesByCustom3>(
      (completer, action) => false),
  TypedReducer<bool?, FilterTaskStatusesByCustom4>(
      (completer, action) => false),
]);

Reducer<String?> selectedIdReducer = combineReducers([
  TypedReducer<String?, ArchiveTaskStatusesSuccess>((completer, action) => ''),
  TypedReducer<String?, DeleteTaskStatusesSuccess>((completer, action) => ''),
  TypedReducer<String?, PreviewEntity>((selectedId, action) =>
      action.entityType == EntityType.taskStatus
          ? action.entityId
          : selectedId),
  TypedReducer<String?, ViewTaskStatus>(
      (String? selectedId, dynamic action) => action.taskStatusId),
  TypedReducer<String?, AddTaskStatusSuccess>(
      (String? selectedId, dynamic action) => action.taskStatus.id),
  TypedReducer<String?, SelectCompany>(
      (selectedId, action) => action.clearSelection ? '' : selectedId),
  TypedReducer<String?, ClearEntityFilter>((selectedId, action) => ''),
  TypedReducer<String?, SortTaskStatuses>((selectedId, action) => ''),
  TypedReducer<String?, FilterTaskStatuses>((selectedId, action) => ''),
  TypedReducer<String?, FilterTaskStatusesByState>((selectedId, action) => ''),
  TypedReducer<String?, FilterTaskStatusesByCustom1>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterTaskStatusesByCustom2>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterTaskStatusesByCustom3>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterTaskStatusesByCustom4>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterByEntity>(
      (selectedId, action) => action.clearSelection
          ? ''
          : action.entityType == EntityType.taskStatus
              ? action.entityId
              : selectedId),
]);

final editingReducer = combineReducers<TaskStatusEntity?>([
  TypedReducer<TaskStatusEntity?, SaveTaskStatusSuccess>(_updateEditing),
  TypedReducer<TaskStatusEntity?, AddTaskStatusSuccess>(_updateEditing),
  TypedReducer<TaskStatusEntity?, RestoreTaskStatusesSuccess>(
      (taskStatuses, action) {
    return action.taskStatuses[0];
  }),
  TypedReducer<TaskStatusEntity?, ArchiveTaskStatusesSuccess>(
      (taskStatuses, action) {
    return action.taskStatuses[0];
  }),
  TypedReducer<TaskStatusEntity?, DeleteTaskStatusesSuccess>(
      (taskStatuses, action) {
    return action.taskStatuses[0];
  }),
  TypedReducer<TaskStatusEntity?, EditTaskStatus>(_updateEditing),
  TypedReducer<TaskStatusEntity?, UpdateTaskStatus>((taskStatus, action) {
    return action.taskStatus.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<TaskStatusEntity?, DiscardChanges>(_clearEditing),
]);

TaskStatusEntity _clearEditing(TaskStatusEntity? taskStatus, dynamic action) {
  return TaskStatusEntity();
}

TaskStatusEntity? _updateEditing(TaskStatusEntity? taskStatus, dynamic action) {
  return action.taskStatus;
}

final taskStatusListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortTaskStatuses>(_sortTaskStatuses),
  TypedReducer<ListUIState, FilterTaskStatusesByState>(
      _filterTaskStatusesByState),
  TypedReducer<ListUIState, FilterTaskStatuses>(_filterTaskStatuses),
  TypedReducer<ListUIState, FilterTaskStatusesByCustom1>(
      _filterTaskStatusesByCustom1),
  TypedReducer<ListUIState, FilterTaskStatusesByCustom2>(
      _filterTaskStatusesByCustom2),
  TypedReducer<ListUIState, StartTaskStatusMultiselect>(_startListMultiselect),
  TypedReducer<ListUIState, AddToTaskStatusMultiselect>(_addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromTaskStatusMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearTaskStatusMultiselect>(_clearListMultiselect),
  TypedReducer<ListUIState, ViewTaskStatusList>(_viewTaskStatusList),
  TypedReducer<ListUIState, FilterByEntity>(
      (state, action) => state.rebuild((b) => b
        ..filter = null
        ..filterClearedAt = DateTime.now().millisecondsSinceEpoch)),
]);

ListUIState _viewTaskStatusList(
    ListUIState taskStatusListState, ViewTaskStatusList action) {
  return taskStatusListState.rebuild((b) => b
    ..selectedIds = null
    ..filter = null
    ..filterClearedAt = DateTime.now().millisecondsSinceEpoch);
}

ListUIState _filterTaskStatusesByCustom1(
    ListUIState taskStatusListState, FilterTaskStatusesByCustom1 action) {
  if (taskStatusListState.custom1Filters.contains(action.value)) {
    return taskStatusListState
        .rebuild((b) => b..custom1Filters.remove(action.value));
  } else {
    return taskStatusListState
        .rebuild((b) => b..custom1Filters.add(action.value));
  }
}

ListUIState _filterTaskStatusesByCustom2(
    ListUIState taskStatusListState, FilterTaskStatusesByCustom2 action) {
  if (taskStatusListState.custom2Filters.contains(action.value)) {
    return taskStatusListState
        .rebuild((b) => b..custom2Filters.remove(action.value));
  } else {
    return taskStatusListState
        .rebuild((b) => b..custom2Filters.add(action.value));
  }
}

ListUIState _filterTaskStatusesByState(
    ListUIState taskStatusListState, FilterTaskStatusesByState action) {
  if (taskStatusListState.stateFilters.contains(action.state)) {
    return taskStatusListState
        .rebuild((b) => b..stateFilters.remove(action.state));
  } else {
    return taskStatusListState
        .rebuild((b) => b..stateFilters.add(action.state));
  }
}

ListUIState _filterTaskStatuses(
    ListUIState taskStatusListState, FilterTaskStatuses action) {
  return taskStatusListState.rebuild((b) => b
    ..filter = action.filter
    ..filterClearedAt = action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : taskStatusListState.filterClearedAt);
}

ListUIState _sortTaskStatuses(
    ListUIState taskStatusListState, SortTaskStatuses action) {
  return taskStatusListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending!
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState productListState, StartTaskStatusMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState productListState, AddToTaskStatusMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds.add(action.entity!.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState productListState, RemoveFromTaskStatusMultiselect action) {
  return productListState
      .rebuild((b) => b..selectedIds.remove(action.entity!.id));
}

ListUIState _clearListMultiselect(
    ListUIState productListState, ClearTaskStatusMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = null);
}

final taskStatusesReducer = combineReducers<TaskStatusState>([
  TypedReducer<TaskStatusState, SaveTaskStatusSuccess>(_updateTaskStatus),
  TypedReducer<TaskStatusState, AddTaskStatusSuccess>(_addTaskStatus),
  TypedReducer<TaskStatusState, LoadTaskStatusesSuccess>(
      _setLoadedTaskStatuses),
  TypedReducer<TaskStatusState, LoadTaskStatusSuccess>(_setLoadedTaskStatus),
  TypedReducer<TaskStatusState, LoadCompanySuccess>(_setLoadedCompany),
  TypedReducer<TaskStatusState, ArchiveTaskStatusesSuccess>(
      _archiveTaskStatusSuccess),
  TypedReducer<TaskStatusState, DeleteTaskStatusesSuccess>(
      _deleteTaskStatusSuccess),
  TypedReducer<TaskStatusState, RestoreTaskStatusesSuccess>(
      _restoreTaskStatusSuccess),
  TypedReducer<TaskStatusState, SortTasksSuccess>(_sortTaskStatusSuccess),
]);

TaskStatusState _sortTaskStatusSuccess(
    TaskStatusState taskStatusState, SortTasksSuccess action) {
  return taskStatusState.rebuild((b) {
    for (final statusId in action.statusIds!) {
      b.map[statusId] = taskStatusState.map[statusId]!
          .rebuild((b) => b..statusOrder = action.statusIds!.indexOf(statusId));
    }
  });
}

TaskStatusState _archiveTaskStatusSuccess(
    TaskStatusState taskStatusState, ArchiveTaskStatusesSuccess action) {
  return taskStatusState.rebuild((b) {
    for (final taskStatus in action.taskStatuses) {
      b.map[taskStatus.id] = taskStatus;
    }
  });
}

TaskStatusState _deleteTaskStatusSuccess(
    TaskStatusState taskStatusState, DeleteTaskStatusesSuccess action) {
  return taskStatusState.rebuild((b) {
    for (final taskStatus in action.taskStatuses) {
      b.map[taskStatus.id] = taskStatus;
    }
  });
}

TaskStatusState _restoreTaskStatusSuccess(
    TaskStatusState taskStatusState, RestoreTaskStatusesSuccess action) {
  return taskStatusState.rebuild((b) {
    for (final taskStatus in action.taskStatuses) {
      b.map[taskStatus.id] = taskStatus;
    }
  });
}

TaskStatusState _addTaskStatus(
    TaskStatusState taskStatusState, AddTaskStatusSuccess action) {
  return taskStatusState.rebuild((b) => b
    ..map[action.taskStatus.id] = action.taskStatus
    ..list.add(action.taskStatus.id));
}

TaskStatusState _updateTaskStatus(
    TaskStatusState taskStatusState, SaveTaskStatusSuccess action) {
  return taskStatusState
      .rebuild((b) => b..map[action.taskStatus.id] = action.taskStatus);
}

TaskStatusState _setLoadedTaskStatus(
    TaskStatusState taskStatusState, LoadTaskStatusSuccess action) {
  return taskStatusState
      .rebuild((b) => b..map[action.taskStatus.id] = action.taskStatus);
}

TaskStatusState _setLoadedTaskStatuses(
        TaskStatusState taskStatusState, LoadTaskStatusesSuccess action) =>
    taskStatusState.loadTaskStatuses(action.taskStatuses);

TaskStatusState _setLoadedCompany(
    TaskStatusState taskStatusState, LoadCompanySuccess action) {
  final company = action.userCompany.company;
  return taskStatusState.loadTaskStatuses(company.taskStatuses);
}
