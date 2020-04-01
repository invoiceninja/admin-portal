import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/ui/app/forms/save_cancel_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
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
    final company = store.state.company;
    final userCompany = store.state.userCompany;
    final localization = AppLocalization.of(context);
    final listUIState = state.uiState.projectUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    return ListScaffold(
      isChecked: isInMultiselect &&
          listUIState.selectedIds.length == viewModel.projectList.length,
      showCheckbox: isInMultiselect,
      onHamburgerLongPress: () => store.dispatch(StartProjectMultiselect()),
      onCheckboxChanged: (value) {
        final projects = viewModel.projectList
            .map<ProjectEntity>((projectId) => viewModel.projectMap[projectId])
            .where((project) => value != listUIState.isSelected(project.id))
            .toList();

        handleProjectAction(context, projects, EntityAction.toggleMultiselect);
      },
      appBarTitle: ListFilter(
        title: localization.projects,
        key: ValueKey(store.state.projectListState.filterClearedAt),
        filter: state.projectListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterProjects(value));
        },
      ),
      appBarActions: [
        if (!viewModel.isInMultiselect)
          ListFilterButton(
            filter: state.projectListState.filter,
            onFilterPressed: (String value) {
              store.dispatch(FilterProjects(value));
            },
          ),
        if (viewModel.isInMultiselect)
          SaveCancelButtons(
            saveLabel: localization.done,
            onSavePressed: listUIState.selectedIds.isEmpty
                ? null
                : (context) async {
                    final projects = listUIState.selectedIds
                        .map<ProjectEntity>(
                            (projectId) => viewModel.projectMap[projectId])
                        .toList();

                    await showEntityActionsDialog(
                      entities: projects,
                      context: context,
                      multiselect: true,
                      completer: Completer<Null>()
                        ..future.then<dynamic>(
                            (_) => store.dispatch(ClearProjectMultiselect())),
                    );
                  },
            onCancelPressed: (context) =>
                store.dispatch(ClearProjectMultiselect()),
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
        customValues3: company.getCustomFieldValues(CustomFieldType.project3,
            excludeBlank: true),
        customValues4: company.getCustomFieldValues(CustomFieldType.project4,
            excludeBlank: true),
        onSelectedCustom1: (value) =>
            store.dispatch(FilterProjectsByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterProjectsByCustom2(value)),
        onSelectedCustom3: (value) =>
            store.dispatch(FilterProjectsByCustom3(value)),
        onSelectedCustom4: (value) =>
            store.dispatch(FilterProjectsByCustom4(value)),
        sortFields: [
          ProjectFields.name,
          ProjectFields.updatedAt,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterProjectsByState(state));
        },
        onCheckboxPressed: () {
          if (store.state.projectListState.isInMultiselect()) {
            store.dispatch(ClearProjectMultiselect());
          } else {
            store.dispatch(StartProjectMultiselect());
          }
        },
      ),
      floatingActionButton: userCompany.canCreate(EntityType.project)
          ? FloatingActionButton(
              heroTag: 'project_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () => createEntityByType(
                  context: context, entityType: EntityType.project),
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
