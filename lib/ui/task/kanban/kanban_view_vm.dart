// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:invoiceninja_flutter/redux/task_status/task_status_actions.dart';
import 'package:invoiceninja_flutter/ui/task/kanban/kanban_view.dart';

class KanbanViewBuilder extends StatefulWidget {
  const KanbanViewBuilder({Key? key}) : super(key: key);

  @override
  _KanbanViewBuilderState createState() => _KanbanViewBuilderState();
}

class _KanbanViewBuilderState extends State<KanbanViewBuilder> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, KanbanVM>(
      converter: KanbanVM.fromStore,
      builder: (context, viewModel) {
        final state = viewModel.state;
        final company = state.company;
        return KanbanView(
          viewModel: viewModel,
          key: ValueKey(
              '__${company.id}_${state.userCompanyState.lastUpdated}_${viewModel.filteredTaskList.length}_${state.taskUIState.kanbanLastUpdated}__'),
        );
      },
    );
  }
}

class KanbanVM {
  KanbanVM({
    required this.state,
    required this.taskList,
    required this.filteredTaskList,
    required this.onSaveTaskPressed,
    required this.onSaveStatusPressed,
    required this.onBoardChanged,
  });

  static KanbanVM fromStore(Store<AppState> store) {
    final state = store.state;

    return KanbanVM(
      state: state,
      taskList: memoizedKanbanTaskList(
          state.getUISelection(EntityType.task),
          state.taskState.map,
          state.clientState.map,
          state.userState.map,
          state.projectState.map,
          state.invoiceState.map,
          state.taskStatusState.map,
          state.taskState.list,
          state.taskListState),
      filteredTaskList: memoizedFilteredTaskList(
          state.getUISelection(EntityType.task),
          state.taskState.map,
          state.clientState.map,
          state.userState.map,
          state.projectState.map,
          state.invoiceState.map,
          state.taskStatusState.map,
          state.taskState.list,
          state.taskListState),
      onBoardChanged: (completer, statusIds, taskIds) {
        store.dispatch(SortTasksRequest(
          completer: completer,
          taskIds: taskIds,
          statusIds: statusIds,
        ));
      },
      onSaveStatusPressed: (completer, statusId, name, statusOrder) {
        TaskStatusEntity status = state.taskStatusState.get(statusId);
        status = status.rebuild((b) => b
          ..name = name
          ..statusOrder = status.isNew ? statusOrder : status.statusOrder);

        store.dispatch(SaveTaskStatusRequest(
          completer: completer,
          taskStatus: status,
        ));
      },
      onSaveTaskPressed:
          (completer, taskId, statusId, description, statusOrder) {
        TaskEntity task = state.taskState.get(taskId);
        task = task.rebuild((b) => b
          ..description = description
          ..statusOrder = task.isNew ? statusOrder : task.statusOrder
          ..statusId = statusId);
        if (task.isNew) {
          final uiState = state.uiState;
          if (uiState.filterEntityType == EntityType.client) {
            task = task.rebuild((b) => b..clientId = uiState.filterEntityId);
          } else if (uiState.filterEntityType == EntityType.project) {
            final project = state.projectState.get(uiState.filterEntityId!);
            task = task.rebuild((b) => b
              ..projectId = uiState.filterEntityId
              ..clientId = project.clientId);
          } else if (uiState.filterEntityType == EntityType.user) {
            task =
                task.rebuild((b) => b..assignedUserId = uiState.filterEntityId);
          }
        }

        store.dispatch(SaveTaskRequest(
          completer: completer,
          task: task,
          autoSelect: false,
        ));
      },
    );
  }

  final AppState state;
  final List<String> taskList;
  final List<String> filteredTaskList;
  final Function(Completer<Null>, List<String>?, Map<String, List<String>>?)
      onBoardChanged;
  final Function(Completer<TaskEntity>, String, String, String, int)
      onSaveTaskPressed;
  final Function(Completer<TaskStatusEntity>, String, String, int)
      onSaveStatusPressed;
}
