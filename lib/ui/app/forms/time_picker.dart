// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/main_app.dart';

// Project imports:
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({
    Key? key,
    required this.onSelected,
    required this.selectedDateTime,
    this.isEndTime = false,
    this.labelText,
    this.validator,
    this.autoValidate = false,
    this.allowClearing = false,
  }) : super(key: key);

  final String? labelText;
  final DateTime? selectedDateTime;
  final Function(DateTime?) onSelected;
  final Function? validator;
  final bool autoValidate;
  final bool allowClearing;
  final bool isEndTime;

  @override
  _TimePickerState createState() => new _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  String? _pendingValue;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFoucsChanged);
  }

  @override
  void didChangeDependencies() {
    if (widget.selectedDateTime != null) {
      final formatted = formatDate(
          widget.selectedDateTime!.toIso8601String(), context,
          showDate: false, showTime: true);

      _textController.text = formatted;
    }

    super.didChangeDependencies();
  }

  void _onFoucsChanged() {
    if (!_focusNode.hasFocus && widget.selectedDateTime != null) {
      _textController.text = formatDate(
          widget.selectedDateTime!.toIso8601String(), context,
          showDate: false, showTime: true);

      setState(() {
        _pendingValue = null;
      });
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
    final selectedDateTime = widget.selectedDateTime?.toLocal();
    final now = DateTime.now();

    final hour = selectedDateTime?.hour ?? now.hour;
    final minute = selectedDateTime?.minute ?? now.minute;

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: hour, minute: minute),
      builder: (BuildContext context, Widget? child) {
        final store = StoreProvider.of<AppState>(context);
        final enableMilitaryTime =
            store.state.company.settings.enableMilitaryTime;
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(alwaysUse24HourFormat: enableMilitaryTime),
          child: child!,
        );
      },
    );

    if (selectedTime != null) {
      final dateTime = convertTimeOfDayToDateTime(selectedTime);

      _textController.text = formatDate(
          dateTime.toIso8601String(), navigatorKey.currentContext,
          showTime: true, showDate: false);

      widget.onSelected(dateTime.toLocal());
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedFormField(
      focusNode: _focusNode,
      validator: widget.validator as dynamic Function(String)?,
      controller: _textController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: _pendingValue ?? widget.labelText ?? '',
        suffixIcon: widget.allowClearing && widget.selectedDateTime != null
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
          final initialValue = value;
          value = value.replaceAll(RegExp('[^\\d\:]'), '');
          value = value.toLowerCase().replaceAll('.', ':');

          final parts =
              value.split(':').where((element) => element.isNotEmpty).toList();
          String dateTimeStr = '';

          if (parts.length == 1) {
            final part = parts[0];
            if (part.length == 1 || part.length == 2) {
              dateTimeStr = part + ':00:00';
            } else if (part.length == 3) {
              dateTimeStr =
                  part.substring(0, 1) + ':' + part.substring(1, 3) + ':00';
            } else if (part.length == 4) {
              dateTimeStr =
                  part.substring(0, 2) + ':' + part.substring(2, 4) + ':00';
            }
          } else if (parts.isNotEmpty) {
            dateTimeStr = parts[0] + ':' + parts[1];
            if (parts[1].length == 1) {
              dateTimeStr += '0';
            }
            if (parts.length == 3) {
              dateTimeStr += ':' + parts[2];
            } else {
              dateTimeStr += ':00';
            }
          }

          if (initialValue.toLowerCase().contains('a')) {
            dateTimeStr += ' AM';
          } else if (initialValue.toLowerCase().contains('p')) {
            dateTimeStr += ' PM';
          } else {
            final store = StoreProvider.of<AppState>(context);
            if (!store.state.company.settings.enableMilitaryTime!) {
              final hour = parseDouble(parts[0])!;
              if (hour > 12) {
                final parts = dateTimeStr
                    .split(':')
                    .where((element) => element.isNotEmpty)
                    .toList();
                parts[0] = '${(hour - 12).toInt()}';
                dateTimeStr = parts.join(':');
              }
              dateTimeStr += ' PM';
            }
          }

          final dateTime = parseTime(dateTimeStr, context);

          if (dateTime != null) {
            final date = DateTime.now();
            final selectedDate = DateTime(
              date.year,
              date.month,
              date.day,
              dateTime.hour,
              dateTime.minute,
              dateTime.second,
            ).toUtc();

            widget.onSelected(selectedDate);

            setState(() {
              _pendingValue = formatDate(
                  selectedDate.toIso8601String(), context,
                  showTime: true, showDate: false);
            });
          }
        }
      },
    );
  }
}
