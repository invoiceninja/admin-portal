// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/widgets.dart';

// Project imports:
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

class OAuthLoginRequest implements StartLoading {
  OAuthLoginRequest({
    required this.completer,
    required this.url,
    required this.secret,
    required this.platform,
    required this.provider,
    required this.oneTimePassword,
    this.idToken,
    this.accessToken,
    this.authCode,
    this.email,
  });

  final Completer completer;
  final String? email; // TODO remove this property, break up _saveAuthLocal
  final String? idToken;
  final String? accessToken;
  final String url;
  final String secret;
  final String platform;
  final String provider;
  final String oneTimePassword;
  final String? authCode;
}

class UserLoadUrl {
  UserLoadUrl({this.url});

  final String? url;
}

class UserLoginRequest implements StartLoading {
  UserLoginRequest(
      {required this.completer,
      required this.email,
      required this.password,
      required this.url,
      required this.secret,
      required this.platform,
      required this.oneTimePassword});

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
    required this.completer,
    required this.email,
    required this.url,
    required this.secret,
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

class UserLogout implements PersistData, PersistUI {}

class UserLogoutAll implements StartLoading {
  const UserLogoutAll({this.completer});

  final Completer? completer;
}

class UserLogoutAllSuccess implements StopLoading {}

class UserLogoutAllFailure implements StopLoading {
  const UserLogoutAllFailure(this.error);

  final Object error;
}

class UserSignUpRequest implements StartLoading {
  UserSignUpRequest({
    required this.completer,
    required this.email,
    required this.password,
  });

  final Completer completer;
  final String email;
  final String password;
}

class OAuthSignUpRequest implements StartLoading {
  OAuthSignUpRequest({
    required this.url,
    required this.completer,
    required this.provider,
    required this.idToken,
    this.accessToken,
    this.firstName,
    this.lastName,
  });

  final Completer completer;
  final String? idToken;
  final String url;
  final String? accessToken;
  final String provider;
  final String? firstName;
  final String? lastName;
}

class UserVerifiedPassword {}

class UserUnverifiedPassword {}
