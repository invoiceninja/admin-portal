import 'package:flutter/material.dart';

class DecoratedFormField extends StatelessWidget {
  const DecoratedFormField({
    @required this.controller,
    @required this.label,
    this.autovalidate = false,
    this.autocorrect = false,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
    this.maxLines,
    this.textInputAction,
    this.onFieldSubmitted,
    this.enabled,
    this.hint,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final Function(String) validator;
  final TextInputType keyboardType;
  final int maxLines;
  final bool autovalidate;
  final bool enabled;
  final bool autocorrect;
  final bool obscureText;
  final TextInputAction textInputAction;
  final ValueChanged<String> onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: ValueKey(label),
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
      ),
      validator: validator,
      keyboardType: keyboardType ?? TextInputType.text,
      maxLines: maxLines ?? 1,
      autovalidate: autovalidate,
      autocorrect: autocorrect,
      obscureText: obscureText,
      textInputAction: textInputAction ??
          (keyboardType == TextInputType.multiline
              ? TextInputAction.newline
              : TextInputAction.next),
      onFieldSubmitted: (value) {
        if (onFieldSubmitted != null) {
          return onFieldSubmitted(value);
        } else if (keyboardType == TextInputType.multiline) {
          return null;
        } else {
          FocusScope.of(context).nextFocus();
        }
      },
      enabled: enabled,
    );
  }
}
