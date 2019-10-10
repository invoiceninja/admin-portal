import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/app/app_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/project/project_list_vm.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';

class ProjectScreen extends StatelessWidget {
  static const String route = '/project';

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final company = store.state.selectedCompany;
    final user = company.user;
    final localization = AppLocalization.of(context);

    return AppScaffold(
      appBarTitle: ListFilter(
        key: ValueKey(store.state.projectListState.filterClearedAt),
        entityType: EntityType.project,
        onFilterChanged: (value) {
          store.dispatch(FilterProjects(value));
        },
      ),
      appBarActions: [
        ListFilterButton(
          entityType: EntityType.project,
          onFilterPressed: (String value) {
            store.dispatch(FilterProjects(value));
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
      floatingActionButton: user.canCreate(EntityType.project)
          ? FloatingActionButton(
              heroTag: 'project_screen',
              //key: Key(ProjectKeys.projectScreenFABKeyString),
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                store.dispatch(EditProject(
                    project: ProjectEntity().rebuild((b) => b
                      ..clientId =
                          store.state.projectListState.filterEntityId ?? 0),
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
