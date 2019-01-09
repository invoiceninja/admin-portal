import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/task/task_screen.dart';
import 'package:invoiceninja_flutter/ui/task/view/task_view_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
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
    @required this.taskTime,
    @required this.company,
    @required this.isSaving,
    @required this.origTask,
    @required this.onSavePressed,
    @required this.onBackPressed,
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
      taskTime: state.taskUIState.editingTime,
      state: state,
      company: state.selectedCompany,
      onBackPressed: () {
        if (state.uiState.currentRoute.contains(TaskScreen.route)) {
          store.dispatch(UpdateCurrentRoute(TaskScreen.route));
        }
      },
      onFabPressed: () {
        if (task.isRunning) {
          final taskTimes = task.taskTimes;
          store.dispatch(UpdateTaskTime(
              index: taskTimes.length - 1, taskTime: taskTimes.last.stop));
        } else {
          store.dispatch(AddTaskTime(TaskTime()));
        }
      },
      onSavePressed: (BuildContext context) {
        if (!task.areTimesValid) {
          showDialog<ErrorDialog>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(AppLocalization.of(context).taskErrors);
              });
          return null;
        }

        final Completer<TaskEntity> completer = new Completer<TaskEntity>();
        store.dispatch(SaveTaskRequest(completer: completer, task: task));
        return completer.future.then((savedTask) {
          store.dispatch(UpdateCurrentRoute(TaskViewScreen.route));
          if (task.isNew) {
            Navigator.of(context).pushReplacementNamed(TaskViewScreen.route);
          } else {
            Navigator.of(context).pop(savedTask);
          }
        }).catchError((Object error) {
          showDialog<ErrorDialog>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(error);
              });
        });
      },
    );
  }

  final TaskEntity task;
  final TaskTime taskTime;
  final CompanyEntity company;
  final Function(BuildContext) onSavePressed;
  final Function onFabPressed;
  final Function onBackPressed;
  final bool isLoading;
  final bool isSaving;
  final TaskEntity origTask;
  final AppState state;
}
