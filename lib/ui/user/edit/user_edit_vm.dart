import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
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
    @required this.isSaving,
    @required this.origUser,
    @required this.onSavePressed,
    @required this.onCancelPressed,
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
      company: state.company,
      onUserChanged: (UserEntity user) {
        store.dispatch(UpdateUser(user));
      },
      onCancelPressed: (BuildContext context) {
        createEntity(context: context, entity: UserEntity(), force: true);
        store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
      },
      onSavePressed: (BuildContext context) {
        final localization = AppLocalization.of(context);
        final Completer<UserEntity> completer = new Completer<UserEntity>();
        passwordCallback(
            context: context,
            callback: (password, idToken) {
              store.dispatch(SaveUserRequest(
                completer: completer,
                user: user,
                password: password,
                idToken: idToken,
              ));
            });
        return completer.future.then((savedUser) {
          showToast(
              user.isNew ? localization.createdUser : localization.updatedUser);

          if (isMobile(context)) {
            store.dispatch(UpdateCurrentRoute(UserViewScreen.route));
            if (user.isNew) {
              Navigator.of(context).pushReplacementNamed(UserViewScreen.route);
            } else {
              Navigator.of(context).pop(savedUser);
            }
          } else {
            viewEntity(context: context, entity: savedUser, force: true);
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
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final bool isLoading;
  final bool isSaving;
  final UserEntity origUser;
  final AppState state;
}
