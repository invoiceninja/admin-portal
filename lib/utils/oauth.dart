import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Set your OAuth client IDs as needed.
/// - `clientId` is optional (some platforms use it, e.g. iOS/macOS).
/// - `serverClientId` (your Web client ID) is needed if you want a reliable ID token.
const String? kClientId = null;
const String? kServerClientId =
    '640903115046-37ltu6s2j07gcqkssmf5feofj4isnsju.apps.googleusercontent.com';

class GoogleOAuth {
  static bool _initialized = false;

  static bool get isEnabled => true;

  /// Call once during app startup.
  static Future<void> init() async {
    if (_initialized) return;
    await GoogleSignIn.instance.initialize(
      clientId: kClientId,
      serverClientId: kServerClientId,
    );
    _initialized = true;
  }

  /// Sign in. If [isSilent] is true, try lightweight auth first.
  /// Calls [callback] with (idToken, accessToken).
  /// NOTE: v7's authentication flow only returns an **idToken**;
  /// obtaining an **access token** requires an authorization step with scopes.
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
      debugPrint('## ERROR: sign in failed');
      callback('', ''); // preserve your previous contract
      return false;
    }

    // AUTHENTICATION → ID TOKEN
    final idToken = (await account.authentication).idToken ?? '';

    // AUTHORIZATION → ACCESS TOKEN (only if you actually need one)
    // If you don't need an access token, you can skip this block or return ''.
    String accessToken = '';
    final authz =
        await account.authorizationClient.authorizationForScopes(const [
      'email',
      'openid',
      'profile',
    ]);
    if (authz != null) {
      accessToken = authz.accessToken ?? '';
    }

    callback(idToken, accessToken);
    return idToken.isNotEmpty;
  }

  /// Mirror of your old API; just does interactive auth.
  static Future<bool> signUp(
    void Function(String idToken, String accessToken) callback,
  ) async {
    await init();

    final account = await _interactiveAuthenticate();
    if (account == null) {
      debugPrint('## ERROR: sign up failed');
      callback('', '');
      return false;
    }

    final idToken = (await account.authentication).idToken ?? '';

    String accessToken = '';
    final authz =
        await account.authorizationClient.authorizationForScopes(const [
      'email',
      'openid',
      'profile',
    ]);
    if (authz != null) {
      accessToken = authz.accessToken ?? '';
    }

    callback(idToken, accessToken);
    return idToken.isNotEmpty;
  }

  static Future<void> signOut() async {
    await init();
    await GoogleSignIn.instance.signOut();
  }

  static Future<void> disconnect() async {
    await init();
    await GoogleSignIn.instance.disconnect();
  }

  // ---- helpers ----

  static Future<GoogleSignInAccount?> _interactiveAuthenticate() async {
    if (GoogleSignIn.instance.supportsAuthenticate()) {
      try {
        return await GoogleSignIn.instance.authenticate();
      } on GoogleSignInException catch (e) {
        debugPrint('## authenticate failed: ${e.code}');
        return null;
      }
    } else {
      // On Web, you must render the GIS button and listen to authenticationEvents.
      // See package example for web button rendering.
      debugPrint('## authenticate() not supported on this platform');
      return null;
    }
  }

  static Future<GoogleSignInAccount?> _requireAuthenticatedUser() async {
    // Try to reuse an authenticated user:
    final existing =
        await GoogleSignIn.instance.attemptLightweightAuthentication();
    if (existing != null) return existing;
    // Otherwise interactive:
    return await _interactiveAuthenticate();
  }

  static Future<bool> _authorizeSilently(
      GoogleSignInAccount user, List<String> scopes) async {
    final silent =
        await user.authorizationClient.authorizationForScopes(scopes);
    return silent != null;
  }

  static Future<bool> _authorizeWithUi(
      GoogleSignInAccount user, List<String> scopes) async {
    try {
      await user.authorizationClient.authorizeScopes(scopes);
      return true;
    } on GoogleSignInException {
      return false;
    }
  }
}
