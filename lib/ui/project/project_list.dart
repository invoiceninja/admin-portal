import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/project/project_list_item.dart';
import 'package:invoiceninja_flutter/ui/project/project_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ProjectList extends StatelessWidget {
  const ProjectList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ProjectListVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final localization = AppLocalization.of(context);
    final listState = viewModel.listState;
    final filteredClientId = listState.filterEntityId;
    final filteredClient =
        filteredClientId != null ? viewModel.clientMap[filteredClientId] : null;
    final isInMultiselect = listState.isInMultiselect();

    return Column(
      children: <Widget>[
        filteredClient != null
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
                          '${localization.filteredByClient}: ${filteredClient.listDisplayName}',
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
              ? (viewModel.isLoading ? LoadingIndicator() : SizedBox())
              : RefreshIndicator(
                  onRefresh: () => viewModel.onRefreshed(context),
                  child: viewModel.projectList.isEmpty
                      ? HelpText(AppLocalization.of(context).noRecordsFound)
                      : ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => ListDivider(),
                          itemCount: viewModel.projectList.length,
                          itemBuilder: (BuildContext context, index) {
                            final projectId = viewModel.projectList[index];
                            final project = viewModel.projectMap[projectId];
                            final client =
                                viewModel.clientMap[project.clientId] ??
                                    ClientEntity(id: project.clientId);

                            void showDialog() => showEntityActionsDialog(
                                entities: [project],
                                context: context,
                                userCompany: viewModel.state.userCompany,
                                client: client,
                                onEntityAction: viewModel.onEntityAction);

                            return ProjectListItem(
                              userCompany: viewModel.state.userCompany,
                              filter: viewModel.filter,
                              project: project,
                              client: viewModel.clientMap[project.clientId] ??
                                  ClientEntity(),
                              onTap: () =>
                                  viewModel.onProjectTap(context, project),
                              onEntityAction: (EntityAction action) {
                                if (action == EntityAction.more) {
                                  showDialog();
                                } else {
                                  viewModel.onEntityAction(
                                      context, [project], action);
                                }
                              },
                              onLongPress: () async {
                                final longPressIsSelection = store.state.uiState
                                        .longPressSelectionIsDefault ??
                                    true;
                                if (longPressIsSelection && !isInMultiselect) {
                                  viewModel.onEntityAction(context, [project],
                                      EntityAction.toggleMultiselect);
                                } else {
                                  showDialog();
                                }
                              },
                              isChecked: isInMultiselect &&
                                  listState.isSelected(project),
                            );
                          },
                        ),
                ),
        ),
      ],
    );
  }
}
