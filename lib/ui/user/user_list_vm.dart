import 'dart:async';
import 'package:invoiceninja_flutter/data/models/user_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/user/user_list_item.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/user/user_selectors.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/user/user_actions.dart';

class UserListBuilder extends StatelessWidget {
  const UserListBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserListVM>(
      converter: UserListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            isLoaded: viewModel.isLoaded,
            entityType: EntityType.user,
            //presenter: ClientPresenter(),
            state: viewModel.state,
            entityList: viewModel.userList,
            onEntityTap: viewModel.onUserTap,
            //tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onClearEntityFilterPressed: viewModel.onClearEntityFilterPressed,
            onViewEntityFilterPressed: viewModel.onViewEntityFilterPressed,
            onSortColumn: viewModel.onSortColumn,
            itemBuilder: (BuildContext context, index) {
              final userId = viewModel.userList[index];
              final user = viewModel.userMap[userId];

              void showDialog() => showEntityActionsDialog(
                    entities: [user],
                    context: context,
                  );

              return UserListItem(
                user: user,
                filter: viewModel.filter,
                onTap: () => viewModel.onUserTap(context, user),
                onEntityAction: (EntityAction action) {
                  if (action == EntityAction.more) {
                    showDialog();
                  } else {
                    handleUserAction(context, [user], action);
                  }
                },
                onLongPress: () => showDialog(),
              );
            });
      },
    );
  }
}

class UserListVM {
  UserListVM({
    @required this.state,
    @required this.userCompany,
    @required this.userList,
    @required this.userMap,
    @required this.filter,
    @required this.isLoading,
    @required this.isLoaded,
    @required this.onUserTap,
    @required this.listState,
    @required this.onRefreshed,
    @required this.onClearEntityFilterPressed,
    @required this.onViewEntityFilterPressed,
    @required this.onSortColumn,
  });

  static UserListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>(null);
      }
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadUsers(completer: completer, force: true));
      return completer.future;
    }

    final state = store.state;

    return UserListVM(
      state: state,
      userCompany: state.userCompany,
      listState: state.userListState,
      userList: memoizedFilteredUserList(state.userState.map,
          state.userState.list, state.userListState, state.user.id),
      userMap: state.userState.map,
      isLoading: state.isLoading,
      isLoaded: state.userState.isLoaded,
      filter: state.userUIState.listUIState.filter,
      onClearEntityFilterPressed: () => store.dispatch(ClearEntityFilter()),
      onViewEntityFilterPressed: (BuildContext context) => viewEntityById(
          context: context,
          entityId: state.userListState.filterEntityId,
          entityType: state.userListState.filterEntityType),
      onUserTap: (context, user) {
        if (store.state.userListState.isInMultiselect()) {
          handleUserAction(context, [user], EntityAction.toggleMultiselect);
        } else {
          viewEntity(context: context, entity: user);
        }
      },
      onRefreshed: (context) => _handleRefresh(context),
      onSortColumn: (field) => store.dispatch(SortUsers(field)),
    );
  }

  final AppState state;
  final UserCompanyEntity userCompany;
  final List<String> userList;
  final BuiltMap<String, UserEntity> userMap;
  final ListUIState listState;
  final String filter;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext, BaseEntity) onUserTap;
  final Function(BuildContext) onRefreshed;
  final Function onClearEntityFilterPressed;
  final Function(BuildContext) onViewEntityFilterPressed;
  final Function(String) onSortColumn;
}
