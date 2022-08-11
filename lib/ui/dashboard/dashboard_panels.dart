// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:charts_common/common.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/app_border.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/live_text.dart';
import 'package:invoiceninja_flutter/ui/app/review_app.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/company/company_selectors.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_chart.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_date_range_picker.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_screen_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

enum DashboardSections {
  messages,
  runningTasks,
  overview,
  invoices,
  payments,
  quotes,
  tasks,
  expenses,
}

class DashboardPanels extends StatelessWidget {
  const DashboardPanels({
    Key key,
    @required this.viewModel,
    @required this.scrollController,
  }) : super(key: key);

  final DashboardVM viewModel;
  final ScrollController scrollController;

  void _showDateOptions(BuildContext context) {
    showDialog<DashboardDateRangePicker>(
        context: context,
        builder: (BuildContext context) {
          return DashboardDateRangePicker(
              state: viewModel.dashboardUIState,
              onSettingsChanged: viewModel.onSettingsChanged);
        });
  }

  Widget _header(BuildContext context) {
    final state = viewModel.state;
    final company = state.company;
    final clientMap = state.clientState.map;
    final groupMap = state.groupState.map;
    final settings = state.dashboardUIState.settings;

    // Add "All" if more than one currency
    final currencies = memoizedGetCurrencyIds(company, clientMap, groupMap);
    if (currencies.length > 1 && !currencies.contains(kCurrencyAll)) {
      currencies.insert(0, kCurrencyAll);
    }
    final localization = AppLocalization.of(context);
    final hasMultipleCurrencies =
        memoizedHasMultipleCurrencies(company, clientMap, groupMap);

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final isWide = constraints.maxWidth > 500;

      final groupBy = Padding(
        padding: const EdgeInsets.only(left: 16),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            items: [
              DropdownMenuItem(
                child: Text(localization.day),
                value: kReportGroupDay,
              ),
              DropdownMenuItem(
                child: Text(localization.month),
                value: kReportGroupMonth,
              ),
              DropdownMenuItem(
                child: Text(localization.year),
                value: kReportGroupYear,
              ),
            ],
            onChanged: (value) {
              viewModel.onGroupByChanged(value);
              if (!isWide && Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            value: settings.groupBy,
          ),
        ),
      );

      final taxSettings = Padding(
        padding: const EdgeInsets.only(left: 16),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<bool>(
            items: [
              DropdownMenuItem(
                child: Text(localization.gross),
                value: true,
              ),
              DropdownMenuItem(
                child: Text(localization.net),
                value: false,
              ),
            ],
            onChanged: (value) {
              viewModel.onTaxesChanged(value);
              if (!isWide && Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            value: settings.includeTaxes,
          ),
        ),
      );

      final dateRange = PopupMenuButton<DateRange>(
        child: Padding(
          padding: const EdgeInsets.only(left: 4, top: 6, bottom: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child: Text(
                  formatDateRange(settings.startDate(company),
                      settings.endDate(company), context),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              SizedBox(width: 6.0),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
        itemBuilder: (context) => DateRange.values
            .map((dateRange) => PopupMenuItem(
                  child: Text(dateRange == DateRange.custom
                      ? '${localization.more}...'
                      : localization.lookup(dateRange.toString())),
                  value: dateRange,
                ))
            .toList(),
        onSelected: (dateRange) {
          final settings = DashboardSettings.fromState(state.dashboardUIState);
          if (dateRange == DateRange.custom) {
            WidgetsBinding.instance.addPostFrameCallback((duration) {
              _showDateOptions(context);
            });
          } else {
            settings.dateRange = dateRange;
            viewModel.onSettingsChanged(settings);
          }
        },
      );

      Widget currencySettings = SizedBox();
      if (hasMultipleCurrencies) {
        currencySettings = Padding(
          padding: const EdgeInsets.only(left: 16),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              items: memoizedGetCurrencyIds(company, clientMap, groupMap)
                  .map((currencyId) => DropdownMenuItem<String>(
                        child: Text(currencyId == kCurrencyAll
                            ? localization.all
                            : viewModel.currencyMap[currencyId]?.code),
                        value: currencyId,
                      ))
                  .toList(),
              onChanged: (currencyId) {
                viewModel.onCurrencyChanged(currencyId);
                if (!isWide && Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              value: settings.currencyId,
            ),
          ),
        );
      }

      return Material(
        color: Theme.of(context).cardColor,
        elevation: 6.0,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 2),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.navigate_before),
                onPressed: () => viewModel.onOffsetChanged(1),
                visualDensity: VisualDensity.compact,
              ),
              IconButton(
                icon: Icon(Icons.navigate_next),
                onPressed: () => viewModel.onOffsetChanged(-1),
                visualDensity: VisualDensity.compact,
              ),
              SizedBox(width: 4),
              Expanded(child: dateRange),
              if (!isWide)
                IconButton(
                  icon: Icon(MdiIcons.tuneVariant),
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    showDialog<AlertDialog>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(localization.settings),
                            key: ValueKey(
                                '__${settings.includeTaxes}_${settings.currencyId}__'),
                            actions: [
                              TextButton(
                                child: Text(localization.close.toUpperCase()),
                                onPressed: () => Navigator.of(context).pop(),
                              )
                            ],
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Text(localization.groupBy),
                                    Spacer(),
                                    groupBy,
                                  ],
                                ),
                                if (hasMultipleCurrencies)
                                  Row(
                                    children: [
                                      Text(localization.currency),
                                      Spacer(),
                                      currencySettings,
                                    ],
                                  ),
                                if (company.hasTaxes)
                                  Row(
                                    children: [
                                      Text(localization.taxes),
                                      Spacer(),
                                      taxSettings,
                                    ],
                                  ),
                              ],
                            ),
                          );
                        });
                  },
                )
              else ...[
                groupBy,
                if (company.hasTaxes) taxSettings,
                if (hasMultipleCurrencies) currencySettings,
              ],
              if (isDesktop(context) && !state.dashboardUIState.showSidebar)
                IconButton(
                    tooltip: localization.showSidebar,
                    icon: Icon(Icons.view_sidebar),
                    onPressed: () => viewModel.onShowSidebar()),
            ],
          ),
        ),
      );
    });
  }

  Widget _paymentChart({
    @required BuildContext context,
    @required Function(List<String>) onDateSelected,
  }) {
    final settings = viewModel.dashboardUIState.settings;
    final state = viewModel.state;
    final isLoaded = state.isLoaded || state.paymentState.list.isNotEmpty;
    final currentData = memoizedChartPayments(
        state.staticState.currencyMap,
        state.company,
        settings,
        state.invoiceState.map,
        state.clientState.map,
        state.paymentState.map);

    List<ChartDataGroup> previousData;
    if (settings.enableComparison) {
      previousData = memoizedPreviousChartPayments(
          state.staticState.currencyMap,
          state.company,
          settings.rebuild((b) => b..offset += 1),
          state.invoiceState.map,
          state.clientState.map,
          state.paymentState.map);
    }

    return _DashboardPanel(
      viewModel: viewModel,
      currentData: currentData,
      previousData: previousData,
      isLoaded: isLoaded,
      title: AppLocalization.of(context).payments,
      onDateSelected: (index, date) =>
          onDateSelected(currentData[index].entityMap[date]),
    );
  }

  Widget _invoiceChart({
    @required BuildContext context,
    @required Function(List<String>) onDateSelected,
  }) {
    final settings = viewModel.dashboardUIState.settings;
    final state = viewModel.state;
    final isLoaded = state.isLoaded || state.invoiceState.list.isNotEmpty;
    final currentData = memoizedChartInvoices(
      state.staticState.currencyMap,
      state.company,
      settings,
      state.invoiceState.map,
      state.clientState.map,
    );

    List<ChartDataGroup> previousData;
    if (settings.enableComparison) {
      previousData = memoizedPreviousChartInvoices(
        state.staticState.currencyMap,
        state.company,
        settings.rebuild((b) => b..offset += 1),
        state.invoiceState.map,
        state.clientState.map,
      );
    }

    return _DashboardPanel(
      viewModel: viewModel,
      currentData: currentData,
      previousData: previousData,
      isLoaded: isLoaded,
      title: AppLocalization.of(context).invoice,
      onDateSelected: (index, date) =>
          onDateSelected(currentData[index].entityMap[date]),
    );
  }

  Widget _quoteChart({
    @required BuildContext context,
    @required Function(List<String>) onDateSelected,
  }) {
    final settings = viewModel.dashboardUIState.settings;
    final state = viewModel.state;
    final isLoaded = state.isLoaded || state.quoteState.list.isNotEmpty;
    final currentData = memoizedChartQuotes(
      state.staticState.currencyMap,
      state.company,
      settings,
      state.quoteState.map,
      state.clientState.map,
    );

    List<ChartDataGroup> previousData;
    if (settings.enableComparison) {
      previousData = memoizedPreviousChartQuotes(
        state.staticState.currencyMap,
        state.company,
        settings.rebuild((b) => b..offset += 1),
        state.quoteState.map,
        state.clientState.map,
      );
    }

    return _DashboardPanel(
      viewModel: viewModel,
      currentData: currentData,
      previousData: previousData,
      isLoaded: isLoaded,
      title: AppLocalization.of(context).quotes,
      onDateSelected: (index, date) =>
          onDateSelected(currentData[index].entityMap[date]),
    );
  }

  Widget _taskChart({
    @required BuildContext context,
    @required Function(List<String>) onDateSelected,
  }) {
    final settings = viewModel.dashboardUIState.settings;
    final state = viewModel.state;
    final isLoaded = state.isLoaded || state.taskState.list.isNotEmpty;
    final currentData = memoizedChartTasks(
      state.staticState.currencyMap,
      state.company,
      settings,
      state.taskState.map,
      state.invoiceState.map,
      state.projectState.map,
      state.clientState.map,
      state.groupState.map,
    );

    List<ChartDataGroup> previousData;
    if (settings.enableComparison) {
      previousData = memoizedPreviousChartTasks(
        state.staticState.currencyMap,
        state.company,
        settings.rebuild((b) => b..offset += 1),
        state.taskState.map,
        state.invoiceState.map,
        state.projectState.map,
        state.clientState.map,
        state.groupState.map,
      );
    }

    return _DashboardPanel(
      viewModel: viewModel,
      currentData: currentData,
      previousData: previousData,
      isLoaded: isLoaded,
      title: AppLocalization.of(context).tasks,
      onDateSelected: (index, date) =>
          onDateSelected(currentData[index].entityMap[date]),
    );
  }

  Widget _expenseChart({
    @required BuildContext context,
    @required Function(List<String>) onDateSelected,
  }) {
    final settings = viewModel.dashboardUIState.settings;
    final state = viewModel.state;
    final isLoaded = state.isLoaded || state.expenseState.list.isNotEmpty;
    final currentData = memoizedChartExpenses(
        state.staticState.currencyMap,
        state.company,
        settings,
        state.invoiceState.map,
        state.expenseState.map);

    List<ChartDataGroup> previousData;
    if (settings.enableComparison) {
      previousData = memoizedPreviousChartExpenses(
          state.staticState.currencyMap,
          state.company,
          settings.rebuild((b) => b..offset += 1),
          state.invoiceState.map,
          state.expenseState.map);
    }

    return _DashboardPanel(
      viewModel: viewModel,
      currentData: currentData,
      previousData: previousData,
      isLoaded: isLoaded,
      title: AppLocalization.of(context).expenses,
      onDateSelected: (index, date) =>
          onDateSelected(currentData[index].entityMap[date]),
    );
  }

  Widget _runningTasks(BuildContext context) {
    final state = viewModel.state;

    final runningTasks =
        memoizedRunningTasks(state.taskState.map, state.user.id);

    if (runningTasks.isEmpty) {
      return null;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 12),
      child: Wrap(
          spacing: 8,
          children: runningTasks.map((task) {
            final client = state.clientState.map[task.clientId];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kBorderRadius),
              ),
              child: AppBorder(
                hideBorder: !isDarkMode(context),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 180),
                  child: Tooltip(
                    message: task.description,
                    child: ListTile(
                      dense: true,
                      title: LiveText(() {
                        return formatDuration(task.calculateDuration());
                      }),
                      subtitle: Text(
                        client != null ? client.displayName : task.number,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () =>
                          viewEntity(entity: task, filterEntity: client),
                      onLongPress: () => editEntity(entity: task),
                      leading: ActionMenuButton(
                        entity: task,
                        entityActions: task.getActions(
                          includeEdit: true,
                          userCompany: state.userCompany,
                        ),
                        onSelected: (context, action) =>
                            handleTaskAction(context, [task], action),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = viewModel.state;
    final company = state.company;
    final localization = AppLocalization.of(context);
    final runningTasks = _runningTasks(context);

    if (!state.staticState.isLoaded) {
      return LoadingIndicator();
    }

    final sections = [
      DashboardSections.messages,
      if (company.isModuleEnabled(EntityType.task) && runningTasks != null)
        DashboardSections.runningTasks,
      DashboardSections.overview,
      if (company.isModuleEnabled(EntityType.invoice))
        DashboardSections.invoices,
      if (company.isModuleEnabled(EntityType.invoice))
        DashboardSections.payments,
      if (company.isModuleEnabled(EntityType.quote)) DashboardSections.quotes,
      if (company.isModuleEnabled(EntityType.task)) DashboardSections.tasks,
      if (company.isModuleEnabled(EntityType.expense))
        DashboardSections.expenses,
    ];

    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: kTopBottomBarHeight),
          child: ScrollableListViewBuilder(
            scrollController: scrollController,
            itemCount: sections.length + 1,
            itemBuilder: (context, index) {
              if (index == sections.length) {
                return SizedBox(
                  height: 500,
                );
              }

              switch (sections[index]) {
                case DashboardSections.messages:
                  return Column(
                    children: [
                      if (!state.prefState.hideReviewApp &&
                          state.company.daysActive > (isMobileOS() ? 60 : 120))
                        ReviewApp(),
                      if (state.userCompany.isAdmin &&
                          state.company.daysActive < 30 &&
                          !state.prefState.hideGatewayWarning &&
                          state.companyGatewayState.list.isEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: FormCard(
                              child: InkWell(
                            onTap: isMobile(context)
                                ? () => createEntityByType(
                                      context: context,
                                      entityType: EntityType.companyGateway,
                                    )
                                : null,
                            child: Row(
                              children: [
                                Expanded(
                                  child:
                                      Text(localization.addGatewayHelpMessage),
                                ),
                                if (isDesktop(context))
                                  TextButton(
                                      onPressed: () {
                                        createEntityByType(
                                          context: context,
                                          entityType: EntityType.companyGateway,
                                        );
                                      },
                                      child: Text(localization.addGateway)),
                                IconButton(
                                    onPressed: () {
                                      final store =
                                          StoreProvider.of<AppState>(context);
                                      store.dispatch(
                                          DismissGatewayWarningPermanently());
                                    },
                                    icon: Icon(
                                      Icons.clear,
                                      color: Colors.grey,
                                    ))
                              ],
                            ),
                          )),
                        )
                    ],
                  );
                case DashboardSections.overview:
                  final settings = viewModel.dashboardUIState.settings;
                  final state = viewModel.state;
                  final isLoaded =
                      state.isLoaded || state.invoiceState.list.isNotEmpty;

                  final invoiceData = memoizedChartOverviewInvoices(
                    state.staticState.currencyMap,
                    state.company,
                    settings,
                    state.invoiceState.map,
                    state.clientState.map,
                  );

                  final paymentData = memoizedChartPayments(
                      state.staticState.currencyMap,
                      state.company,
                      settings,
                      state.invoiceState.map,
                      state.clientState.map,
                      state.paymentState.map);

                  final expenseData = memoizedChartExpenses(
                      state.staticState.currencyMap,
                      state.company,
                      settings,
                      state.invoiceState.map,
                      state.expenseState.map);

                  final textTheme = Theme.of(context).textTheme;

                  return Column(
                    children: [
                      FormCard(
                        children: [
                          Text('test', style: textTheme.headline6),
                          Text(formatNumber(0, context),
                              style: textTheme.headline5),
                        ],
                      ),
                      _OverviewPanel(
                          viewModel: viewModel,
                          title: localization.overview,
                          invoiceData: invoiceData,
                          paymentData: paymentData,
                          expenseData: expenseData,
                          isLoaded: isLoaded,
                          onDateSelected: null),
                    ],
                  );
                case DashboardSections.invoices:
                  return _invoiceChart(
                      context: context,
                      onDateSelected: (entityIds) => viewModel
                          .onSelectionChanged(EntityType.invoice, entityIds));
                case DashboardSections.payments:
                  return _paymentChart(
                      context: context,
                      onDateSelected: (entityIds) => viewModel
                          .onSelectionChanged(EntityType.payment, entityIds));
                case DashboardSections.quotes:
                  return _quoteChart(
                      context: context,
                      onDateSelected: (entityIds) => viewModel
                          .onSelectionChanged(EntityType.quote, entityIds));
                case DashboardSections.tasks:
                  return _taskChart(
                      context: context,
                      onDateSelected: (entityIds) => viewModel
                          .onSelectionChanged(EntityType.task, entityIds));
                case DashboardSections.expenses:
                  return _expenseChart(
                      context: context,
                      onDateSelected: (entityIds) => viewModel
                          .onSelectionChanged(EntityType.expense, entityIds));
                case DashboardSections.runningTasks:
                  return runningTasks;
              }

              return SizedBox();
            },
          ),
        ),
        _header(context),
        if (state.isLoading) LinearProgressIndicator(),
      ],
    );
  }
}

