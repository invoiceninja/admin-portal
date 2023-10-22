// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/redux/user/user_actions.dart';
import 'package:invoiceninja_flutter/ui/user/user_screen.dart';
import 'package:invoiceninja_flutter/ui/user/view/user_view.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class UserViewScreen extends StatelessWidget {
  const UserViewScreen({
    Key? key,
    this.isFilter = false,
  }) : super(key: key);
  final bool isFilter;
  static const String route = '/$kSettings/$kSettingsUserManagementView';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserViewVM>(
      converter: (Store<AppState> store) {
        return UserViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return UserView(
          viewModel: vm,
          isFilter: isFilter,
        );
      },
    );
  }
}

class UserViewVM {
  UserViewVM({
    required this.state,
    required this.user,
    required this.company,
    required this.onEntityAction,
    required this.onBackPressed,
    required this.onRefreshed,
    required this.isSaving,
    required this.isLoading,
    required this.isDirty,
  });

  factory UserViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final user = state.userState.map[state.userUIState.selectedId] ??
        UserEntity(id: state.userUIState.selectedId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);
      store.dispatch(LoadUser(completer: completer, userId: user.id));
      return completer.future;
    }

    return UserViewVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: user.isNew,
      user: user,
      onRefreshed: (context) => _handleRefresh(context),
      onBackPressed: () {
        store.dispatch(UpdateCurrentRoute(UserScreen.route));
      },
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions([user], action, autoPop: true),
    );
  }

  final AppState state;
  final UserEntity user;
  final CompanyEntity? company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function onBackPressed;
  final Function(BuildContext) onRefreshed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
