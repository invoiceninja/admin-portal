import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_state.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/progress_button.dart';
import 'package:invoiceninja_flutter/ui/auth/login_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
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
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _urlController = TextEditingController();
  final _secretController = TextEditingController();
  final _oneTimePasswordController = TextEditingController();

  static const String OTP_ERROR = 'OTP_REQUIRED';

  final FocusNode _focusNode1 = new FocusNode();

  bool _createAccount = false;
  bool _isSelfHosted = false;
  bool _autoValidate = false;

  @override
  void didChangeDependencies() {
    final state = widget.viewModel.authState;
    _emailController.text = state.email;
    _passwordController.text = state.password;
    _urlController.text = cleanApiUrl(state.url);
    _secretController.text = state.secret;

    if (cleanApiUrl(state.url).isNotEmpty) {
      _isSelfHosted = true;
    }

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

  void _submitForm() {
    final bool isValid = _formKey.currentState.validate();

    setState(() {
      _autoValidate = !isValid;
    });

    if (!isValid) {
      return;
    }

    widget.viewModel.onLoginPressed(context,
        email: _emailController.text,
        password: _passwordController.text,
        url: _isSelfHosted ? _urlController.text : '',
        secret: _isSelfHosted ? _secretController.text : '',
        oneTimePassword: _oneTimePasswordController.text);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final error = viewModel.authState.error ?? '';
    final isOneTimePassword =
        error.contains(OTP_ERROR) || _oneTimePasswordController.text.isNotEmpty;

    if (!viewModel.authState.isInitialized) {
      return Container();
    }

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
            Form(
              key: _formKey,
              child: FormCard(
                isResponsive: calculateLayout(context) != AppLayout.mobile,
                children: <Widget>[
                  isOneTimePassword
                      ? TextFormField(
                          controller: _oneTimePasswordController,
                          key: ValueKey(localization.oneTimePassword),
                          autocorrect: false,
                          decoration: InputDecoration(
                              labelText: localization.oneTimePassword),
                        )
                      : Column(
                          children: <Widget>[
                            TextFormField(
                              controller: _emailController,
                              key: ValueKey(localization.email),
                              autocorrect: false,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  labelText: localization.email),
                              keyboardType: TextInputType.emailAddress,
                              autovalidate: _autoValidate,
                              validator: (val) =>
                                  val.isEmpty || val.trim().isEmpty
                                      ? localization.pleaseEnterYourEmail
                                      : null,
                              onFieldSubmitted: (String value) =>
                                  FocusScope.of(context)
                                      .requestFocus(_focusNode1),
                            ),
                            TextFormField(
                              controller: _passwordController,
                              key: ValueKey(localization.password),
                              autocorrect: false,
                              autovalidate: _autoValidate,
                              decoration: InputDecoration(
                                  labelText: localization.password),
                              validator: (val) =>
                                  val.isEmpty || val.trim().isEmpty
                                      ? localization.pleaseEnterYourPassword
                                      : null,
                              obscureText: true,
                              focusNode: _focusNode1,
                              onFieldSubmitted: (value) => _submitForm(),
                            ),
                            if (_isSelfHosted)
                              TextFormField(
                                controller: _urlController,
                                key: ValueKey(localization.url),
                                autocorrect: false,
                                autovalidate: _autoValidate,
                                decoration: InputDecoration(
                                    labelText: localization.url),
                                validator: (val) =>
                                    val.isEmpty || val.trim().isEmpty
                                        ? localization.pleaseEnterYourUrl
                                        : null,
                                keyboardType: TextInputType.url,
                              ),
                            if (_isSelfHosted)
                              TextFormField(
                                controller: _secretController,
                                key: ValueKey(localization.secret),
                                autocorrect: false,
                                decoration: InputDecoration(
                                    labelText: localization.secret),
                                obscureText: true,
                              ),
                          ],
                        ),
                  if (viewModel.authState.error != null &&
                      !error.contains(OTP_ERROR))
                    Container(
                      padding: EdgeInsets.only(top: 26.0),
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
                  Padding(
                    padding: EdgeInsets.only(top: 35, bottom: 10),
                    child: _createAccount
                        ? ProgressButton(
                            isLoading: viewModel.isLoading,
                            label: localization.signUp.toUpperCase(),
                            onPressed: () => _submitForm(),
                          )
                        : Row(
                            children: <Widget>[
                              Expanded(
                                child: ProgressButton(
                                  isLoading: viewModel.isLoading,
                                  label: localization.emailLogin.toUpperCase(),
                                  onPressed: () => _submitForm(),
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: ElevatedButton(
                                  label: localization.googleLogin.toUpperCase(),
                                  onPressed: () =>
                                      viewModel.onGoogleLoginPressed(
                                          context,
                                          _urlController.text,
                                          _secretController.text),
                                ),
                              ),
                            ],
                          ),
                  ),
                  if (!isOneTimePassword)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(FontAwesomeIcons.user, size: 16),
                            _createAccount
                                ? FlatButton(
                                    onPressed: () =>
                                        setState(() => _createAccount = false),
                                    child: Text(localization.accountLogin))
                                : FlatButton(
                                    key: ValueKey(localization.selfhostLogin),
                                    onPressed: () => setState(() {
                                          _createAccount = true;
                                          _isSelfHosted = false;
                                        }),
                                    child: Text(localization.createAccount)),
                          ],
                        ),
                        Row(children: <Widget>[
                          Icon(FontAwesomeIcons.userCog, size: 16),
                          _isSelfHosted
                              ? FlatButton(
                                  onPressed: () =>
                                      setState(() => _isSelfHosted = false),
                                  child: Text(localization.hostedLogin))
                              : FlatButton(
                                  key: ValueKey(localization.selfhostLogin),
                                  onPressed: () =>
                                      setState(() {
                                        _isSelfHosted = true;
                                        _createAccount = false;
                                      }),
                                  child: Text(localization.selfhostLogin)),
                        ]),
                        Row(children: <Widget>[
                          Icon(FontAwesomeIcons.externalLinkAlt, size: 16),
                          FlatButton(
                            child: Text(localization.viewWebsite),
                            onPressed: () async {
                              if (await canLaunch(kSiteUrl)) {
                                await launch(kSiteUrl,
                                    forceSafariVC: false, forceWebView: false);
                              }
                            },
                          ),
                        ]),
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
                          viewModel.onCancel2FAPressed();
                        },
                      ),
                    ),
                ],
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
