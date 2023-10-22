// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ViewTaskStatusList implements PersistUI {
  ViewTaskStatusList({
    this.force = false,
  });

  final bool force;
}

class ViewTaskStatus implements PersistUI, PersistPrefs {
  ViewTaskStatus({
    required this.taskStatusId,
    this.force = false,
  });

  final String? taskStatusId;
  final bool force;
}

class EditTaskStatus implements PersistUI, PersistPrefs {
  EditTaskStatus(
      {required this.taskStatus,
      this.completer,
      this.cancelCompleter,
      this.force = false});

  final TaskStatusEntity taskStatus;
  final Completer? completer;
  final Completer? cancelCompleter;
  final bool force;
}

class UpdateTaskStatus implements PersistUI {
  UpdateTaskStatus(this.taskStatus);

  final TaskStatusEntity taskStatus;
}

class LoadTaskStatus {
  LoadTaskStatus({this.completer, this.taskStatusId});

  final Completer? completer;
  final String? taskStatusId;
}

class LoadTaskStatusActivity {
  LoadTaskStatusActivity({this.completer, this.taskStatusId});

  final Completer? completer;
  final String? taskStatusId;
}

class LoadTaskStatuses {
  LoadTaskStatuses({this.completer});

  final Completer? completer;
}

class LoadTaskStatusRequest implements StartLoading {}

class LoadTaskStatusFailure implements StopLoading {
  LoadTaskStatusFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadTaskStatusFailure{error: $error}';
  }
}

class LoadTaskStatusSuccess implements StopLoading, PersistData {
  LoadTaskStatusSuccess(this.taskStatus);

  final TaskStatusEntity taskStatus;

  @override
  String toString() {
    return 'LoadTaskStatusSuccess{taskStatus: $taskStatus}';
  }
}

class LoadTaskStatusesRequest implements StartLoading {}

class LoadTaskStatusesFailure implements StopLoading {
  LoadTaskStatusesFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadTaskStatusesFailure{error: $error}';
  }
}

class LoadTaskStatusesSuccess implements StopLoading {
  LoadTaskStatusesSuccess(this.taskStatuses);

  final BuiltList<TaskStatusEntity> taskStatuses;

  @override
  String toString() {
    return 'LoadTaskStatusesSuccess{taskStatuses: $taskStatuses}';
  }
}

class SaveTaskStatusRequest implements StartSaving {
  SaveTaskStatusRequest({this.completer, this.taskStatus});

  final Completer? completer;
  final TaskStatusEntity? taskStatus;
}

class SaveTaskStatusSuccess implements StopSaving, PersistData, PersistUI {
  SaveTaskStatusSuccess(this.taskStatus);

  final TaskStatusEntity taskStatus;
}

class AddTaskStatusSuccess implements StopSaving, PersistData, PersistUI {
  AddTaskStatusSuccess(this.taskStatus);

  final TaskStatusEntity taskStatus;
}

class SaveTaskStatusFailure implements StopSaving {
  SaveTaskStatusFailure(this.error);

  final Object error;
}

class ArchiveTaskStatusesRequest implements StartSaving {
  ArchiveTaskStatusesRequest(this.completer, this.taskStatusIds);

  final Completer completer;
  final List<String> taskStatusIds;
}

class ArchiveTaskStatusesSuccess implements StopSaving, PersistData {
  ArchiveTaskStatusesSuccess(this.taskStatuses);

  final List<TaskStatusEntity> taskStatuses;
}

class ArchiveTaskStatusesFailure implements StopSaving {
  ArchiveTaskStatusesFailure(this.taskStatuses);

  final List<TaskStatusEntity?> taskStatuses;
}

class DeleteTaskStatusesRequest implements StartSaving {
  DeleteTaskStatusesRequest(this.completer, this.taskStatusIds);

  final Completer completer;
  final List<String> taskStatusIds;
}

class DeleteTaskStatusesSuccess implements StopSaving, PersistData {
  DeleteTaskStatusesSuccess(this.taskStatuses);

  final List<TaskStatusEntity> taskStatuses;
}

class DeleteTaskStatusesFailure implements StopSaving {
  DeleteTaskStatusesFailure(this.taskStatuses);

  final List<TaskStatusEntity?> taskStatuses;
}

class RestoreTaskStatusesRequest implements StartSaving {
  RestoreTaskStatusesRequest(this.completer, this.taskStatusIds);

