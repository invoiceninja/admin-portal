import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:invoiceninja_flutter/ui/task/task_screen.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/task/view/task_view_vm.dart';
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
    @required this.company,
    @required this.onChanged,
    @required this.onAddClientPressed,
    @required this.onAddProjectPressed,
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
      state: state,
      company: state.selectedCompany,
      onChanged: (TaskEntity task) {
        store.dispatch(UpdateTask(task));
      },
      onBackPressed: () {
        if (state.uiState.currentRoute.contains(TaskScreen.route)) {
          store.dispatch(UpdateCurrentRoute(TaskScreen.route));
        }
      },
      onAddClientPressed: (context, completer) {
        store.dispatch(EditClient(
            client: ClientEntity(),
            context: context,
            completer: completer,
            trackRoute: false));
        completer.future.then((SelectableEntity client) {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: SnackBarRow(
            message: AppLocalization.of(context).createdClient,
          )));
        });
      },
      onAddProjectPressed: (context, completer) {
        store.dispatch(EditProject(
            project:
                ProjectEntity().rebuild((b) => b..clientId = task.clientId),
            context: context,
            completer: completer,
            trackRoute: false));
        completer.future.then((SelectableEntity client) {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: SnackBarRow(
            message: AppLocalization.of(context).createdProject,
          )));
        });
      },
      onSavePressed: (BuildContext context) {
        final Completer<TaskEntity> completer = new Completer<TaskEntity>();
        store.dispatch(SaveTaskRequest(completer: completer, task: task));
        return completer.future.then((_) {
          return completer.future.then((savedTask) {
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
        });
      },
    );
  }

  final TaskEntity task;
  final CompanyEntity company;
  final Function(TaskEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function onBackPressed;
  final bool isLoading;
  final bool isSaving;
  final TaskEntity origTask;
  final AppState state;
  final Function(BuildContext context, Completer<SelectableEntity> completer)
      onAddClientPressed;
  final Function(BuildContext context, Completer<SelectableEntity> completer)
      onAddProjectPressed;
}
