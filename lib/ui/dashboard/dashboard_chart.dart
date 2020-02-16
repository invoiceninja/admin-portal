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
  final String currencyId;

  static const PERIOD_CURRENT = 'current';
  static const PERIOD_PREVIOUS = 'previous';

  @override
  _DashboardChartState createState() => _DashboardChartState();
}

class _DashboardChartState extends State<DashboardChart> {
  String _selected;
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
        _selected = formatDate(date.toIso8601String(), context) +
            ' • ' +
            formatNumber(total, context, currencyId: widget.currencyId);
      } else {
        _selected = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;
    final color = state.prefState.enableDarkMode
        ? charts.MaterialPalette.white
        : charts.MaterialPalette.gray.shade700;

    final series = widget.data[_selectedIndex];

    final chart = charts.TimeSeriesChart(
      series.chartSeries,
      animate: true,
      selectionModels: [
        charts.SelectionModelConfig(
          type: charts.SelectionModelType.info,
          changedListener: _onSelectionChanged,
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
            lineStyle: charts.LineStyleSpec(color: color)),
      ),
    );

    return FormCard(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(14.0),
          child: Text(
            widget.title,
            style: theme.textTheme.headline5,
          ),
        ),
        Divider(height: 1.0),
        Container(
          width: double.infinity,
          height: state.dashboardUIState.enableComparison ? 106 : 86,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: widget.data.map((dataGroup) {
              final int index = widget.data.indexOf(dataGroup);
              final bool isSelected = index == _selectedIndex;
              final bool isIncrease = dataGroup.total > dataGroup.previousTotal;
              final String changeAmount = (isIncrease ? '+' : '') +
                  formatNumber(
                      dataGroup.total - dataGroup.previousTotal, context,
                      currencyId: widget.currencyId);
              final changePercent = (isIncrease ? '+' : '') +
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
              final String changeString = dataGroup.total == 0 ||
                      dataGroup.previousTotal == 0 ||
                      dataGroup.total == dataGroup.previousTotal
                  ? (state.dashboardUIState.enableComparison ? ' ' : '')
                  : '$changeAmount ($changePercent)';

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                    _selected = null;
                  });
                },
                child: Container(
                  color: isSelected ? Colors.blue : theme.cardColor,
                  padding:
                      EdgeInsets.only(left: 16, top: 8, right: 32, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(localization.lookup(dataGroup.name),
                          style: theme.textTheme.headline5.copyWith(
                              color: isSelected ? Colors.white : null,
                              fontWeight: FontWeight.w400)),
                      SizedBox(height: 4.0),
                      Text(
                          formatNumber(dataGroup.total, context,
                              currencyId: widget.currencyId),
                          style: theme.textTheme.headline5.copyWith(
                              color: isSelected ? Colors.white : null)),
                      SizedBox(height: 2.0),
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
        ),
        Divider(height: 1.0),
        SizedBox(
          height: 240.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRect(
              child: chart,
            ),
          ),
        ),
        Divider(height: 1.0),
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Text(
                  localization.average +
                      ': ' +
                      formatNumber(series.average, context,
                          currencyId: widget.currencyId),
                  style: theme.textTheme.headline5,
                ),
              ),
              _selected != null
                  ? Text(
                      _selected,
                      style: theme.textTheme.headline5,
                    )
                  : SizedBox(),
            ],
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
