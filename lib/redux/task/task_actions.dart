// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ViewTaskList implements PersistUI {
  ViewTaskList({
    this.force = false,
    this.page = 0,
  });

  final bool force;
  final int? page;
}

class ViewTask implements PersistUI, PersistPrefs {
  ViewTask({
    required this.taskId,
    this.force = false,
  });

  final String? taskId;
  final bool force;
}

class EditTask implements PersistUI, PersistPrefs {
  EditTask(
      {this.task,
      this.taskTime,
      this.completer,
      this.force = false,
      this.taskTimeIndex});

  final int? taskTimeIndex;
  final TaskEntity? task;
  final TaskTime? taskTime;
  final Completer? completer;
  final bool force;
}

class UpdateTask implements PersistUI {
  UpdateTask(this.task);

  final TaskEntity task;
}

class LoadTask {
  LoadTask({this.completer, this.taskId});

  final Completer? completer;
  final String? taskId;
}

class LoadTaskActivity {
  LoadTaskActivity({this.completer, this.taskId});

  final Completer? completer;
  final String? taskId;
}

class LoadTasks {
  LoadTasks({this.completer, this.page = 1});

  final Completer? completer;
  final int page;
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

  final int? taskTimeIndex;
}

class AddTaskTime implements PersistUI {
  AddTaskTime(this.taskTime);

  final TaskTime taskTime;
}

class UpdateTaskTime implements PersistUI {
  UpdateTaskTime({this.index, this.taskTime});

  final int? index;
  final TaskTime? taskTime;
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
  SaveTaskRequest(
      {this.completer, this.task, this.autoSelect = true, this.action});

  final Completer? completer;
  final TaskEntity? task;
  final bool autoSelect;
  final EntityAction? action;
}

class SaveTaskSuccess implements StopSaving, PersistData, PersistUI {
  SaveTaskSuccess(this.task);

  final TaskEntity task;
}

class AddTaskSuccess implements StopSaving, PersistData, PersistUI {
  AddTaskSuccess({required this.task, this.autoSelect = true});

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

  final List<TaskEntity?> tasks;
}

class StartTasksRequest implements StartSaving {
  StartTasksRequest(this.completer, this.taskIds);

  final Completer completer;
  final List<String> taskIds;
}

class StartTasksSuccess implements StopSaving, PersistData {
  StartTasksSuccess(this.tasks);

  final List<TaskEntity> tasks;
}

class StartTasksFailure implements StopSaving {
  StartTasksFailure(this.tasks);

  final List<TaskEntity?> tasks;
}

class StopTasksRequest implements StartSaving {
  StopTasksRequest(this.completer, this.taskIds);

  final Completer completer;
  final List<String> taskIds;
}

class StopTasksSuccess implements StopSaving, PersistData {
  StopTasksSuccess(this.tasks);

  final List<TaskEntity> tasks;
}

class StopTasksFailure implements StopSaving {
  StopTasksFailure(this.tasks);

  final List<TaskEntity?> tasks;
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

  final List<TaskEntity?> tasks;
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

  final List<TaskEntity?> tasks;
}

class SortTasksRequest implements StartSaving {
  SortTasksRequest({this.completer, this.statusIds, this.taskIds});

  final Completer? completer;
  final List<String>? statusIds;
  final Map<String, List<String>>? taskIds;
}

class SortTasksSuccess implements StopSaving, PersistData {
  SortTasksSuccess({this.statusIds, this.taskIds});

  final List<String>? statusIds;
  final Map<String, List<String>>? taskIds;
}

class SortTasksFailure implements StopSaving {
  SortTasksFailure(this.error);

  final Object error;
}

class FilterTasks implements PersistUI {
  FilterTasks(this.filter);

  final String? filter;
}

