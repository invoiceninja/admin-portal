// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    Key? key,
    required this.onSelected,
    required this.selectedDate,
    this.labelText,
    this.validator,
    this.autoValidate = false,
    this.allowClearing = false,
    this.message,
    this.firstDate,
    this.autofocus = false,
    this.hint,
  }) : super(key: key);

  final String? labelText;
  final String? selectedDate;
  final Function(String, bool) onSelected;
  final Function(String)? validator;
  final bool autoValidate;
  final bool allowClearing;
  final String? message;
  final DateTime? firstDate;
  final bool autofocus;
  final String? hint;

  @override
  _DatePickerState createState() => new _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
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
    if ((widget.selectedDate ?? '').isNotEmpty) {
      _textController.text = formatDate(widget.selectedDate, context);
    }

    super.didChangeDependencies();
  }

  void _onFoucsChanged() {
    if (!_focusNode.hasFocus) {
      _textController.text = formatDate(widget.selectedDate, context);

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

  void _showDatePicker() async {
    DateTime firstDate = DateTime.now();
    final DateTime initialDate =
        widget.selectedDate != null && widget.selectedDate!.isNotEmpty
            ? DateTime.tryParse(widget.selectedDate!)!
            : DateTime.now();

    if (widget.firstDate != null) {
      if (initialDate.isBefore(firstDate)) {
        firstDate = initialDate;
      }
    } else {
      firstDate = DateTime(1920, 1);
    }

    final store = StoreProvider.of<AppState>(context);
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: DateTime(2101),
      locale: AppLocalization.createLocale(localeSelector(store.state)),
      //initialEntryMode: DatePickerEntryMode.input,
    );

    if (selectedDate != null) {
      final date = convertDateTimeToSqlDate(selectedDate);
      _textController.text = formatDate(date, navigatorKey.currentContext);
      widget.onSelected(date, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var label = widget.labelText ?? '';
    if (widget.message != null && (widget.selectedDate ?? '').isEmpty) {
      label += ' • ${widget.message}';
    }

    return DecoratedFormField(
      autofocus: widget.autofocus,
      focusNode: _focusNode,
      validator: widget.validator,
      controller: _textController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: widget.hint ?? '',
        labelText: _pendingValue ?? label,
        suffixIcon:
            widget.allowClearing && (widget.selectedDate ?? '').isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _textController.text = '';
                      widget.onSelected('', false);
                    },
                  )
                : IconButton(
                    icon: Icon(Icons.date_range),
                    onPressed: () => _showDatePicker(),
                  ),
      ),
      onChanged: (value) {
        if (value.isEmpty) {
          widget.onSelected('', false);
        } else {
          String date = '';
          final dateAsNumber = value.replaceAll('/', '').replaceAll('\\', '');
          if (value.startsWith('+') || value.startsWith('-')) {
            date = convertDateTimeToSqlDate(
                DateTime.now().add(Duration(days: parseInt(value)!)));
          } else if (isAllDigits(dateAsNumber) || value.length <= 5) {
            String firstPart = '01';
            String secondPart = '01';
            int? year = DateTime.now().year;
            if (value.contains('/')) {
              final parts = value.split('/');
              if (parts[0].length == 1) {
                firstPart = '0' + parts[0];
              } else {
                firstPart = parts[0];
              }
              if (parts[1].length == 1) {
                secondPart = '0' + parts[1];
              } else {
                secondPart = parts[1];
              }
              if (parts.length == 3) {
                year = parseInt(parts[2]);
                if (year! < 100) {
                  year += 2000;
                }
              }
            } else if (value.contains('\\')) {
              final parts = value.split('\\');
              if (parts[0].length == 1) {
                secondPart = '0' + parts[0];
              } else {
                secondPart = parts[0];
              }
              if (parts[1].length == 1) {
                firstPart = '0' + parts[1];
              } else {
                firstPart = parts[1];
              }
              if (parts.length == 3) {
                year = parseInt(parts[2]);
                if (year! < 100) {
                  year += 2000;
                }
              }
            } else {
              value = value.replaceAll(RegExp(r'[^0-9]'), '');

              if (value.length <= 2) {
                if (value.length == 1) {
                  value = '0$value';
                }

                firstPart = value;
              } else if (value.length == 3) {
                if (value.substring(0, 1) == '0') {
                  firstPart = value.substring(0, 2);
                  secondPart = '0' + value.substring(2, 3);
                } else {
                  firstPart = '0' + value.substring(0, 1);
                  secondPart = value.substring(1, 3);
                }
              } else {
                if (value.length == 5) {
                  value = '0$value';
                }

                firstPart = value.substring(0, 2);
                secondPart = value.substring(2, 4);

                if (value.length == 6) {
                  year = int.tryParse(value.substring(4, 6));
                  if (year! < 30) {
                    year += 2000;
                  } else {
                    year += 1900;
                  }
                } else if (value.length == 8) {
                  year = int.tryParse(value.substring(4, 8));
                }
              }
            }

            final month = firstPart;
            final day = secondPart;

            final state = StoreProvider.of<AppState>(context).state;
            final countryId = state.company.settings.countryId;

            value = [
              kCountryUnitedStates,
              kCountryCanada,
            ].contains(countryId)
                ? '$month$day'
                : '$day$month';

            if (value.length == 4) {
              value = '$year$value';
            }

            date = convertDateTimeToSqlDate(DateTime.tryParse(value));
          } else {
            try {
              date = parseDate(value, context);
            } catch (e) {
              return;
            }
          }

          if (widget.firstDate != null) {
            final firstDateSql = convertDateTimeToSqlDate(widget.firstDate);
            if (firstDateSql.compareTo(date) > 0) {
              date = firstDateSql;
            }
          }

          if (date.isNotEmpty) {
            widget.onSelected(date, true);
          }

          setState(() {
            _pendingValue = formatDate(date, context);
          });
        }
      },
    );
  }
}
