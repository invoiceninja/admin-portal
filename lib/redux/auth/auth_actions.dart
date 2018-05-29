import 'dart:async';

class LoadUserLogin {}

class UserLoginLoaded {
  final String email;
  final String password;
  final String url;

  UserLoginLoaded(this.email, this.password, this.url);
}

class UserLoginRequest {
  final Completer completer;
  final String email;
  final String password;
  final String url;

  UserLoginRequest(this.completer, this.email, this.password, this.url);
}

class UserLoginSuccess {}

class UserLoginFailure {
  final String error;

  UserLoginFailure(this.error);
}

class UserLogout {}

