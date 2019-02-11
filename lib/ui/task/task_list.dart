import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:invoiceninja_flutter/ui/task/task_list_item.dart';
import 'package:invoiceninja_flutter/ui/task/task_list_vm.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final TaskListVM viewModel;

  void _showMenu(
      BuildContext context, TaskEntity task, ClientEntity client) async {
    if (task == null || client == null) {
      return;
    }

    final user = viewModel.user;
    final message = await showDialog<String>(
        context: context,
        builder: (BuildContext dialogContext) => SimpleDialog(
                children: task
                    .getEntityActions(
                        user: user, client: client, includeEdit: true)
                    .map((entityAction) {
              if (entityAction == null) {
                return Divider();
              } else {
                return ListTile(
                  leading: Icon(getEntityActionIcon(entityAction)),
                  title: Text(AppLocalization.of(context)
                      .lookup(entityAction.toString())),
                  onTap: () {
                    Navigator.of(dialogContext).pop();
                    viewModel.onEntityAction(context, task, entityAction);
                  },
                );
              }
            }).toList()));

    if (message != null) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: SnackBarRow(
        message: message,
      )));
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final listState = viewModel.listState;

    BaseEntity filteredEntity;

    if (listState.filterEntityType == EntityType.client) {
      final filteredClientId = listState.filterEntityId;
      filteredEntity = filteredClientId != null
          ? viewModel.clientMap[filteredClientId]
          : null;
    } else if (listState.filterEntityType == EntityType.project) {
      final filteredProjectId = listState.filterEntityId;
      filteredEntity = filteredProjectId != null
          ? viewModel.state.projectState.map[filteredProjectId]
          : null;
    }

    return Column(
      children: <Widget>[
        filteredEntity != null
            ? Material(
                color: Colors.orangeAccent,
                elevation: 6.0,
                child: InkWell(
                  onTap: () => viewModel.onViewEntityFilterPressed(context),
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 18.0),
                      Expanded(
                        child: Text(
                          '${localization.filteredBy} ${filteredEntity.listDisplayName}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () => viewModel.onClearEntityFilterPressed(),
                      )
                    ],
                  ),
                ),
              )
            : Container(),
        Expanded(
          child: !viewModel.isLoaded
              ? LoadingIndicator()
              : RefreshIndicator(
                  onRefresh: () => viewModel.onRefreshed(context),
                  child: viewModel.taskList.isEmpty
                      ? Opacity(
                          opacity: 0.5,
                          child: Center(
                            child: Text(
                              AppLocalization.of(context).noRecordsFound,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: viewModel.taskList.length,
                          itemBuilder: (BuildContext context, index) {
                            final taskId = viewModel.taskList[index];
                            final task = viewModel.taskMap[taskId];
                            final client = viewModel.clientMap[task.clientId] ??
                                ClientEntity();
                            return Column(
                              children: <Widget>[
                                TaskListItem(
                                  user: viewModel.user,
                                  filter: viewModel.filter,
                                  task: task,
                                  client: viewModel.clientMap[task.clientId] ??
                                      ClientEntity(),
                                  project: viewModel
                                      .state.projectState.map[task.projectId],
                                  onTap: () =>
                                      viewModel.onTaskTap(context, task),
                                  onEntityAction: (EntityAction action) {
                                    if (action == EntityAction.more) {
                                      _showMenu(context, task, client);
                                    } else {
                                      viewModel.onEntityAction(
                                          context, task, action);
                                    }
                                  },
                                  onLongPress: () =>
                                      _showMenu(context, task, client),
                                ),
                                Divider(
                                  height: 1.0,
                                ),
                              ],
                            );
                          },
                        ),
                ),
        ),
      ],
    );
  }
}
