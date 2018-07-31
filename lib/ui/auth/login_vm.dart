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

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  static const String route = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, LoginVM>(
        converter: LoginVM.fromStore,
        builder: (context, vm) {
          return LoginView(
            isLoading: vm.isLoading,
            authState: vm.authState,
            onLoginPressed: vm.onLoginPressed,
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

  LoginVM({
    @required this.isLoading,
    @required this.authState,
    @required this.onLoginPressed,
  });

  static LoginVM fromStore(Store<AppState> store) {
    return LoginVM(
        isLoading: store.state.isLoading,
        authState: store.state.authState,
        onLoginPressed: (BuildContext context, String email, String password,
            String url, String secret) {
          if (store.state.isLoading) {
            return;
          }

          final Completer<Null> completer = new Completer<Null>();
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
