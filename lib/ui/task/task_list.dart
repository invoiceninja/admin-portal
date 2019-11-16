import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/task/task_list_item.dart';
import 'package:invoiceninja_flutter/ui/task/task_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final TaskListVM viewModel;

  @override
  Widget build(BuildContext context) {
    final state = viewModel.state;
    final listState = viewModel.listState;
    final listUIState = state.uiState.taskUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    return Column(
      children: <Widget>[
        if (listState.filterEntityId != null)
          ListFilterMessage(
            filterEntityId: listState.filterEntityId,
            filterEntityType: listState.filterEntityType,
            onPressed: viewModel.onViewEntityFilterPressed,
            onClearPressed: viewModel.onClearEntityFilterPressed,
          ),
        Expanded(
          child: !viewModel.isLoaded
              ? LoadingIndicator()
              : RefreshIndicator(
                  onRefresh: () => viewModel.onRefreshed(context),
                  child: viewModel.taskList.isEmpty
                      ? HelpText(AppLocalization.of(context).noRecordsFound)
                      : ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => ListDivider(),
                          itemCount: viewModel.taskList.length,
                          itemBuilder: (BuildContext context, index) {
                            final taskId = viewModel.taskList[index];
                            final task = viewModel.taskMap[taskId];
                            final client = viewModel.clientMap[task.clientId] ??
                                ClientEntity();

                            void showDialog() => showEntityActionsDialog(
                                  entities: [task],
                                  context: context,
                                  client: client,
                                );

                            return TaskListItem(
                              userCompany: state.userCompany,
                              filter: viewModel.filter,
                              task: task,
                              client: viewModel.clientMap[task.clientId] ??
                                  ClientEntity(),
                              project: viewModel
                                  .state.projectState.map[task.projectId],
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
                                    state.prefState.longPressSelectionIsDefault ??
                                        true;
                                if (longPressIsSelection && !isInMultiselect) {
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
                        ),
                ),
        ),
      ],
    );
  }
}
