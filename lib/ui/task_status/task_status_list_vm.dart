import 'dart:async';
import 'package:invoiceninja_flutter/data/models/task_status_model.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/task_status/task_status_list_item.dart';
import 'package:invoiceninja_flutter/ui/task_status/task_status_presenter.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/task_status/task_status_selectors.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/task_status/task_status_actions.dart';

class TaskStatusListBuilder extends StatelessWidget {
  const TaskStatusListBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskStatusListVM>(
      converter: TaskStatusListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            entityType: EntityType.taskStatus,
            presenter: TaskStatusPresenter(),
            state: viewModel.state,
            entityList: viewModel.taskStatusList,
            tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onSortColumn: viewModel.onSortColumn,
            onClearMultiselect: viewModel.onClearMultielsect,
            itemBuilder: (BuildContext context, index) {
              final state = viewModel.state;
              final taskStatusId = viewModel.taskStatusList[index];
              final taskStatus = viewModel.taskStatusMap[taskStatusId];
              final listState = state.getListState(EntityType.taskStatus);
              final isInMultiselect = listState.isInMultiselect();

              return TaskStatusListItem(
                user: viewModel.state.user,
                filter: viewModel.filter,
                taskStatus: taskStatus,
                isChecked:
                    isInMultiselect && listState.isSelected(taskStatus.id),
              );
            });
      },
    );
  }
}

class TaskStatusListVM {
  TaskStatusListVM({
    @required this.state,
    @required this.userCompany,
    @required this.taskStatusList,
    @required this.taskStatusMap,
    @required this.filter,
    @required this.isLoading,
    @required this.listState,
    @required this.onRefreshed,
    @required this.onEntityAction,
    @required this.tableColumns,
    @required this.onSortColumn,
    @required this.onClearMultielsect,
  });

  static TaskStatusListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>(null);
      }
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(RefreshData(completer: completer));
      return completer.future;
    }

    final state = store.state;

    return TaskStatusListVM(
      state: state,
      userCompany: state.userCompany,
      listState: state.taskStatusListState,
      taskStatusList: memoizedFilteredTaskStatusList(
          state.getUISelection(EntityType.taskStatus),
          state.taskStatusState.map,
          state.taskStatusState.list,
          state.taskStatusListState),
      taskStatusMap: state.taskStatusState.map,
      isLoading: state.isLoading,
      filter: state.taskStatusUIState.listUIState.filter,
      onEntityAction: (BuildContext context, List<BaseEntity> taskStatuses,
              EntityAction action) =>
          handleTaskStatusAction(context, taskStatuses, action),
      onRefreshed: (context) => _handleRefresh(context),
      tableColumns:
          state.userCompany.settings.getTableColumns(EntityType.taskStatus) ??
              TaskStatusPresenter.getDefaultTableFields(state.userCompany),
      onSortColumn: (field) => store.dispatch(SortTaskStatuses(field)),
      onClearMultielsect: () => store.dispatch(ClearTaskStatusMultiselect()),
    );
  }

  final AppState state;
  final UserCompanyEntity userCompany;
  final List<String> taskStatusList;
  final BuiltMap<String, TaskStatusEntity> taskStatusMap;
  final ListUIState listState;
  final String filter;
  final bool isLoading;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final List<String> tableColumns;
  final Function(String) onSortColumn;
  final Function onClearMultielsect;
}
