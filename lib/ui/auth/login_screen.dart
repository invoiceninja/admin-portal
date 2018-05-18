import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/auth/auth_actions.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String _username;
  String _password;

  void _submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, dynamic>(
        converter: (Store<AppState> store) {
      return (BuildContext context, String username, String password) =>
          store.dispatch(login(context, username, password));
    }, builder: (BuildContext context, loginAction) {
      return Scaffold(
        body: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 40.0),
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                //autofocus: false,
                /*
                validator: (val) =>
                    val.isEmpty ? 'Please enter your email.' : null,
                */
                onSaved: (val) => _username = val,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                /*
                validator: (val) =>
                    val.isEmpty ? 'Please enter your password.' : null,
                */
                onSaved: (val) => _password = val,
                obscureText: true,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Material(
                  //borderRadius: BorderRadius.circular(30.0),
                  shadowColor: Colors.lightBlueAccent.shade100,
                  elevation: 5.0,
                  child: MaterialButton(
                    minWidth: 200.0,
                    height: 42.0,
                    onPressed: () {
                      _submit();
                      loginAction(context, _username, _password);
                      //Navigator.of(context).pushNamed(HomeScreen.tag);
                    },
                    color: Colors.lightBlueAccent,
                    child:
                        Text('Log In', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
