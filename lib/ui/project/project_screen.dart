import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/project/project_list_vm.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';

class ProjectScreen extends StatelessWidget {
  static const String route = '/project';

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final company = store.state.selectedCompany;
    final user = company.user;
    final localization = AppLocalization.of(context);

    return WillPopScope(
      onWillPop: () async {
        store.dispatch(ViewDashboard(context));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: ListFilter(
            entityType: EntityType.project,
            onFilterChanged: (value) {
              store.dispatch(FilterProjects(value));
            },
          ),
          actions: [
            ListFilterButton(
              entityType: EntityType.project,
              onFilterPressed: (String value) {
                store.dispatch(FilterProjects(value));
              },
            ),
          ],
        ),
        drawer: AppDrawerBuilder(),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: user.canCreate(EntityType.project)
            ? FloatingActionButton(
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
      ),
    );
  }
}
