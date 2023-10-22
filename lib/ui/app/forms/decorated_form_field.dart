// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Project imports:
import 'package:invoiceninja_flutter/utils/platforms.dart';

class DecoratedFormField extends StatefulWidget {
  const DecoratedFormField({
    Key? key,
    required this.keyboardType,
    this.controller,
    this.label,
    this.onSavePressed,
    this.autocorrect = false,
    this.obscureText = false,
    this.onChanged,
    this.validator,
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
    this.suffixIconButton,
    this.isMoney = false,
    this.isPercent = false,
    this.showClear = true,
    this.inputFormatters,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? initialValue;
  final Function(String)? validator;
  final TextInputType keyboardType;
  final int? maxLines;
  final int? minLines;
  final bool? enabled;
  final bool autocorrect;
  final bool obscureText;
  final bool expands;
  final bool autofocus;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  final Icon? suffixIcon;
  final IconButton? suffixIconButton;
  final Iterable<String>? autofillHints;
  final Function(BuildContext)? onSavePressed;
  final TextAlign textAlign;
  final InputDecoration? decoration;
  final FocusNode? focusNode;
  final bool isMoney;
  final bool isPercent;
  final bool showClear;
  final List<TextInputFormatter>? inputFormatters;

  @override
  _DecoratedFormFieldState createState() => _DecoratedFormFieldState();
}

class _DecoratedFormFieldState extends State<DecoratedFormField> {
  bool _showClear = true;

  @override
  Widget build(BuildContext context) {
    Widget? iconButton = widget.suffixIconButton;

    final hasValue = (widget.initialValue ?? '').isNotEmpty ||
        (widget.controller?.text ?? '').isNotEmpty;

    final enterShouldSubmit = isDesktop(context) &&
        widget.onSavePressed != null &&
        (widget.maxLines ?? 1) <= 1;

    if (_showClear &&
        widget.showClear &&
        hasValue &&
        widget.key == null &&
        widget.controller != null) {
      if (widget.suffixIconButton == null &&
          widget.suffixIcon == null &&
          widget.enabled!) {
        iconButton = IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            widget.controller!.text = '';
            setState(() {
              _showClear = false;
            });
          },
        );
      }
    }

    InputDecoration? inputDecoration;
    if (widget.decoration != null) {
      inputDecoration = widget.decoration;
    } else if (widget.label == null && widget.hint == null) {
      inputDecoration = null;
    } else {
      var icon = widget.suffixIcon ?? iconButton;
      if (icon == null) {
        if (widget.isPercent) {
          icon = Icon(
            MdiIcons.percent,
            size: 16,
          );
        }
      }

      inputDecoration = InputDecoration(
          labelText: widget.label ?? '',
          hintText: widget.hint ?? '',
          suffixIcon: icon == null ? null : icon,
          floatingLabelBehavior:
              (widget.hint ?? '').isNotEmpty && (widget.label ?? '').isEmpty
                  ? FloatingLabelBehavior.always
                  : FloatingLabelBehavior.auto);
    }

    return TextFormField(
      key: ValueKey(widget.label),
      // Enables tests to find fields
      focusNode: widget.focusNode,
      controller: widget.controller,
      autofocus: widget.autofocus,
      decoration: inputDecoration,
      validator: (val) => val == null || widget.validator == null
          ? null
          : widget.validator!(val),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: widget.keyboardType,
      maxLines: widget.expands ? null : widget.maxLines ?? 1,
      minLines: widget.expands ? null : widget.minLines,
      expands: widget.expands,
      autocorrect:
          widget.isMoney || widget.isPercent ? false : widget.autocorrect,
      obscureText: widget.obscureText,
      initialValue: widget.initialValue,
      textInputAction: widget.keyboardType == TextInputType.multiline
          ? TextInputAction.newline
          // On web typing enter is clearing the value when using TextInputAction.next
          : enterShouldSubmit || kIsWeb
              ? TextInputAction.done
              : TextInputAction.next,
      onChanged: (value) {
        _showClear = true;
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      inputFormatters: widget.inputFormatters,
      onFieldSubmitted: (value) {
        if (widget.onFieldSubmitted != null) {
          return widget.onFieldSubmitted!(value);
        } else if (widget.keyboardType == TextInputType.multiline) {
          return null;
        } else if (enterShouldSubmit) {
          widget.onSavePressed!(context);
        }
      },
      enabled: widget.enabled,
      autofillHints: widget.autofillHints,
      textAlign: widget.textAlign,
    );
  }
}