class SortTasks implements PersistUI, PersistPrefs {
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

class UpdateKanban {}

void handleTaskAction(
    BuildContext? context, List<BaseEntity> tasks, EntityAction? action) {
  if (tasks.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context!);
  final state = store.state;
  final localization = AppLocalization.of(context);
  final task = tasks.first as TaskEntity;
  final client = state.clientState.get(task.clientId);
  final taskIds = tasks.map((task) => task.id).toList();

  switch (action) {
    case EntityAction.edit:
      editEntity(entity: task);
      break;
    case EntityAction.start:
    case EntityAction.resume:
      final message = taskIds.length > 1
          ? localization!.startedTasks
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', taskIds.length.toString())
          : localization!.startedTask;
      store.dispatch(
          StartTasksRequest(snackBarCompleter<Null>(message), taskIds));
      break;
    case EntityAction.stop:
      final message = taskIds.length > 1
          ? localization!.stoppedTasks
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', taskIds.length.toString())
          : localization!.stoppedTask;
      store.dispatch(
          StopTasksRequest(snackBarCompleter<Null>(message), taskIds));
      break;
    case EntityAction.invoiceTask:
    case EntityAction.addToInvoice:
      String lastClientId = '';
      bool hasMultipleClients = false;
      tasks.forEach((task) {
        final clientId = (task as TaskEntity).clientId;
        if (clientId.isNotEmpty) {
          if (lastClientId.isNotEmpty && lastClientId != clientId) {
            hasMultipleClients = true;
          }
          lastClientId = clientId;
        }
      });
      if (hasMultipleClients) {
        showErrorDialog(message: localization!.multipleClientError);
        return;
      }

      tasks.sort((taskA, taskB) {
        final taskAEntity = taskA as TaskEntity;
        final taskBEntity = taskB as TaskEntity;

        final taskAProjectId = taskAEntity.projectId;
        final taskBProjectId = taskBEntity.projectId;

        if (taskAProjectId != taskBProjectId) {
          return taskAProjectId.compareTo(taskBProjectId);
        }

        final taskATimes = taskAEntity.getTaskTimes();
        final taskBTimes = taskBEntity.getTaskTimes();
        final taskADate = taskATimes.isEmpty
            ? convertTimestampToDate(taskA.createdAt)
            : taskATimes.first.startDate!;
        final taskBDate = taskBTimes.isEmpty
            ? convertTimestampToDate(taskB.createdAt)
            : taskBTimes.first.startDate!;
        return taskADate.compareTo(taskBDate);
      });

      String projectId = '';
      for (var each in tasks) {
        final task = each as TaskEntity;
        if (task.projectId.isNotEmpty && projectId.isEmpty) {
          projectId = task.projectId;
        }
      }

      final company = state.company;
      final items = <InvoiceItemEntity>[];
      TaskEntity? lastTask;

      tasks.where((entity) {
        final task = entity as TaskEntity;
        return !task.isDeleted! && !task.isRunning && !task.isInvoiced;
      }).forEach((task) {
        items.add(convertTaskToInvoiceItem(
            task: task as TaskEntity,
            context: context,
            includeProjectHeader: company.invoiceTaskProject &&
                !company.hasCustomProductField(localization!.project) &&
                task.projectId != lastTask?.projectId));
        lastTask = task;
      });

      if (items.isNotEmpty) {
        if (action == EntityAction.invoiceTask) {
          createEntity(
              entity:
                  InvoiceEntity(state: state, client: client).rebuild((b) => b
                    ..lineItems.addAll(items)
                    ..projectId = projectId));
        } else {
          addToInvoiceDialog(
            context: context,
            clientId: task.clientId,
            items: items,
          );
        }
      }
      break;
    case EntityAction.clone:
      createEntity(entity: task.clone);
      break;
    case EntityAction.changeStatus:
      changeTaskStatusDialog(context: context, task: task);
      break;
    case EntityAction.restore:
      final message = taskIds.length > 1
          ? localization!.restoredTasks
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', taskIds.length.toString())
          : localization!.restoredTask;
      store.dispatch(
          RestoreTaskRequest(snackBarCompleter<Null>(message), taskIds));
      break;
    case EntityAction.archive:
      final message = taskIds.length > 1
          ? localization!.archivedTasks
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', taskIds.length.toString())
          : localization!.archivedTask;
      store.dispatch(
          ArchiveTaskRequest(snackBarCompleter<Null>(message), taskIds));
      break;
    case EntityAction.delete:
      final message = taskIds.length > 1
          ? localization!.deletedTasks
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', taskIds.length.toString())
          : localization!.deletedTask;
      store.dispatch(
          DeleteTaskRequest(snackBarCompleter<Null>(message), taskIds));
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
      );
      break;
    case EntityAction.documents:
      final documentIds = <String>[];
      for (var task in tasks) {
        for (var document in (task as TaskEntity).documents) {
          documentIds.add(document.id);
        }
      }
      if (documentIds.isEmpty) {
        showMessageDialog(message: localization!.noDocumentsToDownload);
      } else {
        store.dispatch(
          DownloadDocumentsRequest(
            documentIds: documentIds,
            completer: snackBarCompleter<Null>(
              localization!.exportedData,
            ),
          ),
        );
      }
      break;
    case EntityAction.runTemplate:
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => RunTemplateDialog(
          entityType: EntityType.task,
          entities: tasks,
        ),
      );
      break;
    default:
      print('## ERROR: unhandled action $action in task_actions');
      break;
  }
}

class StartTaskMultiselect {}

class AddToTaskMultiselect {
  AddToTaskMultiselect({required this.entity});

  final BaseEntity? entity;
}

class RemoveFromTaskMultiselect {
  RemoveFromTaskMultiselect({required this.entity});

  final BaseEntity? entity;
}

class ClearTaskMultiselect {}

class SaveTaskDocumentRequest implements StartSaving {
  SaveTaskDocumentRequest({
    required this.isPrivate,
    required this.completer,
    required this.multipartFiles,
    required this.task,
  });

  final bool isPrivate;
  final Completer completer;
  final List<MultipartFile> multipartFiles;
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

  final int? tabIndex;
}
