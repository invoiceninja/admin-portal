import 'package:flutter/material.dart';


class DatePicker extends StatefulWidget {

  DatePicker({
    @required this.labelText,
    @required this.onSelected,
    @required this.selectedDate,
  });

  final String labelText;
  final DateTime selectedDate;
  final Function(int) onSelected;

  @override
  _DatePickerState createState() => new _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {

  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.text = widget.selectedDate?.toIso8601String();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  _showDatePicker() async {
    print('== Focused: ');

    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: new DateTime(2015, 8),
        lastDate: new DateTime(2101)
    );

    print('== Picked: ');
    print(picked);

    //var localization = AppLocalization.of(context);

  }

  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showDatePicker(),
      child: IgnorePointer(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: widget.labelText,
            suffixIcon: Icon(Icons.date_range),
          ),
        ),
      ),
    );
  }
}
