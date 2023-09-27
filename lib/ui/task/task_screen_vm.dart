// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'task_screen.dart';

class TaskScreenBuilder extends StatelessWidget {
  const TaskScreenBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskScreenVM>(
      converter: TaskScreenVM.fromStore,
      builder: (context, vm) {
        return TaskScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class TaskScreenVM {
  TaskScreenVM({
    required this.isInMultiselect,
    required this.taskList,
    required this.userCompany,
    required this.taskMap,
  });

  final bool isInMultiselect;
  final UserCompanyEntity? userCompany;
  final List<String> taskList;
  final BuiltMap<String, TaskEntity> taskMap;

  static TaskScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return TaskScreenVM(
      taskMap: state.taskState.map,
      taskList: memoizedFilteredTaskList(
          state.getUISelection(EntityType.task),
          state.taskState.map,
          state.clientState.map,
          state.userState.map,
          state.projectState.map,
          state.invoiceState.map,
          state.taskStatusState.map,
          state.taskState.list,
          state.taskListState),
      userCompany: state.userCompany,
      isInMultiselect: state.taskListState.isInMultiselect(),
    );
  }
}
