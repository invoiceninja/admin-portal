import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_state.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/responsive_padding.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class DateRangePicker extends StatefulWidget {
  const DateRangePicker({Key key, this.state, this.onSettingsChanged})
      : super(key: key);

  final DashboardUIState state;
  final Function(DashboardSettings) onSettingsChanged;

  @override
  _DateRangePickerState createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  DashboardSettings _settings;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _settings = DashboardSettings.fromState(widget.state);

    if (_settings.dateRange != DateRange.custom) {
      _settings.startDate = '';
      _settings.endDate = convertDateTimeToSqlDate();
    }

    if (_settings.compareDateRange != DateRangeComparison.customRange) {
      _settings.compareStartDate = '';
      _settings.compareEndDate = convertDateTimeToSqlDate();
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    return ResponsivePadding(
        child: Column(children: <Widget>[
      Material(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Text(localization.dateRange,
                      style: Theme.of(context).textTheme.headline6),
                  SizedBox(height: 16.0),
                  Row(
                    children: <Widget>[
                      DropdownButtonHideUnderline(
                        child: DropdownButton<DateRange>(
                          items: DateRange.values
                              .map((dateRange) => DropdownMenuItem<DateRange>(
                                    child: Text(localization
                                        .lookup(dateRange.toString())),
                                    value: dateRange,
                                  ))
                              .toList(),
                          onChanged: (dateRange) {
                            setState(() => _settings.dateRange = dateRange);
                          },
                          value: _settings.dateRange,
                        ),
                      ),
                      Expanded(child: Container()),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                          Text(localization.compare),
                          Switch(
                            value: _settings.enableComparison,
                            activeColor: Theme.of(context).accentColor,
                            onChanged: (value) {
                              setState(
                                  () => _settings.enableComparison = value);
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                  _settings.dateRange != DateRange.custom
                      ? Container()
                      : DatePicker(
                          selectedDate: _settings.startDate,
                          labelText: localization.startDate,
                          onSelected: (date) => _settings.startDate = date,
                        ),
                  _settings.dateRange != DateRange.custom
                      ? Container()
                      : DatePicker(
                          selectedDate: _settings.endDate,
                          labelText: localization.endDate,
                          onSelected: (date) => _settings.endDate = date,
                        ),
                  SizedBox(height: 6.0),
                  _settings.enableComparison
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            DropdownButtonHideUnderline(
                              child: DropdownButton<DateRangeComparison>(
                                items: DateRangeComparison.values
                                    .map((dateRange) =>
                                        DropdownMenuItem<DateRangeComparison>(
                                          child: Text(localization
                                              .lookup(dateRange.toString())),
                                          value: dateRange,
                                        ))
                                    .toList(),
                                onChanged: (dateRange) {
                                  setState(() =>
                                      _settings.compareDateRange = dateRange);
                                },
                                value: _settings.compareDateRange,
                              ),
                            ),
                            _settings.compareDateRange !=
                                    DateRangeComparison.customRange
                                ? Container()
                                : DatePicker(
                                    labelText: localization.startDate,
                                    selectedDate: _settings.compareStartDate,
                                    onSelected: (date) =>
                                        _settings.compareStartDate = date,
                                  ),
                            _settings.compareDateRange !=
                                    DateRangeComparison.customRange
                                ? Container()
                                : DatePicker(
                                    labelText: localization.endDate,
                                    selectedDate: _settings.compareEndDate,
                                    onSelected: (date) =>
                                        _settings.compareEndDate = date,
                                  ),
                          ],
                        )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ElevatedButton(
                          label: localization.done,
                          onPressed: () {
                            // TODO replace with form validation
                            if (_settings.dateRange == DateRange.custom &&
                                _settings.startDate
                                        .compareTo(_settings.endDate) ==
                                    1) {
                              showDialog<ErrorDialog>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ErrorDialog(
                                        'Date range is not valid');
                                  });
                              return;
                            }

                            if (_settings.compareDateRange ==
                                    DateRange.custom &&
                                _settings.compareStartDate
                                        .compareTo(_settings.compareEndDate) ==
                                    1) {
                              showDialog<ErrorDialog>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ErrorDialog(
                                        'Comparison date range is not valid');
                                  });
                              return;
                            }

                            widget.onSettingsChanged(_settings);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ]));
  }
}
