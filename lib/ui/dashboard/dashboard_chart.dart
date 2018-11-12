import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_selectors.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class DashboardChart extends StatefulWidget {
  const DashboardChart({this.data, this.title, this.currencyId});

  final List<ChartDataGroup> data;
  final String title;
  final int currencyId;

  static const PERIOD_CURRENT = 'current';
  static const PERIOD_PREVIOUS = 'previous';

  @override
  _DashboardChartState createState() => _DashboardChartState();
}

class _DashboardChartState extends State<DashboardChart> {
  String _title;
  String _subtitle;
  int _selectedIndex = 0;

  void _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    DateTime date;
    double total = 0.0;
    final measures = <String, num>{};

    if (selectedDatum.isNotEmpty) {
      date = selectedDatum.first.datum.date;
      selectedDatum
          .where((charts.SeriesDatum datumPair) =>
              datumPair.series.id == DashboardChart.PERIOD_CURRENT)
          .forEach((charts.SeriesDatum datumPair) {
        total += datumPair.datum.amount;
        measures[datumPair.series.displayName] = datumPair.datum.amount;
      });
    }

    setState(() {
      if (date != null) {
        _title = formatNumber(total, context, currencyId: widget.currencyId);
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
    final state = StoreProvider.of<AppState>(context).state;
    final color = state.uiState.enableDarkMode
        ? charts.MaterialPalette.white
        : charts.MaterialPalette.gray.shade700;

    final series = widget.data[_selectedIndex];

    final chart = charts.TimeSeriesChart(
      [series.chartSeries],
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
      domainAxis: charts.DateTimeAxisSpec(
          renderSpec: charts.SmallTickRendererSpec(
              labelStyle: charts.TextStyleSpec(color: color),
              lineStyle: charts.LineStyleSpec(color: color))),
      primaryMeasureAxis: charts.NumericAxisSpec(
          renderSpec: charts.GridlineRendererSpec(
              labelStyle: charts.TextStyleSpec(color: color),
              lineStyle: charts.LineStyleSpec(color: color))),
    );

    return FormCard(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(14.0),
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.title,
          ),
        ),
        Divider(height: 1.0),
        Row(
          children: widget.data.map((dataGroup) {
            final int index = widget.data.indexOf(dataGroup);
            final bool isSelected = index == _selectedIndex;
            final bool isIncrease = dataGroup.total >= dataGroup.previousTotal;
            final String changeAmount = (isIncrease ? '+' : '') +
                formatNumber(dataGroup.total - dataGroup.previousTotal, context,
                    currencyId: widget.currencyId);
            final changePercent = (isIncrease ? '+' : '-') +
                formatNumber(
                    dataGroup.total != 0 && dataGroup.previousTotal != 0
                        ? round(
                            (dataGroup.total - dataGroup.previousTotal) /
                                dataGroup.previousTotal *
                                100,
                            2)
                        : 0.0,
                    context,
                    formatNumberType: FormatNumberType.percent,
                    currencyId: widget.currencyId);
            final String changeString =
                dataGroup.total == 0 || dataGroup.previousTotal == 0
                    ? ''
                    : '$changeAmount ($changePercent)';

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: Container(
                color: isSelected ? Colors.blue : Theme.of(context).cardColor,
                padding: EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(localization.lookup(dataGroup.name),
                        style: Theme.of(context).textTheme.subhead.copyWith(
                            color: isSelected ? Colors.white : null,
                            fontWeight: FontWeight.w400)),
                    SizedBox(height: 2.0),
                    Text(
                        formatNumber(dataGroup.total, context,
                            currencyId: widget.currencyId),
                        style: Theme.of(context)
                            .textTheme
                            .headline
                            .copyWith(color: isSelected ? Colors.white : null)),
                    changeString.isNotEmpty
                        ? Text(
                            changeString,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: isSelected
                                  ? Colors.white
                                  : (isIncrease ? Colors.green : Colors.red),
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        Divider(height: 1.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _title != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(_subtitle,
                          style: Theme.of(context).textTheme.subhead),
                      Text(_title, style: Theme.of(context).textTheme.headline),
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
    );
  }
}

class FormCard extends StatelessWidget {
  const FormCard({
    Key key,
    @required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        elevation: 4.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}
