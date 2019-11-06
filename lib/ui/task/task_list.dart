import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
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
    final localization = AppLocalization.of(context);
    final state = viewModel.state;
    final listState = viewModel.listState;
    final listUIState = state.uiState.taskUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    BaseEntity filteredEntity;
    String filteredMessage;

    if (listState.filterEntityType == EntityType.client) {
      final filteredClientId = listState.filterEntityId;
      filteredMessage = localization.filteredByClient;
      filteredEntity = filteredClientId != null
          ? viewModel.clientMap[filteredClientId]
          : null;
    } else if (listState.filterEntityType == EntityType.project) {
      final filteredProjectId = listState.filterEntityId;
      filteredMessage = localization.filteredByProject;
      filteredEntity = filteredProjectId != null
          ? state.projectState.map[filteredProjectId]
          : null;
    }

    return Column(
      children: <Widget>[
        if (filteredEntity != null)
          ListFilterMessage(
            title: '$filteredMessage: ${filteredEntity.listDisplayName}',
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
                                userCompany: state.userCompany,
                                client: client,
                                onEntityAction: viewModel.onEntityAction);

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
                                  viewModel.onEntityAction(
                                      context, [task], action);
                                }
                              },
                              onLongPress: () async {
                                final longPressIsSelection =
                                    state.uiState.longPressSelectionIsDefault ??
                                        true;
                                if (longPressIsSelection && !isInMultiselect) {
                                  viewModel.onEntityAction(context, [task],
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
