import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({
    Key key,
    @required this.labelText,
    @required this.onSelected,
    @required this.selectedDate,
    this.validator,
    this.autoValidate = false,
  }) : super(key: key);

  final String labelText;
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

  void _showDatePicker() async {
    final selectedDate = widget.selectedDate;
    final now = DateTime.now();

    final hour = selectedDate?.hour ?? now.hour;
    final minute = selectedDate?.minute ?? now.minute;

    final TimeOfDay selectedTime = await showTimePicker(
        context: context, initialTime: TimeOfDay(hour: hour, minute: minute));

    if (selectedTime != null) {
      final dateTime = convertTimeOfDayToDateTime(selectedTime);
      _textController.text = formatDate(dateTime.toIso8601String(), context,
          showTime: true, showDate: false);

      widget.onSelected(dateTime);
    }
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
            suffixIcon: Icon(Icons.access_time),
          ),
        ),
      ),
    );
  }
}
