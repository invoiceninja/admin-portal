import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/auth/auth_actions.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:invoiceninja/redux/auth/auth_state.dart';
import 'package:invoiceninja/data/file_storage.dart';
import 'package:invoiceninja/data/repositories/auth_repository.dart';
import 'package:path_provider/path_provider.dart';

List<Middleware<AppState>> createStoreAuthMiddleware([
  AuthRepositoryFlutter repository = const AuthRepositoryFlutter(
    fileStorage: const FileStorage(
      '__invoiceninja__',
      getApplicationDocumentsDirectory,
    ),
  ),
]) {
  final loginRequest = _createLoginRequest(repository);

  return [
    TypedMiddleware<AppState, UserLoginRequest>(loginRequest),
  ];
}

_saveAuth(action) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('email', action.email);
  prefs.setString('url', action.url);
}

Middleware<AppState> _createLoginRequest(AuthRepositoryFlutter repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    print('SAVE AUTH...');
    _saveAuth(action);

    repository.login(action.email, action.password, action.url);

    /*
    repository.login(action.email, action.password, action.url).then(
        (data) {
        }
        //(data) => store.dispatch(UserLoginSuccess(data))
    ).catchError((error) => store.dispatch(UserLoginFailure(error)));
    */

    next(action);
  };
}
