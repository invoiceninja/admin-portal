import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_state.dart';

Reducer<AuthState> authReducer = combineReducers([
  TypedReducer<AuthState, UserLoadUrl>(userLoadUrlReducer),
  TypedReducer<AuthState, UserLoginRequest>(userLoginRequestReducer),
  TypedReducer<AuthState, OAuthLoginRequest>(oauthLoginRequestReducer),
  TypedReducer<AuthState, OAuthSignUpRequest>(oauthSignUpRequestReducer),
  TypedReducer<AuthState, UserSignUpRequest>(userSignUpRequestReducer),
  TypedReducer<AuthState, UserLoginSuccess>(userLoginSuccessReducer),
  TypedReducer<AuthState, UserVerifiedPassword>(userVerifiedPasswordReducer),
  TypedReducer<AuthState, UserUnverifiedPassword>(
      userUnverifiedPasswordReducer),
]);

AuthState userLoadUrlReducer(AuthState authState, UserLoadUrl action) {
  return authState.rebuild((b) => b..url = formatApiUrl(action.url));
}

AuthState userSignUpRequestReducer(
    AuthState authState, UserSignUpRequest action) {
  return authState.rebuild((b) => b
    ..url = formatApiUrl(kAppProductionUrl)
    ..secret = '');
}

AuthState userLoginRequestReducer(
    AuthState authState, UserLoginRequest action) {
  return authState.rebuild((b) => b
    ..url = formatApiUrl(action.url)
    ..secret = action.secret
    ..email = action.email
    ..password = action.password);
}

AuthState oauthLoginRequestReducer(
    AuthState authState, OAuthLoginRequest action) {
  return authState.rebuild((b) => b
    ..url = formatApiUrl(action.url)
    ..secret = action.secret);
}

AuthState oauthSignUpRequestReducer(
    AuthState authState, OAuthSignUpRequest action) {
  return authState.rebuild((b) => b
    ..url = formatApiUrl(kAppProductionUrl)
    ..secret = '');
}

AuthState userLoginSuccessReducer(
    AuthState authState, UserLoginSuccess action) {
  return authState.rebuild((b) => b
    ..isAuthenticated = true
    ..password = '');
}

AuthState userVerifiedPasswordReducer(
    AuthState authState, UserVerifiedPassword action) {
  return authState.rebuild(
      (b) => b..lastEnteredPasswordAt = DateTime.now().millisecondsSinceEpoch);
}

AuthState userUnverifiedPasswordReducer(
    AuthState authState, UserUnverifiedPassword action) {
  return authState.rebuild((b) => b..lastEnteredPasswordAt = 0);
}
