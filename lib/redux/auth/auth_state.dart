import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

part 'auth_state.g.dart';

abstract class AuthState implements Built<AuthState, AuthStateBuilder> {
  factory AuthState({String url}) {
    return _$AuthState._(
      email: '',
      password: '',
      url: url ?? '',
      secret: '',
      isAuthenticated: false,
      isInitialized: false,
      lastEnteredPasswordAt: 0,
    );
  }

  AuthState._();

  @override
  @memoized
  int get hashCode;

  String get email;

  String get password;

  String get url;

  String get secret;

  bool get isInitialized;

  bool get isAuthenticated;

  int get lastEnteredPasswordAt;

  bool get isHosted {
    final cleanUrl = cleanApiUrl(url);

    if (cleanUrl.isEmpty) {
      return true;
    }

    if ([
      kAppProductionUrl,
      kAppDemoUrl,
      kAppStagingUrl,
    ].contains(cleanUrl)) {
      return true;
    }

    return false;
  }

  bool get isSelfHost => !isHosted;

  bool get isStaging => cleanApiUrl(url) == kAppStagingUrl;

  static Serializer<AuthState> get serializer => _$authStateSerializer;
}
