import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({
    this.controller,
    this.textInputAction,
    this.autoValidate,
    this.newPassword = true,
  });

  final TextEditingController controller;
  final TextInputAction textInputAction;
  final bool autoValidate;
  final bool newPassword;

  @override
  _PasswordFormFieldState createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _isPasswordObscured = true;

  bool _validatePassword(String value) {
    const pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    final regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return DecoratedFormField(
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      autocorrect: false,
      autovalidate: widget.autoValidate,
      decoration: InputDecoration(
        labelText: localization.password,
        suffixIcon: IconButton(
          tooltip: _isPasswordObscured
              ? localization.showPassword
              : localization.hidePassword,
          icon: Icon(
            _isPasswordObscured ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isPasswordObscured = !_isPasswordObscured;
            });
          },
        ),
      ),
      validator: (value) {
        if (value.isEmpty || value.trim().isEmpty) {
          return widget.newPassword
              ? null
              : localization.pleaseEnterYourPassword;
        }

        if (value.length < 8) {
          return localization.passwordIsTooShort;
        }

        if (!_validatePassword(value)) {
          return localization.passwordIsTooEasy;
        }

        return null;
      },
      obscureText: _isPasswordObscured,
      keyboardType: TextInputType.visiblePassword,
      onFieldSubmitted: (String value) => FocusScope.of(context).nextFocus(),
      autofillHints: [
        widget.newPassword ? AutofillHints.newPassword : AutofillHints.password,
      ],
    );
  }
}
