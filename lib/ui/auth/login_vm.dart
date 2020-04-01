import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/app_builder.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:invoiceninja_flutter/ui/auth/login_view.dart';
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
  LoginVM({
    @required this.isLoading,
    @required this.authState,
    @required this.onLoginPressed,
    @required this.onRecoverPressed,
    @required this.onSignUpPressed,
    @required this.onGoogleLoginPressed,
    @required this.onGoogleSignUpPressed,
  });

  bool isLoading;
  AuthState authState;

  final Function(
    BuildContext,
    Completer<Null> completer, {
    @required String email,
    @required String password,
    @required String url,
    @required String secret,
    @required String oneTimePassword,
  }) onLoginPressed;

  final Function(
    BuildContext,
    Completer<Null> completer, {
    @required String email,
    @required String url,
    @required String secret,
  }) onRecoverPressed;

  final Function(
    BuildContext,
    Completer<Null> completer, {
    @required String firstName,
    @required String lastName,
    @required String email,
    @required String password,
  }) onSignUpPressed;

  final Function(BuildContext, Completer<Null> completer,
      {String url, String secret, String oneTimePassword}) onGoogleLoginPressed;
  final Function(BuildContext, Completer<Null> completer) onGoogleSignUpPressed;

  static LoginVM fromStore(Store<AppState> store) {
    final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'openid',
        'profile',
        'https://www.googleapis.com/auth/gmail.send',
      ],
    );

    void _handleLogin(BuildContext context) {
      final layout = calculateLayout(context);

      store.dispatch(UserSettingsChanged(layout: layout));
      AppBuilder.of(context).rebuild();

      WidgetsBinding.instance.addPostFrameCallback((duration) {
        if (layout == AppLayout.mobile) {
          store.dispatch(ViewDashboard(navigator: Navigator.of(context)));
        } else {
          store.dispatch(ViewMainScreen(navigator: Navigator.of(context)));
        }
      });
    }

    return LoginVM(
        isLoading: store.state.isLoading,
        authState: store.state.authState,
        onGoogleLoginPressed: (
          BuildContext context,
          Completer<Null> completer, {
          @required String url,
          @required String secret,
          @required String oneTimePassword,
        }) async {
          try {
            final account = await _googleSignIn.signIn();

            if (account != null) {
              account.authentication.then((GoogleSignInAuthentication value) {
                store.dispatch(OAuthLoginRequest(
                  completer: completer,
                  token: value.idToken,
                  url: url.trim(),
                  secret: secret.trim(),
                  platform: getPlatform(context),
                  oneTimePassword: oneTimePassword,
                ));
                completer.future.then((_) => _handleLogin(context));
              });
            }
          } catch (error) {
            print(error);
          }
        },
        onGoogleSignUpPressed:
            (BuildContext context, Completer<Null> completer) async {
          try {
            final account = await _googleSignIn.signIn();

            if (account != null) {
              account.authentication.then((GoogleSignInAuthentication value) {
                store.dispatch(UserSignUpRequest(
                  completer: completer,
                  email: account.email,
                  firstName: getFirstName(account.displayName),
                  lastName: getLastName(account.displayName),
                  photoUrl: account.photoUrl,
                  oauthId: account.id,
                ));
                completer.future.then((_) => _handleLogin(context));
              });
            }
          } catch (error) {
            print(error);
          }
        },
        onSignUpPressed: (
          BuildContext context,
          Completer<Null> completer, {
          @required String firstName,
          @required String lastName,
          @required String email,
          @required String password,
        }) async {
          if (store.state.isLoading) {
            return;
          }

          store.dispatch(UserSignUpRequest(
            completer: completer,
            firstName: firstName.trim(),
            lastName: lastName.trim(),
            email: email.trim(),
            password: password.trim(),
          ));
          completer.future.then((_) => _handleLogin(context));
        },
        onRecoverPressed: (
          BuildContext context,
          Completer<Null> completer, {
          @required String email,
          @required String url,
          @required String secret,
        }) {
          if (store.state.isLoading) {
            return;
          }

          if (url.isNotEmpty && !url.startsWith('http')) {
            url = 'https://' + url;
          }

          store.dispatch(RecoverPasswordRequest(
            completer: completer,
            email: email.trim(),
            url: url.trim(),
            secret: secret.trim(),
          ));
          completer.future.then((_) {
            print('## DONE ##');
          });
        },
        onLoginPressed: (
          BuildContext context,
          Completer<Null> completer, {
          @required String email,
          @required String password,
          @required String url,
          @required String secret,
          @required String oneTimePassword,
        }) async {
          if (store.state.isLoading) {
            return;
          }

          if (url.isNotEmpty && !url.startsWith('http')) {
            url = 'https://' + url;
          }

          store.dispatch(UserLoginRequest(
            completer: completer,
            email: email.trim(),
            password: password.trim(),
            url: url.trim(),
            secret: secret.trim(),
            platform: getPlatform(context),
            oneTimePassword: oneTimePassword.trim(),
          ));
          completer.future.then((_) => _handleLogin(context));
        });
  }
}
