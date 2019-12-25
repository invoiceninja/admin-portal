import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/project/project_list_item.dart';
import 'package:invoiceninja_flutter/ui/project/project_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class ProjectList extends StatelessWidget {
  const ProjectList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ProjectListVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final listState = viewModel.listState;
    final isInMultiselect = listState.isInMultiselect();
    final projectList = viewModel.projectList;

    if (isNotMobile(context) &&
        projectList.isNotEmpty &&
        !state.uiState.isEditing &&
        !projectList.contains(state.projectUIState.selectedId)) {
      viewEntityById(
          context: context,
          entityType: EntityType.project,
          entityId: projectList.first);
    }

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
                                  client: client,
                                );

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
                                  handleProjectAction(
                                      context, [project], action);
                                }
                              },
                              onLongPress: () async {
                                final longPressIsSelection = store
                                        .state
                                        .prefState
                                        .longPressSelectionIsDefault ??
                                    true;
                                if (longPressIsSelection && !isInMultiselect) {
                                  handleProjectAction(context, [project],
                                      EntityAction.toggleMultiselect);
                                } else {
                                  showDialog();
                                }
                              },
                              isChecked: isInMultiselect &&
                                  listState.isSelected(project.id),
                            );
                          },
                        ),
                ),
        ),
      ],
    );
  }
}
