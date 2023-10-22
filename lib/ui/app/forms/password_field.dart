// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({
    this.controller,
    this.newPassword = true,
    this.validate = true,
    this.onSavePressed,
    this.labelText,
  });

  final TextEditingController? controller;
  final Function(BuildContext)? onSavePressed;
  final bool newPassword;
  final bool validate;
  final String? labelText;

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
      key: ValueKey(widget.labelText ?? localization!.password),
      controller: widget.controller,
      onSavePressed: widget.onSavePressed,
      autocorrect: false,
      decoration: InputDecoration(
        labelText: widget.labelText ?? localization!.password,
        suffixIcon: IconButton(
          alignment: Alignment.bottomCenter,
          tooltip: _isPasswordObscured
              ? localization!.showPassword
              : localization!.hidePassword,
          icon: Icon(
            _isPasswordObscured ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _isPasswordObscured = !_isPasswordObscured;
            });
          },
        ),
      ),
      validator: (value) {
        if (!widget.validate) {
          return null;
        }

        if (value.isEmpty || value.trim().isEmpty) {
          return widget.newPassword
              ? null
              : localization.pleaseEnterYourPassword;
        }

        if (!widget.newPassword) {
          return null;
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
      autofillHints: widget.validate
          ? [
              widget.newPassword
                  ? AutofillHints.newPassword
                  : AutofillHints.password,
            ]
          : null,
    );
  }
}
