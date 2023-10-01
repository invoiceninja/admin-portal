// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/project/project_list_vm.dart';
import 'package:invoiceninja_flutter/ui/project/project_presenter.dart';
import 'package:invoiceninja_flutter/ui/project/project_screen_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({
    Key? key,
    required this.viewModel,
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

    return ListScaffold(
      entityType: EntityType.project,
      onHamburgerLongPress: () => store.dispatch(StartProjectMultiselect()),
      appBarTitle: ListFilter(
        key: ValueKey('__filter_${state.projectListState.filterClearedAt}__'),
        entityType: EntityType.project,
        entityIds: viewModel.projectList,
        filter: state.projectListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterProjects(value));
        },
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterProjectsByState(state));
        },
      ),
      onCheckboxPressed: () {
        if (store.state.projectListState.isInMultiselect()) {
          store.dispatch(ClearProjectMultiselect());
        } else {
          store.dispatch(StartProjectMultiselect());
        }
      },
      body: ProjectListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.project,
        tableColumns: ProjectPresenter.getAllTableFields(userCompany),
        defaultTableColumns:
            ProjectPresenter.getDefaultTableFields(userCompany),
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
          ProjectFields.number,
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
      floatingActionButton: state.prefState.isMenuFloated &&
              userCompany.canCreate(EntityType.project)
          ? FloatingActionButton(
              heroTag: 'project_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () => createEntityByType(
                  context: context, entityType: EntityType.project),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: localization!.newProject,
            )
          : null,
    );
  }
}