class _DashboardPanel extends StatefulWidget {
  const _DashboardPanel({
    @required this.viewModel,
    @required this.title,
    @required this.currentData,
    @required this.previousData,
    @required this.isLoaded,
    @required this.onDateSelected,
  });

  final DashboardVM viewModel;
  final String title;
  final List<ChartDataGroup> currentData;
  final List<ChartDataGroup> previousData;
  final bool isLoaded;
  final Function(int, String) onDateSelected;

  @override
  __DashboardPanelState createState() => __DashboardPanelState();
}

class __DashboardPanelState extends State<_DashboardPanel> {
  List<ChartDataGroup> _currentData;
  List<ChartDataGroup> _previousData;
  Widget _chart;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final settings = widget.viewModel.dashboardUIState.settings;
    final state = widget.viewModel.state;

    if (!widget.isLoaded) {
      return LoadingIndicator(useCard: true);
    }

    // Cache chart to retain user's selection
    // https://github.com/google/charts/issues/286
    if (_chart != null &&
        _currentData == widget.currentData &&
        _previousData == widget.previousData) {
      return _chart;
    }

    _currentData = widget.currentData;
    _previousData = widget.previousData;

    widget.currentData.forEach((dataGroup) {
      final index = widget.currentData.indexOf(dataGroup);
      dataGroup.chartSeries = <Series<dynamic, DateTime>>[];

      if (settings.enableComparison) {
        final List<ChartMoneyData> previous = [];
        final currentSeries = dataGroup.rawSeries;
        final previousSeries = widget.previousData[index].rawSeries;

        dataGroup.previousTotal = widget.previousData[index].total;

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
            strokeWidthPxFn: (_a, _b) => 2.5,
            id: DashboardChart.PERIOD_PREVIOUS,
            displayName: localization.previous,
            data: previous,
          ),
        );
      }

