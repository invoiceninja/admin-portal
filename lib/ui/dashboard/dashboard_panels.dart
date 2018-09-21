import 'package:invoiceninja_flutter/redux/dashboard/dashboard_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_range_picker.dart';
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
          return DateRangePicker(
              state: viewModel.dashboardUIState,
              onSettingsChanged: viewModel.onSettingsChanged);
        });
  }

  Widget _header(BuildContext context) {
    final uiState = viewModel.dashboardUIState;

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
                    Flexible(
                      child: Text(
                          formatDateRange(
                              uiState.startDate, uiState.endDate, context),
                          style: Theme.of(context).textTheme.title),
                    ),
                    SizedBox(width: 6.0),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
              onTap: () => _showDateOptions(context),
            ),
          ),
          SizedBox(width: 8.0),
          IconButton(
            icon: Icon(Icons.navigate_before),
            onPressed: () => viewModel.onOffsetChanged(1),
          ),
          SizedBox(width: 8.0),
          IconButton(
            icon: Icon(Icons.navigate_next),
            onPressed: () =>
                viewModel.isNextEnabled ? viewModel.onOffsetChanged(-1) : null,
          ),
          SizedBox(width: 8.0),
        ],
      ),
    );
  }

  Widget _invoiceChart(BuildContext context) {
    final localization = AppLocalization.of(context);

    final data = memoizedChartOutstandingInvoices(
        viewModel.dashboardUIState, viewModel.state.invoiceState.map);

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

    double total = 0.0;
    data.forEach((dynamic item) {
      total += item.amount;
    });

    return DashboardChart(
        series: series,
        heading: localization.invoices,
        subheading: formatNumber(total, context));
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
  const DashboardChart({this.series, this.heading, this.subheading});

  final List<charts.Series> series;
  final String heading;
  final String subheading;

  @override
  _DashboardChartState createState() => _DashboardChartState();
}

class _DashboardChartState extends State<DashboardChart> {
  String _title;
  String _subtitle;

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
        _title = null;
        _subtitle = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
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
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(widget.heading,
                            style: Theme.of(context).textTheme.subhead),
                        Text(widget.subheading,
                            style: Theme.of(context).textTheme.headline),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                  _title != null
                      ? Column(
                          children: <Widget>[
                            Text(_subtitle,
                                style: Theme.of(context).textTheme.subhead),
                            Text(_title,
                                style: Theme.of(context).textTheme.headline),
                          ],
                        )
                      : Container(),
                ],
              ),
              SizedBox(
                height: 200.0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: chart,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
