import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Google sign-in for the InvoiceNinja API (`/oauth_login`).
///
/// We deliberately ride v7's "access token" path instead of the new
/// "id token" path: the backend's `getTokenResponse(id_token)` route
/// rejects v7-issued JWTs, while `harvestUser(access_token)` (which calls
/// Google's userinfo endpoint) keeps working unchanged. So this returns
/// `(idToken: '', accessToken)` and the repository layer omits the empty
/// id_token from the request body so Laravel's `request()->has('id_token')`
/// returns false and execution falls into the access-token branch.
///
/// Android requires `serverClientId` to be passed to `initialize()` — the
/// v7 plugin routes through Credential Manager, which needs the Web OAuth
/// client ID and does not auto-resolve it from `google-services.json`. iOS
/// resolves its client ID from `Info.plist`/`GoogleService-Info.plist`, and
/// passing `serverClientId` there breaks the flow, so it stays Android-only.
const String _kAndroidServerClientId =
    '640903115046-37ltu6s2j07gcqkssmf5feofj4isnsju.apps.googleusercontent.com';

class GoogleOAuth {
  static bool _initialized = false;

  static bool get isEnabled => true;

  static Future<void> init() async {
    if (_initialized) {
      return;
    }
    if (!kIsWeb && Platform.isAndroid) {
      await GoogleSignIn.instance.initialize(
        serverClientId: _kAndroidServerClientId,
      );
    } else {
      await GoogleSignIn.instance.initialize();
    }
    _initialized = true;
  }

  static Future<bool> signIn(
    void Function(String idToken, String accessToken) callback, {
    bool isSilent = false,
  }) async {
    await init();

    GoogleSignInAccount? account;

    if (isSilent) {
      account = await GoogleSignIn.instance.attemptLightweightAuthentication();
    }

    account ??= await _interactiveAuthenticate();

    if (account == null) {
      callback('', '');
      return false;
    }

    final accessToken = await _resolveAccessToken(account);
    callback('', accessToken);
    return accessToken.isNotEmpty;
  }

  static Future<bool> signUp(
    void Function(String idToken, String accessToken) callback,
  ) async {
    await init();

    final account = await _interactiveAuthenticate();
    if (account == null) {
      callback('', '');
      return false;
    }

    final accessToken = await _resolveAccessToken(account);
    callback('', accessToken);
    return accessToken.isNotEmpty;
  }

  static Future<void> signOut() async {
    await init();
    await GoogleSignIn.instance.signOut();
  }

  static Future<void> disconnect() async {
    await init();
    await GoogleSignIn.instance.disconnect();
  }

  static const _scopes = ['email', 'profile'];

  static Future<GoogleSignInAccount?> _interactiveAuthenticate() async {
    if (!GoogleSignIn.instance.supportsAuthenticate()) {
      debugPrint('## authenticate() not supported on this platform');
      return null;
    }
    try {
      return await GoogleSignIn.instance.authenticate();
    } on GoogleSignInException catch (e) {
      debugPrint('## authenticate failed: ${e.code}');
      return null;
    }
  }

  static Future<String> _resolveAccessToken(GoogleSignInAccount account) async {
    final silent =
        await account.authorizationClient.authorizationForScopes(_scopes);
    if (silent != null) {
      return silent.accessToken;
    }

    try {
      final interactive =
          await account.authorizationClient.authorizeScopes(_scopes);
      return interactive.accessToken;
    } on GoogleSignInException catch (e) {
      debugPrint('## authorizeScopes failed: ${e.code}');
      return '';
    }
  }
}
