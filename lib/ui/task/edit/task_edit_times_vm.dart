// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/ui/task/edit/task_edit_times.dart';

class TaskEditTimesScreen extends StatelessWidget {
  const TaskEditTimesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskEditTimesVM>(
      converter: (Store<AppState> store) {
        return TaskEditTimesVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return TaskEditTimes(
          viewModel: viewModel,
        );
      },
    );
  }
}

class TaskEditTimesVM {
  TaskEditTimesVM({
    required this.company,
    required this.task,
    required this.taskTimeIndex,
    required this.onRemoveTaskTimePressed,
    required this.onDoneTaskTimePressed,
    required this.onUpdatedTaskTime,
    required this.clearSelectedTaskTime,
  });

  factory TaskEditTimesVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final task = state.taskUIState.editing;

    return TaskEditTimesVM(
      company: state.company,
      task: task,
      taskTimeIndex: state.taskUIState.editingTimeIndex,
      onRemoveTaskTimePressed: (index) => store.dispatch(DeleteTaskTime(index)),
      onDoneTaskTimePressed: () {
        store.dispatch(EditTaskTime());
      },
      onUpdatedTaskTime: (taskTime, index) {
        store.dispatch(UpdateTaskTime(taskTime: taskTime, index: index));
      },
      clearSelectedTaskTime: () => store.dispatch(EditTaskTime()),
    );
  }

  final CompanyEntity? company;
  final TaskEntity? task;
  final int? taskTimeIndex;
  final Function(int) onRemoveTaskTimePressed;
  final Function onDoneTaskTimePressed;
  final Function(TaskTime?, int) onUpdatedTaskTime;
  final Function clearSelectedTaskTime;
}
