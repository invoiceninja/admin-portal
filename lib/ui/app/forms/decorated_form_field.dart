import 'package:flutter/material.dart';

class DecoratedFormField extends StatelessWidget {
  const DecoratedFormField({
    @required this.controller,
    @required this.label,
    this.autovalidate = false,
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
  final TextInputAction textInputAction;
  final ValueChanged<String> onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: ValueKey(label),
      autocorrect: false,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
      ),
      validator: validator,
      keyboardType: null,
      maxLines: maxLines ?? 1,
      autovalidate: autovalidate,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      enabled: enabled,
    );
  }
}
