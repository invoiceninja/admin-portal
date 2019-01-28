import 'dart:math';

import 'package:charts_common/common.dart';
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
import 'package:invoiceninja_flutter/data/models/entities.dart';

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
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(fontSize: 18),
                      ),
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

  Widget _buildChart(
      {BuildContext context,
      String title,
      List<ChartDataGroup> currentData,
      List<ChartDataGroup> previousData,
      bool isLoaded}) {
    if (!isLoaded) {
      return LoadingIndicator(useCard: true);
    }

    final localization = AppLocalization.of(context);
    final settings = viewModel.dashboardUIState;
    final state = viewModel.state;

    currentData.forEach((dataGroup) {
      final index = currentData.indexOf(dataGroup);
      dataGroup.chartSeries = <Series<dynamic, DateTime>>[
        charts.Series<ChartMoneyData, DateTime>(
          domainFn: (ChartMoneyData chartData, _) => chartData.date,
          measureFn: (ChartMoneyData chartData, _) => chartData.amount,
          colorFn: (ChartMoneyData chartData, _) =>
              charts.MaterialPalette.blue.shadeDefault,
          id: DashboardChart.PERIOD_CURRENT,
          displayName: settings.enableComparison ? localization.current : title,
          data: dataGroup.rawSeries,
        )
      ];

      if (settings.enableComparison) {
        final List<ChartMoneyData> previous = [];
        final currentSeries = dataGroup.rawSeries;
        final previousSeries = previousData[index].rawSeries;

        dataGroup.previousTotal = previousData[index].total;

        for (int i = 0;
            i < min(currentSeries.length, previousSeries.length);
            i++) {
          previous.add(
              ChartMoneyData(currentSeries[i].date, previousSeries[i].amount));
        }

        dataGroup.chartSeries.add(
          charts.Series<ChartMoneyData, DateTime>(
            domainFn: (ChartMoneyData chartData, _) => chartData.date,
            measureFn: (ChartMoneyData chartData, _) => chartData.amount,
            colorFn: (ChartMoneyData chartData, _) =>
                charts.MaterialPalette.gray.shadeDefault,
            id: DashboardChart.PERIOD_PREVIOUS,
            displayName: localization.previous,
            data: previous,
          ),
        );
      }
    });

    return DashboardChart(
      data: currentData,
      title: title,
      currencyId: settings.currencyId > 0
          ? settings.currencyId
          : state.selectedCompany.currencyId,
    );
  }

  Widget _invoiceChart(BuildContext context) {
    final isLoaded = viewModel.state.invoiceState.isLoaded;
    final settings = viewModel.dashboardUIState;
    final state = viewModel.state;
    final currentData = memoizedChartInvoices(state.selectedCompany, settings,
        state.invoiceState.map, state.clientState.map);

    List<ChartDataGroup> previousData;
    if (settings.enableComparison) {
      previousData = memoizedChartInvoices(
          state.selectedCompany,
          settings.rebuild((b) => b..offset += 1),
          state.invoiceState.map,
          state.clientState.map);
    }

    return _buildChart(
        context: context,
        currentData: currentData,
        previousData: previousData,
        isLoaded: isLoaded,
        title: AppLocalization.of(context).invoices);
  }

  Widget _paymentChart(BuildContext context) {
    final isLoaded = viewModel.state.paymentState.isLoaded;
    final settings = viewModel.dashboardUIState;
    final state = viewModel.state;
    final currentData = memoizedChartPayments(
        state.selectedCompany,
        settings,
        state.invoiceState.map,
        state.clientState.map,
        viewModel.state.paymentState.map);

    List<ChartDataGroup> previousData;
    if (settings.enableComparison) {
      previousData = memoizedChartPayments(
          state.selectedCompany,
          settings.rebuild((b) => b..offset += 1),
          state.invoiceState.map,
          state.clientState.map,
          viewModel.state.paymentState.map);
    }

    return _buildChart(
        context: context,
        currentData: currentData,
        previousData: previousData,
        isLoaded: isLoaded,
        title: AppLocalization.of(context).payments);
  }

  Widget _quoteChart(BuildContext context) {
    final settings = viewModel.dashboardUIState;
    final state = viewModel.state;
    final isLoaded = state.quoteState.isLoaded;
    final currentData = memoizedChartQuotes(state.selectedCompany, settings,
        state.quoteState.map, state.clientState.map);

    List<ChartDataGroup> previousData;
    if (settings.enableComparison) {
      previousData = memoizedChartQuotes(
          state.selectedCompany,
          settings.rebuild((b) => b..offset += 1),
          state.quoteState.map,
          state.clientState.map);
    }

    return _buildChart(
        context: context,
        currentData: currentData,
        previousData: previousData,
        isLoaded: isLoaded,
        title: AppLocalization.of(context).quotes);
  }

  Widget _taskChart(BuildContext context) {
    final settings = viewModel.dashboardUIState;
    final state = viewModel.state;
    final isLoaded = state.taskState.isLoaded;

    final currentData = memoizedChartTasks(
        state.selectedCompany,
        settings,
        state.taskState.map,
        state.invoiceState.map,
        state.projectState.map,
        state.clientState.map);

    List<ChartDataGroup> previousData;
    if (settings.enableComparison) {
      previousData = memoizedChartTasks(
          state.selectedCompany,
          settings.rebuild((b) => b..offset += 1),
          state.taskState.map,
          state.invoiceState.map,
          state.projectState.map,
          state.clientState.map);
    }

    return _buildChart(
        context: context,
        currentData: currentData,
        previousData: previousData,
        isLoaded: isLoaded,
        title: AppLocalization.of(context).tasks);
  }

  @override
  Widget build(BuildContext context) {
    final state = viewModel.state;
    final company = state.selectedCompany;

    return Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            SizedBox(
              height: 74.0,
            ),
            _invoiceChart(context),
            _paymentChart(context),
            company.isModuleEnabled(EntityType.quote)
                ? _quoteChart(context)
                : SizedBox(),
            company.isModuleEnabled(EntityType.task)
                ? _taskChart(context)
                : SizedBox(),
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
