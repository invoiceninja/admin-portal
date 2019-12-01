import 'package:flutter/material.dart';

class DecoratedFormField extends StatelessWidget {
  const DecoratedFormField({
    Key key,
    @required this.controller,
    @required this.label,
    this.autovalidate = false,
    this.autocorrect = false,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.minLines,
    this.maxLines,
    this.textInputAction,
    this.onFieldSubmitted,
    this.initialValue,
    this.enabled,
    this.hint,
    this.expands = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final String hint;
  final String initialValue;
  final Function(String) validator;
  final TextInputType keyboardType;
  final int maxLines;
  final int minLines;
  final bool autovalidate;
  final bool enabled;
  final bool autocorrect;
  final bool obscureText;
  final bool expands;
  final TextInputAction textInputAction;
  final ValueChanged<String> onFieldSubmitted;
  final ValueChanged<String> onChanged;

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
      maxLines: expands ? null : maxLines ?? 1,
      minLines: expands ? null : minLines,
      expands: expands,
      autovalidate: autovalidate,
      autocorrect: autocorrect,
      obscureText: obscureText,
      initialValue: initialValue,
      textInputAction: textInputAction ??
          (keyboardType == TextInputType.multiline
              ? TextInputAction.newline
              : TextInputAction.next),
      onChanged: onChanged,
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
