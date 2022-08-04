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
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class SmsVerification extends StatefulWidget {
  const SmsVerification();

  @override
  State<SmsVerification> createState() => _SmsVerificationState();
}

class _SmsVerificationState extends State<SmsVerification> {
  bool _showCode = false;
  bool _isLoading = false;
  String _code = '';
  String _phone = '';
  bool _autoValidate = false;
  final _webClient = WebClient();

  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_smsVerification');
  final FocusScopeNode _focusNode = FocusScopeNode();

  void _sendCode() {
    final bool isValid = _formKey.currentState.validate();

    setState(() {
      _autoValidate = !isValid ?? false;
    });

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

    setState(() {
      _autoValidate = !isValid ?? false;
    });

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
                    SizedBox(height: 8),
                    DecoratedFormField(
                      label: localization.code,
                      keyboardType: TextInputType.number,
                      autovalidate: _autoValidate,
                      onChanged: (value) => _code = value,
                      validator: (value) =>
                          value.isEmpty ? localization.pleaseEnterACode : null,
                    ),
                  ] else
                    IntlPhoneField(
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
