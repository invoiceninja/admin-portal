import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/app_text_button.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/alert_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_toggle_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/password_field.dart';
import 'package:invoiceninja_flutter/ui/app/link_text.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/auth/login_vm.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:invoiceninja_flutter/.env.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
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

  final _buttonController = RoundedLoadingButtonController();

  static const String OTP_ERROR = 'OTP_REQUIRED';

  String _loginError = '';

  bool _emailLogin = true;
  bool _isSelfHosted = true;
  bool _createAccount = false;

  // TODO change for stable release
  //bool _emailLogin = false;
  //bool _isSelfHosted = false;
  //bool _createAccount = true;

  bool _recoverPassword = false;
  bool _autoValidate = false;
  bool _termsChecked = false;
  bool _privacyChecked = false;

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      final authState = widget.viewModel.authState;
      _isSelfHosted = authState.isSelfHost;
      if (_isSelfHosted) {
        _emailLogin = true;
        _createAccount = false;
      }
    }
  }

  @override
  void didChangeDependencies() {
    if (!kReleaseMode && Config.TEST_EMAIL.isNotEmpty) {
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

    if (_urlController.text.isEmpty) {
      _urlController.text = widget.viewModel.authState.url;
    }

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

  void _submitSignUpForm() {
    final isValid = _formKey.currentState.validate();
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;

    setState(() {
      _autoValidate = !isValid ?? false;
      print('_autoValidate: $_autoValidate');
      _loginError = '';
    });

    if (!isValid) {
      _buttonController.reset();
      return;
    }

    if (_createAccount && (!_termsChecked || !_privacyChecked)) {
      _buttonController.reset();
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
                  child: TextButton(
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
        //_buttonController.reset();
        _loginError = '';
      });
    }).catchError((Object error) {
      setState(() {
        _buttonController.reset();
        _loginError = error.toString();
      });
    });

    if (_emailLogin) {
      viewModel.onSignUpPressed(
        context,
        completer,
        email: _emailController.text,
        password: _passwordController.text,
      );
    } else {
      viewModel.onGoogleSignUpPressed(context, completer);
    }
  }

  void _submitLoginForm() {
    final bool isValid = true;
    final viewModel = widget.viewModel;

    setState(() {
      _autoValidate = !isValid ?? false;
      _loginError = '';
    });

    if (!isValid) {
      _buttonController.reset();
      return;
    }

    final Completer<Null> completer = Completer<Null>();

    completer.future.then((_) {
      setState(() {
        //_buttonController.reset();
        _loginError = '';
        if (_recoverPassword) {
          _recoverPassword = false;
          _buttonController.reset();
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
        _buttonController.reset();
        _loginError = error.toString();
      });
    });

    final authState = widget.viewModel.authState;
    final url = _isSelfHosted
        ? _urlController.text
        : authState.isStaging
            ? kAppStagingUrl
            : kAppProductionUrl;

    if (_emailLogin) {
      if (_recoverPassword) {
        viewModel.onRecoverPressed(
          context,
          completer,
          email: _emailController.text,
          url: url,
          secret: _isSelfHosted ? _secretController.text : '',
        );
      } else {
        viewModel.onLoginPressed(
          context,
          completer,
          email: _emailController.text,
          password: _passwordController.text,
          url: url,
          secret: _isSelfHosted ? _secretController.text : '',
          oneTimePassword: _oneTimePasswordController.text,
        );
      }
    } else {
      viewModel.onGoogleLoginPressed(context, completer,
          url: url,
          secret: _isSelfHosted ? _secretController.text : '',
          oneTimePassword: _oneTimePasswordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;

    final ThemeData themeData = Theme.of(context);
    final TextStyle aboutTextStyle = themeData.textTheme.bodyText2;
    final TextStyle linkStyle = themeData.textTheme.bodyText2
        .copyWith(color: convertHexStringToColor(kDefaultAccentColor));

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
                  Theme.of(context).buttonColor,
                  Theme.of(context).buttonColor.withOpacity(.7),
                ],
              )),
            ),
          ),
        ),
        ScrollableListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Center(
                child: InkWell(
                  child: Image.asset('assets/images/logo.png',
                      width: 100, height: 100),
                  onTap: () {
                    launch(kSiteUrl, forceSafariVC: false, forceWebView: false);
                  },
                ),
              ),
            ),
            AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: viewModel.authState.isAuthenticated ? 0 : 1,
              child: Form(
                key: _formKey,
                child: AutofillGroup(
                  child: FormCard(
                    forceNarrow: calculateLayout(context) != AppLayout.mobile,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          SizedBox(height: 10),
                          if (!kIsWeb && !kReleaseMode)
                            AppToggleButtons(
                              tabLabels: [
                                localization.hosted,
                                localization.selfhosted,
                              ],
                              selectedIndex: _isSelfHosted ? 1 : 0,
                              onTabChanged: (index) {
                                setState(() {
                                  _isSelfHosted = index == 1;
                                  _loginError = '';
                                  _emailLogin = _isSelfHosted;
                                  _createAccount = !_isSelfHosted;
                                });
                              },
                            ),
                          if (!_isSelfHosted)
                            AppToggleButtons(
                              tabLabels: [
                                localization.signUp,
                                localization.login,
                              ],
                              selectedIndex: _createAccount ? 0 : 1,
                              onTabChanged: (index) {
                                setState(() {
                                  _createAccount = index == 0;
                                  _loginError = '';
                                });
                              },
                            ),
                          if (!_isSelfHosted)
                            AppToggleButtons(
                              tabLabels: [
                                'Google',
                                localization.email,
                              ],
                              selectedIndex: _emailLogin ? 1 : 0,
                              onTabChanged: (index) {
                                setState(() {
                                  _emailLogin = index == 1;
                                  _loginError = '';
                                });
                              },
                            ),
                          if (_emailLogin)
                            DecoratedFormField(
                              controller: _emailController,
                              label: localization.email,
                              keyboardType: TextInputType.emailAddress,
                              autovalidate: _autoValidate,
                              validator: (val) =>
                                  val.isEmpty || val.trim().isEmpty
                                      ? localization.pleaseEnterYourEmail
                                      : null,
                              autofillHints: [AutofillHints.email],
                              onSavePressed: (_) => _submitLoginForm(),
                            ),
                          if (_emailLogin && !_recoverPassword)
                            PasswordFormField(
                              controller: _passwordController,
                              autoValidate: false,
                              newPassword: _createAccount,
                              onSavePressed: (_) => _submitLoginForm(),
                            ),
                          if (_isSelfHosted && !kIsWeb)
                            DecoratedFormField(
                              controller: _urlController,
                              label: localization.url,
                              validator: (val) =>
                                  val.isEmpty || val.trim().isEmpty
                                      ? localization.pleaseEnterYourUrl
                                      : null,
                              keyboardType: TextInputType.url,
                              onSavePressed: (_) => _submitLoginForm(),
                            ),
                          if (!_createAccount)
                            DecoratedFormField(
                              controller: _oneTimePasswordController,
                              label:
                                  '${localization.oneTimePassword} (${localization.optional})',
                              onSavePressed: (_) => _submitLoginForm(),
                            ),
                          if (_isSelfHosted)
                            PasswordFormField(
                              labelText:
                                  '${localization.secret} (${localization.optional})',
                              controller: _secretController,
                              autoValidate: _autoValidate,
                              onSavePressed: (_) => _submitLoginForm(),
                            ),
                          if (_createAccount)
                            Padding(
                              padding: EdgeInsets.only(top: 10),
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
                          child: Row(
                            children: [
                              Expanded(
                                child: SelectableText(
                                  _loginError,
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              IconButton(
                                  icon: Icon(Icons.content_copy),
                                  tooltip: localization.copyError,
                                  onPressed: () {
                                    Clipboard.setData(
                                        ClipboardData(text: _loginError));
                                  }),
                            ],
                          ),
                        ),
                      Padding(
                        padding: EdgeInsets.only(top: 30, bottom: 10),
                        child: RoundedLoadingButton(
                          height: 44,
                          //width: 210,
                          width: 220,
                          controller: _buttonController,
                          color: convertHexStringToColor('#4285F4'),
                          onPressed: () => _createAccount
                              ? _submitSignUpForm()
                              : _submitLoginForm(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (_emailLogin)
                                Icon(Icons.mail, color: Colors.white)
                              else
                                ClipOval(
                                  child: Image.asset(
                                      'assets/images/google-icon.png',
                                      width: 30,
                                      height: 30),
                                ),
                              SizedBox(width: 10),
                              Text(
                                _recoverPassword
                                    ? localization.recoverPassword
                                    : _createAccount
                                        ? (_emailLogin
                                            ? localization.emailSignUp
                                            : localization.googleSignUp)
                                        : (_emailLogin
                                            ? localization.emailSignIn
                                            : localization.googleSignIn),
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          if (!_createAccount && _emailLogin)
                            Padding(
                              padding: const EdgeInsets.all(6),
                              child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    if (!_recoverPassword)
                                      Icon(MdiIcons.lock, size: 16),
                                    AppTextButton(
                                        label: _recoverPassword
                                            ? localization.cancel
                                            : localization.recoverPassword,
                                        onPressed: () {
                                          setState(() {
                                            _recoverPassword =
                                                !_recoverPassword;
                                          });
                                        }),
                                  ]),
                            ),
                        ],
                      ),
                    ],
                  ),
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
