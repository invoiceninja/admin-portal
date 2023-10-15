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
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_builder.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/loading_dialog.dart';
import 'package:invoiceninja_flutter/ui/settings/user_details.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/oauth.dart';

import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({Key? key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsUserDetails';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserDetailsVM>(
      converter: UserDetailsVM.fromStore,
      builder: (context, viewModel) {
        final state = viewModel.state;
        return UserDetails(
            key: ValueKey(
                state.settingsUIState.updatedAt + state.user.updatedAt),
            viewModel: viewModel);
      },
    );
  }
}

class UserDetailsVM {
  UserDetailsVM({
    required this.user,
    required this.state,
    required this.onChanged,
    required this.onSavePressed,
    required this.onConnectGooglePressed,
    required this.onDisconnectGooglePressed,
    required this.onConnectGmailPressed,
    required this.onDisconnectGmailPressed,
    required this.onDisableTwoFactorPressed,
    required this.onConnectMicrosoftPressed,
    required this.onDisconnectMicrosoftPressed,
    required this.onDisconnectMicrosoftEmailPressed,
    required this.onDisconnectApplePressed,
  });

  static UserDetailsVM fromStore(Store<AppState> store) {
    final state = store.state;

    return UserDetailsVM(
      state: state,
      user: state.uiState.settingsUIState.user,
      onChanged: (user) => store.dispatch(UpdateUserSettings(user: user)),
      onConnectGmailPressed: (context, completer, password) async {
        /*
        final completer = snackBarCompleter<Null>( AppLocalization.of(context).connectedGmail);
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
        */
      },
      onDisconnectMicrosoftEmailPressed: (context) {
        confirmCallback(
            context: context,
            callback: (_) {
              passwordCallback(
                  context: context,
                  callback: (password, idToken) {
                    final completer = snackBarCompleter<Null>(
                        AppLocalization.of(context)!.disconnectedEmail);
                    store.dispatch(
                      DisconnectOAuthMailerRequest(
                          user: state.user,
                          completer: completer,
                          password: password,
                          idToken: idToken),
                    );
                  });
            });
      },
      onDisconnectGmailPressed: (context) {
        confirmCallback(
            context: context,
            callback: (_) {
              passwordCallback(
                  context: context,
                  callback: (password, idToken) {
                    final completer = snackBarCompleter<Null>(
                        AppLocalization.of(context)!.disconnectedGmail);
                    store.dispatch(
                      DisconnectOAuthMailerRequest(
                          user: state.user,
                          completer: completer,
                          password: password,
                          idToken: idToken),
                    );
                  });
            });
      },
      onDisableTwoFactorPressed: (context) {
        final completer = snackBarCompleter<Null>(
            AppLocalization.of(context)!.disabledTwoFactor);

        confirmCallback(
            context: context,
            callback: (_) {
              passwordCallback(
                  context: context,
                  callback: (password, idToken) {
                    store.dispatch(
                      DisableTwoFactorRequest(
                        completer: completer,
                        password: password,
                        idToken: idToken,
                      ),
                    );
                  });
            });
      },
      onDisconnectGooglePressed: (context) {
        if (!state.user.hasPassword) {
          showErrorDialog(
              message: AppLocalization.of(context)!.pleaseFirstSetAPassword);
          return;
        }

        confirmCallback(
            context: context,
            callback: (_) {
              passwordCallback(
                  context: context,
                  skipOAuth: true,
                  callback: (password, idToken) {
                    final completer = snackBarCompleter<Null>(
                        AppLocalization.of(context)!.disconnectedGoogle);
                    completer.future.then<Null>((_) {
                      GoogleOAuth.disconnect();
                    });
                    store.dispatch(
                      DisconnecOAuthUserRequest(
                        user: state.user,
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
            AppLocalization.of(context)!.connectedGoogle);

        passwordCallback(
            context: context,
            callback: (password, idToken) async {
              try {
                final signedIn =
                    await GoogleOAuth.signUp((idToken, accessToken) {
                  if (idToken.isEmpty || accessToken.isEmpty) {
                    GoogleOAuth.signOut();
                    showErrorDialog(
                        message: AppLocalization.of(context)!
                            .anErrorOccurredTryAgain);
                  } else {
                    store.dispatch(
                      ConnecOAuthUserRequest(
                        provider: UserEntity.OAUTH_PROVIDER_GOOGLE,
                        password: password,
                        idToken: idToken,
                        accessToken: accessToken,
                        completer: completer,
                      ),
                    );
                  }
                });
                if (!signedIn) {
                  showErrorDialog(
                      message: AppLocalization.of(navigatorKey.currentContext!)!
                          .anErrorOccurredTryAgain);
                }
              } catch (error) {
                showErrorDialog(message: '$error');
              }
            });
      },
      onDisconnectMicrosoftPressed: (context) {
        if (!state.user.hasPassword) {
          showErrorDialog(
              message: AppLocalization.of(context)!.pleaseFirstSetAPassword);
          return;
        }

        confirmCallback(
            context: context,
            skip: true,
            callback: (_) {
              passwordCallback(
                  context: context,
                  callback: (password, idToken) {
                    final completer = snackBarCompleter<Null>(
                        AppLocalization.of(context)!.disconnectedMicrosoft);
                    store.dispatch(
                      DisconnecOAuthUserRequest(
                        user: state.user,
                        password: password,
                        idToken: idToken,
                        completer: completer,
                      ),
                    );
                  });
            });
      },
      onDisconnectApplePressed: (context) {
        if (!state.user.hasPassword) {
          showErrorDialog(
              message: AppLocalization.of(context)!.pleaseFirstSetAPassword);
          return;
        }

        confirmCallback(
            context: context,
            callback: (_) {
              passwordCallback(
                  context: context,
                  skipOAuth: true,
                  callback: (password, idToken) {
                    final completer = snackBarCompleter<Null>(
                        AppLocalization.of(context)!.disconnectedApple);
                    store.dispatch(
                      DisconnecOAuthUserRequest(
                        user: state.user,
                        password: password,
                        idToken: idToken,
                        completer: completer,
                      ),
                    );
                  });
            });
      },
      onConnectMicrosoftPressed: (context) {
        final completer = snackBarCompleter<Null>(
            AppLocalization.of(context)!.connectedMicrosoft);

        passwordCallback(
            context: context,
            callback: (password, idToken) async {
              try {
                WebUtils.microsoftLogin((idToken, accessToken) {
                  store.dispatch(
                    ConnecOAuthUserRequest(
                      provider: UserEntity.OAUTH_PROVIDER_MICROSOFT,
                      password: password,
                      idToken: idToken,
                      accessToken: accessToken,
                      completer: completer,
                    ),
                  );
                }, (dynamic error) {
                  showErrorDialog(message: error);
                });
              } catch (error) {
                showErrorDialog(message: '$error');
              }
            });
      },
      onSavePressed: (context) {
        Debouncer.runOnComplete(() {
          final localization = AppLocalization.of(context)!;
          final completer = snackBarCompleter<Null>(localization.updatedUser);
          final appBuilder = AppBuilder.of(context);
          final origUser = state.user;
          final origUserSettings = state.userCompany.settings;

          completer.future.then<Null>((_) async {
            final newUser = store.state.user;
            final newUserSettings = store.state.userCompany.settings;
            if (origUserSettings.includeDeletedClients !=
                    newUserSettings.includeDeletedClients ||
                origUserSettings.numberYearsActive !=
                    newUserSettings.numberYearsActive) {
              store.dispatch(RefreshData(
                completer: snackBarCompleter<Null>(localization.refreshComplete,
                    shouldPop: true),
                clearData: true,
                includeStatic: true,
              ));

              await showDialog<AlertDialog>(
                  context: navigatorKey.currentContext!,
                  barrierDismissible: false,
                  builder: (BuildContext context) => SimpleDialog(
                        children: <Widget>[LoadingDialog()],
                      ));
            } else if (origUser.languageId != newUser.languageId) {
              store.dispatch(RefreshData(
                includeStatic: true,
                completer: Completer<dynamic>()
                  ..future.then((dynamic value) => appBuilder!.rebuild()),
              ));
            }

            appBuilder!.rebuild();
          });

          confirmCallback(
              context: context,
              message: localization.changingPhoneDisablesTwoFactor,
              skip: state.user.phone ==
                      state.uiState.settingsUIState.user.phone ||
                  !state.user.isTwoFactorEnabled,
              callback: (_) {
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
  final Function(BuildContext) onConnectMicrosoftPressed;
  final Function(BuildContext) onDisconnectMicrosoftPressed;
  final Function(BuildContext) onDisconnectMicrosoftEmailPressed;
  final Function(BuildContext, Completer, String) onConnectGmailPressed;
  final Function(BuildContext) onDisconnectGmailPressed;
  final Function(BuildContext) onDisableTwoFactorPressed;
  final Function(BuildContext) onDisconnectApplePressed;
}
