import 'package:redux/redux.dart';

import 'package:invoiceninja/redux/auth/auth_actions.dart';
import 'package:invoiceninja/redux/auth/auth_state.dart';

Reducer<AuthState> authReducer = combineReducers([
  TypedReducer<AuthState, UserLoginLoaded>(userLoginLoadedReducer),
  TypedReducer<AuthState, UserLoginRequest>(userLoginRequestReducer),
  TypedReducer<AuthState, UserLoginSuccess>(userLoginSuccessReducer),
  TypedReducer<AuthState, UserLoginFailure>(userLoginFailureReducer),
  //TypedReducer<AuthState, UserLogout>(userLogoutReducer),
]);

AuthState userLoginLoadedReducer(AuthState authState, UserLoginLoaded action) {
  return authState.rebuild((b) => b
    ..isInitialized = true
    ..url = action.url ?? ''
    ..email = action.email ?? ''
    ..password = action.password ?? '');
}

AuthState userLoginRequestReducer(
    AuthState authState, UserLoginRequest action) {
  return authState.rebuild((b) => b
    ..url = action.url
    ..email = action.email
    ..password = action.password);
}

AuthState userLoginSuccessReducer(
    AuthState authState, UserLoginSuccess action) {
  return authState.rebuild((b) => b
      ..isAuthenticated = true
    ..password = ''
  );
}

AuthState userLoginFailureReducer(
    AuthState authState, UserLoginFailure action) {
  return authState.rebuild((b) => b
      ..error = action.error
  );
}

/*
AuthState userLogoutReducer(AuthState authState, UserLogout action) {
  return AuthState();
}
*/