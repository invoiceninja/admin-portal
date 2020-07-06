import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/task/task_list_item.dart';
import 'package:invoiceninja_flutter/ui/task/task_presenter.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';

class TaskListBuilder extends StatelessWidget {
  const TaskListBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskListVM>(
      converter: TaskListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            isLoaded: viewModel.isLoaded,
            entityType: EntityType.taxRate,
            presenter: TaskPresenter(),
            state: viewModel.state,
            entityList: viewModel.taskList,
            onEntityTap: viewModel.onTaskTap,
            tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onClearEntityFilterPressed: viewModel.onClearEntityFilterPressed,
            onViewEntityFilterPressed: viewModel.onViewEntityFilterPressed,
            onSortColumn: viewModel.onSortColumn,
            itemBuilder: (BuildContext context, index) {
              final taskId = viewModel.taskList[index];
              final task = viewModel.taskMap[taskId];
              final client =
                  viewModel.clientMap[task.clientId] ?? ClientEntity();
              final state = viewModel.state;
              final listUIState = state.getListState(EntityType.client);
              final isInMultiselect = listUIState.isInMultiselect();

              void showDialog() => showEntityActionsDialog(
                    entities: [task],
                    context: context,
                    client: client,
                  );

              return TaskListItem(
                userCompany: viewModel.state.userCompany,
                filter: viewModel.filter,
                task: task,
                client: viewModel.clientMap[task.clientId] ?? ClientEntity(),
                project: viewModel.state.projectState.map[task.projectId],
                onTap: () => viewModel.onTaskTap(context, task),
                onEntityAction: (EntityAction action) {
                  if (action == EntityAction.more) {
                    showDialog();
                  } else {
                    handleTaskAction(context, [task], action);
                  }
                },
                onLongPress: () async {
                  final longPressIsSelection =
                      viewModel.state.prefState.longPressSelectionIsDefault ??
                          true;
                  if (longPressIsSelection && !isInMultiselect) {
                    handleTaskAction(
                        context, [task], EntityAction.toggleMultiselect);
                  } else {
                    showDialog();
                  }
                },
                isChecked: isInMultiselect && listUIState.isSelected(task.id),
              );
            });
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
    @required this.tableColumns,
    @required this.onClearEntityFilterPressed,
    @required this.onViewEntityFilterPressed,
    @required this.onSortColumn,
  });

  static TaskListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>(null);
      }
      final completer = snackBarCompleter<Null>(
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
          state.userState.map,
          state.projectState.map,
          state.invoiceState.map,
          state.taskState.list,
          state.taskListState),
      taskMap: state.taskState.map,
      clientMap: state.clientState.map,
      isLoading: state.isLoading,
      isLoaded: state.taskState.isLoaded,
      filter: state.taskUIState.listUIState.filter,
      onClearEntityFilterPressed: () => store.dispatch(ClearEntityFilter()),
      onViewEntityFilterPressed: (BuildContext context) => viewEntityById(
          context: context,
          entityId: state.taskListState.filterEntityId,
          entityType: state.taskListState.filterEntityType),
      onSortColumn: (field) => store.dispatch(SortTasks(field)),
      onTaskTap: (context, task) {
        if (store.state.taskListState.isInMultiselect()) {
          handleTaskAction(context, [task], EntityAction.toggleMultiselect);
        } else if (isDesktop(context) && state.uiState.isEditing) {
          viewEntity(context: context, entity: task);
        } else if (isDesktop(context) &&
            state.taskUIState.selectedId == task.id) {
          editEntity(context: context, entity: task);
        } else {
          viewEntity(context: context, entity: task);
        }
      },
      onRefreshed: (context) => _handleRefresh(context),
      tableColumns:
          state.userCompany.settings.getTableColumns(EntityType.task) ??
              TaskPresenter.getAllTableFields(state.userCompany),
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
  final Function(BuildContext, BaseEntity) onTaskTap;
  final Function(BuildContext) onRefreshed;
  final Function onClearEntityFilterPressed;
  final Function(BuildContext) onViewEntityFilterPressed;
  final List<String> tableColumns;
  final Function(String) onSortColumn;
}
