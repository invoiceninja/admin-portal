import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/task/task_list_vm.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';

class TaskScreen extends StatelessWidget {
  static const String route = '/task';

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final company = store.state.selectedCompany;
    final user = company.user;
    final localization = AppLocalization.of(context);

    return WillPopScope(
      onWillPop: () async {
        store.dispatch(ViewDashboard(context));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: ListFilter(
            entityType: EntityType.task,
            onFilterChanged: (value) {
              store.dispatch(FilterTasks(value));
            },
          ),
          actions: [
            ListFilterButton(
              entityType: EntityType.task,
              onFilterPressed: (String value) {
                store.dispatch(FilterTasks(value));
              },
            ),
          ],
        ),
        drawer: AppDrawerBuilder(),
        body: TaskListBuilder(),
        bottomNavigationBar: AppBottomBar(
          entityType: EntityType.task,
          onSelectedSortField: (value) => store.dispatch(SortTasks(value)),
          onSelectedStatus: (EntityStatus status, value) {
            store.dispatch(FilterTasksByStatus(status));
          },
          customValues1: company.getCustomFieldValues(CustomFieldType.task1,
              excludeBlank: true),
          customValues2: company.getCustomFieldValues(CustomFieldType.task2,
              excludeBlank: true),
          onSelectedCustom1: (value) =>
              store.dispatch(FilterTasksByCustom1(value)),
          onSelectedCustom2: (value) =>
              store.dispatch(FilterTasksByCustom2(value)),
          sortFields: [
            TaskFields.description,
            TaskFields.duration,
            TaskFields.updatedAt,
          ],
          statuses: [
            TaskStatusEntity().rebuild((b) => b
              ..id = kTaskStatusLogged
              ..name = localization.logged),
            TaskStatusEntity().rebuild(
              (b) => b
                ..id = kTaskStatusRunning
                ..name = localization.running,
            ),
            TaskStatusEntity().rebuild(
              (b) => b
                ..id = kTaskStatusInvoiced
                ..name = localization.invoiced,
            ),
          ],
          onSelectedState: (EntityState state, value) {
            store.dispatch(FilterTasksByState(state));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: user.canCreate(EntityType.task)
            ? FloatingActionButton(
                //key: Key(TaskKeys.taskScreenFABKeyString),
                backgroundColor: Theme.of(context).primaryColorDark,
                onPressed: () {
                  store.dispatch(EditTask(
                      task: TaskEntity(
                              isRunning: store.state.uiState.autoStartTasks)
                          .rebuild((b) => b
                            ..clientId =
                                store.state.taskListState.filterEntityId ?? 0),
                      context: context));
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                tooltip: localization.newTask,
              )
            : null,
      ),
    );
  }
}
