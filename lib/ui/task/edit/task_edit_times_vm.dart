import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/ui/task/edit/task_edit_times.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class TaskEditTimesScreen extends StatelessWidget {
  const TaskEditTimesScreen({Key key}) : super(key: key);

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
    @required this.company,
    @required this.task,
    @required this.taskTime,
    @required this.onRemoveTaskTimePressed,
    @required this.onDoneTaskTimePressed,
  });

  factory TaskEditTimesVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final task = state.taskUIState.editing;

    return TaskEditTimesVM(
      company: state.selectedCompany,
      task: task,
      taskTime: state.taskUIState.editingTime,
      onRemoveTaskTimePressed: (index) => store.dispatch(DeleteTaskTime(index)),
      onDoneTaskTimePressed: (taskTime, index) {
        store.dispatch(UpdateTaskTime(taskTime: taskTime, index: index));
        store.dispatch(EditTaskTime());
      },
    );
  }

  final CompanyEntity company;
  final TaskEntity task;
  final TaskTime taskTime;
  final Function(int) onRemoveTaskTimePressed;
  final Function(TaskTime, int) onDoneTaskTimePressed;
}
