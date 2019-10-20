import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/block_picker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_colorpicker/hsv_picker.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class FormColorPicker extends StatefulWidget {
  const FormColorPicker({this.labelText, this.initialValue, this.onSelected});

  final String labelText;
  final String initialValue;
  final Function(String) onSelected;

  @override
  _FormColorPickerState createState() => _FormColorPickerState();
}

class _FormColorPickerState extends State<FormColorPicker> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  String _color;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _textController.text = widget.initialValue;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _showPicker() {
    final localization = AppLocalization.of(context);

    Color color = Colors.black;
    if (widget.initialValue.isNotEmpty) {
      color = Color(int.parse(widget.initialValue.substring(1, 7), radix: 16) +
          0xFF000000);
    }

    showDialog<AlertDialog>(
      context: context,
      child: AlertDialog(
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: color,
            onColorChanged: (color) {
              final hex = color.value.toRadixString(16);
              _color = '#' + hex.substring(2, hex.length);
            },
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(localization.cancel.toUpperCase()),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text(localization.done.toUpperCase()),
            onPressed: () {
              widget.onSelected(_color);
              _textController.text = _color;
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        TextFormField(
          focusNode: _focusNode,
          controller: _textController,
          decoration: InputDecoration(
            labelText: widget.labelText,
          ),
        ),
        if (_textController.text.isEmpty)
          IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: _showPicker,
          ),
        if (_textController.text.isNotEmpty)
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              _textController.text = '';
              widget.onSelected(null);
            },
          ),
      ],
    );
  }
}
