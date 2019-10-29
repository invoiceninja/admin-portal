import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/ui/app/app_scaffold.dart';
import 'package:invoiceninja_flutter/data/models/user_model.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
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

  static const String route = '/$kSettings';

  final UserScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final userCompany = state.userCompany;
    final localization = AppLocalization.of(context);
    final listUIState = state.uiState.userUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    return AppScaffold(
      isChecked: isInMultiselect &&
          listUIState.selectedIds.length == viewModel.userList.length,
      showCheckbox: isInMultiselect,
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
        key: ValueKey(state.userListState.filterClearedAt),
        entityType: EntityType.user,
        onFilterChanged: (value) {
          store.dispatch(FilterUsers(value));
        },
      ),
      appBarActions: [
        if (!viewModel.isInMultiselect)
          ListFilterButton(
            entityType: EntityType.user,
            onFilterPressed: (String value) {
              store.dispatch(FilterUsers(value));
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
              store.dispatch(ClearUserMultiselect(context: context));
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
            onPressed: state.userListState.selectedIds.isEmpty
                ? null
                : () async {
                    await showEntityActionsDialog(
                        //entities: users,
                        userCompany: userCompany,
                        context: context,
                        onEntityAction: viewModel.onEntityAction,
                        multiselect: true);
                    store.dispatch(ClearUserMultiselect(context: context));
                  },
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
          UserFields.updatedAt,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterUsersByState(state));
        },
      ),
      floatingActionButton: userCompany.canCreate(EntityType.user)
          ? FloatingActionButton(
              heroTag: 'user_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                store.dispatch(EditUser(user: UserEntity(), context: context));
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
