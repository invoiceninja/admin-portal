import 'package:meta/meta.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:invoiceninja/data/models/models.dart';

part 'auth_state.g.dart';

abstract class AuthState implements Built<AuthState, AuthStateBuilder> {

  String get email;
  String get password;
  String get url;
  bool get isInitialized;
  bool get isAuthenticated;
  String get error;

  factory AuthState() {
    return _$AuthState._(
      email: '',
      password: '',
      url: '',
      isAuthenticated: false,
      isInitialized: false,
      error: '',
    );
  }

  AuthState._();
  //factory AuthState([updates(AuthStateBuilder b)]) = _$AuthState;
  static Serializer<AuthState> get serializer => _$authStateSerializer;
}


/*
@immutable
class AuthState {

  // properties
  final String email;
  final String password;
  final String url;
  final bool isInitialized;
  final bool isAuthenticated;
  final bool isAuthenticating;
  final String error;

  // constructor with default
  AuthState({
    this.email,
    this.password,
    this.url,
    this.isInitialized = false,
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
    bool isInitialized,
    bool isAuthenticated,
    bool isAuthenticating,
    String error,
  }) {
    return new AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      url: url ?? this.url,
      isInitialized: isInitialized ?? this.isInitialized,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isAuthenticating: isAuthenticating ?? this.isAuthenticating,
      error: error ?? this.error,
    );
  }

  factory AuthState.fromJSON(Map<String, dynamic> json) => new AuthState(
    email: json['email'],
    password: '',
    url: json['url'],
    isInitialized: json['isInitialized'],
    isAuthenticated: json['isAuthenticated'],
    isAuthenticating: json['isAuthenticating'],
    error: json['error'],
  );

  Map<String, dynamic> toJSON() => <String, dynamic>{
    'email': this.email,
    'password': '',
    'url': this.url,
    'isInitialized': this.isInitialized,
    'isAuthenticated': this.isAuthenticated,
    'isAuthenticating': this.isAuthenticating,
    'error': this.error,
  };

  @override
  String toString() {
    return '''{
                email: $email,
                url: $url,
                isInitialized: $isInitialized,
                isAuthenticated: $isAuthenticated,
                isAuthenticating: $isAuthenticating,
                error: $error
            }''';
  }
}
*/