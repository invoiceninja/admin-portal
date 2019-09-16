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
  });

  final TextEditingController controller;
  final String label;
  final Function(String) validator;
  final TextInputType keyboardType;
  final int maxLines;
  final bool autovalidate;
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
      ),
      validator: validator,
      keyboardType: null,
      maxLines: maxLines ?? 1,
      autovalidate: autovalidate,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
