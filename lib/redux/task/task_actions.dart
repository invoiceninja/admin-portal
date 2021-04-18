import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ViewTaskList implements PersistUI, StopLoading {
  ViewTaskList({this.force = false});

  final bool force;
}

class ViewTask implements PersistUI, PersistPrefs {
  ViewTask({
    @required this.taskId,
    this.force = false,
  });

  final String taskId;
  final bool force;
}

class EditTask implements PersistUI, PersistPrefs {
  EditTask(
      {this.task,
      this.taskTime,
      this.completer,
      this.force = false,
      this.taskTimeIndex});

  final int taskTimeIndex;
  final TaskEntity task;
  final TaskTime taskTime;
  final Completer completer;
  final bool force;
}

class UpdateTask implements PersistUI {
  UpdateTask(this.task);

  final TaskEntity task;
}

class LoadTask {
  LoadTask({this.completer, this.taskId});

  final Completer completer;
  final String taskId;
}

class LoadTaskActivity {
  LoadTaskActivity({this.completer, this.taskId});

  final Completer completer;
  final String taskId;
}

class LoadTasks {
  LoadTasks({this.completer});

  final Completer completer;
}

class LoadTaskRequest implements StartLoading {}

class LoadTaskFailure implements StopLoading {
  LoadTaskFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadTaskFailure{error: $error}';
  }
}

class LoadTaskSuccess implements StopLoading, PersistData {
  LoadTaskSuccess(this.task);

  final TaskEntity task;

  @override
  String toString() {
    return 'LoadTaskSuccess{task: $task}';
  }
}

class EditTaskTime implements PersistUI {
  EditTaskTime([this.taskTimeIndex]);

  final int taskTimeIndex;
}

class AddTaskTime implements PersistUI {
  AddTaskTime(this.taskTime, {this.showAsRunning = false});

  final TaskTime taskTime;
  final bool showAsRunning;
}

class UpdateTaskTime implements PersistUI {
  UpdateTaskTime({this.index, this.taskTime});

  final int index;
  final TaskTime taskTime;
}

class DeleteTaskTime implements PersistUI {
  DeleteTaskTime(this.index);

  final int index;
}

class LoadTasksRequest implements StartLoading {}

class LoadTasksFailure implements StopLoading {
  LoadTasksFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadTasksFailure{error: $error}';
  }
}

class LoadTasksSuccess implements StopLoading {
  LoadTasksSuccess(this.tasks);

  final BuiltList<TaskEntity> tasks;

  @override
  String toString() {
    return 'LoadTasksSuccess{tasks: $tasks}';
  }
}

class SaveTaskRequest implements StartSaving {
  SaveTaskRequest({this.completer, this.task, this.autoSelect = true});

  final Completer completer;
  final TaskEntity task;
  final bool autoSelect;
}

class SaveTaskSuccess implements StopSaving, PersistData, PersistUI {
  SaveTaskSuccess(this.task);

  final TaskEntity task;
}

class AddTaskSuccess implements StopSaving, PersistData, PersistUI {
  AddTaskSuccess({this.task, this.autoSelect = true});

  final TaskEntity task;
  final bool autoSelect;
}

class SaveTaskFailure implements StopSaving {
  SaveTaskFailure(this.error);

  final Object error;
}

class ArchiveTaskRequest implements StartSaving {
  ArchiveTaskRequest(this.completer, this.taskIds);

  final Completer completer;
  final List<String> taskIds;
}

class ArchiveTaskSuccess implements StopSaving, PersistData {
  ArchiveTaskSuccess(this.tasks);

  final List<TaskEntity> tasks;
}

class ArchiveTaskFailure implements StopSaving {
  ArchiveTaskFailure(this.tasks);

  final List<TaskEntity> tasks;
}

class DeleteTaskRequest implements StartSaving {
  DeleteTaskRequest(this.completer, this.taskIds);

  final Completer completer;
  final List<String> taskIds;
}

class DeleteTaskSuccess implements StopSaving, PersistData {
  DeleteTaskSuccess(this.tasks);

  final List<TaskEntity> tasks;
}

class DeleteTaskFailure implements StopSaving {
  DeleteTaskFailure(this.tasks);

  final List<TaskEntity> tasks;
}

class RestoreTaskRequest implements StartSaving {
  RestoreTaskRequest(this.completer, this.taskIds);

  final Completer completer;
  final List<String> taskIds;
}

class RestoreTaskSuccess implements StopSaving, PersistData {
  RestoreTaskSuccess(this.tasks);

  final List<TaskEntity> tasks;
}

class RestoreTaskFailure implements StopSaving {
  RestoreTaskFailure(this.tasks);

  final List<TaskEntity> tasks;
}

class SortTasksRequest implements StartSaving {
  SortTasksRequest({this.completer, this.statusIds, this.taskIds});

  final Completer completer;
  final List<String> statusIds;
  final Map<String, List<String>> taskIds;
}

class SortTasksSuccess implements StopSaving, PersistData {
  SortTasksSuccess({this.statusIds, this.taskIds});

  final List<String> statusIds;
  final Map<String, List<String>> taskIds;
}

