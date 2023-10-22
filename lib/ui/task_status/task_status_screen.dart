// Flutter imports:
import 'dart:async';

import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/task_status/task_status_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/app_text_button.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/task_status/task_status_list_vm.dart';
import 'package:invoiceninja_flutter/ui/task_status/task_status_presenter.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'task_status_screen_vm.dart';

class TaskStatusScreen extends StatelessWidget {
  const TaskStatusScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  static const String route = '/$kSettings/$kSettingsTaskStatuses';

  final TaskStatusScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final userCompany = state.userCompany;
    final localization = AppLocalization.of(context);
    final listUIState = state.uiState.taskStatusUIState.listUIState;

    return ListScaffold(
      entityType: EntityType.taskStatus,
      onHamburgerLongPress: () => store.dispatch(StartTaskStatusMultiselect()),
      onCancelSettingsSection: kSettingsTasks,
      appBarTitle: ListFilter(
        key:
            ValueKey('__filter_${state.taskStatusListState.filterClearedAt}__'),
        entityType: EntityType.taskStatus,
        entityIds: viewModel.taskStatusList,
        filter: state.taskStatusListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterTaskStatuses(value));
        },
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterTaskStatusesByState(state));
        },
      ),
      onCheckboxPressed: () {
        if (store.state.taskStatusListState.isInMultiselect()) {
          store.dispatch(ClearTaskStatusMultiselect());
        } else {
          store.dispatch(StartTaskStatusMultiselect());
        }
      },
      appBarActions: [
        if (viewModel.isInMultiselect)
          AppTextButton(
            isInHeader: true,
            onPressed: () async {
              final taskStatusIds = listUIState.selectedIds!
                  .map<TaskStatusEntity>(
                      (taskStatusId) => viewModel.taskStatusMap[taskStatusId]!)
                  .toList();

              await showEntityActionsDialog(
                entities: taskStatusIds,
                multiselect: true,
                completer: Completer<Null>()
                  ..future.then<Null>(
                      (_) => store.dispatch(ClearTaskStatusMultiselect())),
              );
            },
            label: localization!.actions,
          ),
      ],
      body: TaskStatusListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.taskStatus,
        tableColumns: TaskStatusPresenter.getAllTableFields(userCompany),
        defaultTableColumns:
            TaskStatusPresenter.getDefaultTableFields(userCompany),
        onSelectedSortField: (value) {
          store.dispatch(SortTaskStatuses(value));
        },
        sortFields: [],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterTaskStatusesByState(state));
        },
        onCheckboxPressed: () {
          if (store.state.taskStatusListState.isInMultiselect()) {
            store.dispatch(ClearTaskStatusMultiselect());
          } else {
            store.dispatch(StartTaskStatusMultiselect());
          }
        },
        onSelectedCustom1: (value) =>
            store.dispatch(FilterTaskStatusesByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterTaskStatusesByCustom2(value)),
        onSelectedCustom3: (value) =>
            store.dispatch(FilterTaskStatusesByCustom3(value)),
        onSelectedCustom4: (value) =>
            store.dispatch(FilterTaskStatusesByCustom4(value)),
      ),
      floatingActionButton: state.prefState.isMenuFloated &&
              userCompany.canCreate(EntityType.taskStatus)
          ? FloatingActionButton(
              heroTag: 'task_status_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                createEntityByType(
                    context: context, entityType: EntityType.taskStatus);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: localization!.newTaskStatus,
            )
          : null,
    );
  }
}
