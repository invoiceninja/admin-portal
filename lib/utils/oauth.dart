import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'openid',
    'profile',
    'https://www.googleapis.com/auth/gmail.send',
  ],
);

void googleSignIn(Function(String, String, String) callback) async {
  final account = await _googleSignIn.signIn();
  if (account != null) {
    account.authentication.then((GoogleSignInAuthentication value) {
      callback(value.idToken, value.accessToken, value.serverAuthCode);
    });
  }
}

void googleSignUp(Function(String, String, String) callback) async {
  final account = await _googleSignIn.grantOfflineAccess();
  if (account != null) {
    account.authentication.then((GoogleSignInAuthentication value) {
      callback(value.idToken, value.accessToken, value.serverAuthCode);
    });
  }
}
