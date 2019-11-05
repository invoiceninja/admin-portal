import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/block_picker.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class FormColorPicker extends StatefulWidget {
  const FormColorPicker({
    this.labelText,
    this.initialValue,
    this.onSelected,
    this.showClear = true,
  });

  final String labelText;
  final String initialValue;
  final Function(String) onSelected;
  final bool showClear;

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
    _selectedColor = _textController.text = widget.initialValue;
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
                _pendingColor = convertColorToHexString(color);
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
            GestureDetector(
              onTap: _showPicker,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.initialValue == null
                      ? Colors.grey
                      : convertHexStringToColor(widget.initialValue),
                  border: Border.all(
                    color: Colors.black38,
                  ),
                ),
                width: 100,
                height: 25,
              ),
            ),
            SizedBox(width: 10),
            if (widget.showClear && _selectedColor != null)
              IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  _textController.text = '';
                  setState(() {
                    _selectedColor = null;
                  });
                  widget.onSelected(null);
                },
              )
            else
              IconButton(
                icon: Icon(Icons.color_lens),
                onPressed: _showPicker,
              )
          ],
        ),
      ],
    );
  }
}
