import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/task_presenter.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_datatable.dart';
import 'package:invoiceninja_flutter/ui/task/task_list_item.dart';
import 'package:invoiceninja_flutter/ui/task/task_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TaskList extends StatefulWidget {
  const TaskList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final TaskListVM viewModel;

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  EntityDataTableSource dataTableSource;

  @override
  void initState() {
    super.initState();

    final viewModel = widget.viewModel;

    dataTableSource = EntityDataTableSource(
        context: context,
        entityType: EntityType.task,
        editingId: viewModel.state.taskUIState.editing.id,
        tableColumns: viewModel.tableColumns,
        entityList: viewModel.taskList,
        entityMap: viewModel.taskMap,
        entityPresenter: TaskPresenter(),
        onTap: (BaseEntity task) => viewModel.onTaskTap(context, task));
  }

  @override
  void didUpdateWidget(TaskList oldWidget) {
    super.didUpdateWidget(oldWidget);

    final viewModel = widget.viewModel;
    dataTableSource.editingId = viewModel.state.taskUIState.editing.id;
    dataTableSource.entityList = viewModel.taskList;
    dataTableSource.entityMap = viewModel.taskMap;

    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    dataTableSource.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = widget.viewModel.state;
    final listState = widget.viewModel.listState;
    final listUIState = state.uiState.taskUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final taskList = widget.viewModel.taskList;

    if (state.shouldSelectEntity(EntityType.task)) {
      viewEntityById(
          context: context,
          entityType: EntityType.task,
          entityId: taskList.first);
    }

    return Column(
      children: <Widget>[
        if (listState.filterEntityId != null)
          ListFilterMessage(
            filterEntityId: listState.filterEntityId,
            filterEntityType: listState.filterEntityType,
            onPressed: widget.viewModel.onViewEntityFilterPressed,
            onClearPressed: widget.viewModel.onClearEntityFilterPressed,
          ),
        Expanded(
          child: !widget.viewModel.isLoaded
              ? LoadingIndicator()
              : RefreshIndicator(
                  onRefresh: () => widget.viewModel.onRefreshed(context),
                  child: widget.viewModel.taskList.isEmpty
                      ? HelpText(AppLocalization.of(context).noRecordsFound)
                      : state.prefState.moduleLayout == ModuleLayout.list
                          ? ListView.separated(
                              shrinkWrap: true,
                              separatorBuilder: (context, index) =>
                                  ListDivider(),
                              itemCount: widget.viewModel.taskList.length,
                              itemBuilder: (BuildContext context, index) {
                                final taskId = widget.viewModel.taskList[index];
                                final task = widget.viewModel.taskMap[taskId];
                                final client =
                                    widget.viewModel.clientMap[task.clientId] ??
                                        ClientEntity();

                                void showDialog() => showEntityActionsDialog(
                                      entities: [task],
                                      context: context,
                                      client: client,
                                    );

                                return TaskListItem(
                                  userCompany: state.userCompany,
                                  filter: widget.viewModel.filter,
                                  task: task,
                                  client: widget
                                          .viewModel.clientMap[task.clientId] ??
                                      ClientEntity(),
                                  project: widget.viewModel.state.projectState
                                      .map[task.projectId],
                                  onTap: () =>
                                      widget.viewModel.onTaskTap(context, task),
                                  onEntityAction: (EntityAction action) {
                                    if (action == EntityAction.more) {
                                      showDialog();
                                    } else {
                                      handleTaskAction(context, [task], action);
                                    }
                                  },
                                  onLongPress: () async {
                                    final longPressIsSelection = state.prefState
                                            .longPressSelectionIsDefault ??
                                        true;
                                    if (longPressIsSelection &&
                                        !isInMultiselect) {
                                      handleTaskAction(context, [task],
                                          EntityAction.toggleMultiselect);
                                    } else {
                                      showDialog();
                                    }
                                  },
                                  isChecked: isInMultiselect &&
                                      listUIState.isSelected(task.id),
                                );
                              },
                            )
                          : SingleChildScrollView(
                              child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: PaginatedDataTable(
                                onSelectAll: (value) {
                                  final tasks = widget.viewModel.taskList
                                      .map<TaskEntity>((taskId) =>
                                          widget.viewModel.taskMap[taskId])
                                      .where((task) =>
                                          value !=
                                          listUIState.isSelected(task.id))
                                      .toList();
                                  handleTaskAction(context, tasks,
                                      EntityAction.toggleMultiselect);
                                },
                                columns: [
                                  if (!listUIState.isInMultiselect())
                                    DataColumn(label: SizedBox()),
                                  ...widget.viewModel.tableColumns.map(
                                      (field) => DataColumn(
                                          label: Text(
                                              AppLocalization.of(context)
                                                  .lookup(field)),
                                          numeric:
                                              EntityPresenter.isFieldNumeric(
                                                  field),
                                          onSort: (int columnIndex,
                                                  bool ascending) =>
                                              store
                                                  .dispatch(SortTasks(field)))),
                                ],
                                source: dataTableSource,
                                header: DatatableHeader(
                                  entityType: EntityType.task,
                                  onClearPressed: widget
                                      .viewModel.onClearEntityFilterPressed,
                                ),
                              ),
                            )),
                ),
        ),
      ],
    );
  }
}
