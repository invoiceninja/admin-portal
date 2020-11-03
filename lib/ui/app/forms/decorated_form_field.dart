import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DecoratedFormField extends StatelessWidget {
  const DecoratedFormField({
    Key key,
    this.controller,
    this.label,
    this.onSavePressed,
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
    this.enabled = true,
    this.hint,
    this.suffixIcon,
    this.expands = false,
    this.autofocus = false,
    this.autofillHints,
    this.textAlign = TextAlign.start,
    this.decoration,
    this.focusNode,
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
  final bool autofocus;
  final TextInputAction textInputAction;
  final ValueChanged<String> onFieldSubmitted;
  final ValueChanged<String> onChanged;
  final Icon suffixIcon;
  final Iterable<String> autofillHints;
  final Function(BuildContext) onSavePressed;
  final TextAlign textAlign;
  final InputDecoration decoration;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key ?? ValueKey(label),
      focusNode: focusNode,
      controller: controller,
      autofocus: autofocus,
      decoration: decoration ??
          (label == null
              ? null
              : InputDecoration(
                  labelText: label,
                  hintText: hint,
                  suffixIcon: suffixIcon,
                )),
      validator: validator,
      keyboardType: keyboardType ?? TextInputType.text,
      maxLines: expands ? null : maxLines ?? 1,
      minLines: expands ? null : minLines,
      expands: expands,
      autovalidateMode: autovalidate
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      autocorrect: autocorrect,
      obscureText: obscureText,
      initialValue: initialValue,
      textInputAction: textInputAction ??
          (keyboardType == TextInputType.multiline
              ? TextInputAction.newline
              : TextInputAction.next),
      onChanged: onChanged,
      onFieldSubmitted: (value) {
        print('## onFieldSubmitted');
        if (onFieldSubmitted != null) {
          return onFieldSubmitted(value);
        } else if (keyboardType == TextInputType.multiline) {
          return null;
        } else if (kIsWeb && onSavePressed != null) {
          print('## WEB');
          onSavePressed(context);
        } else {
          print('## FOUCY');
          FocusScope.of(context).nextFocus();
        }
      },
      enabled: enabled,
      autofillHints: autofillHints,
      textAlign: textAlign,
    );
  }
}
