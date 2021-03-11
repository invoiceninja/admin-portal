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
      print('## 1 CATCH ERROR: $error');
    }).onError((Object error, stackTrace) {
      print('## 1 ON ERROR: $error');
      return null;
    });
  }

  account ??= await _googleSignIn.signIn().catchError((Object error) {
    print('## 2 CATCH ERROR: $error');
  }).onError((Object error, stackTrace) {
    print('## 2 ON ERROR: $error');
    return null;
  });

  if (account != null) {
    account.authentication.then((GoogleSignInAuthentication value) {
      callback(value.idToken, value.accessToken, value.serverAuthCode);
    });
  } else {
    throw 'Error: sign in failed';
  }
}

void googleSignUp(Function(String, String, String) callback) async {
  final account =
      await _googleSignIn.grantOfflineAccess().catchError((Object error) {
    print('## 3 CATCH ERROR: $error');
  }).onError((Object error, stackTrace) {
    print('## 3 ON ERROR: $error');
    return null;
  });
  if (account != null) {
    account.authentication.then((GoogleSignInAuthentication value) {
      callback(value.idToken, value.accessToken, value.serverAuthCode);
    });
  } else {
    throw 'Error: sign up failed';
  }
}

Future<GoogleSignInAccount> googleSignOut() async {
  return await _googleSignIn.signOut();
}
