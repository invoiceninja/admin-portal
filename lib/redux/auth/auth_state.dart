import 'package:meta/meta.dart';

import 'package:invoiceninja/data/models/models.dart';

@immutable
class AuthState {

  // properties
  final String url;
  final String secret;
  final String token;
  final bool isAuthenticated;
  final bool isAuthenticating;
  final User user;
  final String error;

  // constructor with default
  AuthState({
    this.url,
    this.secret,
    this.token,
    this.isAuthenticated = false,
    this.isAuthenticating = false,
    this.user,
    this.error,
  });

  // allows to modify AuthState parameters while cloning previous ones
  AuthState copyWith({
    String url,
    String secret,
    String token,
    bool isAuthenticated,
    bool isAuthenticating,
    String error,
    User user
  }) {
    return new AuthState(
      url: url ?? this.url,
      token: token ?? this.token,
      secret: secret ?? this.secret,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isAuthenticating: isAuthenticating ?? this.isAuthenticating,
      error: error ?? this.error,
      user: user ?? this.user,
    );
  }

  factory AuthState.fromJSON(Map<String, dynamic> json) => new AuthState(
    url: json['url'],
    token: json['token'],
    secret: json['secret'],
    isAuthenticated: json['isAuthenticated'],
    isAuthenticating: json['isAuthenticating'],
    error: json['error'],
    user: json['user'] == null ? null : new User.fromJSON(json['user']),
  );

  Map<String, dynamic> toJSON() => <String, dynamic>{
    'url': this.url,
    'token': this.token,
    'secret': this.secret,
    'isAuthenticated': this.isAuthenticated,
    'isAuthenticating': this.isAuthenticating,
    'user': this.user == null ? null : this.user.toJSON(),
    'error': this.error,
  };

  @override
  String toString() {
    return '''{
                url: $url,
                isAuthenticated: $isAuthenticated,
                isAuthenticating: $isAuthenticating,
                user: $user,
                error: $error
            }''';
  }
}