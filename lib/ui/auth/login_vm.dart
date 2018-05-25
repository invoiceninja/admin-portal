import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/auth/auth_actions.dart';
import 'package:invoiceninja/ui/auth/login.dart';
import 'package:invoiceninja/redux/auth/auth_state.dart';

class LoginVM extends StatelessWidget {
  LoginVM({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
          return Login(
            isLoading: vm.isLoading,
            authState: vm.authState,
            onLoginClicked: vm.onLoginClicked,
          );
        },
      ),
    );
  }
}

class _ViewModel {
  bool isLoading;
  AuthState authState;
  final Function(BuildContext, String, String, String) onLoginClicked;

  _ViewModel({
    @required this.isLoading,
    @required this.authState,
    @required this.onLoginClicked,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      isLoading: store.state.isLoading,
      authState: store.state.authState,
        onLoginClicked: (BuildContext context, String email, String password, String url) {
          if (store.state.isLoading) {
            return;
          }
          store.dispatch(UserLoginRequest(context, email.trim(), password.trim(), url.trim()));
        }
    );
  }
}
