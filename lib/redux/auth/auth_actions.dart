import 'dart:async';

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

