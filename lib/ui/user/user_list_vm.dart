import 'dart:async';
import 'package:invoiceninja_flutter/data/models/user_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
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
import 'package:invoiceninja_flutter/ui/user/user_list.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/user/user_actions.dart';

class UserListBuilder extends StatelessWidget {
  const UserListBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserListVM>(
      converter: UserListVM.fromStore,
      builder: (context, viewModel) {
        return UserList(
          viewModel: viewModel,
        );
      },
    );
  }
}

class UserListVM {
  UserListVM({
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
      userCompany: state.userCompany,
      listState: state.userListState,
      userList: memoizedFilteredUserList(
          state.userState.map, state.userState.list, state.userListState),
      userMap: state.userState.map,
      isLoading: state.isLoading,
      isLoaded: state.userState.isLoaded,
      filter: state.userUIState.listUIState.filter,
      onClearEntityFilterPressed: () => store.dispatch(FilterUsersByEntity()),
      onViewEntityFilterPressed: (BuildContext context) => viewEntityById(
          context: context,
          entityId: state.userListState.filterEntityId,
          entityType: state.userListState.filterEntityType),
      onUserTap: (context, user) {
        store.dispatch(ViewUser(userId: user.id, context: context));
      },
      onRefreshed: (context) => _handleRefresh(context),
    );
  }

  final UserCompanyEntity userCompany;
  final List<String> userList;
  final BuiltMap<String, UserEntity> userMap;
  final ListUIState listState;
  final String filter;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext, UserEntity) onUserTap;
  final Function(BuildContext) onRefreshed;
  final Function onClearEntityFilterPressed;
  final Function(BuildContext) onViewEntityFilterPressed;
}
