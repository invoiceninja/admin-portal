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
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';

List<Middleware<AppState>> createStoreAuthMiddleware([
  AuthRepository repository = const AuthRepository(),
]) {
  final loginInit = _createLoginInit();
  final loginRequest = _createLoginRequest(repository);

  return [
    TypedMiddleware<AppState, LoadUserLogin>(loginInit),
    TypedMiddleware<AppState, UserLoginRequest>(loginRequest),
  ];
}

void _saveAuthLocal(dynamic action) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('email', action.email);
  prefs.setString('url', action.url);

  if (action.password == 'password') {
    prefs.setString('password', action.password);
  }
  if (action.secret == 'secret') {
    prefs.setString('secret', action.secret);
  }
}

void _loadAuthLocal(Store<AppState> store, dynamic action) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final String email = prefs.getString('email') ?? Config.LOGIN_EMAIL;
  final String password = prefs.getString('password') ?? Config.LOGIN_PASSWORD;
  final String url = prefs.getString('url') ?? Config.LOGIN_URL;
  final String secret = prefs.getString('secret') ?? Config.LOGIN_SECRET;

  store.dispatch(UserLoginLoaded(email, password, url, secret));
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
        .login(action.email, action.password, action.url, action.secret)
        .then((data) {
      _saveAuthLocal(action);

      if (_isVersionSupported(data.version)) {
        store.dispatch(LoadStaticSuccess(data.static));

        for (int i = 0; i < data.accounts.length; i++) {
          store.dispatch(SelectCompany(i + 1));
          store.dispatch(LoadCompanySuccess(data.accounts[i]));
        }

        store.dispatch(SelectCompany(1));
        store.dispatch(UserLoginSuccess());

        action.completer.complete(null);
      } else {
        store.dispatch(UserLoginFailure(
            'The minimum version is v$kMinMajorAppVersion.$kMinMinorAppVersion'));
      }
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

  return major >= kMinMajorAppVersion && minor >= kMinMinorAppVersion;
}
