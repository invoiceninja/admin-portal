import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/auth/auth_actions.dart';
import 'package:invoiceninja/ui/auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginVM extends StatelessWidget {
  LoginVM({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
          return Login(
            email: vm.email,
            password: vm.password,
            url: vm.url,
            onLoginClicked: vm.onLoginClicked,
          );
        },
      ),
    );
  }
}

class _ViewModel {
  String email;
  String password;
  String url;
  final Function(BuildContext, String, String, String) onLoginClicked;

  _ViewModel({
    @required this.email,
    @required this.password,
    @required this.url,
    @required this.onLoginClicked,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      email: store.state.auth.email ?? '',
      url: store.state.auth.url ?? '',
      password: store.state.auth.password ?? '',
        onLoginClicked: (BuildContext context, String email, String password, String url) {
          store.dispatch(UserLoginRequest(context, email, password, url));
        }
    );
  }
}
