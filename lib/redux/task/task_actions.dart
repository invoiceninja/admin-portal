import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';

class ViewTaskList implements PersistUI {
  ViewTaskList(this.context);

  final BuildContext context;
}

class ViewTask implements PersistUI {
  ViewTask({this.taskId, this.context});

  final int taskId;
  final BuildContext context;
}

class EditTask implements PersistUI {
  EditTask(
      {this.task,
      this.taskTime,
      this.context,
      this.completer,
      this.trackRoute = true,
      this.taskTimeIndex});

  final int taskTimeIndex;
  final TaskEntity task;
  final TaskTime taskTime;
  final BuildContext context;
  final Completer completer;
  final bool trackRoute;
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
