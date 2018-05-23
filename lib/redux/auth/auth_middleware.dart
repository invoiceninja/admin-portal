import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/auth/auth_actions.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:invoiceninja/redux/auth/auth_state.dart';
import 'package:invoiceninja/data/file_storage.dart';
import 'package:invoiceninja/data/repositories/auth_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:invoiceninja/redux/company/company_actions.dart';
import 'package:invoiceninja/routes.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_actions.dart';

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

_saveAuthLocal(action) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('email', action.email);
  prefs.setString('url', action.url);

  if (action.password == 'password') {
    prefs.setString('password', action.password);
  }
}

Middleware<AppState> _createLoginRequest(AuthRepositoryFlutter repository) {
  return (Store<AppState> store, action, NextDispatcher next) {

    repository.login(action.email, action.password, action.url).then(
        (data) {
          _saveAuthLocal(action);

          for (int i=0; i<data.length; i++) {
            store.dispatch(SelectCompany(i+1));
            store.dispatch(LoadCompanySuccess(data[i]));
          }

          store.dispatch(SelectCompany(1));
          store.dispatch(UserLoginSuccess());

          store.dispatch(UserLoginSuccess());
          store.dispatch(LoadDashboardAction());

          Navigator.of(action.context).pushNamed(AppRoutes.dashboard);
        }
    ).catchError((error) => store.dispatch(UserLoginFailure(error)));

    next(action);
  };
}


/*
Middleware<AppState> _createLoginSuccess() {
  return (Store<AppState> store, action, NextDispatcher next) {


    next(action);
  };
}
*/