      dataGroup.chartSeries.add(charts.Series<ChartMoneyData, DateTime>(
        domainFn: (ChartMoneyData chartData, _) => chartData.date,
        measureFn: (ChartMoneyData chartData, _) => chartData.amount,
        colorFn: (ChartMoneyData chartData, _) =>
            charts.ColorUtil.fromDartColor(state.accentColor),
        strokeWidthPxFn: (_a, _b) => 2.5,
        id: DashboardChart.PERIOD_CURRENT,
        displayName:
            settings.enableComparison ? localization.current : widget.title,
        data: dataGroup.rawSeries,
      ));
    });

    _chart = DashboardChart(
      data: widget.currentData,
      title: widget.title,
      onDateSelected: widget.onDateSelected,
      currencyId: (settings.currencyId ?? '').isNotEmpty
          ? settings.currencyId
          : state.company.currencyId,
    );

    return _chart;
  }
}

class _OverviewPanel extends StatefulWidget {
  const _OverviewPanel({
    @required this.viewModel,
    @required this.title,
    @required this.invoiceData,
    @required this.paymentData,
    @required this.expenseData,
    @required this.isLoaded,
    @required this.onDateSelected,
  });

  final DashboardVM viewModel;
  final String title;
  final List<ChartDataGroup> invoiceData;
  final List<ChartDataGroup> paymentData;
  final List<ChartDataGroup> expenseData;
  final bool isLoaded;
  final Function(int, String) onDateSelected;

