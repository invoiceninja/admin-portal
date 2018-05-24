import 'package:meta/meta.dart';

import 'package:invoiceninja/data/models/models.dart';

@immutable
class AuthState {

  // properties
  final String email;
  final String password;
  final String url;
  final bool isAuthenticated;
  final bool isAuthenticating;
  final String error;

  // constructor with default
  AuthState({
    this.email,
    this.password,
    this.url,
    this.isAuthenticated = false,
    this.isAuthenticating = false,
    this.error,
  });

  // allows to modify AuthState parameters while cloning previous ones
  AuthState copyWith({
    String email,
    String password,
    String url,
    String secret,
    String token,
    bool isAuthenticated,
    bool isAuthenticating,
    String error,
  }) {
    return new AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      url: url ?? this.url,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isAuthenticating: isAuthenticating ?? this.isAuthenticating,
      error: error ?? this.error,
    );
  }

  factory AuthState.fromJSON(Map<String, dynamic> json) => new AuthState(
    email: json['email'],
    password: '',
    url: json['url'],
    isAuthenticated: json['isAuthenticated'],
    isAuthenticating: json['isAuthenticating'],
    error: json['error'],
  );

  Map<String, dynamic> toJSON() => <String, dynamic>{
    'email': this.email,
    'password': '',
    'url': this.url,
    'isAuthenticated': this.isAuthenticated,
    'isAuthenticating': this.isAuthenticating,
    'error': this.error,
  };

  @override
  String toString() {
    return '''{
                email: $email,
                url: $url,
                isAuthenticated: $isAuthenticated,
                isAuthenticating: $isAuthenticating,
                error: $error
            }''';
  }
}