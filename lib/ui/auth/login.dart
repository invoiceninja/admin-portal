import 'package:flutter/material.dart';
import 'package:invoiceninja/redux/auth/auth_state.dart';
import 'package:invoiceninja/ui/app/progress_button.dart';
import 'package:invoiceninja/utils/formatting.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:invoiceninja/ui/app/form_card.dart';

import 'package:invoiceninja/utils/keys.dart';


class LoginView extends StatefulWidget {
  final bool isLoading;
  final bool isDirty;
  final AuthState authState;
  final Function(BuildContext, String, String, String, String) onLoginPressed;

  const LoginView({
    Key key,
    @required this.isDirty,
    @required this.isLoading,
    @required this.authState,
    @required this.onLoginPressed,
  }) : super(key: key);

  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<LoginView> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _urlController = TextEditingController();
  final _secretController = TextEditingController();

  static final ValueKey _emailKey = new Key(LoginKeys.emailKeyString);
  static final ValueKey _passwordKey = new Key(LoginKeys.passwordKeyString);
  static final ValueKey _urlKey = new Key(LoginKeys.urlKeyString);
  static final ValueKey _secretKey = new Key(LoginKeys.secretKeyString);

  @override
  void didChangeDependencies() {

    final state = widget.authState;
    _emailController.text = state.email;
    _passwordController.text = state.password;
    _urlController.text = formatApiUrlReadable(state.url);
    _secretController.text = state.secret;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _urlController.dispose();
    _secretController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if (!widget.authState.isInitialized) {
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
                validator: (val) => val.isEmpty || val.trim().isEmpty
                    ? AppLocalization.of(context).pleaseEnterYourEmail
                    : null,
              ),
              TextFormField(
                controller: _passwordController,
                key: _passwordKey,
                autocorrect: false,
                decoration: InputDecoration(
                    labelText: AppLocalization.of(context).password),
                validator: (val) => val.isEmpty || val.trim().isEmpty
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
                validator: (val) => val.isEmpty || val.trim().isEmpty
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
              widget.authState.error == null
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(top: 26.0, bottom: 4.0),
                      child: Center(
                        child: Text(
                          widget.authState.error,
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
          label: AppLocalization.of(context).login.toUpperCase(),
          isLoading: widget.isLoading,
          isDirty: widget.isDirty,
          onPressed: () {
            if (!_formKey.currentState.validate()) {
              return;
            }
            widget.onLoginPressed(
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