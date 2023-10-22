// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/utils/widgets.dart';

// Package imports:
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/repositories/auth_repository.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_builder.dart';
import 'package:invoiceninja_flutter/ui/auth/login_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

List<Middleware<AppState>> createStoreAuthMiddleware([
  AuthRepository repository = const AuthRepository(),
]) {
  final userLogout = _createUserLogout();
  final userLogoutAll = _createUserLogoutAll(repository);
  final loginRequest = _createLoginRequest(repository);
  final oauthLoginRequest = _createOAuthLoginRequest(repository);
  final signUpRequest = _createSignUpRequest(repository);
  final oauthSignUpRequest = _createOAuthSignUpRequest(repository);
  final refreshRequest = _createRefreshRequest(repository);
  final recoverRequest = _createRecoverRequest(repository);
  final addCompany = _createCompany(repository);
  final deleteCompany = _deleteCompany(repository);
  final setDefaultCompany = _setDefaultCompany(repository);
  final purgeData = _purgeData(repository);
  final resendConfirmation = _resendConfirmation(repository);

  return [
    TypedMiddleware<AppState, UserLogout>(userLogout),
    TypedMiddleware<AppState, UserLogoutAll>(userLogoutAll),
    TypedMiddleware<AppState, UserLoginRequest>(loginRequest),
    TypedMiddleware<AppState, OAuthLoginRequest>(oauthLoginRequest),
    TypedMiddleware<AppState, UserSignUpRequest>(signUpRequest),
    TypedMiddleware<AppState, OAuthSignUpRequest>(oauthSignUpRequest),
    TypedMiddleware<AppState, RefreshData>(refreshRequest),
    TypedMiddleware<AppState, RecoverPasswordRequest>(recoverRequest),
    TypedMiddleware<AppState, AddCompany>(addCompany),
    TypedMiddleware<AppState, DeleteCompanyRequest>(deleteCompany),
    TypedMiddleware<AppState, SetDefaultCompanyRequest>(setDefaultCompany),
    TypedMiddleware<AppState, PurgeDataRequest>(purgeData),
    TypedMiddleware<AppState, ResendConfirmation>(resendConfirmation),
  ];
}

void _saveAuthLocal(String url) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(kSharedPrefUrl, formatApiUrl(url));
}

Middleware<AppState> _createUserLogout() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as UserLogout?;

    next(action);

    navigatorKey.currentState!.pushNamedAndRemoveUntil(
        LoginScreen.route, (Route<dynamic> route) => false);

    store.dispatch(UpdateCurrentRoute(LoginScreen.route));

    WidgetUtils.clearData();
  };
}

Middleware<AppState> _createUserLogoutAll(AuthRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as UserLogoutAll?;

    repository
        .logout(credentials: store.state.credentials)
        .then((dynamic response) {
      store.dispatch(UserLogoutAllSuccess());
      store.dispatch(UserLogout());
    }).catchError((Object error) {
      if (action!.completer != null) {
        action.completer!.completeError(error);
      }
      store.dispatch(UserLogoutAllFailure(error));
    });

    next(action);
  };
}

Middleware<AppState> _createLoginRequest(AuthRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as UserLoginRequest;

    repository
        .login(
            email: action.email,
            password: action.password,
            url: action.url,
            secret: action.secret,
            platform: action.platform,
            oneTimePassword: action.oneTimePassword)
        .then((data) {
      _saveAuthLocal(action.url);
      store.dispatch(
          LoadAccountSuccess(completer: action.completer, loginResponse: data));
      store.dispatch(UserVerifiedPassword());
    }).catchError((Object error) {
      print('## Login error: $error');
      final message = _parseError('$error');
      action.completer.completeError(message);
      store.dispatch(UserLoginFailure(message));
      if ('$error'.startsWith('Error ::')) {
        throw error;
      }
    });

    next(action);
  };
}

