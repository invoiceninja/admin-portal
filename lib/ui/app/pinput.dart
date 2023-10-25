import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:pinput/pinput.dart';

class AppPinput extends StatelessWidget {
  const AppPinput({Key? key, this.onCompleted}) : super(key: key);

  final ValueChanged<String>? onCompleted;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;

    return Pinput(
      onCompleted: onCompleted,
      autofocus: true,
      length: 6,
      showCursor: true,
      androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
      validator: (value) =>
          value!.isEmpty ? localization.pleaseEnterACode : null,
    );
  }
}
