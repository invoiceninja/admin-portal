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
  GoogleSignInAccount account;

  if (isSilent) {
    account = await _googleSignIn.signInSilently().catchError((Object error) {
      print('## on sign in silent error: $error');
    });
  }

  account ??= await _googleSignIn.signIn().catchError((Object error) {
    print('## on sign in error: $error');
  });

  if (account == null) {
    print('## Error: Google sign in failed');
  } else {
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
  } else {
    print('## Error: Google sign up failed');
  }
}

Future<GoogleSignInAccount> googleSignOut() async {
  return await _googleSignIn.signOut();
}
