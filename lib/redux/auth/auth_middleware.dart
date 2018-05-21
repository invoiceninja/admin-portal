import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/auth/auth_actions.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:invoiceninja/redux/auth/auth_state.dart';

List<Middleware<AppState>> createStoreAuthMiddleware() {
  final saveAuth = _createSaveAuth();

  return [
    TypedMiddleware<AppState, UserLoginRequest>(saveAuth),
  ];
}

_saveAuth(action) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('url', action.url);
  prefs.setString('token', action.token);
}

Middleware<AppState> _createSaveAuth() {
  return (Store<AppState> store, action, NextDispatcher next) {
    print('SAVE AUTH...');

    _saveAuth(action);

    next(action);
  };
}
