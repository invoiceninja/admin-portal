import 'package:invoiceninja_flutter/redux/dashboard/dashboard_selectors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_range_picker.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_chart.dart';
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
    final settings = viewModel.dashboardUIState;

    final data = memoizedChartOutstandingInvoices(
        settings, viewModel.state.invoiceState.map);

    final series = [
      charts.Series<ChartMoneyData, DateTime>(
        domainFn: (ChartMoneyData clickData, _) => clickData.date,
        measureFn: (ChartMoneyData clickData, _) => clickData.amount,
        colorFn: (ChartMoneyData clickData, _) =>
            charts.MaterialPalette.blue.shadeDefault,
        id: 'invoices',
        displayName: settings.enableComparison
            ? localization.currentPeriod
            : localization.invoices,
        data: data,
      ),
    ];

    double total = 0.0;
    double previousTotal = 0.0;
    data.forEach((dynamic item) {
      total += item.amount;
    });

    if (settings.enableComparison) {
      final offsetData = memoizedChartOutstandingInvoices(
          viewModel.dashboardUIState.rebuild((b) => b..offset += 1),
          viewModel.state.invoiceState.map);

      final List<ChartMoneyData> previousData = [];
      for (int i = 0; i < data.length; i++) {
        previousData.add(ChartMoneyData(data[i].date, offsetData[i].amount));
      }

      series.add(
        charts.Series<ChartMoneyData, DateTime>(
          domainFn: (ChartMoneyData clickData, _) => clickData.date,
          measureFn: (ChartMoneyData clickData, _) => clickData.amount,
          colorFn: (ChartMoneyData clickData, _) =>
              charts.MaterialPalette.gray.shadeDefault,
          id: 'previous',
          displayName: localization.previousPeriod,
          data: previousData,
        ),
      );

      previousData.forEach((dynamic item) {
        previousTotal += item.amount;
      });
    }

    return DashboardChart(
        series: series,
        amount: total,
        previousAmount: previousTotal,
        title: localization.invoices);
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

