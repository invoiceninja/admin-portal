import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/forms/save_cancel_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/group/group_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

import 'group_screen_vm.dart';

class GroupSettingsScreen extends StatelessWidget {
  const GroupSettingsScreen({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  static const String route = '/$kSettings/$kSettingsGroupSettings';

  final GroupScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final company = state.company;
    final localization = AppLocalization.of(context);
    final listUIState = state.uiState.groupUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    return ListScaffold(
      entityType: EntityType.group,
      isChecked: isInMultiselect &&
          listUIState.selectedIds.length == viewModel.groupList.length,
      showCheckbox: isInMultiselect,
      onHamburgerLongPress: () => store.dispatch(StartGroupMultiselect()),
      onCheckboxChanged: (value) {
        final groups = viewModel.groupList
            .map<GroupEntity>((groupId) => viewModel.groupMap[groupId])
            .where((group) => value != listUIState.isSelected(group.id))
            .toList();

        handleGroupAction(context, groups, EntityAction.toggleMultiselect);
      },
      appBarTitle: ListFilter(
        entityType: EntityType.group,
        entityIds: viewModel.groupList,
        filter: state.groupListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterGroups(value));
        },
      ),
      appBarActions: [
        if (viewModel.isInMultiselect)
          SaveCancelButtons(
            saveLabel: localization.done,
            onSavePressed: listUIState.selectedIds.isEmpty
                ? null
                : (context) async {
                    final groups = listUIState.selectedIds
                        .map<GroupEntity>(
                            (groupId) => viewModel.groupMap[groupId])
                        .toList();

                    await showEntityActionsDialog(
                      entities: groups,
                      context: context,
                      multiselect: true,
                      completer: Completer<Null>()
                        ..future.then<dynamic>(
                            (_) => store.dispatch(ClearGroupMultiselect())),
                    );
                  },
            onCancelPressed: (context) =>
                store.dispatch(ClearGroupMultiselect()),
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
              tooltip: localization.newGroup,
            )
          : null,
    );
  }
}
