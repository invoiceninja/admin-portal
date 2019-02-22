import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/task/task_screen.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/data/models/task_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/task/view/task_view.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class TaskViewScreen extends StatelessWidget {
  const TaskViewScreen({Key key}) : super(key: key);
  static const String route = '/task/view';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskViewVM>(
      converter: (Store<AppState> store) {
        return TaskViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return TaskView(
          viewModel: vm,
        );
      },
    );
  }
}

class TaskViewVM {
  TaskViewVM({
    @required this.onFabPressed,
    @required this.task,
    @required this.client,
    @required this.project,
    @required this.company,
    @required this.state,
    @required this.onActionSelected,
    @required this.onEditPressed,
    @required this.onBackPressed,
    @required this.onRefreshed,
    @required this.onClientPressed,
    @required this.onProjectPressed,
    @required this.onInvoicePressed,
    @required this.isSaving,
    @required this.isLoading,
    @required this.isDirty,
  });

  factory TaskViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final task = state.taskState.map[state.taskUIState.selectedId] ??
        TaskEntity(id: state.taskUIState.selectedId);
    final client = state.clientState.map[task.clientId];
    final project = state.projectState.map[task.projectId];
    final invoice = state.invoiceState.map[task.invoiceId];

    Future<Null> _handleRefresh(BuildContext context) {
      final completer = snackBarCompleter(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadTask(completer: completer, taskId: task.id));
      return completer.future;
    }

    void _toggleTask(BuildContext context) {
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
    }

    return TaskViewVM(
        state: state,
        company: state.selectedCompany,
        isSaving: state.isSaving,
        isLoading: state.isLoading,
        isDirty: task.isNew,
        task: task,
        client: client,
        project: project,
        onFabPressed: (BuildContext context) => _toggleTask(context),
        onClientPressed: (context, [longPress = false]) {
          if (longPress) {
            store.dispatch(EditClient(client: client, context: context));
          } else {
            store.dispatch(ViewClient(clientId: client.id, context: context));
          }
        },
        onProjectPressed: (context, [longPress = false]) {
          if (longPress) {
            store.dispatch(EditProject(project: project, context: context));
          } else {
            store
                .dispatch(ViewProject(projectId: project.id, context: context));
          }
        },
        onInvoicePressed: (context, [longPress = false]) {
          if (longPress) {
            store.dispatch(EditInvoice(invoice: invoice, context: context));
          } else {
            store
                .dispatch(ViewInvoice(invoiceId: invoice.id, context: context));
          }
        },
        onEditPressed: (BuildContext context, [TaskTime taskTime]) {
          final Completer<TaskEntity> completer = new Completer<TaskEntity>();
          store.dispatch(EditTask(
            task: task,
            taskTime: taskTime,
            context: context,
            completer: completer,
          ));
          completer.future.then((task) {
            Scaffold.of(context).showSnackBar(SnackBar(
                content: SnackBarRow(
              message: AppLocalization.of(context).updatedTask,
            )));
          });
        },
        onRefreshed: (context) => _handleRefresh(context),
        onBackPressed: () {
          if (state.uiState.currentRoute.contains(TaskScreen.route)) {
            store.dispatch(UpdateCurrentRoute(TaskScreen.route));
          }
        },
        onActionSelected: (BuildContext context, EntityAction action) {
          final localization = AppLocalization.of(context);
          switch (action) {
            case EntityAction.resume:
            case EntityAction.start:
            case EntityAction.stop:
              _toggleTask(context);
              break;
            case EntityAction.newInvoice:
              final item =
                  convertTaskToInvoiceItem(task: task, context: context);
              store.dispatch(EditInvoice(
                  invoice: InvoiceEntity(company: state.selectedCompany)
                      .rebuild((b) => b
                        ..hasTasks = true
                        ..clientId = task.clientId
                        ..invoiceItems.add(item)),
                  context: context));
              break;
            case EntityAction.clone:
              store.dispatch(EditTask(context: context, task: task.clone));
              break;
            case EntityAction.viewInvoice:
              store.dispatch(
                  ViewInvoice(invoiceId: task.invoiceId, context: context));
              break;
            case EntityAction.archive:
              store.dispatch(ArchiveTaskRequest(
                  popCompleter(context, localization.archivedTask), task.id));
              break;
            case EntityAction.delete:
              store.dispatch(DeleteTaskRequest(
                  popCompleter(context, localization.deletedTask), task.id));
              break;
            case EntityAction.restore:
              store.dispatch(RestoreTaskRequest(
                  snackBarCompleter(context, localization.restoredTask),
                  task.id));
              break;
          }
        });
  }

  final AppState state;
  final TaskEntity task;
  final ClientEntity client;
  final ProjectEntity project;
  final CompanyEntity company;
  final Function(BuildContext, EntityAction) onActionSelected;
  final Function(BuildContext, [TaskTime]) onEditPressed;
  final Function onBackPressed;
  final Function(BuildContext) onFabPressed;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, [bool]) onClientPressed;
  final Function(BuildContext, [bool]) onProjectPressed;
  final Function(BuildContext, [bool]) onInvoicePressed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
