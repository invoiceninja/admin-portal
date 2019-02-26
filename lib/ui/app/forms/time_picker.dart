import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({
    Key key,
    @required this.labelText,
    @required this.onSelected,
    @required this.selectedDate,
    this.previousDate,
    this.validator,
    this.autoValidate = false,
  }) : super(key: key);

  final String labelText;
  final DateTime previousDate;
  final DateTime selectedDate;
  final Function(DateTime) onSelected;
  final Function validator;
  final bool autoValidate;

  @override
  _TimePickerState createState() => new _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  final _textController = TextEditingController();

  @override
  void didChangeDependencies() {
    if (widget.selectedDate != null) {
      _textController.text = formatDate(
          widget.selectedDate.toIso8601String(), context,
          showDate: false, showTime: true);
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _showTimePicker() async {
    final selectedDate = widget.selectedDate;
    final now = DateTime.now();

    final hour = selectedDate?.hour ?? now.hour;
    final minute = selectedDate?.minute ?? now.minute;

    final TimeOfDay selectedTime = await showTimePicker(
        context: context, initialTime: TimeOfDay(hour: hour, minute: minute));

    if (selectedTime != null) {
      var dateTime = convertTimeOfDayToDateTime(selectedTime, selectedDate);

      if (widget.previousDate != null &&
          dateTime.isBefore(widget.previousDate)) {
        dateTime = dateTime.add(Duration(days: 1));
      }

      _textController.text = formatDate(dateTime.toIso8601String(), context,
          showTime: true, showDate: false);

      widget.onSelected(dateTime.toLocal());
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showTimePicker(),
      child: IgnorePointer(
        child: TextFormField(
          validator: widget.validator,
          autovalidate: widget.autoValidate,
          controller: _textController,
          decoration: InputDecoration(
            labelText: widget.labelText,
            suffixIcon: Icon(Icons.access_time),
          ),
        ),
      ),
    );
  }
}
