import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/data/models/models.dart';

class UserLoginRequest {
  final dynamic context;
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


/*
final Function login = (BuildContext context, String url, String token) {
  return (Store<AppState> store) {
    store.dispatch(new UserLoginRequest(url, token));
    store.dispatch(new UserLoginSuccess(new User(token, 1)));
    Navigator.of(context).pushNamed('/dashboard');
  };
};
*/

/*
final Function logout = (BuildContext context) {
  return (Store<AppState> store) {
    store.dispatch(new UserLogout());
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
  };
};
*/