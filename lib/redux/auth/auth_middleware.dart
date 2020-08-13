import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/auth/login_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:invoiceninja_flutter/data/repositories/auth_repository.dart';

List<Middleware<AppState>> createStoreAuthMiddleware([
  AuthRepository repository = const AuthRepository(),
]) {
  final userLogout = _createUserLogout();
  final loginRequest = _createLoginRequest(repository);
  final oauthLoginRequest = _createOAuthLoginRequest(repository);
  final signUpRequest = _createSignUpRequest(repository);
  final oauthSignUpRequest = _createOAuthSignUpRequest(repository);
  final refreshRequest = _createRefreshRequest(repository);
  final recoverRequest = _createRecoverRequest(repository);
  final addCompany = _createCompany(repository);
  final deleteCompany = _deleteCompany(repository);
  final purgeData = _purgeData(repository);

  return [
    TypedMiddleware<AppState, UserLogout>(userLogout),
    TypedMiddleware<AppState, UserLoginRequest>(loginRequest),
    TypedMiddleware<AppState, OAuthLoginRequest>(oauthLoginRequest),
    TypedMiddleware<AppState, UserSignUpRequest>(signUpRequest),
    TypedMiddleware<AppState, OAuthSignUpRequest>(oauthSignUpRequest),
    TypedMiddleware<AppState, RefreshData>(refreshRequest),
    TypedMiddleware<AppState, RecoverPasswordRequest>(recoverRequest),
    TypedMiddleware<AppState, AddCompany>(addCompany),
    TypedMiddleware<AppState, DeleteCompanyRequest>(deleteCompany),
    TypedMiddleware<AppState, PurgeDataRequest>(purgeData),
  ];
}

void _saveAuthLocal({String email = '', String url = ''}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(kSharedPrefEmail, email);
  prefs.setString(kSharedPrefUrl, formatApiUrl(url));
}

Middleware<AppState> _createUserLogout() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as UserLogout;

    next(action);

    Navigator.of(action.context).pushNamedAndRemoveUntil(
        LoginScreen.route, (Route<dynamic> route) => false);

    store.dispatch(UpdateCurrentRoute(LoginScreen.route));
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
      _saveAuthLocal(
        email: action.email,
        url: action.url,
      );
      store.dispatch(
          LoadAccountSuccess(completer: action.completer, loginResponse: data));
    }).catchError((Object error) {
      print('Login error: $error');
      var message = error.toString();
      if (message.startsWith('Deserializing') && !kIsWeb) {
        message = message.substring(message.lastIndexOf('Deserializing'));
        message =
            'An error occurred, please check that you\'re using the latest version of the app. $message';
      } else if (message.toLowerCase().contains('no host specified')) {
        message = 'An error occurred, please check the URL is correct';
      } else if (message.contains('404')) {
        message += ', you may need to add /public to the URL';
      }
      print('Login error: $message');
      if (action.completer != null) {
        action.completer.completeError(message);
      }
      store.dispatch(UserLoginFailure(message));
    });

    next(action);
  };
}

Middleware<AppState> _createSignUpRequest(AuthRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as UserSignUpRequest;

    repository
        .signUp(
      email: action.email,
      password: action.password,
    )
        .then((data) {
      _saveAuthLocal(email: action.email, url: kAppProductionUrl);

      store.dispatch(
          LoadAccountSuccess(completer: action.completer, loginResponse: data));
    }).catchError((Object error) {
      print('Signup error: $error');
      if (action.completer != null) {
        action.completer.completeError(error);
      }
      store.dispatch(UserLoginFailure(error));
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
            serverAuthCode: action.serverAuthCode,
            url: action.url,
            secret: action.secret,
            platform: action.platform)
        .then((data) {
      _saveAuthLocal(
        email: action.email,
        url: action.url,
      );

      store.dispatch(
          LoadAccountSuccess(completer: action.completer, loginResponse: data));
    }).catchError((Object error) {
      print('Oauth login error: $error');
      if (action.completer != null) {
        action.completer.completeError(error);
      }
      store.dispatch(UserLoginFailure(error));
    });

    next(action);
  };
}

Middleware<AppState> _createOAuthSignUpRequest(AuthRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as OAuthSignUpRequest;

    repository
        .oauthSignUp(
      accessToken: action.accessToken,
      idToken: action.idToken,
      serverAuthCode: action.serverAuthCode,
    )
        .then((data) {
      _saveAuthLocal(url: kAppProductionUrl);

      store.dispatch(
          LoadAccountSuccess(completer: action.completer, loginResponse: data));
    }).catchError((Object error) {
      print('OAuth signup error: $error');
      if (action.completer != null) {
        action.completer.completeError(error);
      }
      store.dispatch(UserLoginFailure(error));
    });

    next(action);
  };
}

Middleware<AppState> _createRefreshRequest(AuthRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as RefreshData;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final url = formatApiUrl(
        prefs.getString(kSharedPrefUrl) ?? store.state.authState.url);
    final token =
        TokenEntity.unobscureToken(prefs.getString(kSharedPrefToken)) ??
            'TOKEN';
    final updatedAt = action.clearData
        ? 0
        : ((store.state.userCompanyState.lastUpdated -
                    kMillisecondsToRefreshData) /
                1000)
            .round();

    store.dispatch(UserLoadUrl(url: url));

    repository
        .refresh(
      url: url,
      token: token,
      updatedAt: updatedAt - kUpdatedAtBufferSeconds,
      includeStatic: action.includeStatic || store.state.staticState.isStale,
    )
        .then((data) {
      if (action.clearData) {
        store.dispatch(ClearData());
      }
      store.dispatch(LoadAccountSuccess(
        completer: action.completer,
        loginResponse: data,
      ));
    }).catchError((Object error) {
      print('Refresh data error: $error');
      if (action.completer != null) {
        action.completer.completeError(error);
      }
      store.dispatch(RefreshDataFailure(error));
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
      if (action.completer != null) {
        store.dispatch(RecoverPasswordFailure(error.toString()));
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _createCompany(AuthRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as AddCompany;
    final state = store.state;

    repository.addCompany(credentials: state.credentials).then((dynamic value) {
      store.dispatch(AddCompanySuccess());
      store.dispatch(RefreshData(
        completer: Completer<Null>()
          ..future.then<Null>((_) {
            store.dispatch(SelectCompany(companyIndex: state.companies.length));
            store.dispatch(ViewDashboard(
                navigator: Navigator.of(action.context), force: true));
          }),
      ));
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
            companyId: state.company.id)
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

    repository
        .purgeData(
            credentials: state.credentials,
            password: action.password,
            companyId: state.company.id)
        .then((dynamic value) {
      store.dispatch(RefreshData(
          clearData: true,
          completer: Completer<Null>()
            ..future.then((value) {
              action.completer.complete(null);
              store.dispatch(PurgeDataSuccess());
            })));
    }).catchError((Object error) {
      store.dispatch(PurgeDataFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}