class SortTasksFailure implements StopSaving {
  SortTasksFailure(this.error);

  final Object error;
}

class FilterTasks implements PersistUI {
  FilterTasks(this.filter);

  final String filter;
}

class SortTasks implements PersistUI {
  SortTasks(this.field);

  final String field;
}

class FilterTasksByState implements PersistUI {
  FilterTasksByState(this.state);

  final EntityState state;
}

class FilterTasksByStatus implements PersistUI {
  FilterTasksByStatus(this.status);

  final EntityStatus status;
}

class FilterTasksByCustom1 implements PersistUI {
  FilterTasksByCustom1(this.value);

  final String value;
}

class FilterTasksByCustom2 implements PersistUI {
  FilterTasksByCustom2(this.value);

  final String value;
}

class FilterTasksByCustom3 implements PersistUI {
  FilterTasksByCustom3(this.value);

  final String value;
}

class FilterTasksByCustom4 implements PersistUI {
  FilterTasksByCustom4(this.value);

  final String value;
}

void handleTaskAction(
    BuildContext context, List<BaseEntity> tasks, EntityAction action) {
  if (tasks.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final localization = AppLocalization.of(context);
  final task = tasks.first as TaskEntity;
  final client = state.clientState.get(task.clientId);
  final taskIds = tasks.map((task) => task.id).toList();

  switch (action) {
    case EntityAction.edit:
      editEntity(context: context, entity: task);
      break;
    case EntityAction.start:
    case EntityAction.stop:
    case EntityAction.resume:
      final Completer<TaskEntity> completer = new Completer<TaskEntity>();
      final localization = AppLocalization.of(context);
      store
          .dispatch(SaveTaskRequest(completer: completer, task: task.toggle()));
      completer.future.then((savedTask) {
        showToast(savedTask.isRunning
            ? (savedTask.duration > 0
                ? localization.resumedTask
                : localization.startedTask)
            : localization.stoppedTask);
      }).catchError((Object error) {
        showDialog<ErrorDialog>(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(error);
            });
      });

      break;
    case EntityAction.invoiceTask:
      final items = tasks
          .where((entity) {
            final task = entity as TaskEntity;
            return !task.isDeleted && !task.isRunning && !task.isInvoiced;
          })
          .map((task) => convertTaskToInvoiceItem(task: task, context: context))
          .toList();
      if (items.isNotEmpty) {
        createEntity(
            context: context,
            entity: InvoiceEntity(state: state, client: client)
                .rebuild((b) => b..lineItems.addAll(items)));
      }
      break;
    case EntityAction.clone:
      createEntity(context: context, entity: task.clone);
      break;
    case EntityAction.restore:
      final message = taskIds.length > 1
          ? localization.restoredTasks
              .replaceFirst(':value', taskIds.length.toString())
          : localization.restoredTask;
      store.dispatch(RestoreTaskRequest(
          snackBarCompleter<Null>(context, message), taskIds));
      break;
    case EntityAction.archive:
      final message = taskIds.length > 1
          ? localization.archivedTasks
              .replaceFirst(':value', taskIds.length.toString())
          : localization.archivedTask;
      store.dispatch(ArchiveTaskRequest(
          snackBarCompleter<Null>(context, message), taskIds));
      break;
    case EntityAction.delete:
      final message = taskIds.length > 1
          ? localization.deletedTasks
              .replaceFirst(':value', taskIds.length.toString())
          : localization.deletedTask;
      store.dispatch(DeleteTaskRequest(
          snackBarCompleter<Null>(context, message), taskIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.taskListState.isInMultiselect()) {
        store.dispatch(StartTaskMultiselect());
      }

      if (tasks.isEmpty) {
        break;
      }

      for (final task in tasks) {
        if (!store.state.taskListState.isSelected(task.id)) {
          store.dispatch(AddToTaskMultiselect(entity: task));
        } else {
          store.dispatch(RemoveFromTaskMultiselect(entity: task));
        }
      }
      break;
    case EntityAction.more:
      showEntityActionsDialog(
        entities: [task],
        context: context,
      );
      break;
  }
}

class StartTaskMultiselect {}

class AddToTaskMultiselect {
  AddToTaskMultiselect({@required this.entity});

  final BaseEntity entity;
}

class RemoveFromTaskMultiselect {
  RemoveFromTaskMultiselect({@required this.entity});

  final BaseEntity entity;
}

class ClearTaskMultiselect {}

class SaveTaskDocumentRequest implements StartSaving {
  SaveTaskDocumentRequest({
    @required this.completer,
    @required this.multipartFile,
    @required this.task,
  });

  final Completer completer;
  final MultipartFile multipartFile;
  final TaskEntity task;
}

class SaveTaskDocumentSuccess implements StopSaving, PersistData, PersistUI {
  SaveTaskDocumentSuccess(this.document);

  final DocumentEntity document;
}

class SaveTaskDocumentFailure implements StopSaving {
  SaveTaskDocumentFailure(this.error);

  final Object error;
}

class UpdateTaskTab implements PersistUI {
  UpdateTaskTab({this.tabIndex});

  final int tabIndex;
}
