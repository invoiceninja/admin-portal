import 'package:flutter/material.dart';
import 'package:invoiceninja/utils/formatting.dart';


class DatePicker extends StatefulWidget {

  const DatePicker({
    @required this.labelText,
    @required this.onSelected,
    @required this.selectedDate,
    this.validator,
  });

  final String labelText;
  final String selectedDate;
  final Function(String) onSelected;
  final Function validator;

  @override
  _DatePickerState createState() => new _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {

  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _textController.text = widget.selectedDate;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _showDatePicker() async {
    final DateTime selectedDate = await showDatePicker(
        context: context,
        initialDate: widget.selectedDate != null && widget.selectedDate.isNotEmpty ? DateTime.tryParse(widget.selectedDate) : DateTime.now(),
        firstDate: new DateTime(2015, 8),
        lastDate: new DateTime(2101)
    );

    _textController.text = convertDateTimeToSqlDate(selectedDate);
    widget.onSelected(convertDateTimeToSqlDate(selectedDate));
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showDatePicker(),
      child: IgnorePointer(
        child: TextFormField(
          validator: widget.validator,
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
