import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/ui/app/app_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/group/group_list_vm.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';

class GroupScreen extends StatelessWidget {
  static const String route = '/group';

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final company = state.selectedCompany;
    final localization = AppLocalization.of(context);

    return AppScaffold(
      appBarTitle: ListFilter(
        key: ValueKey(state.groupListState.filterClearedAt),
        entityType: EntityType.group,
        onFilterChanged: (value) {
          store.dispatch(FilterGroups(value));
        },
      ),
      appBarActions: [
        ListFilterButton(
          entityType: EntityType.group,
          onFilterPressed: (String value) {
            store.dispatch(FilterGroups(value));
          },
        ),
      ],
      body: GroupListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.group,
        onSelectedSortField: (value) => store.dispatch(SortGroups(value)),
        customValues1: company.getCustomFieldValues(CustomFieldType.group1,
            excludeBlank: true),
        customValues2: company.getCustomFieldValues(CustomFieldType.group2,
            excludeBlank: true),
        onSelectedCustom1: (value) =>
            store.dispatch(FilterGroupsByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterGroupsByCustom2(value)),
        sortFields: [
          GroupFields.name,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterGroupsByState(state));
        },
      ),
      floatingActionButton: state.userCompany.canCreate(EntityType.group)
          ? FloatingActionButton(
              heroTag: 'group_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                store.dispatch(
                    EditGroup(group: GroupEntity(), context: context));
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: localization.newGroup,
            )
          : null,
    );
  }
}