Middleware<AppState> _createSignUpRequest(AuthRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as UserSignUpRequest;
    final state = store.state;

    repository
        .signUp(
            email: action.email,
            password: action.password,
            referralCode: state.authState.referralCode)
        .then((data) {
      _saveAuthLocal(kAppProductionUrl);

      store.dispatch(
          LoadAccountSuccess(completer: action.completer, loginResponse: data));
      store.dispatch(UserVerifiedPassword());
    }).catchError((Object error) {
      print('## Signup error: $error');
      final message = _parseError('$error');
      action.completer.completeError(message);
      store.dispatch(UserLoginFailure(message));
      if ('$error'.startsWith('Error ::')) {
        throw error;
      }
    });

    next(action);
  };
}

Middleware<AppState> _createOAuthLoginRequest(AuthRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as OAuthLoginRequest;

    repository
        .oauthLogin(
      idToken: action.idToken,
      accessToken: action.accessToken,
      url: action.url,
      secret: action.secret,
      provider: action.provider,
      platform: action.platform,
      authCode: action.authCode,
      email: action.email,
    )
        .then((data) {
      _saveAuthLocal(action.url);

      store.dispatch(
          LoadAccountSuccess(completer: action.completer, loginResponse: data));
      store.dispatch(UserVerifiedPassword());
    }).catchError((Object error) {
      print('## Oauth login error: $error');
      final message = _parseError('$error');
      action.completer.completeError(message);
      store.dispatch(UserLoginFailure(message));
      if ('$error'.startsWith('Error ::')) {
        throw error;
      }
    });

    next(action);
  };
}

Middleware<AppState> _createOAuthSignUpRequest(AuthRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as OAuthSignUpRequest;
    final state = store.state;

    repository
        .oauthSignUp(
      url: action.url,
      accessToken: action.accessToken,
      idToken: action.idToken,
      provider: action.provider,
      referralCode: state.authState.referralCode,
      firstName: action.firstName,
      lastName: action.lastName,
    )
        .then((data) {
      _saveAuthLocal(kAppProductionUrl);

      store.dispatch(
          LoadAccountSuccess(completer: action.completer, loginResponse: data));
      store.dispatch(UserVerifiedPassword());
    }).catchError((Object error) {
      print('## OAuth signup error: $error');
      final message = _parseError('$error');
      action.completer.completeError(message);
      store.dispatch(UserLoginFailure(message));
      if ('$error'.startsWith('Error ::')) {
        throw error;
      }
    });

    next(action);
  };
}

Middleware<AppState> _createRefreshRequest(AuthRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as RefreshData;
    final state = store.state;

    if (action.clearData) {
      //
    } else {
      if (state.isSaving) {
        print('## Skipping refresh request - pending save');
        next(action);
        return;
      } else if (state.isLoading) {
        print('## Skipping refresh request - pending load');
        next(action);
        return;
      } else if (state.company.isLarge && !state.isLoaded) {
        print('## Skipping refresh request - not loaded');
        next(action);
        store.dispatch(LoadClients());
        return;
      }
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final url =
        formatApiUrl(prefs.getString(kSharedPrefUrl) ?? state.authState.url);

    String token;
    bool hasToken = false;
    if (state.userCompany.token.token.isNotEmpty) {
      token = state.userCompany.token.token;
      hasToken = true;
    } else {
      token = TokenEntity.unobscureToken(prefs.getString(kSharedPrefToken)) ??
          'TOKEN';
    }

    final updatedAt = action.clearData
        ? 0
        : ((state.userCompanyState.lastUpdated - kMillisecondsToRefreshData) /
                1000)
            .round();

    store.dispatch(UserLoadUrl(url: url));

    repository
        .refresh(
      url: url,
      token: token,
      updatedAt: updatedAt - kUpdatedAtBufferSeconds,
      includeStatic: action.includeStatic || state.staticState.isStale,
      currentCompany: hasToken && !action.allCompanies,
    )
        .then((data) {
      bool permissionsWereChanged = false;
      data.userCompanies.forEach((userCompany) {
        state.userCompanyStates.forEach((userCompanyState) {
          if (userCompany.company.id == userCompanyState.company.id) {
            if (userCompanyState.userCompany.permissionsUpdatedAt > 0 &&
                userCompany.permissionsUpdatedAt !=
                    userCompanyState.userCompany.permissionsUpdatedAt) {
              permissionsWereChanged = true;
            }
          }
        });
      });

      if (permissionsWereChanged && !action.clearData) {
        store.dispatch(
            RefreshData(completer: action.completer, clearData: true));
      } else {
        if (action.clearData) {
          store.dispatch(ClearData());
        }

        store.dispatch(RefreshDataSuccess(
          completer: action.completer,
          data: data,
        ));
      }

      AppBuilder.of(navigatorKey.currentContext!)!.rebuild();
    }).catchError((Object error) {
      if ('$error'.startsWith('403') || '$error'.startsWith('429')) {
        store.dispatch(UserLogout());
      } else {
        final message = _parseError('$error');
        if (action.completer != null) {
          action.completer!.completeError(message);
        }

        store.dispatch(RefreshDataFailure(message));

        if ('$error'.startsWith('Error ::')) {
          throw error;
        }
      }
    });

    next(action);
  };
}

