// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/task_status/task_status_actions.dart';
import 'package:invoiceninja_flutter/ui/task_status/task_status_list.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/task_status/task_status_selectors.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TaskStatusListBuilder extends StatelessWidget {
  const TaskStatusListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskStatusListVM>(
      converter: TaskStatusListVM.fromStore,
      builder: (context, viewModel) {
        return TaskStatusList(viewModel: viewModel);
      },
    );
  }
}

class TaskStatusListVM {
  TaskStatusListVM({
    required this.state,
    required this.taskStatusList,
    required this.taskStatusMap,
    required this.filter,
    required this.listState,
    required this.onRefreshed,
    required this.onSortChanged,
  });

  static TaskStatusListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>.value();
      }
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);
      store.dispatch(RefreshData(completer: completer));
      return completer.future;
    }

    final state = store.state;
    final taskStatusIds = memoizedFilteredTaskStatusList(
        state.getUISelection(EntityType.taskStatus),
        state.taskStatusState.map,
        state.taskStatusState.list,
        state.taskStatusListState);

    return TaskStatusListVM(
      state: state,
      listState: state.taskStatusListState,
      taskStatusList: taskStatusIds,
      taskStatusMap: state.taskStatusState.map,
      filter: state.taskStatusUIState.listUIState.filter,
      onRefreshed: (context) => _handleRefresh(context),
      onSortChanged: (int oldIndex, int newIndex) {
        final taskStatusId = taskStatusIds[oldIndex];
        final taskStatus = state.taskStatusState.get(taskStatusId);

        store.dispatch(SaveTaskStatusRequest(
            completer: snackBarCompleter<TaskStatusEntity>(
                AppLocalization.of(navigatorKey.currentContext!)!
                    .updatedTaskStatus),
            taskStatus:
                taskStatus.rebuild((b) => b..statusOrder = newIndex + 1)));
      },
    );
  }

  final AppState state;
  final List<String> taskStatusList;
  final BuiltMap<String?, TaskStatusEntity?> taskStatusMap;
  final ListUIState listState;
  final String? filter;
  final Function(BuildContext) onRefreshed;
  final Function(int, int) onSortChanged;
}
