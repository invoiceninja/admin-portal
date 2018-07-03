import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/redux/ui/ui_actions.dart';
import 'package:invoiceninja/ui/dashboard/dashboard_screen.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/auth/auth_actions.dart';
import 'package:invoiceninja/ui/auth/login.dart';
import 'package:invoiceninja/redux/auth/auth_state.dart';

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
            isDirty: vm.isDirty,
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
  bool isDirty;
  AuthState authState;
  final Function(BuildContext, String, String, String, String) onLoginPressed;

  LoginVM({
    @required this.isLoading,
    @required this.isDirty,
    @required this.authState,
    @required this.onLoginPressed,
  });

  static LoginVM fromStore(Store<AppState> store) {
    return LoginVM(
        isDirty: !store.state.authState.isAuthenticated,
        isLoading: store.state.isLoading,
        authState: store.state.authState,
        onLoginPressed: (BuildContext context, String email, String password,
            String url, String secret) {
          if (store.state.isLoading) {
            return;
          }

          final Completer<Null> completer = new Completer<Null>();
          var apiUrl = url
              .trim()
              .replaceFirst(RegExp(r'/api/v1'), '')
              .replaceFirst(RegExp(r'/$'), '');
          apiUrl += '/api/v1';
          store.dispatch(UserLoginRequest(
              completer, email.trim(), password.trim(), apiUrl, secret.trim()));
          completer.future.then((_) {
            Navigator.of(context).pushReplacementNamed(DashboardScreen.route);
            store.dispatch(UpdateCurrentRoute(DashboardScreen.route));
          });
        });
  }
}