Middleware<AppState> _createRecoverRequest(AuthRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RecoverPasswordRequest;

    repository
        .recoverPassword(
      email: action.email,
      url: action.url,
      secret: action.secret,
    )
        .then((data) {
      store.dispatch(RecoverPasswordSuccess());
      action.completer.complete(null);
    }).catchError((Object error) {
      store.dispatch(RecoverPasswordFailure(error.toString()));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _createCompany(AuthRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as AddCompany?;
    final state = store.state;

    repository.addCompany(credentials: state.credentials).then((dynamic value) {
      store.dispatch(AddCompanySuccess());
      store.dispatch(RefreshData(
        allCompanies: true,
        completer: Completer<Null>()
          ..future.then<Null>((_) {
            store.dispatch(SelectCompany(companyIndex: state.companies.length));
            store.dispatch(ViewDashboard(force: true));

            action!.completer!.complete();
          }),
      ));
    });

    next(action);
  };
}

Middleware<AppState> _setDefaultCompany(AuthRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as SetDefaultCompanyRequest?;
    final state = store.state;
    final companyId = state.company.id;

    repository
        .setDefaultCompany(credentials: state.credentials, companyId: companyId)
        .then((_) {
      store.dispatch(SetDefaultCompanySuccess());
      store.dispatch(RefreshData(allCompanies: true));
      action!.completer.complete();
    }).catchError((Object error) {
      store.dispatch(SetDefaultCompanyFailure(error));
      action!.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _deleteCompany(AuthRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as DeleteCompanyRequest;
    final state = store.state;

    repository
        .deleteCompany(
      credentials: state.credentials,
      password: action.password,
      companyId: state.company.id,
      reason: action.reason,
    )
        .then((dynamic value) {
      store.dispatch(DeleteCompanySuccess());
      action.completer.complete(null);
    }).catchError((Object error) {
      store.dispatch(DeleteCompanyFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _purgeData(AuthRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as PurgeDataRequest;
    final state = store.state;
    final company = state.company;

    repository
        .purgeData(
            credentials: state.credentials,
            password: action.password,
            idToken: action.idToken,
            companyId: company.id)
        .then((dynamic value) {
      store.dispatch(PurgeDataSuccess());
      store.dispatch(RefreshData(
          clearData: true,
          completer: Completer<Null>()
            ..future.then<Null>((_) {
              action.completer.complete(null);
            })));
    }).catchError((Object error) {
      store.dispatch(PurgeDataFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _resendConfirmation(AuthRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ResendConfirmation?;
    final state = store.state;

    repository
        .resendConfirmation(
            credentials: state.credentials, userId: state.user.id)
        .then((dynamic value) {
      store.dispatch(ResendConfirmationSuccess());
    }).catchError((Object error) {
      store.dispatch(ResendConfirmationFailure(error));
    });

    next(action);
  };
}

String _parseError(String error) {
  const errorPattern = 'failed due to: Deserializing';
  if (error.contains(errorPattern)) {
    final lastIndex = error.lastIndexOf(errorPattern);
    final secondToLastIndex = secondToLastIndexOf(error, errorPattern);
    error = 'Error :: ' +
        error
            .substring(
                (secondToLastIndex >= 0 ? secondToLastIndex : lastIndex) +
                    errorPattern.length)
            .trim();
  } else if (error.toLowerCase().contains('no host specified')) {
    error = 'An error occurred, please check the URL is correct';
  } else if (error.contains('404')) {
    error += ', you may need to add /public to the URL';
  }

  return error;
}
