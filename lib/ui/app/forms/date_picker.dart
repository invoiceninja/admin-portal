import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    @required this.labelText,
    @required this.onSelected,
    @required this.selectedDate,
    this.validator,
    this.autoValidate = false,
    this.allowClearing = false,
    this.firstDate,
  });

  final String labelText;
  final String selectedDate;
  final Function(String) onSelected;
  final Function validator;
  final bool autoValidate;
  final bool allowClearing;
  final DateTime firstDate;

  @override
  _DatePickerState createState() => new _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void didChangeDependencies() {
    _textController.text = formatDate(widget.selectedDate, context);
    _focusNode.addListener(_onFoucsChanged);

    super.didChangeDependencies();
  }

  void _onFoucsChanged() {
    if (!_focusNode.hasFocus) {
      _textController.text = formatDate(widget.selectedDate, context);
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.removeListener(_onFoucsChanged);
    _focusNode.dispose();

    super.dispose();
  }

  void _showDatePicker() async {
    DateTime firstDate = DateTime.now();
    final DateTime initialDate =
        widget.selectedDate != null && widget.selectedDate.isNotEmpty
            ? DateTime.tryParse(widget.selectedDate)
            : DateTime.now();

    if (widget.firstDate != null) {
      if (initialDate.isBefore(firstDate)) {
        firstDate = initialDate;
      }
    } else {
      firstDate = DateTime(2015, 8);
    }

    final DateTime selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: DateTime(2101),
      //initialEntryMode: DatePickerEntryMode.input,
    );

    if (selectedDate != null) {
      final date = convertDateTimeToSqlDate(selectedDate);
      _textController.text = formatDate(date, context);
      widget.onSelected(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        TextFormField(
          focusNode: _focusNode,
          validator: widget.validator,
          autovalidateMode: widget.autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.onUserInteraction,
          controller: _textController,
          decoration: InputDecoration(
            labelText: widget.labelText,
          ),
          onChanged: (value) {
            if (value.isEmpty) {
              widget.onSelected('');
            } else {
              String date = '';
              if (isAllDigits(value)) {
                if (value.length < 4) {
                  value = '0$value';
                }
                if (value.length < 5) {
                  value = '${DateTime.now().year}$value';
                }
                date = convertDateTimeToSqlDate(DateTime.tryParse(value));
              } else {
                date = parseDate(value, context);
              }

              if ((date ?? '').isNotEmpty) {
                widget.onSelected(date);
              }
            }
          },
        ),
        widget.allowClearing && (widget.selectedDate ?? '').isNotEmpty
            ? IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  _textController.text = '';
                  widget.onSelected('');
                },
              )
            : IconButton(
                icon: Icon(Icons.date_range),
                onPressed: () => _showDatePicker(),
              )
      ],
    );
  }
}
