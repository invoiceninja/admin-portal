import 'package:redux/redux.dart';

import 'package:invoiceninja/redux/auth/auth_actions.dart';
import 'package:invoiceninja/redux/auth/auth_state.dart';

Reducer<AuthState> authReducer = combineReducers([
  new TypedReducer<AuthState, UserLoginRequest>(userLoginRequestReducer),
  new TypedReducer<AuthState, UserLoginSuccess>(userLoginSuccessReducer),
  new TypedReducer<AuthState, UserLoginFailure>(userLoginFailureReducer),
  new TypedReducer<AuthState, UserLogout>(userLogoutReducer),
]);

AuthState userLoginRequestReducer(AuthState auth, UserLoginRequest action) {
  return new AuthState().copyWith(
    isAuthenticated: false,
    isAuthenticating: true,
  );
}

AuthState userLoginSuccessReducer(AuthState auth, UserLoginSuccess action) {
  return new AuthState().copyWith(
      isAuthenticated: true,
      isAuthenticating: false,
      user: action.user
  );
}

AuthState userLoginFailureReducer(AuthState auth, UserLoginFailure action) {
  return new AuthState().copyWith(
      isAuthenticated: false,
      isAuthenticating: false,
      error: action.error
  );
}

AuthState userLogoutReducer(AuthState auth, UserLogout action) {
  return new AuthState();
}