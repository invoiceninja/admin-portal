import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/task/view/task_view_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/utils/app_context.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/data/models/task_model.dart';
import 'package:invoiceninja_flutter/ui/task/edit/task_edit.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class TaskEditScreen extends StatelessWidget {
  const TaskEditScreen({Key key}) : super(key: key);
  static const String route = '/task/edit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskEditVM>(
      converter: (Store<AppState> store) {
        return TaskEditVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return TaskEdit(
          viewModel: viewModel,
          key: ValueKey(viewModel.task.id),
        );
      },
    );
  }
}

class TaskEditVM {
  TaskEditVM({
    @required this.state,
    @required this.task,
    @required this.onFabPressed,
    @required this.taskTimeIndex,
    @required this.company,
    @required this.isSaving,
    @required this.origTask,
    @required this.onSavePressed,
    @required this.onCancelPressed,
    @required this.isLoading,
  });

  factory TaskEditVM.fromStore(Store<AppState> store) {
    final task = store.state.taskUIState.editing;
    final state = store.state;

    return TaskEditVM(
      isLoading: state.isLoading,
      isSaving: state.isSaving,
      origTask: state.taskState.map[task.id],
      task: task,
      taskTimeIndex: state.taskUIState.editingTimeIndex,
      state: state,
      company: state.company,
      onCancelPressed: (BuildContext context) {
        createEntity(context: context, entity: TaskEntity(), force: true);
        store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
      },
      onFabPressed: () {
        if (task.isRunning) {
          final taskTimes = task.getTaskTimes();
          store.dispatch(UpdateTaskTime(
              index: taskTimes.length - 1,
              taskTime: taskTimes.firstWhere((time) => time.isRunning).stop));
        } else {
          store.dispatch(AddTaskTime(TaskTime(), showAsRunning: true));
        }
      },
      onSavePressed: (BuildContext context) {
        final appContext = context.getAppContext();
        Debouncer.runOnComplete(() {
          final task = store.state.taskUIState.editing;
          if (!task.areTimesValid) {
            showDialog<ErrorDialog>(
                context: navigatorKey.currentContext,
                builder: (BuildContext context) {
                  return ErrorDialog(appContext.localization.taskErrors);
                });
            return null;
          }

          final localization = appContext.localization;
          final Completer<TaskEntity> completer = new Completer<TaskEntity>();
          store.dispatch(SaveTaskRequest(completer: completer, task: task));
          return completer.future.then((savedTask) {
            showToast(task.isNew
                ? localization.createTask
                : localization.updatedTask);

            if (state.prefState.isMobile) {
              store.dispatch(UpdateCurrentRoute(TaskViewScreen.route));
              if (task.isNew) {
                appContext.navigator.pushReplacementNamed(TaskViewScreen.route);
              } else {
                appContext.navigator.pop(savedTask);
              }
            } else {
              viewEntity(
                  appContext: appContext, entity: savedTask, force: true);
            }
          }).catchError((Object error) {
            showDialog<ErrorDialog>(
                context: navigatorKey.currentContext,
                builder: (BuildContext context) {
                  return ErrorDialog(error);
                });
          });
        });
      },
    );
  }

  final TaskEntity task;
  final int taskTimeIndex;
  final CompanyEntity company;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final Function onFabPressed;
  final bool isLoading;
  final bool isSaving;
  final TaskEntity origTask;
  final AppState state;
}
