import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/task/task_presenter.dart';
import 'package:invoiceninja_flutter/ui/task/task_screen_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/task/task_list_vm.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  static const String route = '/task';

  final TaskScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final company = store.state.company;
    final userCompany = store.state.userCompany;
    final localization = AppLocalization.of(context);

    return ListScaffold(
      entityType: EntityType.task,
      onHamburgerLongPress: () => store.dispatch(StartTaskMultiselect()),
      appBarTitle: ListFilter(
        entityType: EntityType.task,
        entityIds: viewModel.taskList,
        filter: state.taskListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterTasks(value));
        },
      ),
      body: TaskListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.task,
        tableColumns: TaskPresenter.getAllTableFields(userCompany),
        defaultTableColumns: TaskPresenter.getDefaultTableFields(userCompany),
        onSelectedSortField: (value) => store.dispatch(SortTasks(value)),
        onSelectedStatus: (EntityStatus status, value) {
          store.dispatch(FilterTasksByStatus(status));
        },
        customValues1: company.getCustomFieldValues(CustomFieldType.task1,
            excludeBlank: true),
        customValues2: company.getCustomFieldValues(CustomFieldType.task2,
            excludeBlank: true),
        customValues3: company.getCustomFieldValues(CustomFieldType.task3,
            excludeBlank: true),
        customValues4: company.getCustomFieldValues(CustomFieldType.task4,
            excludeBlank: true),
        onSelectedCustom1: (value) =>
            store.dispatch(FilterTasksByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterTasksByCustom2(value)),
        onSelectedCustom3: (value) =>
            store.dispatch(FilterTasksByCustom3(value)),
        onSelectedCustom4: (value) =>
            store.dispatch(FilterTasksByCustom4(value)),
        sortFields: [
          TaskFields.number,
          TaskFields.duration,
          TaskFields.updatedAt,
        ],
        statuses: [
          TaskStatusEntity().rebuild((b) => b
            ..id = kTaskStatusInvoiced
            ..name = localization.invoiced),
          TaskStatusEntity().rebuild((b) => b
            ..id = kTaskStatusLogged
            ..name = localization.logged),
          TaskStatusEntity().rebuild((b) => b
            ..id = kTaskStatusRunning
            ..name = localization.running),
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterTasksByState(state));
        },
        onCheckboxPressed: () {
          if (store.state.taskListState.isInMultiselect()) {
            store.dispatch(ClearTaskMultiselect());
          } else {
            store.dispatch(StartTaskMultiselect());
          }
        },
      ),
      floatingActionButton: state.prefState.isMenuFloated &&
              userCompany.canCreate(EntityType.task)
          ? FloatingActionButton(
              heroTag: 'task_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                createEntityByType(
                    context: context, entityType: EntityType.task);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: localization.newTask,
            )
          : null,
    );
  }
}
