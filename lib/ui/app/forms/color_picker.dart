import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/block_picker.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';
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
  String _pendingColor;
  String _selectedColor;

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

    _selectedColor = null;

    Color color = Colors.black;
    if (widget.initialValue != null && widget.initialValue.isNotEmpty) {
      color = convertHexStringToColor(widget.initialValue);
    }

    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: color,
              onColorChanged: (color) {
                final hex = color.value.toRadixString(16);
                _pendingColor = '#' + hex.substring(2, hex.length);
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
                widget.onSelected(_pendingColor);
                _textController.text = _pendingColor;
                setState(() {
                  _selectedColor = _pendingColor;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              color: convertHexStringToColor(widget.initialValue),
              width: 100,
              height: 20,
            ),
            SizedBox(width: 20),
            if (_selectedColor == null)
              IconButton(
                icon: Icon(Icons.color_lens),
                onPressed: _showPicker,
              )
            else
              IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  _textController.text = '';
                  setState(() {
                    _selectedColor = null;
                  });
                  widget.onSelected(null);
                },
              ),
          ],
        ),
      ],
    );
  }
}
