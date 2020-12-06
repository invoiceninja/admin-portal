import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
//import 'package:flutter_colorpicker/block_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
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

  String _pendingColor;
  String _selectedColor;

  final _debouncer = Debouncer();
  List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _controllers = [_textController];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    _selectedColor = _textController.text = widget.initialValue;

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    _debouncer.run(() {
      _selectColor(_textController.text.trim());
    });
  }

  void _selectColor(String color) {
    if (color != null && color.length != 7) {
      return;
    }

    setState(() {
      _selectedColor = color;
      widget.onSelected(color);
    });
  }

  @override
  void dispose() {
    _textController.dispose();
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
                _selectColor(_pendingColor);
                _textController.text = _pendingColor;
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
        DecoratedFormField(
          controller: _textController,
          label: widget.labelText,
          hint: '#000000',
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            InkWell(
              onTap: _showPicker,
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedColor == null
                      ? Colors.grey
                      : convertHexStringToColor(_selectedColor) ?? Colors.grey,
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
                  _selectColor(null);
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
