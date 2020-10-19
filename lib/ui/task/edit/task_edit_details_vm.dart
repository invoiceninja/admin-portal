import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/task/edit/task_edit_details.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/data/models/task_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class TaskEditDetailsScreen extends StatelessWidget {
  const TaskEditDetailsScreen({Key key}) : super(key: key);
  static const String route = '/task/edit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskEditDetailsVM>(
      converter: (Store<AppState> store) {
        return TaskEditDetailsVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return TaskEditDetails(
          viewModel: viewModel,
        );
      },
    );
  }
}

class TaskEditDetailsVM {
  TaskEditDetailsVM({
    @required this.state,
    @required this.task,
    @required this.taskTimeIndex,
    @required this.company,
    @required this.onChanged,
    @required this.onAddClientPressed,
    @required this.onAddProjectPressed,
    @required this.isSaving,
    @required this.origTask,
    @required this.isLoading,
  });

  factory TaskEditDetailsVM.fromStore(Store<AppState> store) {
    final task = store.state.taskUIState.editing;
    final state = store.state;

    return TaskEditDetailsVM(
      isLoading: state.isLoading,
      isSaving: state.isSaving,
      origTask: state.taskState.map[task.id],
      task: task,
      taskTimeIndex: state.taskUIState.editingTimeIndex,
      state: state,
      company: state.company,
      onChanged: (TaskEntity task) {
        store.dispatch(UpdateTask(task));
      },
      onAddClientPressed: (context, completer) {
        createEntity(
            context: context,
            entity: ClientEntity(),
            force: true,
            completer: completer,
            cancelCompleter: Completer<Null>()
              ..future.then((_) {
                store.dispatch(UpdateCurrentRoute(TaskEditDetailsScreen.route));
              }));
        completer.future.then((SelectableEntity client) {
          store.dispatch(UpdateCurrentRoute(TaskEditDetailsScreen.route));
        });
      },
      onAddProjectPressed: (context, completer) {
        createEntity(
            context: context,
            entity: ProjectEntity()
                .rebuild((b) => b..clientId = task.clientId ?? 0),
            force: true,
            completer: completer,
            cancelCompleter: Completer<Null>()
              ..future.then((_) {
                store.dispatch(UpdateCurrentRoute(TaskEditDetailsScreen.route));
              }));
        completer.future.then((SelectableEntity client) {
          store.dispatch(UpdateCurrentRoute(TaskEditDetailsScreen.route));
        });
      },
    );
  }

  final TaskEntity task;
  final int taskTimeIndex;
  final CompanyEntity company;
  final Function(TaskEntity) onChanged;
  final bool isLoading;
  final bool isSaving;
  final TaskEntity origTask;
  final AppState state;
  final Function(BuildContext context, Completer<SelectableEntity> completer)
      onAddClientPressed;
  final Function(BuildContext context, Completer<SelectableEntity> completer)
      onAddProjectPressed;
}
