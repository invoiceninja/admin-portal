import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'openid',
    'profile',
    'https://www.googleapis.com/auth/gmail.send',
  ],
);

void googleSignIn(Function(String, String, String) callback,
    {bool isSilent = false}) async {
  final account = await (isSilent
      ? _googleSignIn.signInSilently()
      : _googleSignIn.signIn());
  if (account != null) {
    account.authentication.then((GoogleSignInAuthentication value) {
      print('## googleSignIn: ${value.idToken.isEmpty}, ${value.accessToken.isEmpty}, ${value.serverAuthCode.isEmpty}');
      callback(value.idToken, value.accessToken, value.serverAuthCode);
    });
  }
}

void googleSignUp(Function(String, String, String) callback) async {
  final account = await _googleSignIn.grantOfflineAccess();
  if (account != null) {
    account.authentication.then((GoogleSignInAuthentication value) {
      print('## googleSignUp: ${value.idToken.isEmpty}, ${value.accessToken.isEmpty}, ${value.serverAuthCode.isEmpty}');
      callback(value.idToken, value.accessToken, value.serverAuthCode);
    });
  }
}

Future<GoogleSignInAccount> googleSignOut() async {
  return await _googleSignIn.signOut();
}