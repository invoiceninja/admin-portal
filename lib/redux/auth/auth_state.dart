import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth_state.g.dart';

abstract class AuthState implements Built<AuthState, AuthStateBuilder> {

  factory AuthState() {
    return _$AuthState._(
      email: '',
      password: '',
      url: '',
      secret: '',
      isAuthenticated: false,
      isInitialized: false,
    );
  }
  AuthState._();

  String get email;
  String get password;
  String get url;
  String get secret;
  bool get isInitialized;
  bool get isAuthenticated;

  @nullable
  String get error;


  //factory AuthState([void updates(AuthStateBuilder b)]) = _$AuthState;
  static Serializer<AuthState> get serializer => _$authStateSerializer;
}