  @override
  __OverviewPanelState createState() => __OverviewPanelState();
}

class __OverviewPanelState extends State<_OverviewPanel> {
  List<ChartDataGroup> invoiceData;
  List<ChartDataGroup> paymentData;
  List<ChartDataGroup> expenseData;
  Widget chart;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final settings = widget.viewModel.dashboardUIState.settings;
    final state = widget.viewModel.state;

    if (!widget.isLoaded) {
      return LoadingIndicator(useCard: true);
    }

    // Cache chart to retain user's selection
    // https://github.com/google/charts/issues/286
    if (chart != null &&
        invoiceData == widget.invoiceData &&
        paymentData == widget.paymentData &&
        expenseData == widget.expenseData) {
      return chart;
    }

    invoiceData = widget.invoiceData;
    paymentData = widget.paymentData;
    expenseData = widget.expenseData;

    widget.invoiceData.forEach((dataGroup) {
      dataGroup.chartSeries = <Series<dynamic, DateTime>>[];

      final index = widget.invoiceData.indexOf(dataGroup);
      final invoiceSeries = dataGroup.rawSeries;

      if (state.company.isModuleEnabled(EntityType.expense)) {
        final List<ChartMoneyData> expenses = [];
        final expenseSeries = widget.expenseData[index].rawSeries;
        dataGroup.previousTotal = widget.expenseData[index].total;

        for (int i = 0;
            i < min(invoiceSeries.length, expenseSeries.length);
            i++) {
          expenses.add(
              ChartMoneyData(invoiceSeries[i].date, expenseSeries[i].amount));
        }

        dataGroup.chartSeries.add(charts.Series<ChartMoneyData, DateTime>(
          domainFn: (ChartMoneyData chartData, _) => chartData.date,
          measureFn: (ChartMoneyData chartData, _) => chartData.amount,
          colorFn: (ChartMoneyData chartData, _) =>
              charts.ColorUtil.fromDartColor(Colors.grey),
          strokeWidthPxFn: (_a, _b) => 2.5,
          id: DashboardChart.PERIOD_EXPENSES,
          displayName: localization.expenses,
          data: expenses,
        ));
      }

      final List<ChartMoneyData> payments = [];
      final paymentSeries = widget.paymentData[index].rawSeries;
      dataGroup.previousTotal = widget.paymentData[index].total;

      for (int i = 0;
          i < min(invoiceSeries.length, paymentSeries.length);
          i++) {
        payments.add(
            ChartMoneyData(invoiceSeries[i].date, paymentSeries[i].amount));
      }

      dataGroup.chartSeries.add(charts.Series<ChartMoneyData, DateTime>(
        domainFn: (ChartMoneyData chartData, _) => chartData.date,
        measureFn: (ChartMoneyData chartData, _) => chartData.amount,
        colorFn: (ChartMoneyData chartData, _) =>
            charts.ColorUtil.fromDartColor(Colors.green),
        strokeWidthPxFn: (_a, _b) => 2.5,
        id: DashboardChart.PERIOD_PAYMENTS,
        displayName: localization.payments,
        data: payments,
      ));

      dataGroup.chartSeries.add(charts.Series<ChartMoneyData, DateTime>(
        domainFn: (ChartMoneyData chartData, _) => chartData.date,
        measureFn: (ChartMoneyData chartData, _) => chartData.amount,
        colorFn: (ChartMoneyData chartData, _) =>
            charts.ColorUtil.fromDartColor(state.accentColor),
        strokeWidthPxFn: (_a, _b) => 2.5,
        id: DashboardChart.PERIOD_INVOICES,
        displayName: localization.invoices,
        data: dataGroup.rawSeries,
      ));
    });

    chart = DashboardChart(
      data: widget.invoiceData,
      title: widget.title,
      onDateSelected: widget.onDateSelected,
      currencyId: (settings.currencyId ?? '').isNotEmpty
          ? settings.currencyId
          : state.company.currencyId,
      isOverview: true,
    );

    return chart;
  }
}
