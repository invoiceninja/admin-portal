import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_builder.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/settings/user_details.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/oauth.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({Key key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsUserDetails';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserDetailsVM>(
      converter: UserDetailsVM.fromStore,
      builder: (context, viewModel) {
        return UserDetails(
            key: ValueKey(viewModel.state.settingsUIState.updatedAt),
            viewModel: viewModel);
      },
    );
  }
}

class UserDetailsVM {
  UserDetailsVM({
    @required this.user,
    @required this.state,
    @required this.onChanged,
    @required this.onSavePressed,
    @required this.onConnectGooglePressed,
    @required this.onDisconnectGooglePressed,
    @required this.onDisableTwoFactorPressed,
  });

  static UserDetailsVM fromStore(Store<AppState> store) {
    final state = store.state;

    return UserDetailsVM(
      state: state,
      user: state.uiState.settingsUIState.user,
      onChanged: (user) => store.dispatch(UpdateUserSettings(user: user)),
      onDisableTwoFactorPressed: (context) {
        final completer = snackBarCompleter<Null>(
            context, AppLocalization.of(context).disabledTwoFactor);
        completer.future.then((_) {
          AppBuilder.of(context).rebuild();
        }).catchError((Object error) {
          showDialog<ErrorDialog>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(error);
              });
        });

        passwordCallback(
            context: context,
            callback: (password, idToken) {
              store.dispatch(
                SaveAuthUserRequest(
                  user:
                      state.user.rebuild((b) => b..isTwoFactorEnabled = false),
                  password: password,
                  idToken: idToken,
                ),
              );
            });
      },
      onDisconnectGooglePressed: (context) {
        final completer = snackBarCompleter<Null>(
            context, AppLocalization.of(context).disconnectGoogle);
        completer.future.then((_) {
          AppBuilder.of(context).rebuild();
        }).catchError((Object error) {
          showDialog<ErrorDialog>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(error);
              });
        });

        passwordCallback(
            context: context,
            callback: (password, idToken) {
              store.dispatch(
                SaveAuthUserRequest(
                  user: state.user.rebuild((b) => b..oauthProvider = ''),
                  password: password,
                  idToken: idToken,
                  completer: completer,
                ),
              );
            });
      },
      onConnectGooglePressed: (context) {
        final completer = snackBarCompleter<Null>(
            context, AppLocalization.of(context).connectedGoogle);
        completer.future.catchError((Object error) {
          showDialog<ErrorDialog>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(error);
              });
        });

        passwordCallback(
            context: context,
            callback: (password, idToken) {
              googleSignUp((idToken, accessToken, serverAuthCode) {
                store.dispatch(
                  ConnecOAuthUserRequest(
                    provider: UserEntity.OAUTH_PROVIDER_GOOGLE,
                    password: password,
                    idToken: idToken,
                    serverAuthCode: serverAuthCode,
                    completer: completer,
                  ),
                );
              });
            });
      },
      onSavePressed: (context) {
        final completer = snackBarCompleter<Null>(
            context, AppLocalization.of(context).savedSettings);
        completer.future.then((_) {
          AppBuilder.of(context).rebuild();
        }).catchError((Object error) {
          showDialog<ErrorDialog>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(error);
              });
        });

        passwordCallback(
            context: context,
            callback: (password, idToken) {
              store.dispatch(
                SaveAuthUserRequest(
                  completer: completer,
                  user: state.uiState.settingsUIState.user,
                  password: password,
                  idToken: idToken,
                ),
              );
            });
      },
    );
  }

  final AppState state;
  final UserEntity user;
  final Function(UserEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onConnectGooglePressed;
  final Function(BuildContext) onDisconnectGooglePressed;
  final Function(BuildContext) onDisableTwoFactorPressed;
}
