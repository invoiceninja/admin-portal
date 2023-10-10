// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/user/user_actions.dart';
import 'package:invoiceninja_flutter/redux/user/user_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/user/user_list_item.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class UserListBuilder extends StatelessWidget {
  const UserListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserListVM>(
      converter: UserListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            onClearMultiselect: viewModel.onClearMultielsect,
            //presenter: ClientPresenter(),
            entityType: EntityType.user,
            state: viewModel.state,
            entityList: viewModel.userList,
            //tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onSortColumn: viewModel.onSortColumn,
            itemBuilder: (BuildContext context, index) {
              final userId = viewModel.userList[index];
              final user = viewModel.userMap[userId]!;

              void showDialog() => showEntityActionsDialog(
                    entities: [user],
                  );

              return UserListItem(
                user: user,
                filter: viewModel.filter,
                onLongPress: () => showDialog(),
              );
            });
      },
    );
  }
}

class UserListVM {
  UserListVM({
    required this.state,
    required this.userCompany,
    required this.userList,
    required this.userMap,
    required this.filter,
    required this.isLoading,
    required this.listState,
    required this.onRefreshed,
    required this.onSortColumn,
    required this.onClearMultielsect,
  });

  static UserListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>.value();
      }
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);
      store.dispatch(RefreshData(completer: completer));
      return completer.future;
    }

    final state = store.state;

    return UserListVM(
      state: state,
      userCompany: state.userCompany,
      listState: state.userListState,
      userList: memoizedFilteredUserList(
          state.getUISelection(EntityType.user),
          state.userState.map,
          state.userState.list,
          state.userListState,
          state.user.id),
      userMap: state.userState.map,
      isLoading: state.isLoading,
      filter: state.userUIState.listUIState.filter,
      onRefreshed: (context) => _handleRefresh(context),
      onSortColumn: (field) => store.dispatch(SortUsers(field)),
      onClearMultielsect: () => store.dispatch(ClearUserMultiselect()),
    );
  }

  final AppState state;
  final UserCompanyEntity? userCompany;
  final List<String> userList;
  final BuiltMap<String, UserEntity> userMap;
  final ListUIState listState;
  final String? filter;
  final bool isLoading;
  final Function(BuildContext) onRefreshed;
  final Function(String) onSortColumn;
  final Function onClearMultielsect;
}
