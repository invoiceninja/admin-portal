import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/project_presenter.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_datatable.dart';
import 'package:invoiceninja_flutter/ui/project/project_list_item.dart';
import 'package:invoiceninja_flutter/ui/project/project_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ProjectList extends StatefulWidget {
  const ProjectList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ProjectListVM viewModel;

  @override
  _ProjectListState createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  EntityDataTableSource dataTableSource;

  @override
  void initState() {
    super.initState();

    final viewModel = widget.viewModel;

    dataTableSource = EntityDataTableSource(
        context: context,
        entityType: EntityType.project,
        editingId: viewModel.state.projectUIState.editing.id,
        tableColumns: viewModel.tableColumns,
        entityList: viewModel.projectList,
        entityMap: viewModel.projectMap,
        entityPresenter: ProjectPresenter(),
        onTap: (BaseEntity project) =>
            viewModel.onProjectTap(context, project));
  }

  @override
  void didUpdateWidget(ProjectList oldWidget) {
    super.didUpdateWidget(oldWidget);

    final viewModel = widget.viewModel;
    dataTableSource.editingId = viewModel.state.projectUIState.editing.id;
    dataTableSource.entityList = viewModel.projectList;
    dataTableSource.entityMap = viewModel.projectMap;

    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    dataTableSource.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final listState = widget.viewModel.listState;
    final isInMultiselect = listState.isInMultiselect();
    final projectList = widget.viewModel.projectList;

    if (state.shouldSelectEntity(EntityType.project)) {
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
            onPressed: widget.viewModel.onViewEntityFilterPressed,
            onClearPressed: widget.viewModel.onClearEntityFilterPressed,
          ),
        Expanded(
          child: !widget.viewModel.isLoaded
              ? LoadingIndicator()
              : RefreshIndicator(
                  onRefresh: () => widget.viewModel.onRefreshed(context),
                  child: widget.viewModel.projectList.isEmpty
                      ? HelpText(AppLocalization.of(context).noRecordsFound)
                      : state.prefState.moduleLayout == ModuleLayout.list
                          ? ListView.separated(
                              shrinkWrap: true,
                              separatorBuilder: (context, index) =>
                                  ListDivider(),
                              itemCount: widget.viewModel.projectList.length,
                              itemBuilder: (BuildContext context, index) {
                                final projectId =
                                    widget.viewModel.projectList[index];
                                final project =
                                    widget.viewModel.projectMap[projectId];
                                final client = widget.viewModel
                                        .clientMap[project.clientId] ??
                                    ClientEntity(id: project.clientId);

                                void showDialog() => showEntityActionsDialog(
                                      entities: [project],
                                      context: context,
                                      client: client,
                                    );

                                return ProjectListItem(
                                  userCompany:
                                      widget.viewModel.state.userCompany,
                                  filter: widget.viewModel.filter,
                                  project: project,
                                  client: widget.viewModel
                                          .clientMap[project.clientId] ??
                                      ClientEntity(),
                                  onTap: () => widget.viewModel
                                      .onProjectTap(context, project),
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
                                    if (longPressIsSelection &&
                                        !isInMultiselect) {
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
                            )
                          : SingleChildScrollView(
                              child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: PaginatedDataTable(
                                onSelectAll: (value) {
                                  final projects = widget.viewModel.projectList
                                      .map<ProjectEntity>((projectId) => widget
                                          .viewModel.projectMap[projectId])
                                      .where((project) =>
                                          value !=
                                          listState.isSelected(project.id))
                                      .toList();
                                  handleProjectAction(context, projects,
                                      EntityAction.toggleMultiselect);
                                },
                                columns: [
                                  if (!listState.isInMultiselect())
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
                                              store.dispatch(
                                                  SortProjects(field)))),
                                ],
                                source: dataTableSource,
                                header: DatatableHeader(
                                  entityType: EntityType.project,
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
