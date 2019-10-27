import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/app/app_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/ui/project/project_screen_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/project/project_list_vm.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  static const String route = '/project';

  final ProjectScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final company = store.state.selectedCompany;
    final userCompany = store.state.userCompany;
    final localization = AppLocalization.of(context);
    final listUIState = state.uiState.projectUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    return AppScaffold(
      isChecked: isInMultiselect &&
          listUIState.selectedIds.length == viewModel.projectList.length,
      showCheckbox: isInMultiselect,
      onCheckboxChanged: (value) {
        final projects = viewModel.projectList
            .map<ProjectEntity>((projectId) => viewModel.projectMap[projectId])
            .where((project) => value != listUIState.isSelected(project.id))
            .toList();

        viewModel.onEntityAction(
            context, projects, EntityAction.toggleMultiselect);
      },
      appBarTitle: ListFilter(
        key: ValueKey(store.state.projectListState.filterClearedAt),
        entityType: EntityType.project,
        onFilterChanged: (value) {
          store.dispatch(FilterProjects(value));
        },
      ),
      appBarActions: [
        if (!viewModel.isInMultiselect)
          ListFilterButton(
            entityType: EntityType.project,
            onFilterPressed: (String value) {
              store.dispatch(FilterProjects(value));
            },
          ),
        if (viewModel.isInMultiselect)
          FlatButton(
            key: key,
            child: Text(
              localization.cancel,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              store.dispatch(ClearProjectMultiselect(context: context));
            },
          ),
        if (viewModel.isInMultiselect)
          FlatButton(
            key: key,
            textColor: Colors.white,
            disabledTextColor: Colors.white54,
            child: Text(
              localization.done,
            ),
            onPressed: state.projectListState.selectedIds.isEmpty
                ? null
                : () async {
                    final projects = viewModel.projectList
                        .map<ProjectEntity>(
                            (projectId) => viewModel.projectMap[projectId])
                        .toList();

                    await showEntityActionsDialog(
                        entities: projects,
                        userCompany: userCompany,
                        context: context,
                        onEntityAction: viewModel.onEntityAction,
                        multiselect: true);
                    store.dispatch(ClearProjectMultiselect(context: context));
                  },
          ),
      ],
      body: ProjectListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.project,
        onSelectedSortField: (value) => store.dispatch(SortProjects(value)),
        customValues1: company.getCustomFieldValues(CustomFieldType.project1,
            excludeBlank: true),
        customValues2: company.getCustomFieldValues(CustomFieldType.project2,
            excludeBlank: true),
        onSelectedCustom1: (value) =>
            store.dispatch(FilterProjectsByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterProjectsByCustom2(value)),
        sortFields: [
          ProjectFields.name,
          ProjectFields.updatedAt,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterProjectsByState(state));
        },
      ),
      floatingActionButton: userCompany.canCreate(EntityType.project)
          ? FloatingActionButton(
              heroTag: 'project_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                store.dispatch(EditProject(
                    project: ProjectEntity().rebuild((b) => b
                      ..clientId = store.state.projectListState.filterEntityId),
                    context: context));
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: localization.newProject,
            )
          : null,
    );
  }
}
