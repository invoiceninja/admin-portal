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
import 'package:invoiceninja_flutter/redux/task_status/task_status_actions.dart';
import 'package:invoiceninja_flutter/redux/task_status/task_status_selectors.dart';
import 'task_status_screen.dart';

class TaskStatusScreenBuilder extends StatelessWidget {
  const TaskStatusScreenBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskStatusScreenVM>(
      converter: TaskStatusScreenVM.fromStore,
      builder: (context, vm) {
        return TaskStatusScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class TaskStatusScreenVM {
  TaskStatusScreenVM({
    required this.isInMultiselect,
    required this.taskStatusList,
    required this.userCompany,
    required this.onEntityAction,
    required this.taskStatusMap,
  });

  final bool isInMultiselect;
  final UserCompanyEntity? userCompany;
  final List<String> taskStatusList;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final BuiltMap<String?, TaskStatusEntity?> taskStatusMap;

  static TaskStatusScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return TaskStatusScreenVM(
      taskStatusMap: state.taskStatusState.map,
      taskStatusList: memoizedFilteredTaskStatusList(
          state.getUISelection(EntityType.taskStatus),
          state.taskStatusState.map,
          state.taskStatusState.list,
          state.taskStatusListState),
      userCompany: state.userCompany,
      isInMultiselect: state.taskStatusListState.isInMultiselect(),
      onEntityAction: (BuildContext context, List<BaseEntity> taskStatuses,
              EntityAction action) =>
          handleTaskStatusAction(context, taskStatuses, action),
    );
  }
}
