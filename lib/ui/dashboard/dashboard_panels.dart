import 'package:invoiceninja_flutter/redux/dashboard/dashboard_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_vm.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class DashboardPanels extends StatelessWidget {
  final DashboardVM viewModel;

  const DashboardPanels({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  void _showDateOptions(BuildContext context) {
    showDialog<DateRangePicker>(
        context: context,
        builder: (BuildContext context) {
          return DateRangePicker();
        });
  }

  Widget _header(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    Text('Aug 15 - Sep 15',
                        style: Theme.of(context).textTheme.title),
                  ],
                ),
              ),
              onTap: () => _showDateOptions(context),
            ),
          ),
          SizedBox(width: 18.0),
          IconButton(
              icon: Icon(Icons.navigate_before),
              onPressed: () {
                print('prev');
              }),
          SizedBox(width: 8.0),
          IconButton(
              icon: Icon(Icons.navigate_next),
              onPressed: () {
                print('next');
              }),
          SizedBox(width: 8.0),
        ],
      ),
    );
  }

  Widget _invoiceChart(BuildContext context) {
    final localization = AppLocalization.of(context);
    final data =
        memoizedChartOutstandingInvoices(viewModel.state.invoiceState.map);

    final series = [
      charts.Series<ChartMoneyData, DateTime>(
        domainFn: (ChartMoneyData clickData, _) => clickData.date,
        measureFn: (ChartMoneyData clickData, _) => clickData.amount,
        colorFn: (ChartMoneyData clickData, _) =>
            charts.MaterialPalette.blue.shadeDefault,
        id: 'invoices',
        displayName: localization.invoices,
        data: data,
      ),
    ];

    return DashboardChart(series);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _header(context),
        _invoiceChart(context),
      ],
    );
  }
}

class DashboardChart extends StatefulWidget {
  const DashboardChart(this.series);

  final List<charts.Series> series;

  @override
  _DashboardChartState createState() => _DashboardChartState();
}

class _DashboardChartState extends State<DashboardChart> {
  String _title;
  String _titleOrig;

  String _subtitle;
  String _subtitleOrig;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final series = widget.series[0];
    final data = series.data;

    double total = 0.0;
    data.forEach((dynamic item) {
      total += item.amount;
    });

    _title = _titleOrig = formatNumber(total, context);
    //_subtitle = _subtitleOrig = series.displayName;
    _subtitle = _subtitleOrig = '';
  }

  void _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    DateTime date;
    double total = 0.0;
    final measures = <String, num>{};

    if (selectedDatum.isNotEmpty) {
      date = selectedDatum.first.datum.date;
      selectedDatum.forEach((charts.SeriesDatum datumPair) {
        total += datumPair.datum.amount;
        measures[datumPair.series.displayName] = datumPair.datum.amount;
      });
    }

    setState(() {
      if (date != null) {
        _title = formatNumber(total, context);
        _subtitle = formatDate(date.toIso8601String(), context);
      } else {
        _title = _titleOrig;
        _subtitle = _subtitleOrig;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chart = charts.TimeSeriesChart(
      widget.series,
      animate: true,
      selectionModels: [
        charts.SelectionModelConfig(
          type: charts.SelectionModelType.info,
          listener: _onSelectionChanged,
        )
      ],
      behaviors: [
        charts.SeriesLegend(
          outsideJustification: charts.OutsideJustification.endDrawArea,
        )
      ],
    );

    return FormCard(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(14.0),
          child: SizedBox(
            height: 200.0,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: chart,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(_title, style: Theme.of(context).textTheme.title),
                    Text(_subtitle, style: Theme.of(context).textTheme.subhead),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class DateRangePicker extends StatefulWidget {
  @override
  _DateRangePickerState createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  DateRange _dateRange;
  String _startDate;
  String _endDate;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: <Widget>[
          Material(
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DropdownButton<DateRange>(
                    items: DateRange.values
                        .map((dateRange) => DropdownMenuItem<DateRange>(
                              child: Text(localization
                                  .lookup(dateRange.toString().split('.')[1])),
                              value: dateRange,
                            ))
                        .toList(),
                    onChanged: (dateRange) {
                      print('set date range to: $dateRange');
                      setState(() => _dateRange = dateRange);
                    },
                    value: _dateRange,
                  ),
                  _dateRange != DateRange.custom
                      ? Container()
                      : DatePicker(
                          labelText: localization.startDate,
                          onSelected: (date) => _startDate = date,
                        ),
                  _dateRange != DateRange.custom
                      ? Container()
                      : DatePicker(
                          labelText: localization.endDate,
                          onSelected: (date) => _endDate = date,
                        ),
                  SwitchListTile(
                    value: true,
                    title: Text(localization.compareTo),
                    selected: true,
                  ),
                ],
              ),
            ),
          ),
        ]));
  }
}
