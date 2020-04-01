import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/alert_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/link_text.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/auth/login_vm.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:invoiceninja_flutter/.env.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final LoginVM viewModel;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginView> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_login');

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _urlController = TextEditingController();
  final _secretController = TextEditingController();
  final _oneTimePasswordController = TextEditingController();

  List<TextEditingController> _controllers;

  static const String OTP_ERROR = 'OTP_REQUIRED';

  String _loginError = '';

  bool _emailLogin = true; // TODO stable - change to false
  bool _isSelfHosted = true;

  bool _createAccount = false;
  bool _recoverPassword = false;
  bool _autoValidate = false;
  bool _termsChecked = false;
  bool _privacyChecked = false;
  bool _isPasswordObscured = true;
  bool _isFormComplete = false;

  @override
  void didChangeDependencies() {
    _controllers = [
      _firstNameController,
      _lastNameController,
      _emailController,
      _passwordController,
      _urlController,
      _secretController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    if (!kReleaseMode) {
      _urlController.text = Config.TEST_URL;
      _secretController.text = Config.TEST_SECRET;
      _emailController.text = Config.TEST_EMAIL;
      _passwordController.text = Config.TEST_PASSWORD;
      _firstNameController.text = 'TEST';
      _lastNameController.text = 'TEST';
      _privacyChecked = true;
      _termsChecked = true;
      _emailLogin = true;
    }

    /*
    if (cleanApiUrl(state.url).isNotEmpty) {
      _isSelfHosted = true;
    }
     */
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _urlController.dispose();
    _secretController.dispose();

    super.dispose();
  }

  bool _validatePassword(String value) {
    const pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    final regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  void _onChanged() {
    if (_isFormComplete) {
      return;
    }

    final hasEmail = _emailController.text.isNotEmpty;
    final hasPassword = _passwordController.text.isNotEmpty;
    final hasUrl = _urlController.text.isNotEmpty;
    final hasSecret = _secretController.text.isNotEmpty;

    bool isComplete;
    if (_isSelfHosted) {
      isComplete = hasEmail && hasPassword && hasUrl && hasSecret;
    } else {
      isComplete = hasEmail && hasPassword;
    }

    if (isComplete) {
      setState(() {
        _isFormComplete = true;
      });
    }
  }

  void _submitSignUpForm() {
    final bool isValid = _formKey.currentState.validate();
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;

    setState(() {
      _autoValidate = !isValid ?? false;
      print('_autoValidate: $_autoValidate');
      _loginError = '';
    });

    if (!isValid) {
      return;
    }

    if (_createAccount && (!_termsChecked || !_privacyChecked)) {
      showDialog<AlertDialog>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(!_termsChecked
                  ? localization.termsOfService
                  : localization.privacyPolicy),
              content: Text(localization.pleaseAgreeToTermsAndPrivacy),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FlatButton(
                    child: Text(AppLocalization.of(context).close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                )
              ],
            );
          });
      return;
    }

    final Completer<Null> completer = Completer<Null>();
    completer.future.then((_) {
      setState(() {
        _loginError = '';
      });
    }).catchError((Object error) {
      setState(() {
        _loginError = error.toString();
      });
    });

    if (_emailLogin) {
      viewModel.onSignUpPressed(
        context,
        completer,
        email: _emailController.text,
        password: _passwordController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
      );
    } else {
      viewModel.onGoogleSignUpPressed(context, completer);
    }
  }

  void _submitLoginForm() {
    final bool isValid = _formKey.currentState.validate();
    final viewModel = widget.viewModel;

    setState(() {
      _autoValidate = !isValid ?? false;
      _loginError = '';
    });

    if (!isValid) {
      return;
    }

    final Completer<Null> completer = Completer<Null>();

    completer.future.then((_) {
      setState(() {
        _loginError = '';
        if (_recoverPassword) {
          _recoverPassword = false;
          showDialog<MessageDialog>(
              context: context,
              builder: (BuildContext context) {
                return MessageDialog(
                    AppLocalization.of(context).recoverPasswordEmailSent);
              });
        }
      });
    }).catchError((Object error) {
      setState(() {
        _loginError = error.toString();
      });
    });

    if (_emailLogin) {
      if (_recoverPassword) {
        viewModel.onRecoverPressed(
          context,
          completer,
          email: _emailController.text,
          url: _isSelfHosted ? _urlController.text : '',
          secret: _isSelfHosted ? _secretController.text : '',
        );
      } else {
        viewModel.onLoginPressed(
          context,
          completer,
          email: _emailController.text,
          password: _passwordController.text,
          url: _isSelfHosted ? _urlController.text : '',
          secret: _isSelfHosted ? _secretController.text : '',
          oneTimePassword: _oneTimePasswordController.text,
        );
      }
    } else {
      viewModel.onGoogleLoginPressed(context, completer,
          url: _isSelfHosted ? _urlController.text : '',
          secret: _isSelfHosted ? _secretController.text : '',
          oneTimePassword: _oneTimePasswordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final isOneTimePassword = _loginError.contains(OTP_ERROR) ||
        _oneTimePasswordController.text.isNotEmpty;

    final ThemeData themeData = Theme.of(context);
    final TextStyle aboutTextStyle = themeData.textTheme.bodyText2;
    final TextStyle linkStyle = themeData.textTheme.bodyText2
        .copyWith(color: convertHexStringToColor(kDefaultAccentColor));
    //final showHostedOptions = viewModel.authState.isHosted || !kIsWeb;
    final showHostedOptions = !kReleaseMode;

    return Stack(
      children: <Widget>[
        SizedBox(
          height: 250.0,
          child: ClipPath(
            clipper: ArcClipper(),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  //Colors.grey.shade800,
                  //Colors.black87,
                  Theme.of(context).buttonColor,
                  Theme.of(context).buttonColor.withOpacity(.7),
                ],
              )),
            ),
          ),
        ),
        ListView(
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Image.asset('assets/images/logo.png',
                  width: 100.0, height: 100.0),
            ),
            AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: viewModel.authState.isAuthenticated ? 0 : 1,
              child: Form(
                key: _formKey,
                child: FormCard(
                  isResponsive: calculateLayout(context) != AppLayout.mobile,
                  children: <Widget>[
                    if (isOneTimePassword)
                      DecoratedFormField(
                        controller: _oneTimePasswordController,
                        label: localization.oneTimePassword,
                      )
                    else
                      Column(
                        children: <Widget>[
                          SizedBox(height: 10),
                          if (_createAccount && _emailLogin)
                            DecoratedFormField(
                              label: localization.firstName,
                              controller: _firstNameController,
                              //autovalidate: _autoValidate,
                              validator: (val) =>
                                  val.isEmpty || val.trim().isEmpty
                                      ? localization.pleaseEnterAFirstName
                                      : null,
                            ),
                          if (_createAccount && _emailLogin)
                            DecoratedFormField(
                              label: localization.lastName,
                              controller: _lastNameController,
                              //autovalidate: _autoValidate,
                              validator: (val) =>
                                  val.isEmpty || val.trim().isEmpty
                                      ? localization.pleaseEnterALastName
                                      : null,
                            ),
                          if (_emailLogin)
                            DecoratedFormField(
                              controller: _emailController,
                              autocorrect: false,
                              textInputAction:
                                  _isFormComplete && !_createAccount
                                      ? TextInputAction.done
                                      : TextInputAction.next,
                              label: localization.email,
                              keyboardType: TextInputType.emailAddress,
                              autovalidate: _autoValidate,
                              validator: (val) =>
                                  val.isEmpty || val.trim().isEmpty
                                      ? localization.pleaseEnterYourEmail
                                      : null,
                              onFieldSubmitted: (String value) =>
                                  FocusScope.of(context).nextFocus(),
                            ),
                          if (_emailLogin && !_recoverPassword)
                            TextFormField(
                              controller: _passwordController,
                              key: ValueKey(localization.password),
                              textInputAction:
                                  _isFormComplete && !_createAccount
                                      ? TextInputAction.done
                                      : TextInputAction.next,
                              autocorrect: false,
                              autovalidate: _autoValidate,
                              decoration: InputDecoration(
                                labelText: localization.password,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordObscured
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordObscured =
                                          !_isPasswordObscured;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty || value.trim().isEmpty) {
                                  return localization.pleaseEnterYourPassword;
                                }

                                if (_createAccount) {
                                  if (value.length < 8) {
                                    return localization.passwordIsTooShort;
                                  }

                                  if (!_validatePassword(value)) {
                                    return localization.passwordIsTooEasy;
                                  }
                                }

                                return null;
                              },
                              obscureText: _isPasswordObscured,
                              onFieldSubmitted: (String value) =>
                                  FocusScope.of(context).nextFocus(),
                            ),
                          if (_isSelfHosted)
                            TextFormField(
                              controller: _urlController,
                              key: ValueKey(localization.url),
                              autocorrect: false,
                              autovalidate: _autoValidate,
                              textInputAction: _isFormComplete
                                  ? TextInputAction.done
                                  : TextInputAction.next,
                              decoration:
                                  InputDecoration(labelText: localization.url),
                              validator: (val) =>
                                  val.isEmpty || val.trim().isEmpty
                                      ? localization.pleaseEnterYourUrl
                                      : null,
                              onFieldSubmitted: (String value) =>
                                  FocusScope.of(context).nextFocus(),
                              keyboardType: TextInputType.url,
                            ),
                          if (_isSelfHosted)
                            TextFormField(
                              controller: _secretController,
                              key: ValueKey(localization.secret),
                              textInputAction: TextInputAction.done,
                              autocorrect: false,
                              decoration: InputDecoration(
                                  labelText: '${localization.secret} (${localization.optional})'),
                              obscureText: true,
                              onFieldSubmitted: (String value) =>
                                  FocusScope.of(context).nextFocus(),
                            ),
                          if (_createAccount)
                            Padding(
                              padding: EdgeInsets.only(top: 22),
                              child: Column(
                                children: <Widget>[
                                  CheckboxListTile(
                                    onChanged: (value) =>
                                        setState(() => _termsChecked = value),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    activeColor: convertHexStringToColor(
                                        kDefaultAccentColor),
                                    value: _termsChecked,
                                    title: RichText(
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                            style: aboutTextStyle,
                                            text:
                                                localization.iAgreeToThe + ' ',
                                          ),
                                          LinkTextSpan(
                                            style: linkStyle,
                                            url: kTermsOfServiceURL,
                                            text:
                                                localization.termsOfServiceLink,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  CheckboxListTile(
                                    onChanged: (value) =>
                                        setState(() => _privacyChecked = value),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    activeColor: convertHexStringToColor(
                                        kDefaultAccentColor),
                                    value: _privacyChecked,
                                    title: RichText(
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                            style: aboutTextStyle,
                                            text:
                                                localization.iAgreeToThe + ' ',
                                          ),
                                          LinkTextSpan(
                                            style: linkStyle,
                                            url: kTermsOfServiceURL,
                                            text:
                                                localization.privacyPolicyLink,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    if (_loginError.isNotEmpty &&
                        !_loginError.contains(OTP_ERROR))
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: Center(
                          child: Text(
                            _loginError,
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    Padding(
                        padding: EdgeInsets.only(top: 30, bottom: 10),
                        child: viewModel.isLoading
                            ? LoadingIndicator(height: 48)
                            : _createAccount
                                ? ElevatedButton(
                                    width: 280,
                                    label: (_emailLogin
                                            ? localization.signUp
                                            : localization.signUpWithGoogle)
                                        .toUpperCase(),
                                    onPressed: () => _submitSignUpForm(),
                                  )
                                : ElevatedButton(
                                    width: 280,
                                    label: (_emailLogin
                                            ? (_recoverPassword
                                                ? localization.submit
                                                : localization.login)
                                            : localization.googleLogin)
                                        .toUpperCase(),
                                    onPressed: () => _submitLoginForm(),
                                  )),
                    SizedBox(height: 6),
                    if (!isOneTimePassword)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          if (!_recoverPassword && showHostedOptions)
                            Padding(
                              padding: const EdgeInsets.all(6),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(FontAwesomeIcons.solidEnvelope,
                                      size: 16),
                                  _emailLogin
                                      ? FlatButton(
                                          onPressed: () => setState(() {
                                                _emailLogin = false;
                                                _loginError = '';
                                              }),
                                          child: Text(_createAccount
                                              ? localization.googleSignUp
                                              : localization.googleLogin))
                                      : FlatButton(
                                          key:
                                              ValueKey(localization.emailLogin),
                                          onPressed: () => setState(() {
                                                _emailLogin = true;
                                                _loginError = '';
                                              }),
                                          child: Text(_createAccount
                                              ? localization.emailSignUp
                                              : localization.emailLogin)),
                                ],
                              ),
                            ),
                          if (!_recoverPassword && !_isSelfHosted)
                            Padding(
                              padding: const EdgeInsets.all(6),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(FontAwesomeIcons.user, size: 16),
                                  _createAccount
                                      ? FlatButton(
                                          onPressed: () => setState(() {
                                                _createAccount = false;
                                                _loginError = '';
                                              }),
                                          child:
                                              Text(localization.accountLogin))
                                      : FlatButton(
                                          key: ValueKey(
                                              localization.createAccount),
                                          onPressed: () => setState(() {
                                                _createAccount = true;
                                                //_isSelfHosted = false;
                                                _loginError = '';
                                              }),
                                          child:
                                              Text(localization.createAccount)),
                                ],
                              ),
                            ),
                          if (!_createAccount && !_recoverPassword && showHostedOptions)
                            Padding(
                              padding: const EdgeInsets.all(6),
                              child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(FontAwesomeIcons.userCog, size: 16),
                                    _isSelfHosted
                                        ? FlatButton(
                                            onPressed: () => setState(() {
                                                  _isSelfHosted = false;
                                                  _loginError = '';
                                                }),
                                            child:
                                                Text(localization.hostedLogin))
                                        : FlatButton(
                                            key: ValueKey(
                                                localization.selfhostLogin),
                                            onPressed: () => setState(() {
                                                  _isSelfHosted = true;
                                                  _createAccount = false;
                                                  _emailLogin = true;
                                                  _loginError = '';
                                                }),
                                            child: Text(
                                                localization.selfhostLogin)),
                                  ]),
                            ),
                          if (!_createAccount && _emailLogin)
                            Padding(
                              padding: const EdgeInsets.all(6),
                              child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    if (!_recoverPassword)
                                      Icon(FontAwesomeIcons.lock, size: 16),
                                    FlatButton(
                                        child: Text(_recoverPassword
                                            ? localization.cancel
                                            : localization.recoverPassword),
                                        onPressed: () {
                                          setState(() {
                                            _recoverPassword =
                                                !_recoverPassword;
                                          });
                                        }),
                                  ]),
                            ),
                          if (_createAccount)
                            Padding(
                              padding: const EdgeInsets.all(6),
                              child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(FontAwesomeIcons.externalLinkAlt,
                                        size: 16),
                                    FlatButton(
                                      child: Text(localization.viewWebsite),
                                      onPressed: () async {
                                        if (await canLaunch(kSiteUrl)) {
                                          await launch(kSiteUrl,
                                              forceSafariVC: false,
                                              forceWebView: false);
                                        }
                                      },
                                    ),
                                  ]),
                            ),
                        ],
                      ),
                    if (isOneTimePassword && !viewModel.isLoading)
                      Padding(
                        padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                        child: ElevatedButton(
                          label: localization.cancel.toUpperCase(),
                          color: Colors.grey,
                          onPressed: () {
                            setState(() {
                              _oneTimePasswordController.text = '';
                            });
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// https://github.com/iampawan/Flutter-UI-Kit
class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 30);

    final firstControlPoint = Offset(size.width / 4, size.height);
    final firstPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    final secondControlPoint =
        Offset(size.width - (size.width / 4), size.height);
    final secondPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
