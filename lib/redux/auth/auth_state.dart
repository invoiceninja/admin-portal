// Package imports:
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

part 'auth_state.g.dart';

abstract class AuthState implements Built<AuthState, AuthStateBuilder> {
  factory AuthState({String? url, String? referralCode}) {
    return _$AuthState._(
      email: '',
      url: url ?? '',
      isAuthenticated: false,
      isInitialized: false,
      lastEnteredPasswordAt: 0,
      referralCode: referralCode ?? '',
    );
  }

  AuthState._();

  @override
  @memoized
  int get hashCode;

  String get email;

  String get url;

  bool get isInitialized;

  bool get isAuthenticated;

  int get lastEnteredPasswordAt;

  String get referralCode;

  bool get isHosted {
    final cleanUrl = cleanApiUrl(url);

    if (cleanUrl.isEmpty) {
      return true;
    }

    if ([
      kAppProductionUrl,
      kFlutterDemoUrl,
      kAppStagingUrl,
      kAppStagingNetUrl,
    ].contains(cleanUrl)) {
      return true;
    }

    // Handle if a user logs in with their subdomain
    if (cleanUrl.endsWith('.invoicing.co')) {
      return true;
    }

    return false;
  }

  bool get isSelfHost => !isHosted;

  bool get isStaging => cleanApiUrl(url) == kAppStagingUrl;

  bool get isStagingNet => cleanApiUrl(url) == kAppStagingNetUrl;

  bool get isLargeTest => cleanApiUrl(url) == kAppLargeTestUrl;

  // ignore: unused_element
  static void _initializeBuilder(AuthStateBuilder builder) =>
      builder..referralCode = '';

  static Serializer<AuthState> get serializer => _$authStateSerializer;
}
