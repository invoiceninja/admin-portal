import 'package:redux/redux.dart';

import 'package:invoiceninja/redux/auth/auth_actions.dart';
import 'package:invoiceninja/redux/auth/auth_state.dart';

Reducer<AuthState> authReducer = combineReducers([
  TypedReducer<AuthState, UserLoginRequest>(userLoginRequestReducer),
  TypedReducer<AuthState, UserLoginSuccess>(userLoginSuccessReducer),
  TypedReducer<AuthState, UserLoginFailure>(userLoginFailureReducer),
  TypedReducer<AuthState, UserLogout>(userLogoutReducer),
]);

AuthState userLoginRequestReducer(AuthState auth, UserLoginRequest action) {
  return AuthState().copyWith(
    url: action.url,
    isAuthenticated: false,
    isAuthenticating: true,
  );
}

AuthState userLoginSuccessReducer(AuthState auth, UserLoginSuccess action) {
  return AuthState().copyWith(
      isAuthenticated: true,
      isAuthenticating: false,
      user: action.user
  );
}

AuthState userLoginFailureReducer(AuthState auth, UserLoginFailure action) {
  return AuthState().copyWith(
      isAuthenticated: false,
      isAuthenticating: false,
      error: action.error
  );
}

AuthState userLogoutReducer(AuthState auth, UserLogout action) {
  return AuthState();
}