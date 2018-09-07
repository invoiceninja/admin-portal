import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_state.dart';

Reducer<AuthState> authReducer = combineReducers([
  TypedReducer<AuthState, UserLoginLoaded>(userLoginLoadedReducer),
  TypedReducer<AuthState, UserLoginRequest>(userLoginRequestReducer),
  TypedReducer<AuthState, OAuthLoginRequest>(oauthLoginRequestReducer),
  TypedReducer<AuthState, UserLoginSuccess>(userLoginSuccessReducer),
  TypedReducer<AuthState, UserLoginFailure>(userLoginFailureReducer),
  TypedReducer<AuthState, ClearAuthError>(clearAuthErrorReducer),
]);

AuthState clearAuthErrorReducer(
    AuthState authState, ClearAuthError action) {
  return authState.rebuild((b) => b..error = null);
}

AuthState userLoginLoadedReducer(AuthState authState, UserLoginLoaded action) {
  return authState.rebuild((b) => b
    ..isInitialized = true
    ..url = action.url ?? ''
    ..secret = action.secret ?? ''
    ..email = action.email ?? '');
}

AuthState userLoginRequestReducer(
    AuthState authState, UserLoginRequest action) {
  return authState.rebuild((b) => b
    ..error = null
    ..url = formatApiUrlMachine(action.url)
    ..secret = action.secret
    ..email = action.email
    ..password = action.password);
}

AuthState oauthLoginRequestReducer(
    AuthState authState, OAuthLoginRequest action) {
  return authState.rebuild((b) => b
    ..error = null
    ..url = formatApiUrlMachine(action.url)
    ..secret = action.secret);
}

AuthState userLoginSuccessReducer(
    AuthState authState, UserLoginSuccess action) {
  return authState.rebuild((b) => b
    ..isAuthenticated = true
    ..password = '');
}

AuthState userLoginFailureReducer(
    AuthState authState, UserLoginFailure action) {
  return authState.rebuild((b) => b..error = action.error);
}
