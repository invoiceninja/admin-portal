import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/progress_button.dart';
import 'package:invoiceninja_flutter/ui/auth/login_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';

import 'package:invoiceninja_flutter/utils/keys.dart';

class LoginView extends StatefulWidget {
  final LoginVM viewModel;

  const LoginView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginView> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _urlController = TextEditingController();
  final _secretController = TextEditingController();

  static final ValueKey _emailKey = Key(LoginKeys.emailKeyString);
  static final ValueKey _passwordKey = Key(LoginKeys.passwordKeyString);
  static final ValueKey _urlKey = Key(LoginKeys.urlKeyString);
  static final ValueKey _secretKey = Key(LoginKeys.secretKeyString);

  FocusNode focusNode1 = new FocusNode();
  FocusNode focusNode2 = new FocusNode();
  FocusNode focusNode3 = new FocusNode();

  @override
  void didChangeDependencies() {
    final state = widget.viewModel.authState;
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
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;

    if (!viewModel.authState.isInitialized) {
      return Container();
    }

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: Image.asset('assets/images/logo.png',
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
                decoration: InputDecoration(labelText: localization.email),
                keyboardType: TextInputType.emailAddress,
                validator: (val) => val.isEmpty || val.trim().isEmpty
                    ? localization.pleaseEnterYourEmail
                    : null,
                onFieldSubmitted: (String value) =>
                    FocusScope.of(context).requestFocus(focusNode1),
              ),
              TextFormField(
                controller: _passwordController,
                key: _passwordKey,
                autocorrect: false,
                decoration: InputDecoration(labelText: localization.password),
                validator: (val) => val.isEmpty || val.trim().isEmpty
                    ? localization.pleaseEnterYourPassword
                    : null,
                obscureText: true,
                focusNode: focusNode1,
                onFieldSubmitted: (String value) =>
                    FocusScope.of(context).requestFocus(focusNode2),
              ),
              TextFormField(
                controller: _urlController,
                key: _urlKey,
                autocorrect: false,
                decoration: InputDecoration(labelText: localization.url),
                validator: (val) => val.isEmpty || val.trim().isEmpty
                    ? localization.pleaseEnterYourUrl
                    : null,
                keyboardType: TextInputType.url,
                focusNode: focusNode2,
                onFieldSubmitted: (String value) =>
                    FocusScope.of(context).requestFocus(focusNode3),
              ),
              TextFormField(
                controller: _secretController,
                key: _secretKey,
                autocorrect: false,
                decoration: InputDecoration(labelText: localization.secret),
                obscureText: true,
                focusNode: focusNode3,
              ),
              viewModel.authState.error == null
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(top: 26.0, bottom: 4.0),
                      child: Center(
                        child: Text(
                          viewModel.authState.error,
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
          label: localization.login.toUpperCase(),
          isLoading: viewModel.isLoading,
          onPressed: () {
            if (!_formKey.currentState.validate()) {
              return;
            }
            viewModel.onLoginPressed(
                context,
                _emailController.text,
                _passwordController.text,
                _urlController.text,
                _secretController.text);
          },
        ),
        /*
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ElevatedButton(
            label: 'Google ${localization.login}'.toUpperCase(),
            onPressed: () => viewModel.onGoogleLoginPressed(
                context, _urlController.text, _secretController.text),
          ),
        ),
        */
      ],
    );
  }
}
