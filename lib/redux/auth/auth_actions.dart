import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja/redux/app/app_state.dart';

class LoadStateRequest {
  final BuildContext context;
  LoadStateRequest(this.context);
}
class LoadStateSuccess {
  final AppState state;
  LoadStateSuccess(this.state);
}

class LoadUserLogin {}

class UserLoginLoaded {
  final String email;
  final String password;
  final String url;
  final String secret;

  UserLoginLoaded(this.email, this.password, this.url, this.secret);
}

class UserLoginRequest {
  final Completer completer;
  final String email;
  final String password;
  final String url;
  final String secret;

  UserLoginRequest(this.completer, this.email, this.password, this.url, this.secret);
}

class UserLoginSuccess {}

class UserLoginFailure {
  final String error;

  UserLoginFailure(this.error);
}

class UserLogout {}

