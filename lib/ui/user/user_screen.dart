import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/ui/app/forms/save_cancel_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/data/models/user_model.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/user/user_screen_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/user/user_list_vm.dart';
import 'package:invoiceninja_flutter/redux/user/user_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  static const String route = '/$kSettings/$kSettingsUserManagement';

  final UserScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final userCompany = state.userCompany;
    final localization = AppLocalization.of(context);
    final listUIState = state.uiState.userUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    return ListScaffold(
      entityType: EntityType.user,
      isChecked: isInMultiselect &&
          listUIState.selectedIds.length == viewModel.userList.length,
      showCheckbox: isInMultiselect,
      onHamburgerLongPress: () => store.dispatch(StartUserMultiselect()),
      onCheckboxChanged: (value) {
        /*
        final users = viewModel.userList
            .map<UserEntity>((userId) => viewModel.userMap[userId])
            .where((user) => value != listUIState.isSelected(user))
            .toList();

        viewModel.onEntityAction(
            context, users, EntityAction.toggleMultiselect);            
         */
      },
      appBarTitle: ListFilter(
        entityType: EntityType.user,
        entityIds: viewModel.userList,
        filter: state.userListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterUsers(value));
        },
      ),
      appBarActions: [
        if (viewModel.isInMultiselect)
          SaveCancelButtons(
            saveLabel: localization.done,
            onSavePressed: listUIState.selectedIds.isEmpty
                ? null
                : (context) async {
                    final users = listUIState.selectedIds
                        .map<UserEntity>((userId) => viewModel.userMap[userId])
                        .toList();

                    await showEntityActionsDialog(
                      entities: users,
                      context: context,
                      multiselect: true,
                      completer: Completer<Null>()
                        ..future.then<dynamic>(
                            (_) => store.dispatch(ClearUserMultiselect())),
                    );
                  },
            onCancelPressed: (context) =>
                store.dispatch(ClearUserMultiselect()),
          ),
      ],
      body: UserListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.user,
        onSelectedSortField: (value) => store.dispatch(SortUsers(value)),
        onSelectedCustom1: (value) =>
            store.dispatch(FilterUsersByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterUsersByCustom2(value)),
        sortFields: [
          UserFields.firstName,
          UserFields.lastName,
          UserFields.email,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterUsersByState(state));
        },
        onCheckboxPressed: () {
          if (store.state.userListState.isInMultiselect()) {
            store.dispatch(ClearUserMultiselect());
          } else {
            store.dispatch(StartUserMultiselect());
          }
        },
      ),
      floatingActionButton:
          state.prefState.isMobile && userCompany.canCreate(EntityType.user)
              ? FloatingActionButton(
                  heroTag: 'user_fab',
                  backgroundColor: Theme.of(context).primaryColorDark,
                  onPressed: () {
                    createEntityByType(
                        context: context, entityType: EntityType.user);
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  tooltip: localization.newUser,
                )
              : null,
    );
  }
}
