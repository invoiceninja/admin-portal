import 'package:flutter/material.dart';

class LoadUserLogin {}

class UserLoginLoaded {
  final String email;
  final String password;
  final String url;

  UserLoginLoaded(this.email, this.password, this.url);
}

class UserLoginRequest {
  final BuildContext context;
  final String email;
  final String password;
  final String url;

  UserLoginRequest(this.context, this.email, this.password, [this.url]);
}

class UserLoginSuccess {}

class UserLoginFailure {
  final String error;

  UserLoginFailure(this.error);
}

class UserLogout {}

