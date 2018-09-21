import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:invoiceninja_flutter/utils/formatting.dart';

class DashboardChart extends StatefulWidget {
  const DashboardChart(
      {this.series, this.amount, this.previousAmount, this.title});

  final List<charts.Series> series;
  final double previousAmount;
  final double amount;
  final String title;

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

    final bool isIncrease = widget.amount >= widget.previousAmount;
    final String changeAmount = (isIncrease ? '+' : '') +
        formatNumber(widget.amount - widget.previousAmount, context);
    final changePercent = (isIncrease ? '+' : '-') +
        formatNumber(widget.previousAmount / widget.amount * 100, context,
            formatNumberType: FormatNumberType.percent);
    final String changeString = widget.amount == 0 || widget.previousAmount == 0
        ? ''
        : '$changeAmount ($changePercent)';

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
                        Text(widget.title,
                            style: Theme.of(context).textTheme.subhead),
                        Row(
                          children: <Widget>[
                            Text(formatNumber(widget.amount, context),
                                style: Theme.of(context).textTheme.headline),
                            SizedBox(width: 12.0),
                            Text(
                              changeString,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: isIncrease ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                  _title != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
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
