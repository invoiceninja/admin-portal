import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/task_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:invoiceninja_flutter/ui/task/task_screen.dart';
import 'package:invoiceninja_flutter/ui/task/view/task_view.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';

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
    @required this.onEntityAction,
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
      final completer = snackBarCompleter<Null>(
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
      company: state.company,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: task.isNew,
      task: task,
      client: client,
      project: project,
      onFabPressed: (BuildContext context) => _toggleTask(context),
      onClientPressed: (BuildContext context, [bool longPress = false]) {
        if (longPress) {
          showEntityActionsDialog(
            context: context,
            entities: [client],
          );
        } else {
          store.dispatch(ViewClient(clientId: client.id));
        }
      },
      onProjectPressed: (context, [longPress = false]) {
        if (longPress) {
          showEntityActionsDialog(
            context: context,
            entities: [project],
            client: client,
          );
        } else {
          store.dispatch(ViewProject(projectId: project.id, context: context));
        }
      },
      onInvoicePressed: (context, [longPress = false]) {
        if (longPress) {
          showEntityActionsDialog(
            context: context,
            entities: [invoice],
            client: client,
          );
        } else {
          store.dispatch(ViewInvoice(invoiceId: invoice.id, context: context));
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
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleTaskAction(context, [task], action),
    );
  }

  final AppState state;
  final TaskEntity task;
  final ClientEntity client;
  final ProjectEntity project;
  final CompanyEntity company;
  final Function(BuildContext, EntityAction) onEntityAction;
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
