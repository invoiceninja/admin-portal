import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/user/user_screen.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/user/view/user_view_vm.dart';
import 'package:invoiceninja_flutter/redux/user/user_actions.dart';
import 'package:invoiceninja_flutter/data/models/user_model.dart';
import 'package:invoiceninja_flutter/ui/user/edit/user_edit.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class UserEditScreen extends StatelessWidget {
  const UserEditScreen({Key key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsUserManagementEdit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserEditVM>(
      converter: (Store<AppState> store) {
        return UserEditVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return UserEdit(
          viewModel: viewModel,
          key: ValueKey(viewModel.user.id),
        );
      },
    );
  }
}

class UserEditVM {
  UserEditVM({
    @required this.state,
    @required this.user,
    @required this.userCompany,
    @required this.company,
    @required this.onUserChanged,
    @required this.onUserCompanyChanged,
    @required this.isSaving,
    @required this.origUser,
    @required this.onSavePressed,
    @required this.onCancelPressed,
    @required this.onBackPressed,
    @required this.isLoading,
  });

  factory UserEditVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final user = state.userUIState.editing;

    return UserEditVM(
      state: state,
      isLoading: state.isLoading,
      isSaving: state.isSaving,
      origUser: state.userState.map[user.id],
      user: user,
      userCompany: state.userCompany,
      company: state.selectedCompany,
      onUserChanged: (UserEntity user) {
        store.dispatch(UpdateUser(user));
      },
      onUserCompanyChanged: (UserCompanyEntity userCompany) {
        store.dispatch(UpdateUserCompany(userCompany));
      },
      onBackPressed: () {
        if (state.uiState.currentRoute.contains(UserScreen.route)) {
          store.dispatch(UpdateCurrentRoute(
              user.isNew ? UserScreen.route : UserViewScreen.route));
        }
      },
      onCancelPressed: (BuildContext context) {
        store.dispatch(
            EditUser(user: UserEntity(), context: context, force: true));
        store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
      },
      onSavePressed: (BuildContext context) {
        final Completer<UserEntity> completer = new Completer<UserEntity>();
        store.dispatch(SaveUserRequest(completer: completer, user: user));
        return completer.future.then((savedUser) {
          if (isMobile(context)) {
            store.dispatch(UpdateCurrentRoute(UserViewScreen.route));
            if (user.isNew) {
              Navigator.of(context).pushReplacementNamed(UserViewScreen.route);
            } else {
              Navigator.of(context).pop(savedUser);
            }
          } else {
            store.dispatch(
                ViewUser(context: context, userId: savedUser.id, force: true));
          }
        }).catchError((Object error) {
          showDialog<ErrorDialog>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(error);
              });
        });
      },
    );
  }

  final UserEntity user;
  final UserCompanyEntity userCompany;
  final CompanyEntity company;
  final Function(UserEntity) onUserChanged;
  final Function(UserCompanyEntity) onUserCompanyChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final Function onBackPressed;
  final bool isLoading;
  final bool isSaving;
  final UserEntity origUser;
  final AppState state;
}
