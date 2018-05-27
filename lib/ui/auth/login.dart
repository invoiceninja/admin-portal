import 'package:flutter/material.dart';
import 'package:invoiceninja/redux/auth/auth_state.dart';

class Login extends StatelessWidget {
  final bool isLoading;
  final AuthState authState;
  final Function(BuildContext, String, String, String) onLoginClicked;

  Login({
    Key key,
    @required this.isLoading,
    @required this.authState,
    @required this.onLoginClicked,
  }) : super(key: key);

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static final GlobalKey<FormFieldState<String>> _emailKey =
      GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _passwordKey =
      GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _urlKey =
      GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    if (!authState.isInitialized) {
      return Container();
    }

    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0),
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: new Image.asset('assets/images/logo.png',
              width: 100.0, height: 100.0),
        ),
        Card(
          elevation: 2.0,
          margin: EdgeInsets.all(0.0),
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    key: _emailKey,
                    initialValue: authState.email,
                    autocorrect: false,
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) =>
                        val.isEmpty ? 'Please enter your email.' : null,
                  ),
                  TextFormField(
                    key: _passwordKey,
                    initialValue: authState.password,
                    autocorrect: false,
                    decoration: InputDecoration(labelText: 'Password'),
                    validator: (val) =>
                        val.isEmpty ? 'Please enter your password.' : null,
                    obscureText: true,
                  ),
                  TextFormField(
                    key: _urlKey,
                    initialValue: authState.url,
                    autocorrect: false,
                    decoration: InputDecoration(labelText: 'URL'),
                    validator: (val) =>
                        val.isEmpty ? 'Please enter your URL.' : null,
                    keyboardType: TextInputType.url,
                  ),
                  authState.error == null
                      ? Container()
                      : Container(
                          padding: EdgeInsets.only(top: 26.0, bottom: 4.0),
                          child: Center(
                            child: Text(
                              authState.error,
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: RaisedButton(
            child: this.isLoading ? SizedBox(
              width: 100.0,
              child: new Center(
                child: new SizedBox(
                  height: 16.0,
                  width: 16.0,
                  child: new CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 2.0,
                  ),
                ),
              ),
            ) : Text('LOGIN'),
            padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
            color: Colors.lightBlueAccent,
            textColor: Colors.white,
            elevation: 4.0,
            onPressed: () {
              if (! _formKey.currentState.validate()) {
                return;
              }

              this.onLoginClicked(
                  context,
                  _emailKey.currentState.value,
                  _passwordKey.currentState.value,
                  _urlKey.currentState.value);
            },
          ),
        ),
      ],
    );
  }
}