  final Completer completer;
  final List<String> taskStatusIds;
}

class RestoreTaskStatusesSuccess implements StopSaving, PersistData {
  RestoreTaskStatusesSuccess(this.taskStatuses);

  final List<TaskStatusEntity> taskStatuses;
}

class RestoreTaskStatusesFailure implements StopSaving {
  RestoreTaskStatusesFailure(this.taskStatuses);

  final List<TaskStatusEntity?> taskStatuses;
}

class FilterTaskStatuses implements PersistUI {
  FilterTaskStatuses(this.filter);

  final String? filter;
}

class SortTaskStatuses implements PersistUI, PersistPrefs {
  SortTaskStatuses(this.field);

  final String field;
}

class FilterTaskStatusesByState implements PersistUI {
  FilterTaskStatusesByState(this.state);

  final EntityState state;
}

class FilterTaskStatusesByCustom1 implements PersistUI {
  FilterTaskStatusesByCustom1(this.value);

  final String value;
}

class FilterTaskStatusesByCustom2 implements PersistUI {
  FilterTaskStatusesByCustom2(this.value);

  final String value;
}

class FilterTaskStatusesByCustom3 implements PersistUI {
  FilterTaskStatusesByCustom3(this.value);

  final String value;
}

class FilterTaskStatusesByCustom4 implements PersistUI {
  FilterTaskStatusesByCustom4(this.value);

  final String value;
}

class StartTaskStatusMultiselect {
  StartTaskStatusMultiselect();
}

class AddToTaskStatusMultiselect {
  AddToTaskStatusMultiselect({required this.entity});

  final BaseEntity? entity;
}

class RemoveFromTaskStatusMultiselect {
  RemoveFromTaskStatusMultiselect({required this.entity});

  final BaseEntity? entity;
}

class ClearTaskStatusMultiselect {
  ClearTaskStatusMultiselect();
}

void handleTaskStatusAction(BuildContext? context,
    List<BaseEntity> taskStatuses, EntityAction? action) {
  if (taskStatuses.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context!);
  final state = store.state;
  final localization = AppLocalization.of(context);
  final taskStatus = taskStatuses.first as TaskStatusEntity;
  final taskStatusIds =
      taskStatuses.map((taskStatus) => taskStatus.id).toList();

  switch (action) {
    case EntityAction.edit:
      editEntity(entity: taskStatus);
      break;
    case EntityAction.restore:
      final message = taskStatusIds.length > 1
          ? localization!.restoredTaskStatuses
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', taskStatusIds.length.toString())
          : localization!.restoredTaskStatus;
      store.dispatch(RestoreTaskStatusesRequest(
          snackBarCompleter<Null>(message), taskStatusIds));
      break;
    case EntityAction.archive:
      final message = taskStatusIds.length > 1
          ? localization!.archivedTaskStatuses
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', taskStatusIds.length.toString())
          : localization!.archivedTaskStatus;
      store.dispatch(ArchiveTaskStatusesRequest(
          snackBarCompleter<Null>(message), taskStatusIds));
      break;
    case EntityAction.delete:
      final message = taskStatusIds.length > 1
          ? localization!.deletedTaskStatuses
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', taskStatusIds.length.toString())
          : localization!.deletedTaskStatus;
      store.dispatch(DeleteTaskStatusesRequest(
          snackBarCompleter<Null>(message), taskStatusIds));
      break;
    case EntityAction.newTask:
      createEntity(
          entity: TaskEntity(state: state)
              .rebuild((b) => b..statusId = taskStatus.id));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.taskStatusListState.isInMultiselect()) {
        store.dispatch(StartTaskStatusMultiselect());
      }

      if (taskStatuses.isEmpty) {
        break;
      }

      for (final taskStatus in taskStatuses) {
        if (!store.state.taskStatusListState.isSelected(taskStatus.id)) {
          store.dispatch(AddToTaskStatusMultiselect(entity: taskStatus));
        } else {
          store.dispatch(RemoveFromTaskStatusMultiselect(entity: taskStatus));
        }
      }
      break;
    case EntityAction.more:
      showEntityActionsDialog(
        entities: [taskStatus],
      );
      break;
    default:
      print('## ERROR: unhandled action $action in task_status_actions');
      break;
  }
}
