import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/.env.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
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

void _saveAuthLocal(
    {String email = '', String url = '', String secret = ''}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(kSharedPrefEmail, email ?? '');
  prefs.setString(kSharedPrefUrl, formatApiUrl(url));
}

void _loadAuthLocal(Store<AppState> store) async {
  if (kIsWeb) {
    return;
  }

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String email = kReleaseMode
      ? (prefs.getString(kSharedPrefEmail) ?? '')
      : Config.TEST_EMAIL;
  final String url = formatApiUrl(prefs.getString(kSharedPrefUrl) ?? '');

  store.dispatch(UserLoginLoaded(email, url));
}

Middleware<AppState> _createUserLogout() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as UserLogout;

    next(action);

    _loadAuthLocal(store);

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
        secret: action.secret,
        url: action.url,
      );
      store.dispatch(
          LoadAccountSuccess(completer: action.completer, loginResponse: data));
    }).catchError((Object error) {
      print(error);
      var message = error.toString();
      if (message.toLowerCase().contains('no host specified')) {
        message = 'Please check the URL is correct';
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
      url: action.url,
      email: action.email,
      password: action.password,
      firstName: action.firstName,
      lastName: action.lastName,
      secret: action.secret,
    )
        .then((data) {
      _saveAuthLocal(email: action.email, secret: '', url: '');

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
            token: action.token,
            url: action.url,
            secret: action.secret,
            platform: action.platform)
        .then((data) {
      _saveAuthLocal(
        email: action.email,
        secret: action.secret,
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
            email: action.email,
            firstName: action.firstName,
            lastName: action.lastName,
            oauthId: action.oauthId,
            photoUrl: action.photoUrl)
        .then((data) {
      _saveAuthLocal(email: action.email, secret: '', url: '');

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

Middleware<AppState> _createRefreshRequest(AuthRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as RefreshData;

    _loadAuthLocal(store);

    String url;
    String token;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    url = formatApiUrl(prefs.getString(kSharedPrefUrl) ?? Config.TEST_URL);
    token = prefs.getString(kSharedPrefToken);

    repository.refresh(url: url, token: token).then((data) {
      store.dispatch(LoadAccountSuccess(
          completer: action.completer,
          loginResponse: data,
          loadCompanies: action.loadCompanies));
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
      store.dispatch(RefreshData(
        completer: Completer<Null>()
          ..future.then<Null>((_) {
            store.dispatch(SelectCompany(state.companies.length));
            store.dispatch(ViewDashboard(
                navigator: Navigator.of(action.context), force: true));
            store.dispatch(LoadClients());
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
      action.completer.complete(null);
      store.dispatch(DeleteCompanySuccess());
    }).catchError((Object error) {
      store.dispatch(DeleteCompanyFailure(error));
    });

    next(action);
  };
}

Middleware<AppState> _purgeData(AuthRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as DeleteCompanyRequest;
    final state = store.state;

    repository
        .purgeData(
            token: state.credentials.token,
            password: action.password,
            companyId: state.company.id)
        .then((dynamic value) {
      action.completer.complete(null);
      store.dispatch(PurgeDataSuccess());
    }).catchError((Object error) {
      store.dispatch(PurgeDataFailure(error));
    });

    next(action);
  };
}
