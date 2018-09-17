import 'package:invoiceninja_flutter/redux/dashboard/dashboard_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_vm.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:invoiceninja_flutter/utils/localization.dart';

class DashboardPanels extends StatelessWidget {
  final DashboardVM viewModel;

  const DashboardPanels({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  void _showDateOptions(BuildContext context) {
    print('show date options');
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
              onTap: () {},
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
    final data = chartOutstandingInvoices(viewModel.state.invoiceState.map);

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
  void _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    DateTime date;
    final measures = <String, num>{};

    if (selectedDatum.isNotEmpty) {
      date = selectedDatum.first.datum.date;
      selectedDatum.forEach((charts.SeriesDatum datumPair) {
        measures[datumPair.series.displayName] = datumPair.datum.amount;
      });
    }

    print('time: $date');
    print('measure: $measures');
  }

  @override
  Widget build(BuildContext context) {
    final chart = charts.TimeSeriesChart(
      widget.series,
      animate: true,
      selectionModels: [
        new charts.SelectionModelConfig(
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
                chart,
                Text('tst'),
              ],
            ),
          ),
        )
      ],
    );
  }
}
