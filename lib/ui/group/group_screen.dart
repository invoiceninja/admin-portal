// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/group/group_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'group_screen_vm.dart';

class GroupSettingsScreen extends StatelessWidget {
  const GroupSettingsScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  static const String route = '/$kSettings/$kSettingsGroupSettings';

  final GroupScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final localization = AppLocalization.of(context);

    return ListScaffold(
      entityType: EntityType.group,
      onHamburgerLongPress: () => store.dispatch(StartGroupMultiselect()),
      appBarTitle: ListFilter(
        key: ValueKey('__filter_${state.groupListState.filterClearedAt}__'),
        entityType: EntityType.group,
        entityIds: viewModel.groupList,
        filter: state.groupListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterGroups(value));
        },
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterGroupsByState(state));
        },
      ),
      onCheckboxPressed: () {
        if (store.state.groupListState.isInMultiselect()) {
          store.dispatch(ClearGroupMultiselect());
        } else {
          store.dispatch(StartGroupMultiselect());
        }
      },
      body: GroupListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.group,
        onSelectedSortField: (value) => store.dispatch(SortGroups(value)),
        sortFields: [
          GroupFields.name,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterGroupsByState(state));
        },
        onCheckboxPressed: () {
          if (store.state.groupListState.isInMultiselect()) {
            store.dispatch(ClearGroupMultiselect());
          } else {
            store.dispatch(StartGroupMultiselect());
          }
        },
      ),
      floatingActionButton: state.prefState.isMobile &&
              state.userCompany.canCreate(EntityType.group)
          ? FloatingActionButton(
              heroTag: 'group_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                createEntityByType(
                    context: context, entityType: EntityType.group);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: localization!.newGroup,
            )
          : null,
    );
  }
}
