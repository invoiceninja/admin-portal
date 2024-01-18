// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:charts_flutter/flutter.dart' as charts;

// Project imports:
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ReportCharts extends StatelessWidget {
  const ReportCharts({required this.viewModel});

  final ReportsScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final state = viewModel.state;
    final reportState = viewModel.reportState;
    final localization = AppLocalization.of(context);

    if (reportState.chart.isEmpty || reportState.group.isEmpty) {
      return SizedBox();
    }

    final color = state.prefState.enableDarkMode
        ? charts.MaterialPalette.white
        : charts.MaterialPalette.black;

    final numericAxis = charts.NumericAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
            labelStyle: charts.TextStyleSpec(color: color),
            lineStyle: charts.LineStyleSpec(color: color)));

    final ordinalAxis = charts.OrdinalAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
      lineStyle:
          charts.LineStyleSpec(color: charts.MaterialPalette.transparent),
      labelStyle: charts.TextStyleSpec(fontSize: 10, color: color),
      labelRotation: 45,
    ));

    final dateTimeAxis = charts.DateTimeAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
      labelStyle: charts.TextStyleSpec(color: color),
      lineStyle: charts.LineStyleSpec(color: color),
    ));

    Widget? child;
    final columnType = getReportColumnType(reportState.group, context);

    switch (columnType) {
      case ReportColumnType.string:
      case ReportColumnType.bool:
      case ReportColumnType.number:
      case ReportColumnType.age:
      case ReportColumnType.duration:
        child = charts.BarChart(
          [
            charts.Series<dynamic, String>(
                id: 'chart',
                colorFn: (dynamic _, __) =>
                    charts.ColorUtil.fromDartColor(state.accentColor!),
                domainFn: (dynamic item, _) =>
                    columnType == ReportColumnType.age
                        ? localization!.lookup(item['name'])
                        : item['name']!,
                measureFn: (dynamic item, _) => item['value'],
                data: viewModel.groupTotals.rows!.map((key) {
                  return {
                    'name': key,
                    'value':
                        viewModel.groupTotals.totals![key]![reportState.chart]!
                  };
                }).toList())
          ],
          animate: true,
          primaryMeasureAxis: numericAxis,
          domainAxis: ordinalAxis,
        );
        break;
      case ReportColumnType.date:
      case ReportColumnType.dateTime:
        final keys = viewModel.groupTotals.rows!
            .where((element) => element!.isNotEmpty)
            .toList();
        keys.sort((String? str1, String? str2) => str1!.compareTo(str2!));
        child = charts.TimeSeriesChart(
          [
            charts.Series<dynamic, DateTime>(
                id: 'chart',
                colorFn: (dynamic _, __) =>
                    charts.ColorUtil.fromDartColor(state.accentColor!),
                domainFn: (dynamic item, _) => DateTime.parse(item['name']),
                measureFn: (dynamic item, _) => item['value'],
                data: keys.map((key) {
                  return {
                    'name': key,
                    'value':
                        viewModel.groupTotals.totals![key]![reportState.chart]
                  };
                }).toList())
          ],
          animate: true,
          primaryMeasureAxis: numericAxis,
          domainAxis: dateTimeAxis,
          /*
          behaviors: [
            charts.SeriesLegend(
              outsideJustification: charts.OutsideJustification.endDrawArea,
            )
          ],
           */
        );
        break;
    }

    return FormCard(
      child: ClipRect(
        child: SizedBox(
          height: 200,
          child: child,
        ),
      ),
    );
  }
}
