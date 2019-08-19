import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';

class ViewTaskList implements PersistUI {
  ViewTaskList({@required this.context, this.force = false});

  final BuildContext context;
  final bool force;
}

class ViewTask implements PersistUI {
  ViewTask({
    @required this.taskId,
    @required this.context,
    this.force = false,
  });

  final int taskId;
  final BuildContext context;
  final bool force;
}

class EditTask implements PersistUI {
  EditTask(
      {this.task,
      this.taskTime,
      this.context,
      this.completer,
      this.trackRoute = true,
      this.force = false,
      this.taskTimeIndex});

  final int taskTimeIndex;
  final TaskEntity task;
  final TaskTime taskTime;
  final BuildContext context;
  final Completer completer;
  final bool trackRoute;
  final bool force;
}

class UpdateTask implements PersistUI {
  UpdateTask(this.task);

  final TaskEntity task;
}

class LoadTask {
  LoadTask({this.completer, this.taskId, this.loadActivities = false});

  final Completer completer;
  final int taskId;
  final bool loadActivities;
}

class LoadTaskActivity {
  LoadTaskActivity({this.completer, this.taskId});

  final Completer completer;
  final int taskId;
}

class LoadTasks {
  LoadTasks({this.completer, this.force = false});

  final Completer completer;
  final bool force;
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

class LoadTasksSuccess implements StopLoading, PersistData {
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
  ArchiveTaskRequest(this.completer, this.taskId);

  final Completer completer;
  final int taskId;
}

class ArchiveTaskSuccess implements StopSaving, PersistData {
  ArchiveTaskSuccess(this.task);

  final TaskEntity task;
}

class ArchiveTaskFailure implements StopSaving {
  ArchiveTaskFailure(this.task);

  final TaskEntity task;
}

class DeleteTaskRequest implements StartSaving {
  DeleteTaskRequest(this.completer, this.taskId);

  final Completer completer;
  final int taskId;
}

class DeleteTaskSuccess implements StopSaving, PersistData {
  DeleteTaskSuccess(this.task);

  final TaskEntity task;
}

class DeleteTaskFailure implements StopSaving {
  DeleteTaskFailure(this.task);

  final TaskEntity task;
}

class RestoreTaskRequest implements StartSaving {
  RestoreTaskRequest(this.completer, this.taskId);

  final Completer completer;
  final int taskId;
}

class RestoreTaskSuccess implements StopSaving, PersistData {
  RestoreTaskSuccess(this.task);

  final TaskEntity task;
}

class RestoreTaskFailure implements StopSaving {
  RestoreTaskFailure(this.task);

  final TaskEntity task;
}

class FilterTasks {
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

class FilterTasksByEntity implements PersistUI {
  FilterTasksByEntity({this.entityId, this.entityType});

  final int entityId;
  final EntityType entityType;
}

void handleTaskAction(
    BuildContext context, TaskEntity task, EntityAction action) {
  final store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final CompanyEntity company = state.selectedCompany;
  final localization = AppLocalization.of(context);

  switch (action) {
    case EntityAction.edit:
      store.dispatch(EditTask(context: context, task: task));
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
      store.dispatch(EditInvoice(
          invoice: InvoiceEntity(company: company).rebuild((b) => b
            ..hasTasks = true
            ..clientId = task.clientId
            ..invoiceItems.add(item)),
          context: context));
      break;
    case EntityAction.viewInvoice:
      store.dispatch(ViewInvoice(invoiceId: task.invoiceId, context: context));
      break;
    case EntityAction.clone:
      store.dispatch(EditTask(context: context, task: task.clone));
      break;
    case EntityAction.restore:
      store.dispatch(RestoreTaskRequest(
          snackBarCompleter(context, localization.restoredTask), task.id));
      break;
    case EntityAction.archive:
      store.dispatch(ArchiveTaskRequest(
          snackBarCompleter(context, localization.archivedTask), task.id));
      break;
    case EntityAction.delete:
      store.dispatch(DeleteTaskRequest(
          snackBarCompleter(context, localization.deletedTask), task.id));
      break;
  }
}
