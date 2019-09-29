import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/ui/task/task_list.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';

class TaskListBuilder extends StatelessWidget {
  const TaskListBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskListVM>(
      converter: TaskListVM.fromStore,
      builder: (context, viewModel) {
        return TaskList(
          viewModel: viewModel,
        );
      },
    );
  }
}

class TaskListVM {
  TaskListVM({
    @required this.state,
    @required this.user,
    @required this.taskList,
    @required this.taskMap,
    @required this.clientMap,
    @required this.filter,
    @required this.isLoading,
    @required this.isLoaded,
    @required this.onTaskTap,
    @required this.listState,
    @required this.onRefreshed,
    @required this.onEntityAction,
    @required this.onClearEntityFilterPressed,
    @required this.onViewEntityFilterPressed,
  });

  static TaskListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>(null);
      }
      final completer = snackBarCompleter(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadTasks(completer: completer, force: true));
      return completer.future;
    }

    final state = store.state;

    return TaskListVM(
      state: state,
      user: state.user,
      listState: state.taskListState,
      taskList: memoizedFilteredTaskList(
          state.taskState.map,
          state.clientState.map,
          state.projectState.map,
          state.taskState.list,
          state.taskListState),
      taskMap: state.taskState.map,
      clientMap: state.clientState.map,
      isLoading: state.isLoading,
      isLoaded: state.taskState.isLoaded,
      filter: state.taskUIState.listUIState.filter,
      onClearEntityFilterPressed: () => store.dispatch(FilterTasksByEntity()),
      onViewEntityFilterPressed: (BuildContext context) {
        switch (state.taskListState.filterEntityType) {
          case EntityType.client:
            store.dispatch(ViewClient(
                clientId: state.taskListState.filterEntityId,
                context: context));
            break;
          case EntityType.project:
            store.dispatch(ViewProject(
                projectId: state.taskListState.filterEntityId,
                context: context));
            break;
        }
      },
      onTaskTap: (context, task) {
        store.dispatch(ViewTask(taskId: task.id, context: context));
      },
      onEntityAction:
          (BuildContext context, List<BaseEntity> tasks, EntityAction action) =>
              handleTaskAction(context, tasks, action),
      onRefreshed: (context) => _handleRefresh(context),
    );
  }

  final AppState state;
  final UserEntity user;
  final List<String> taskList;
  final BuiltMap<String, TaskEntity> taskMap;
  final BuiltMap<String, ClientEntity> clientMap;
  final ListUIState listState;
  final String filter;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext, TaskEntity) onTaskTap;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, List<TaskEntity>, EntityAction) onEntityAction;
  final Function onClearEntityFilterPressed;
  final Function(BuildContext) onViewEntityFilterPressed;
}
