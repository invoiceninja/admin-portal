import 'package:invoiceninja_flutter/redux/dashboard/dashboard_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_vm.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DashboardPanels extends StatelessWidget {
  final DashboardVM viewModel;

  const DashboardPanels({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  void _showDateOptions(BuildContext context) {
    print('show date options');
  }

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
    /*
    final data = [
      new ChartMoneyData1(0, 0.0),
      new ChartMoneyData1(10, 10.0),
      //new ChartMoneyData(20, 20),
      new ChartMoneyData1(30, 30.0),
    ];
    */

    final data = chartOutstandingInvoices(viewModel.state.invoiceState.map);

    final series = [
      charts.Series<ChartMoneyData, DateTime>(
        domainFn: (ChartMoneyData clickData, _) => clickData.date,
        measureFn: (ChartMoneyData clickData, _) => clickData.amount,
        colorFn: (ChartMoneyData clickData, _) =>
            charts.MaterialPalette.blue.shadeDefault,
        id: 'Clicks',
        data: data,
      ),
    ];

    final chart = charts.TimeSeriesChart(
      series,
      animate: true,
      selectionModels: [
        new charts.SelectionModelConfig(
          type: charts.SelectionModelType.info,
          listener: _onSelectionChanged,
        )
      ],
      /*
      behaviors: [
        charts.RangeAnnotation([
          charts.RangeAnnotationSegment<dynamic>(
              DateTime(2018, 09, 4),
              DateTime(2018, 09, 17),
              charts.RangeAnnotationAxisType.values),
        ]),
      ],
      */
    );

    return FormCard(
      children: <Widget>[
        Padding(
          padding: new EdgeInsets.all(14.0),
          child: new SizedBox(
            height: 200.0,
            child: chart,
          ),
        )
      ],
    );
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