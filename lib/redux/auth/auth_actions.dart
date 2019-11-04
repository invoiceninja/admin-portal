import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class LoadStateRequest {
  LoadStateRequest(this.context);

  final BuildContext context;
}

class LoadStateSuccess {
  LoadStateSuccess(this.state);

  final AppState state;
}

class UserLoginLoaded {
  UserLoginLoaded(this.email, this.url, this.secret);

  final String email;
  final String url;
  final String secret;
}

class OAuthLoginRequest implements StartLoading {
  OAuthLoginRequest(
      {this.completer,
      this.email,
      this.token,
      this.url,
      this.secret,
      this.platform,
      this.oneTimePassword});

  final Completer completer;
  final String email; // TODO remove this property, break up _saveAuthLocal
  final String token;
  final String url;
  final String secret;
  final String platform;
  final String oneTimePassword;
}

class UserLoginRequest implements StartLoading {
  UserLoginRequest(
      {this.completer,
      this.email,
      this.password,
      this.url,
      this.secret,
      this.platform,
      this.oneTimePassword});

  final Completer completer;
  final String email;
  final String password;
  final String url;
  final String secret;
  final String platform;
  final String oneTimePassword;
}

class UserLoginSuccess implements StopLoading {}

class UserLoginFailure implements StopLoading {
  UserLoginFailure(this.error);

  final Object error;
}

class RecoverPasswordRequest implements StartLoading {
  RecoverPasswordRequest({
    this.completer,
    this.email,
    this.url,
    this.secret,
  });

  final Completer completer;
  final String email;
  final String url;
  final String secret;
}

class RecoverPasswordSuccess implements StopLoading {}

class RecoverPasswordFailure implements StopLoading {
  RecoverPasswordFailure(this.error);

  final Object error;
}

class UserLogout implements PersistData, PersistUI {
  UserLogout(this.context);

  final BuildContext context;
}

class UserSignUpRequest implements StartLoading {
  UserSignUpRequest({
    this.completer,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.platform,
    this.photoUrl,
    this.oauthId,
  });

  final Completer completer;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String platform;
  final String photoUrl;
  final String oauthId;
}
