import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/pinput.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class AccountSmsVerification extends StatefulWidget {
  const AccountSmsVerification();

  @override
  State<AccountSmsVerification> createState() => _AccountSmsVerificationState();
}

class _AccountSmsVerificationState extends State<AccountSmsVerification> {
  bool _showCode = false;
  bool _isLoading = false;
  String _code = '';
  String _phone = '';
  final _webClient = WebClient();

  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_accountSmsVerification');
  final FocusScopeNode _focusNode = FocusScopeNode();

  void _sendCode() {
    final bool isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    }

    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final credentials = state.credentials;
    final url = '${credentials.url}/verify';

    setState(() {
      _isLoading = true;
    });

    _webClient
        .post(url, credentials.token,
            data: json.encode(
              {'phone': _phone},
            ))
        .then((dynamic data) {
      setState(() {
        _isLoading = false;
        _showCode = true;
      });
    }).catchError((dynamic error) {
      setState(() {
        _isLoading = false;
      });
      showErrorDialog(context: context, message: error);
    });
  }

  void _verifyCode() {
    final bool isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    }

    final store = StoreProvider.of<AppState>(context);
    final localization = AppLocalization.of(context);
    final credentials = store.state.credentials;
    final url = '${credentials.url}/verify/confirm';
    final navigator = Navigator.of(context);

    setState(() {
      _isLoading = true;
    });

    _webClient
        .post(url, credentials.token, data: json.encode({'code': _code}))
        .then((dynamic data) {
      setState(() {
        _isLoading = false;
      });
      if (navigator.canPop()) {
        navigator.pop();
      }
      showToast(localization.verifiedPhoneNumber);
      store.dispatch(RefreshData());
    }).catchError((dynamic error) {
      setState(() {
        _isLoading = false;
      });
      showErrorDialog(context: context, message: error);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    var countryId = state.company.settings.countryId;
    if ((countryId ?? '').isEmpty) {
      countryId = kCountryUnitedStates;
    }
    final country = state.staticState.countryMap[countryId];

    return AlertDialog(
      title: Text(localization.verifyPhoneNumber),
      content: _isLoading
          ? LoadingIndicator(height: 80)
          : AppForm(
              focusNode: _focusNode,
              formKey: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_showCode) ...[
                    Text(localization.codeWasSent),
                    SizedBox(height: 20),
                    AppPinput(
                      onCompleted: (code) => _code = code,
                    ),
                  ] else
                    IntlPhoneField(
                      autofocus: true,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[0-9]'),
                        ),
                      ],
                      initialCountryCode: country.iso2.toUpperCase(),
                      onChanged: (phone) => _phone = phone.completeNumber,
                      validator: (value) => value.number.isEmpty
                          ? localization.pleaseEnterAValue
                          : null,
                    ),
                ],
              ),
            ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            localization.cancel.toUpperCase(),
          ),
        ),
        if (_showCode) ...[
          TextButton(
            onPressed: () => _sendCode(),
            child: Text(
              localization.resend.toUpperCase(),
            ),
          ),
          TextButton(
            onPressed: () => _verifyCode(),
            child: Text(
              localization.verify.toUpperCase(),
            ),
          ),
        ] else ...[
          TextButton(
            onPressed: () => _sendCode(),
            child: Text(
              localization.sendCode.toUpperCase(),
            ),
          ),
        ]
      ],
    );
  }
}

class UserSmsVerification extends StatefulWidget {
  const UserSmsVerification({
    Key key,
    this.showChangeNumber = false,
  }) : super(key: key);

  final bool showChangeNumber;

  @override
  State<UserSmsVerification> createState() => _UserSmsVerificationState();
}

class _UserSmsVerificationState extends State<UserSmsVerification> {
  bool _isLoading = false;
  String _code = '';
  final _webClient = WebClient();

  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_userSmsVerification');
  final FocusScopeNode _focusNode = FocusScopeNode();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((duration) {
      _sendCode();
    });
  }

  void _sendCode() {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final credentials = state.credentials;
    final url = '${credentials.url}/sms_reset';

    setState(() {
      _isLoading = true;
    });

    _webClient
        .post(url, credentials.token,
            data: json.encode(
              {'email': state.user.email},
            ))
        .then((dynamic data) {
      setState(() {
        _isLoading = false;
      });
    }).catchError((dynamic error) {
      setState(() {
        _isLoading = false;
      });
      showErrorDialog(context: context, message: error);
    });
  }

  void _verifyCode() {
    final bool isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    }

    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final localization = AppLocalization.of(context);
    final credentials = store.state.credentials;
    final url = '${credentials.url}/sms_reset/confirm';
    final navigator = Navigator.of(context);

    setState(() {
      _isLoading = true;
    });

    _webClient
        .post(url, credentials.token,
            data: json.encode({
              'code': _code,
              'email': state.user.email,
            }))
        .then((dynamic data) {
      setState(() {
        _isLoading = false;
      });
      if (navigator.canPop()) {
        navigator.pop(true);
      }
      showToast(localization.verifiedPhoneNumber);
      store.dispatch(RefreshData());
    }).catchError((dynamic error) {
      setState(() {
        _isLoading = false;
      });
      showErrorDialog(context: context, message: error);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    return AlertDialog(
      title: Text(localization.verifyPhoneNumber),
      content: _isLoading
          ? LoadingIndicator(height: 80)
          : AppForm(
              focusNode: _focusNode,
              formKey: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(localization.codeWasSentTo
                      .replaceFirst(':number', state.user.phone)),
                  SizedBox(height: 20),
                  AppPinput(
                    onCompleted: (code) => _code = code,
                  ),
                ],
              ),
            ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            localization.cancel.toUpperCase(),
          ),
        ),
        if (!_isLoading) ...[
          TextButton(
            onPressed: () {
              store.dispatch(ViewSettings(section: kSettingsUserDetails));
              Navigator.of(context).pop();
            },
            child: Text(
              localization.changeNumber.toUpperCase(),
            ),
          ),
          TextButton(
            onPressed: () => _sendCode(),
            child: Text(
              localization.resendCode.toUpperCase(),
            ),
          ),
          TextButton(
            onPressed: () => _verifyCode(),
            child: Text(
              localization.verify.toUpperCase(),
            ),
          ),
        ],
      ],
    );
  }
}
