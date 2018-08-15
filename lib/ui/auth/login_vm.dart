import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_screen.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:invoiceninja_flutter/ui/auth/login.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_state.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  static const String route = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, LoginVM>(
        converter: LoginVM.fromStore,
        builder: (context, viewModel) {
          return LoginView(
            viewModel: viewModel,
          );
        },
      ),
    );
  }
}

class LoginVM {
  bool isLoading;
  AuthState authState;
  final Function(BuildContext, String, String, String, String) onLoginPressed;
  final Function(BuildContext) onGoogleLoginPressed;

  LoginVM({
    @required this.isLoading,
    @required this.authState,
    @required this.onLoginPressed,
    @required this.onGoogleLoginPressed,
  });

  static LoginVM fromStore(Store<AppState> store) {
    final GoogleSignIn _googleSignIn = new GoogleSignIn(
      scopes: [
        'email',
        'openid',
        'profile',
      ],
    );

    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      print('gogole account: $account');

      if (account != null) {
        account.authentication.then((GoogleSignInAuthentication value) {
          print('token: ${value.idToken}');
          print('token: ${value.accessToken}');
        });
      }
    });

    //_googleSignIn.signInSilently();

    return LoginVM(
        isLoading: store.state.isLoading,
        authState: store.state.authState,
        onGoogleLoginPressed: (context) async {
          try {
            final result = await _googleSignIn.signIn();
            print(result);
          } catch (error) {
            print(error);
          }
        },
        onLoginPressed: (BuildContext context, String email, String password,
            String url, String secret) async {
          try {
            await _googleSignIn.signIn();
          } catch (error) {
            print(error);
          }

          if (store.state.isLoading) {
            return;
          }

          final Completer<Null> completer = Completer<Null>();
          store.dispatch(UserLoginRequest(
            completer: completer,
            email: email.trim(),
            password: password.trim(),
            url: url.trim(),
            secret: secret.trim(),
            platform: getPlatform(context),
          ));
          completer.future.then((_) {
            Navigator.of(context).pushReplacementNamed(DashboardScreen.route);
            store.dispatch(UpdateCurrentRoute(DashboardScreen.route));
          });
        });
  }
}
