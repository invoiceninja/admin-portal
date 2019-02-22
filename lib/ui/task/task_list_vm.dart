import 'dart:async';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/task/task_list.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';

class TaskListBuilder extends StatelessWidget {
  const TaskListBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskListVM>(
      converter: TaskListVM.fromStore,
      builder: (context, viewModel) {
        return TaskList(
          viewModel: viewModel,
        );
      },
    );
  }
}

class TaskListVM {
  TaskListVM({
    @required this.state,
    @required this.user,
    @required this.taskList,
    @required this.taskMap,
    @required this.clientMap,
    @required this.filter,
    @required this.isLoading,
    @required this.isLoaded,
    @required this.onTaskTap,
    @required this.listState,
    @required this.onRefreshed,
    @required this.onEntityAction,
    @required this.onClearEntityFilterPressed,
    @required this.onViewEntityFilterPressed,
  });

  static TaskListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>(null);
      }
      final completer = snackBarCompleter(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadTasks(completer: completer, force: true));
      return completer.future;
    }

    final state = store.state;

    return TaskListVM(
      state: state,
      user: state.user,
      listState: state.taskListState,
      taskList: memoizedFilteredTaskList(
          state.taskState.map,
          state.clientState.map,
          state.projectState.map,
          state.taskState.list,
          state.taskListState),
      taskMap: state.taskState.map,
      clientMap: state.clientState.map,
      isLoading: state.isLoading,
      isLoaded: state.taskState.isLoaded,
      filter: state.taskUIState.listUIState.filter,
      onClearEntityFilterPressed: () => store.dispatch(FilterTasksByEntity()),
      onViewEntityFilterPressed: (BuildContext context) {
        switch (state.taskListState.filterEntityType) {
          case EntityType.client:
            store.dispatch(ViewClient(
                clientId: state.taskListState.filterEntityId,
                context: context));
            break;
          case EntityType.project:
            store.dispatch(ViewProject(
                projectId: state.taskListState.filterEntityId,
                context: context));
            break;
        }
      },
      onTaskTap: (context, task) {
        store.dispatch(ViewTask(taskId: task.id, context: context));
      },
      onEntityAction: (context, task, action) {
        switch (action) {
          case EntityAction.edit:
            store.dispatch(
                EditTask(context: context, task: task));
            break;
          case EntityAction.start:
          case EntityAction.stop:
          case EntityAction.resume:
            final Completer<TaskEntity> completer = new Completer<TaskEntity>();
            final localization = AppLocalization.of(context);
            store.dispatch(
                SaveTaskRequest(completer: completer, task: task.toggle()));
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
                invoice: InvoiceEntity(company: state.selectedCompany)
                    .rebuild((b) => b
                      ..hasTasks = true
                      ..clientId = task.clientId
                      ..invoiceItems.add(item)),
                context: context));
            break;
          case EntityAction.viewInvoice:
            store.dispatch(
                ViewInvoice(invoiceId: task.invoiceId, context: context));
            break;
          case EntityAction.clone:
            store.dispatch(EditTask(context: context, task: task.clone));
            break;
          case EntityAction.restore:
            store.dispatch(RestoreTaskRequest(
                snackBarCompleter(
                    context, AppLocalization.of(context).restoredTask),
                task.id));
            break;
          case EntityAction.archive:
            store.dispatch(ArchiveTaskRequest(
                snackBarCompleter(
                    context, AppLocalization.of(context).archivedTask),
                task.id));
            break;
          case EntityAction.delete:
            store.dispatch(DeleteTaskRequest(
                snackBarCompleter(
                    context, AppLocalization.of(context).deletedTask),
                task.id));
            break;
        }
      },
      onRefreshed: (context) => _handleRefresh(context),
    );
  }

  final AppState state;
  final UserEntity user;
  final List<int> taskList;
  final BuiltMap<int, TaskEntity> taskMap;
  final BuiltMap<int, ClientEntity> clientMap;
  final ListUIState listState;
  final String filter;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext, TaskEntity) onTaskTap;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, TaskEntity, EntityAction) onEntityAction;
  final Function onClearEntityFilterPressed;
  final Function(BuildContext) onViewEntityFilterPressed;
}
