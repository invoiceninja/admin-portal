import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_builder.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/loading_dialog.dart';
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
    @required this.onConnectGmailPressed,
    @required this.onDisconnectGmailPressed,
    @required this.onDisableTwoFactorPressed,
  });

  static UserDetailsVM fromStore(Store<AppState> store) {
    final state = store.state;

    return UserDetailsVM(
      state: state,
      user: state.uiState.settingsUIState.user,
      onChanged: (user) => store.dispatch(UpdateUserSettings(user: user)),
      onConnectGmailPressed: (context, completer, password) async {
        final completer = snackBarCompleter<Null>(
            context, AppLocalization.of(context).connectedGmail);
        try {
          final signedIn = await GoogleOAuth.grantOfflineAccess(
              (idToken, accessToken, serverAuthCode) {
            if (idToken.isEmpty ||
                accessToken.isEmpty ||
                serverAuthCode.isEmpty) {
              completer.completeError(
                  AppLocalization.of(context).anErrorOccurredTryAgain);
            } else {
              store.dispatch(ConnecGmailUserRequest(
                serverAuthCode: serverAuthCode,
                idToken: idToken,
                completer: completer,
                password: password,
              ));
            }
          }, () {
            completer.completeError(
                AppLocalization.of(context).anErrorOccurredTryAgain);
          });
          if (!signedIn) {
            completer.completeError(
                AppLocalization.of(context).anErrorOccurredTryAgain);
          }
        } catch (error) {
          completer.completeError(error);
        }
      },
      onDisconnectGmailPressed: (context) {
        confirmCallback(
            context: context,
            callback: () {
              passwordCallback(
                  context: context,
                  callback: (password, idToken) {
                    final completer = snackBarCompleter<Null>(
                        context, AppLocalization.of(context).disconnectedGmail);
                    store.dispatch(
                      SaveAuthUserRequest(
                        user: state.user.rebuild((b) => b..oauthUserToken = ''),
                        password: password,
                        idToken: idToken,
                        completer: completer,
                      ),
                    );
                  });
            });
      },
      onDisableTwoFactorPressed: (context) {
        final completer = snackBarCompleter<Null>(
            context, AppLocalization.of(context).disabledTwoFactor);

        confirmCallback(
            context: context,
            callback: () {
              passwordCallback(
                  context: context,
                  callback: (password, idToken) {
                    store.dispatch(
                      SaveAuthUserRequest(
                        user: state.user
                            .rebuild((b) => b..isTwoFactorEnabled = false),
                        password: password,
                        idToken: idToken,
                        completer: completer,
                      ),
                    );
                  });
            });
      },
      onDisconnectGooglePressed: (context) {
        if (!state.user.hasPassword) {
          showErrorDialog(
              context: context,
              message: AppLocalization.of(context).pleaseFirstSetAPassword);
          return;
        }

        confirmCallback(
            context: context,
            callback: () {
              passwordCallback(
                  context: context,
                  callback: (password, idToken) {
                    final completer = snackBarCompleter<Null>(context,
                        AppLocalization.of(context).disconnectedGoogle);
                    completer.future.then((value) {
                      GoogleOAuth.disconnect();
                    });
                    store.dispatch(
                      SaveAuthUserRequest(
                        user: state.user.rebuild((b) => b..oauthProvider = ''),
                        password: password,
                        idToken: idToken,
                        completer: completer,
                      ),
                    );
                  });
            });
      },
      onConnectGooglePressed: (context) {
        final completer = snackBarCompleter<Null>(
            context, AppLocalization.of(context).connectedGoogle);

        passwordCallback(
            context: context,
            callback: (password, idToken) async {
              try {
                final signedIn =
                    await GoogleOAuth.signUp((idToken, accessToken) {
                  if (idToken.isEmpty || accessToken.isEmpty) {
                    GoogleOAuth.signOut();
                    showErrorDialog(
                        context: context,
                        message: AppLocalization.of(context)
                            .anErrorOccurredTryAgain);
                  } else {
                    store.dispatch(
                      ConnecOAuthUserRequest(
                        provider: UserEntity.OAUTH_PROVIDER_GOOGLE,
                        password: password,
                        idToken: idToken,
                        completer: completer,
                      ),
                    );
                  }
                });
                if (!signedIn) {
                  showErrorDialog(
                      context: context,
                      message:
                          AppLocalization.of(context).anErrorOccurredTryAgain);
                }
              } catch (error) {
                showErrorDialog(context: context, message: error);
              }
            });
      },
      onSavePressed: (context) {
        Debouncer.runOnComplete(() {
          final localization = AppLocalization.of(context);
          final completer =
              snackBarCompleter<Null>(context, localization.savedSettings);
          final appBuilder = AppBuilder.of(context);
          final origUserSettings = state.userCompany.settings;

          completer.future.then((_) async {
            final newUserSettings = store.state.userCompany.settings;
            if (origUserSettings.includeDeletedClients !=
                    newUserSettings.includeDeletedClients ||
                origUserSettings.numberYearsActive !=
                    newUserSettings.numberYearsActive) {
              store.dispatch(RefreshData(
                completer: snackBarCompleter<Null>(
                    navigatorKey.currentContext, localization.refreshComplete,
                    shouldPop: true),
                clearData: true,
                includeStatic: true,
              ));

              await showDialog<AlertDialog>(
                  context: navigatorKey.currentContext,
                  barrierDismissible: false,
                  builder: (BuildContext context) => SimpleDialog(
                        children: <Widget>[LoadingDialog()],
                      ));
            }

            appBuilder.rebuild();
          });

          confirmCallback(
              context: context,
              message: localization.changingPhoneDisablesTwoFactor,
              skip: state.user.phone ==
                      state.uiState.settingsUIState.user.phone ||
                  !state.user.isTwoFactorEnabled,
              callback: () {
                passwordCallback(
                    context: context,
                    callback: (password, idToken) {
                      store.dispatch(
                        SaveAuthUserRequest(
                          completer: completer,
                          user: store.state.uiState.settingsUIState.user,
                          password: password,
                          idToken: idToken,
                        ),
                      );
                    });
              });
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
  final Function(BuildContext, Completer, String) onConnectGmailPressed;
  final Function(BuildContext) onDisconnectGmailPressed;
  final Function(BuildContext) onDisableTwoFactorPressed;
}
