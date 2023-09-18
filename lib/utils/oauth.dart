// Package imports:
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'openid',
    'profile',
    //'https://www.googleapis.com/auth/gmail.send',
  ],
);

class GoogleOAuth {
  static bool get isEnabled => true;

  static Future<bool> signIn(Function(String, String) callback,
      {bool isSilent = false}) async {
    GoogleSignInAccount? account;

    if (isSilent) {
      account = await _googleSignIn.signInSilently();
    }

    account ??= await _googleSignIn.signIn();

    if (account != null) {
      account.authentication.then((GoogleSignInAuthentication value) {
        callback(
          value.idToken ?? '',
          value.accessToken ?? '',
        );
      });

      return true;
    } else {
      print('## ERROR: sign in failed');
      return false;
    }
  }

  static Future<bool> signUp(Function(String, String) callback) async {
    final account = await _googleSignIn.signIn();
    if (account != null) {
      account.authentication.then((GoogleSignInAuthentication value) {
        callback(
          value.idToken ?? '',
          value.accessToken ?? '',
        );
      });

      return true;
    } else {
      print('## ERROR: sign up failed');
      return false;
    }
  }

  static Future<bool> requestGmailScope() async {
    return await _googleSignIn
        .requestScopes(['https://www.googleapis.com/auth/gmail.send']);
  }

  /*
  static Future<bool> grantOfflineAccess(
      Function(String, String, String) successCallback,
      Function errorCallback) async {
    final account = await _googleSignIn.grantOfflineAccess();
    if (account != null) {
      account.authentication.then((GoogleSignInAuthentication value) {
        successCallback(value.idToken, value.accessToken, value.serverAuthCode);
      });

      return true;
    } else {
      print('## ERROR: grant offline failed');
      errorCallback();
      return false;
    }
  }
  */

  static Future<GoogleSignInAccount?> signOut() async {
    return await _googleSignIn.signOut();
  }

  static Future<GoogleSignInAccount?> disconnect() async {
    return await _googleSignIn.disconnect();
  }
}
