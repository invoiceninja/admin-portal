import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
    this.isMoney = false,
    this.isPercent = false,
    this.showClear = true,
    this.inputFormatters,
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
  final ValueChanged<String> onFieldSubmitted;
  final ValueChanged<String> onChanged;
  final Icon suffixIcon;
  final Iterable<String> autofillHints;
  final Function(BuildContext) onSavePressed;
  final TextAlign textAlign;
  final InputDecoration decoration;
  final FocusNode focusNode;
  final bool isMoney;
  final bool isPercent;
  final bool showClear;
  final List<TextInputFormatter> inputFormatters;

  @override
  Widget build(BuildContext context) {
    Widget suffixIconButton;

    final hasValue =
        (initialValue ?? '').isNotEmpty || (controller?.text ?? '').isNotEmpty;
    final calcKeyboardType = isMoney || isPercent
        ? TextInputType.numberWithOptions(decimal: true, signed: true)
        : (maxLines ?? 0) > 1
            ? TextInputType.multiline
            : keyboardType ?? TextInputType.text;
    final enterShouldSubmit =
        isDesktop(context) && onSavePressed != null && (maxLines ?? 1) <= 1;

    if (showClear && hasValue && key == null) {
      if (suffixIcon == null && enabled) {
        suffixIconButton = IconButton(
          icon: Icon(Icons.clear),
          onPressed: () =>
              controller != null ? controller.text = '' : onChanged(''),
        );
      }
    }

    InputDecoration inputDecoration;
    if (decoration != null) {
      inputDecoration = decoration;
    } else if (label == null) {
      inputDecoration = null;
    } else {
      var icon = suffixIcon ?? suffixIconButton;
      if (icon == null) {
        if (isMoney) {
          final state = StoreProvider.of<AppState>(context).state;
          icon = Icon(state.company.currencyId == kCurrencyEuro
              ? Icons.euro
              : Icons.attach_money);
        } else if (isPercent) {
          icon = Icon(
            MdiIcons.percent,
            size: 16,
          );
        }
      }

      inputDecoration = InputDecoration(
          labelText: label,
          hintText: hint,
          suffixIcon: icon,
          floatingLabelBehavior:
              (hint ?? '').isNotEmpty && (label ?? '').isEmpty
                  ? FloatingLabelBehavior.always
                  : FloatingLabelBehavior.auto);
    }

    return TextFormField(
      key: ValueKey(label), // Enables tests to find fields
      focusNode: focusNode,
      controller: controller,
      autofocus: autofocus,
      decoration: inputDecoration,
      validator: validator,
      keyboardType: calcKeyboardType,
      maxLines: expands ? null : maxLines ?? 1,
      minLines: expands ? null : minLines,
      expands: expands,
      autovalidateMode: autovalidate
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      autocorrect: isMoney || isPercent ? false : autocorrect,
      obscureText: obscureText,
      initialValue: initialValue,
      textInputAction: calcKeyboardType == TextInputType.multiline
          ? TextInputAction.newline
          : enterShouldSubmit
              ? TextInputAction.done
              : TextInputAction.next,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      onFieldSubmitted: (value) {
        if (onFieldSubmitted != null) {
          return onFieldSubmitted(value);
        } else if (calcKeyboardType == TextInputType.multiline) {
          return null;
        } else if (enterShouldSubmit) {
          onSavePressed(context);
        }
      },
      enabled: enabled,
      autofillHints: autofillHints,
      textAlign: textAlign,
    );
  }
}
