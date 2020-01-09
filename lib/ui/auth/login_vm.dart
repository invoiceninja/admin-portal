import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_builder.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
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
    @required this.onSignUpPressed,
    @required this.onCancel2FAPressed,
    @required this.onGoogleLoginPressed,
  });

  bool isLoading;
  AuthState authState;
  final Function() onCancel2FAPressed;

  final Function(
    BuildContext, {
    @required String email,
    @required String password,
    @required String url,
    @required String secret,
    @required String oneTimePassword,
  }) onLoginPressed;

  final Function(
    BuildContext, {
    @required String firstName,
    @required String lastName,
    @required String email,
    @required String password,
  }) onSignUpPressed;

  final Function(BuildContext, String, String) onGoogleLoginPressed;

  static LoginVM fromStore(Store<AppState> store) {
    final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'openid',
        'profile',
      ],
    );

    void _handleLogin(BuildContext context) {
      store.dispatch(UpdateLayout(calculateLayout(context)));
      AppBuilder.of(context).rebuild();

      if (isMobile(context)) {
        store.dispatch(ViewDashboard(context: context));
      } else {
        store.dispatch(ViewMainScreen(context));
      }
    }

    return LoginVM(
        isLoading: store.state.isLoading,
        authState: store.state.authState,
        onCancel2FAPressed: () => store.dispatch(ClearAuthError()),
        onGoogleLoginPressed:
            (BuildContext context, String url, String secret) async {
          try {
            final account = await _googleSignIn.signIn();

            if (account != null) {
              account.authentication.then((GoogleSignInAuthentication value) {
                final Completer<Null> completer = Completer<Null>();
                store.dispatch(OAuthLoginRequest(
                  completer: completer,
                  token: value.idToken,
                  url: url.trim(),
                  secret: secret.trim(),
                  platform: getPlatform(context),
                ));
                completer.future.then((_) => _handleLogin(context));
              });
            }
          } catch (error) {
            print(error);
          }
        },
        onSignUpPressed: (
          BuildContext context, {
          @required String firstName,
          @required String lastName,
          @required String email,
          @required String password,
        }) async {
          if (store.state.isLoading) {
            return;
          }

          final Completer<Null> completer = Completer<Null>();
          store.dispatch(UserSignUpRequest(
            completer: completer,
            firstName: firstName.trim(),
            lastName: lastName.trim(),
            email: email.trim(),
            password: password.trim(),
            platform: getPlatform(context),
          ));
          completer.future.then((_) => _handleLogin(context));
        },
        onLoginPressed: (
          BuildContext context, {
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

          final Completer<Null> completer = Completer<Null>();
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
