import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

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

  bool get isHosted => cleanApiUrl(url).isEmpty || cleanApiUrl(url) == kAppUrl;

  bool get isSelfHost => !isHosted;

  //factory AuthState([void updates(AuthStateBuilder b)]) = _$AuthState;
  static Serializer<AuthState> get serializer => _$authStateSerializer;
}
