import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/.env.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
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

void _saveAuthLocal({String email, String url, String secret}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(kSharedPrefEmail, email ?? '');

  if (formatApiUrlReadable(url) != kAppUrl) {
    prefs.setString(kSharedPrefUrl, formatApiUrlMachine(url));
    prefs.setString(kSharedPrefSecret, secret);
  }
}

void _loadAuthLocal(Store<AppState> store) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String email = prefs.getString(kSharedPrefEmail) ?? '';
  final String url = formatApiUrlMachine(prefs.getString(kSharedPrefUrl) ?? '');
  final String secret = prefs.getString(kSharedPrefSecret) ?? '';
  store.dispatch(UserLoginLoaded(email, url, secret));

  store.dispatch(UserSettingsChanged(
    enableDarkMode: prefs.getBool(kSharedPrefEnableDarkMode) ?? false,
    emailPayment: prefs.getBool(kSharedPrefEmailPayment) ?? false,
    requireAuthentication:
        prefs.getBool(kSharedPrefRequireAuthentication) ?? false,
    autoStartTasks: prefs.getBool(kSharedPrefAutoStartTasks) ?? false,
    addDocumentsToInvoice:
        prefs.getBool(kSharedPrefAddDocumentsToInvoice) ?? false,
  ));
}

Middleware<AppState> _createLoginInit() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadUserLogin;

    _loadAuthLocal(store);

    Navigator.of(action.context).pushReplacementNamed(LoginScreen.route);

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
      _saveAuthLocal(
        email: action.email,
        secret: action.secret,
        url: action.url,
      );

      if (_isVersionSupported(data.version)) {
        store.dispatch(LoadAccountSuccess(
            completer: action.completer, loginResponse: data));
      } else {
        store.dispatch(UserLoginFailure(
            'The minimum version is v$kMinMajorAppVersion.$kMinMinorAppVersion.$kMinPatchAppVersion'));
      }
    }).catchError((Object error) {
      print(error);
      var message = error.toString();
      if (message.toLowerCase().contains('no host specified')) {
        message = 'Please check the URL is correct';
      } else if (message.toLowerCase().contains('credentials')) {
        message += ', please confirm your credentials in the web app';
      } else if (message.contains('404')) {
        message += ', you may need to add /public to the URL';
      }
      store.dispatch(UserLoginFailure(message));
    });

    next(action);
  };
}

Middleware<AppState> _createOAuthRequest(AuthRepository repository) {
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

      if (_isVersionSupported(data.version)) {
        store.dispatch(LoadAccountSuccess(
            completer: action.completer, loginResponse: data));
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
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as RefreshData;

    next(action);

    _loadAuthLocal(store);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String url =
        formatApiUrlMachine(prefs.getString(kSharedPrefUrl) ?? Config.TEST_URL);
    final String token = prefs.getString(getCompanyTokenKey());

    repository
        .refresh(url: url, token: token, platform: action.platform)
        .then((data) {
      store.dispatch(LoadAccountSuccess(
          completer: action.completer,
          loginResponse: data,
          loadCompanies: action.loadCompanies));
    }).catchError((Object error) {
      print(error);
      store.dispatch(UserLoginFailure(error.toString()));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });
  };
}

bool _isVersionSupported(String version) {
  final parts = version.split('.');

  final int major = int.parse(parts[0]);
  final int minor = int.parse(parts[1]);
  final int patch = int.parse(parts[2]);

  return major >= kMinMajorAppVersion &&
      minor >= kMinMinorAppVersion &&
      patch >= kMinPatchAppVersion;
}
