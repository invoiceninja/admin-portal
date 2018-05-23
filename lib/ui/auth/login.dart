import 'dart:async';

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/auth/auth_actions.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  String _url;

  final _emailTextController = TextEditingController();
  final _urlTextController = TextEditingController();

  void _submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  _loadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _urlTextController.text = prefs.getString('url');
    _emailTextController.text = prefs.getString('email');
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, dynamic>(
        converter: (Store<AppState> store) {
      return (BuildContext context, String email, String password, String url) {
        store.dispatch(UserLoginRequest(email, password, url));
        //store.dispatch(UserLoginSuccess(User(token, 1)));
        //Navigator.of(context).pushNamed('/dashboard');
      };
    }, builder: (BuildContext context, loginAction) {
      return Scaffold(
        body: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 40.0),
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: new Image.asset('assets/images/logo.png', width: 100.0, height: 100.0),
              ),
              TextFormField(
                controller: _emailTextController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (val) =>
                val.isEmpty ? 'Please enter your email.' : null,
                onSaved: (val) => _email = val,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                validator: (val) =>
                val.isEmpty ? 'Please enter your password.' : null,
                onSaved: (val) => _password = val,
                obscureText: true,
              ),
              TextFormField(
                controller: _urlTextController,
                decoration: InputDecoration(labelText: 'URL'),
                validator: (val) =>
                    val.isEmpty ? 'Please enter your URL.' : null,
                onSaved: (val) => _url = val,
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
                      loginAction(context, _email, _password, _url);
                      //Navigator.of(context).pushNamed(HomeScreen.tag);
                    },
                    color: Colors.lightBlueAccent,
                    child:
                        Text('LOGIN', style: TextStyle(color: Colors.white)),
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
