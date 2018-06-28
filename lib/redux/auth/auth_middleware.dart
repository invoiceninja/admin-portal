import 'package:flutter/material.dart';
import 'package:invoiceninja/.env.dart';
import 'package:invoiceninja/redux/app/app_actions.dart';
import 'package:invoiceninja/ui/auth/login_vm.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/auth/auth_actions.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:invoiceninja/data/repositories/auth_repository.dart';
import 'package:invoiceninja/redux/company/company_actions.dart';

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

_saveAuthLocal(action) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('email', action.email);
  prefs.setString('url', action.url);

  if (action.password == 'password') {
    prefs.setString('password', action.password);
  }
  if (action.secret == 'secret') {
    prefs.setString('secret', action.secret);
  }
}

_loadAuthLocal(Store<AppState> store, action) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String email = prefs.getString('email') ?? Config.LOGIN_EMAIL;
  String password = prefs.getString('password') ?? Config.LOGIN_PASSWORD;
  String url = prefs.getString('url') ?? Config.LOGIN_URL;
  String secret = prefs.getString('secret') ?? Config.LOGIN_SECRET;

  store.dispatch(UserLoginLoaded(email, password, url, secret));
  Navigator.of(action.context).pushReplacementNamed(LoginScreen.route);
}

Middleware<AppState> _createLoginInit() {
  return (Store<AppState> store, action, NextDispatcher next) {
    _loadAuthLocal(store, action);

    next(action);
  };
}

Middleware<AppState> _createLoginRequest(AuthRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
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
        store.dispatch(UserLoginFailure('The minimum version is v4.5'));
      }
    }).catchError((error) {
      print(error);
      store.dispatch(UserLoginFailure(error));
    });

    next(action);
  };
}

bool _isVersionSupported(version) {
  var parts = version.split('.');

  int major = int.parse(parts[0]);
  int minor = int.parse(parts[1]);

  return true;

  // TODO enable before release
  //return major >= 4 && minor >= 5;
}
