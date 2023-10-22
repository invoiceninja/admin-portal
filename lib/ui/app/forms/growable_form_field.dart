// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';

class GrowableFormField extends StatefulWidget {
  const GrowableFormField({
    Key? key,
    required this.initialValue,
    required this.onChanged,
    this.autofocus = false,
    this.label,
  }) : super(key: key);

  final String initialValue;
  final ValueChanged<String> onChanged;
  final bool autofocus;
  final String? label;

  @override
  _GrowableFormFieldState createState() => _GrowableFormFieldState();
}

class _GrowableFormFieldState extends State<GrowableFormField> {
  final _focusNode = FocusNode();
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFoucsChanged);
  }

  void _onFoucsChanged() {
    setState(() {
      _hasFocus = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFoucsChanged);
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedFormField(
      label: widget.label,
      autofocus: widget.autofocus,
      focusNode: _focusNode,
      initialValue: widget.initialValue,
      onChanged: widget.onChanged,
      keyboardType: TextInputType.multiline,
      minLines: 1,
      // TODO remove this isWeb check/needed to prevent overflow
      maxLines: _hasFocus ? 20 : 2,
    );
  }
}
