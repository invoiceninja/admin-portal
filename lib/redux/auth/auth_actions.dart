import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class LoadStateRequest {
  final BuildContext context;

  LoadStateRequest(this.context);
}

class LoadStateSuccess {
  final AppState state;

  LoadStateSuccess(this.state);
}

class LoadUserLogin {
  final BuildContext context;

  LoadUserLogin(this.context);
}

class UserLoginLoaded {
  final String email;
  final String url;
  final String secret;

  UserLoginLoaded(this.email, this.url, this.secret);
}

class OAuthLoginRequest implements StartLoading {
  final Completer completer;
  final String token;
  final String url;
  final String secret;
  final String platform;

  OAuthLoginRequest(
      {this.completer, this.token, this.url, this.secret, this.platform});
}

class UserLoginRequest implements StartLoading {
  final Completer completer;
  final String email;
  final String password;
  final String url;
  final String secret;
  final String platform;
  final String oneTimePassword;

  UserLoginRequest(
      {this.completer,
      this.email,
      this.password,
      this.url,
      this.secret,
      this.platform,
      this.oneTimePassword});
}

class UserLoginSuccess implements StopLoading {}

class UserLoginFailure implements StopLoading {
  final Object error;

  UserLoginFailure(this.error);
}

class UserLogout implements PersistData {}
