import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    @required this.labelText,
    @required this.onSelected,
    @required this.selectedDate,
    this.validator,
    this.autoValidate = false,
  });

  final String labelText;
  final String selectedDate;
  final Function(String) onSelected;
  final Function validator;
  final bool autoValidate;

  @override
  _DatePickerState createState() => new _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final _textController = TextEditingController();

  @override
  void didChangeDependencies() {
    _textController.text = formatDate(widget.selectedDate, context);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _showDatePicker() async {
    final DateTime selectedDate = await showDatePicker(
        context: context,
        initialDate:
            widget.selectedDate != null && widget.selectedDate.isNotEmpty
                ? DateTime.tryParse(widget.selectedDate)
                : DateTime.now(),
        firstDate: new DateTime(2015, 8),
        lastDate: new DateTime(2101));

    final date = convertDateTimeToSqlDate(selectedDate);
    _textController.text = formatDate(date, context);
    widget.onSelected(date);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showDatePicker(),
      child: IgnorePointer(
        child: TextFormField(
          validator: widget.validator,
          autovalidate: widget.autoValidate,
          controller: _textController,
          decoration: InputDecoration(
            labelText: widget.labelText,
            suffixIcon: Icon(Icons.date_range),
          ),
        ),
      ),
    );
  }
}
