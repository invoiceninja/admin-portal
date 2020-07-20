import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ViewTaskList extends AbstractNavigatorAction
    implements PersistUI, StopLoading {
  ViewTaskList({@required NavigatorState navigator, this.force = false})
      : super(navigator: navigator);

  final bool force;
}

class ViewTask extends AbstractNavigatorAction
    implements PersistUI, PersistPrefs {
  ViewTask({
    @required this.taskId,
    @required NavigatorState navigator,
    this.force = false,
  }) : super(navigator: navigator);

  final String taskId;
  final bool force;
}

class EditTask extends AbstractNavigatorAction
    implements PersistUI, PersistPrefs {
  EditTask(
      {this.task,
      this.taskTime,
      @required NavigatorState navigator,
      this.completer,
      this.force = false,
      this.taskTimeIndex})
      : super(navigator: navigator);

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
  EditTaskTime([this.taskTime]);

  final TaskTime taskTime;
}

class AddTaskTime implements PersistUI {
  AddTaskTime(this.taskTime);

  final TaskTime taskTime;
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
  SaveTaskRequest({this.completer, this.task});

  final Completer completer;
  final TaskEntity task;
}

class SaveTaskSuccess implements StopSaving, PersistData, PersistUI {
  SaveTaskSuccess(this.task);

  final TaskEntity task;
}

class AddTaskSuccess implements StopSaving, PersistData, PersistUI {
  AddTaskSuccess(this.task);

  final TaskEntity task;
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
  assert(
      [
            EntityAction.restore,
            EntityAction.archive,
            EntityAction.delete,
            EntityAction.toggleMultiselect
          ].contains(action) ||
          tasks.length == 1,
      'Cannot perform this action on more than one task');

  if (tasks.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final localization = AppLocalization.of(context);
  final task = tasks.first as TaskEntity;
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
        Scaffold.of(context).showSnackBar(SnackBar(
            content: SnackBarRow(
          message: savedTask.isRunning
              ? (savedTask.duration > 0
                  ? localization.resumedTask
                  : localization.startedTask)
              : localization.stoppedTask,
        )));
      }).catchError((Object error) {
        showDialog<ErrorDialog>(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(error);
            });
      });

      break;
    case EntityAction.newInvoice:
      final item = convertTaskToInvoiceItem(task: task, context: context);
      createEntity(
          context: context,
          entity: InvoiceEntity(state: state).rebuild((b) => b
            ..hasTasks = true
            ..clientId = task.clientId
            ..lineItems.add(item)));
      break;
    case EntityAction.viewInvoice:
      viewEntityById(
          context: context,
          entityType: EntityType.invoice,
          entityId: task.invoiceId);
      break;
    case EntityAction.clone:
      createEntity(context: context, entity: task.clone);
      break;
    case EntityAction.restore:
      store.dispatch(RestoreTaskRequest(
          snackBarCompleter<Null>(context, localization.restoredTask),
          taskIds));
      break;
    case EntityAction.archive:
      store.dispatch(ArchiveTaskRequest(
          snackBarCompleter<Null>(context, localization.archivedTask),
          taskIds));
      break;
    case EntityAction.delete:
      store.dispatch(DeleteTaskRequest(
          snackBarCompleter<Null>(context, localization.deletedTask), taskIds));
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
