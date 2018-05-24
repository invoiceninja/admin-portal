import 'package:redux/redux.dart';

import 'package:invoiceninja/redux/auth/auth_actions.dart';
import 'package:invoiceninja/redux/auth/auth_state.dart';

Reducer<AuthState> authReducer = combineReducers([
  TypedReducer<AuthState, UserLoginLoaded>(userLoginLoadedReducer),
  TypedReducer<AuthState, UserLoginRequest>(userLoginRequestReducer),
  TypedReducer<AuthState, UserLoginSuccess>(userLoginSuccessReducer),
  TypedReducer<AuthState, UserLoginFailure>(userLoginFailureReducer),
  TypedReducer<AuthState, UserLogout>(userLogoutReducer),
]);

AuthState userLoginLoadedReducer(AuthState auth, UserLoginLoaded action) {
  return AuthState().copyWith(
    isInitialized: true,
    url: action.url,
    email: action.email,
    password: action.password,
  );
}

AuthState userLoginRequestReducer(AuthState auth, UserLoginRequest action) {
  return auth.copyWith(
    isAuthenticating: true,
  );
}

AuthState userLoginSuccessReducer(AuthState auth, UserLoginSuccess action) {
  return auth.copyWith(
    isAuthenticated: true,
    isAuthenticating: false,
    password: '',
  );
}

AuthState userLoginFailureReducer(AuthState auth, UserLoginFailure action) {
  return auth.copyWith(
      isAuthenticated: false, isAuthenticating: false, error: action.error);
}

AuthState userLogoutReducer(AuthState auth, UserLogout action) {
  return AuthState().copyWith(
    isInitialized: true,
    url: auth.url,
  );
}
