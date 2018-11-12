import 'dart:math';

import 'package:invoiceninja_flutter/redux/dashboard/dashboard_selectors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_range_picker.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_chart.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_vm.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/company/company_selectors.dart';

class DashboardPanels extends StatelessWidget {
  const DashboardPanels({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final DashboardVM viewModel;

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
    final state = viewModel.state;
    final company = state.selectedCompany;
    final clientMap = state.clientState.map;
    final currencyMap = state.staticState.currencyMap;

    return Material(
      color: Theme.of(context).backgroundColor,
      elevation: 6.0,
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
                          formatDateRange(uiState.startDate(company),
                              uiState.endDate(company), context),
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
            onPressed: viewModel.isNextEnabled
                ? () => viewModel.onOffsetChanged(-1)
                : null,
          ),
          SizedBox(width: 8.0),
          memoizedHasMultipleCurrencies(company, clientMap)
              ? Row(
                  children: <Widget>[
                    DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        items: memoizedGetCurrencyIds(company, clientMap)
                            .map((currencyId) => DropdownMenuItem<int>(
                                  child: Text(currencyMap[currencyId].code),
                                  value: currencyId,
                                ))
                            .toList(),
                        onChanged: (currencyId) =>
                            viewModel.onCurrencyChanged(currencyId),
                        value: state.dashboardUIState.currencyId,
                      ),
                    ),
                    SizedBox(width: 16.0),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _invoiceChart(BuildContext context) {
    if (!viewModel.state.invoiceState.isLoaded) {
      return LoadingIndicator(useCard: true);
    }

    final localization = AppLocalization.of(context);
    final settings = viewModel.dashboardUIState;
    final state = viewModel.state;

    final data = memoizedChartOutstandingInvoices(state.selectedCompany,
        settings, state.invoiceState.map, state.clientState.map);

    data.forEach((dataGroup) {
      dataGroup.chartSeries = charts.Series<ChartMoneyData, DateTime>(
        domainFn: (ChartMoneyData chartData, _) => chartData.date,
        measureFn: (ChartMoneyData chartData, _) => chartData.amount,
        colorFn: (ChartMoneyData chartData, _) =>
            charts.MaterialPalette.blue.shadeDefault,
        id: DashboardChart.PERIOD_CURRENT,
        displayName: settings.enableComparison
            ? localization.current
            : localization.invoices,
        data: dataGroup.rawSeries,
      );

      if (settings.enableComparison) {
        final offsetData = memoizedChartOutstandingInvoices(
            state.selectedCompany,
            settings.rebuild((b) => b..offset += 1),
            state.invoiceState.map,
            state.clientState.map);

        final List<ChartMoneyData> previousData = [];
        for (int i = 0;
            i < min(dataGroup.rawSeries.length, offsetData.length);
            i++) {
          previousData.add(ChartMoneyData(dataGroup.rawSeries[i].date,
              offsetData[data.indexOf(dataGroup)].rawSeries[i].amount));
        }

        /*
        dataGroup.chartSeries.add(
          charts.Series<ChartMoneyData, DateTime>(
            domainFn: (ChartMoneyData chartData, _) => chartData.date,
            measureFn: (ChartMoneyData chartData, _) => chartData.amount,
            colorFn: (ChartMoneyData chartData, _) =>
                charts.MaterialPalette.gray.shadeDefault,
            id: DashboardChart.PERIOD_PREVIOUS,
            displayName: localization.previous,
            data: previousData,
          ),
        );
        */
      }
    });

    return DashboardChart(
      data: data,
      title: localization.invoices,
      currencyId: settings.currencyId > 0
          ? settings.currencyId
          : state.selectedCompany.currencyId,
    );
  }

  /*
  Widget _paymentChart(BuildContext context) {
    if (!viewModel.state.paymentState.isLoaded) {
      return LoadingIndicator(useCard: true);
    }

    final localization = AppLocalization.of(context);
    final settings = viewModel.dashboardUIState;
    final state = viewModel.state;

    final data = memoizedChartPayments(
        state.selectedCompany,
        settings,
        state.invoiceState.map,
        state.clientState.map,
        viewModel.state.paymentState.map);

    final series = [
      charts.Series<ChartMoneyData, DateTime>(
        domainFn: (ChartMoneyData chartData, _) => chartData.date,
        measureFn: (ChartMoneyData chartData, _) => chartData.amount,
        colorFn: (ChartMoneyData chartData, _) =>
            charts.MaterialPalette.blue.shadeDefault,
        id: DashboardChart.PERIOD_CURRENT,
        displayName: settings.enableComparison
            ? localization.current
            : localization.payments,
        data: data,
      ),
    ];

    double total = 0.0;
    double previousTotal = 0.0;
    data.forEach((dynamic item) {
      total += item.amount;
    });

    if (settings.enableComparison) {
      final offsetData = memoizedChartPayments(
          state.selectedCompany,
          settings.rebuild((b) => b..offset += 1),
          state.invoiceState.map,
          state.clientState.map,
          state.paymentState.map);

      final List<ChartMoneyData> previousData = [];
      for (int i = 0; i < min(data.length, offsetData.length); i++) {
        previousData.add(ChartMoneyData(data[i].date, offsetData[i].amount));
      }

      series.add(
        charts.Series<ChartMoneyData, DateTime>(
          domainFn: (ChartMoneyData chartData, _) => chartData.date,
          measureFn: (ChartMoneyData chartData, _) => chartData.amount,
          colorFn: (ChartMoneyData chartData, _) =>
              charts.MaterialPalette.gray.shadeDefault,
          id: DashboardChart.PERIOD_PREVIOUS,
          displayName: localization.previous,
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
      title: localization.payments,
      currencyId: settings.currencyId > 0
          ? settings.currencyId
          : state.selectedCompany.currencyId,
    );
  }

  Widget _quoteChart(BuildContext context) {
    if (!viewModel.state.quoteState.isLoaded) {
      return LoadingIndicator(useCard: true);
    }

    if (viewModel.state.quoteState.list.isEmpty) {
      return Container();
    }

    final localization = AppLocalization.of(context);
    final settings = viewModel.dashboardUIState;
    final state = viewModel.state;

    final data = memoizedChartOutstandingQuotes(state.selectedCompany, settings,
        state.quoteState.map, state.clientState.map);

    final series = [
      charts.Series<ChartMoneyData, DateTime>(
        domainFn: (ChartMoneyData chartData, _) => chartData.date,
        measureFn: (ChartMoneyData chartData, _) => chartData.amount,
        colorFn: (ChartMoneyData chartData, _) =>
            charts.MaterialPalette.blue.shadeDefault,
        id: DashboardChart.PERIOD_CURRENT,
        displayName: settings.enableComparison
            ? localization.current
            : localization.quotes,
        data: data,
      ),
    ];

    double total = 0.0;
    double previousTotal = 0.0;
    data.forEach((dynamic item) {
      total += item.amount;
    });

    if (settings.enableComparison) {
      final offsetData = memoizedChartOutstandingQuotes(
          state.selectedCompany,
          settings.rebuild((b) => b..offset += 1),
          state.quoteState.map,
          state.clientState.map);

      final List<ChartMoneyData> previousData = [];
      for (int i = 0; i < min(data.length, offsetData.length); i++) {
        previousData.add(ChartMoneyData(data[i].date, offsetData[i].amount));
      }

      series.add(
        charts.Series<ChartMoneyData, DateTime>(
          domainFn: (ChartMoneyData chartData, _) => chartData.date,
          measureFn: (ChartMoneyData chartData, _) => chartData.amount,
          colorFn: (ChartMoneyData chartData, _) =>
              charts.MaterialPalette.gray.shadeDefault,
          id: DashboardChart.PERIOD_PREVIOUS,
          displayName: localization.previous,
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
      title: localization.quotes,
      currencyId: settings.currencyId > 0
          ? settings.currencyId
          : state.selectedCompany.currencyId,
    );
  }
  */

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            SizedBox(
              height: 74.0,
            ),
            _invoiceChart(context),
            //_paymentChart(context),
            //_quoteChart(context),
          ],
        ),
        ConstrainedBox(
          child: _header(context),
          constraints: BoxConstraints.loose(
            Size(double.infinity, 74.0),
          ),
        ),
      ],
    );
  }
}
