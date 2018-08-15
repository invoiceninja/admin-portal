import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/.env.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/ui/auth/login_vm.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:invoiceninja_flutter/data/repositories/auth_repository.dart';

List<Middleware<AppState>> createStoreAuthMiddleware([
  AuthRepository repository = const AuthRepository(),
]) {
  final loginInit = _createLoginInit();
  final loginRequest = _createLoginRequest(repository);
  final oauthRequest = _createOAuthRequest(repository);
  final refreshRequest = _createRefreshRequest(repository);

  return [
    TypedMiddleware<AppState, LoadUserLogin>(loginInit),
    TypedMiddleware<AppState, UserLoginRequest>(loginRequest),
    TypedMiddleware<AppState, OAuthLoginRequest>(oauthRequest),
    TypedMiddleware<AppState, RefreshData>(refreshRequest),
  ];
}

void _saveAuthLocal(dynamic action) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(kSharedPrefEmail, action.email);
  prefs.setString(kSharedPrefUrl, action.url);
  prefs.setString(kSharedPrefSecret, action.secret);
}

void _loadAuthLocal(Store<AppState> store, dynamic action) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final String email = prefs.getString(kSharedPrefEmail) ?? Config.LOGIN_EMAIL;
  final String url = prefs.getString(kSharedPrefUrl) ?? Config.LOGIN_URL;
  final String secret = prefs.getString(kSharedPrefSecret) ?? Config.LOGIN_SECRET;
  store.dispatch(UserLoginLoaded(email, url, secret));

  final bool enableDarkMode = prefs.getBool(kSharedPrefEnableDarkMode) ?? false;
  store.dispatch(UserSettingsChanged(enableDarkMode: enableDarkMode));

  Navigator.of(action.context).pushReplacementNamed(LoginScreen.route);
}

Middleware<AppState> _createLoginInit() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    _loadAuthLocal(store, action);

    next(action);
  };
}

Middleware<AppState> _createLoginRequest(AuthRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    repository
        .login(action.email, action.password, action.url, action.secret, action.platform)
        .then((data) {
      _saveAuthLocal(action);

      if (_isVersionSupported(data.version)) {
        store.dispatch(LoadDataSuccess(completer: action.completer, loginResponse: data));
      } else {
        store.dispatch(UserLoginFailure(
            'The minimum version is v$kMinMajorAppVersion.$kMinMinorAppVersion.$kMinPatchAppVersion'));
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(UserLoginFailure(error.toString()));
    });

    next(action);
  };
}

Middleware<AppState> _createOAuthRequest(AuthRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    repository
        .oauth(action.token, action.url, action.secret, action.platform)
        .then((data) {
      _saveAuthLocal(action);

      if (_isVersionSupported(data.version)) {
        store.dispatch(LoadDataSuccess(completer: action.completer, loginResponse: data));
      } else {
        store.dispatch(UserLoginFailure(
            'The minimum version is v$kMinMajorAppVersion.$kMinMinorAppVersion.$kMinPatchAppVersion'));
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(UserLoginFailure(error.toString()));
    });

    next(action);
  };
}

Middleware<AppState> _createRefreshRequest(AuthRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    final state = store.state;
    repository
        .refresh(state.authState.url, state.selectedCompany.token, action.platform)
        .then((data) {
        store.dispatch(LoadDataSuccess(completer: action.completer, loginResponse: data));
    }).catchError((Object error) {
      print(error);
      store.dispatch(UserLoginFailure(error.toString()));
    });

    next(action);
  };
}

bool _isVersionSupported(String version) {
  final parts = version.split('.');

  final int major = int.parse(parts[0]);
  final int minor = int.parse(parts[1]);
  final int patch = int.parse(parts[2]);

  return major >= kMinMajorAppVersion && minor >= kMinMinorAppVersion && patch >= kMinPatchAppVersion;
}
