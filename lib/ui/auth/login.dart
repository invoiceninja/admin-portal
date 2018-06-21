import 'package:flutter/material.dart';
import 'package:invoiceninja/redux/auth/auth_state.dart';
import 'package:invoiceninja/ui/app/progress_button.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:invoiceninja/ui/app/form_card.dart';

import 'package:invoiceninja/utils/keys.dart';

class Login extends StatelessWidget {
  final bool isLoading;
  final bool isDirty;
  final AuthState authState;
  final Function(BuildContext, String, String, String, String) onLoginPressed;

  Login({
    Key key,
    @required this.isDirty,
    @required this.isLoading,
    @required this.authState,
    @required this.onLoginPressed,
  }) : super(key: key);

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // add controllers
  final _emailController = TextEditingController()..text = '';
  final _passwordController = TextEditingController() ..text = '';
  final _urlController = TextEditingController()..text = '';
  final _secretController = TextEditingController()..text = '';

  // keys
  static final ValueKey _emailKey = new Key(LoginKeys.emailKeyString);
  static final ValueKey _passwordKey = new Key(LoginKeys.passwordKeyString);
  static final ValueKey _urlKey = new Key(LoginKeys.urlKeyString);
  static final ValueKey _secretKey = new Key(LoginKeys.secretKeyString);

  @override
  Widget build(BuildContext context) {
    if (!authState.isInitialized) {
      return Container();
    }

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: new Image.asset('assets/images/logo.png',
              width: 100.0, height: 100.0),
        ),
        Form(
          key: _formKey,
          child: FormCard(
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                key: _emailKey,
                autocorrect: false,
                decoration: InputDecoration(
                    labelText: AppLocalization.of(context).email),
                keyboardType: TextInputType.emailAddress,
                validator: (val) => val.isEmpty || val.trim().length == 0
                    ? AppLocalization.of(context).pleaseEnterYourEmail
                    : null,
              ),
              TextFormField(
                controller: _passwordController,
                key: _passwordKey,
                autocorrect: false,
                decoration: InputDecoration(
                    labelText: AppLocalization.of(context).password),
                validator: (val) => val.isEmpty || val.trim().length == 0
                    ? AppLocalization.of(context).pleaseEnterYourPassword
                    : null,
                obscureText: true,
              ),
              TextFormField(
                controller: _urlController,
                key: _urlKey,
                autocorrect: false,
                decoration:
                    InputDecoration(labelText: AppLocalization.of(context).url),
                validator: (val) => val.isEmpty || val.trim().length == 0
                    ? AppLocalization.of(context).pleaseEnterYourUrl
                    : null,
                keyboardType: TextInputType.url,
              ),
              TextFormField(
                controller: _secretController,
                key: _secretKey,
                autocorrect: false,
                decoration: InputDecoration(
                    labelText: AppLocalization.of(context).secret),
                /*
                    validator: (val) => val.isEmpty || val.trim().length == 0
                        ? AppLocalization.of(context).pleaseEnterYourPassword
                        : null,
                        */
                obscureText: true,
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
        ProgressButton(
          label: 'LOGIN',
          isLoading: this.isLoading,
          isDirty: this.isDirty,
          onPressed: () {
            if (!_formKey.currentState.validate()) {
              return;
            }
            this.onLoginPressed(
                context,
                _emailController.text,
                _passwordController.text,
                _urlController.text,
                _secretController.text);
          },
        ),
      ],
    );
  }
}