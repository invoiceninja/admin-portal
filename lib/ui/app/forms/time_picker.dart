import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
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
    this.allowClearing = false,
  }) : super(key: key);

  final String labelText;
  final DateTime previousDate;
  final DateTime selectedDate;
  final Function(DateTime) onSelected;
  final Function validator;
  final bool autoValidate;
  final bool allowClearing;

  @override
  _TimePickerState createState() => new _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFoucsChanged);
  }

  @override
  void didChangeDependencies() {
    if (widget.selectedDate != null) {
      _textController.text = formatDate(
          widget.selectedDate.toIso8601String(), context,
          showDate: false, showTime: true);
    }

    super.didChangeDependencies();
  }

  void _onFoucsChanged() {
    if (!_focusNode.hasFocus) {
      _textController.text = formatDate(
          widget.selectedDate?.toIso8601String(), context,
          showDate: false, showTime: true);
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.removeListener(_onFoucsChanged);
    _focusNode.dispose();
    super.dispose();
  }

  void _showTimePicker() async {
    final selectedDate = widget.selectedDate;
    final now = DateTime.now();

    final hour = selectedDate?.hour ?? now.hour;
    final minute = selectedDate?.minute ?? now.minute;

    final TimeOfDay selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: hour, minute: minute),
      //initialEntryMode: TimePickerEntryMode.input,
    );

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
    return TextFormField(
      focusNode: _focusNode,
      validator: widget.validator,
      autovalidateMode: widget.autoValidate
          ? AutovalidateMode.always
          : AutovalidateMode.onUserInteraction,
      controller: _textController,
      decoration: InputDecoration(
        labelText: widget.labelText,
        suffixIcon: widget.allowClearing && widget.selectedDate != null
            ? IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  _textController.text = '';
                  widget.onSelected(null);
                },
              )
            : IconButton(
                icon: Icon(Icons.access_time),
                onPressed: () => _showTimePicker(),
              ),
      ),
      onChanged: (value) {
        if (value.isEmpty) {
          if (widget.allowClearing) {
            widget.onSelected(null);
          }
        } else {
          print('## Value was: $value');
          if (value.allMatches(':').length < 2) {
            value += ':00';
            if (value.allMatches(':').length < 2) {
              value += ':00';
            }
          }

          final store = StoreProvider.of<AppState>(context);
          if (!store.state.company.settings.enableMilitaryTime) {
            final hour = parseDouble(value.split(':').first);
            value += hour >= 6 ? ' AM' : ' PM';
          }

          final dateTime = parseTime(value, context);
          print('## DATE TIME: $dateTime');
          if (dateTime != null) {
            final date = widget.selectedDate ?? DateTime.now();
            final selectedDate = DateTime(
              date.year,
              date.month,
              date.day,
              dateTime.hour,
              dateTime.minute,
              dateTime.second,
            );
            widget.onSelected(selectedDate);
          }
        }
      },
    );
  }
}
