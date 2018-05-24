import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/data/models/models.dart';

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

