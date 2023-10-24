// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:charts_common/common.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/app_border.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/live_text.dart';
import 'package:invoiceninja_flutter/ui/app/review_app.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
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
    Key? key,
    required this.viewModel,
    required this.scrollController,
    required this.tabController,
  }) : super(key: key);

  final DashboardVM viewModel;
  final ScrollController? scrollController;
  final TabController? tabController;

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
                child: Text(localization!.day),
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
                  formatDateRange(settings.startDate(company)!,
                      settings.endDate(company)!, context),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              SizedBox(width: 6.0),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
        itemBuilder: (context) => DateRange.values
            .where((value) => value != DateRange.allTime)
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
                        child: Text((currencyId == kCurrencyAll
                            ? localization.all
                            : viewModel.currencyMap[currencyId]?.code)!),
                        value: currencyId,
                      ))
                  .toList(),
              onChanged: (currencyId) {
                viewModel.onCurrencyChanged(currencyId);
              },
              value: settings.currencyId,
            ),
          ),
        );
      }

      void _showSettings() {
        showDialog<AlertDialog>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return _DashboardSettings(
                isWide: isWide,
                viewModel: viewModel,
              );
            });
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
              if (isWide) ...[
                groupBy,
                if (company.hasTaxes) taxSettings,
                if (hasMultipleCurrencies) currencySettings,
                SizedBox(width: 4),
              ],
              IconButton(
                icon: Icon(MdiIcons.tuneVariant),
                onPressed: () {
                  _showSettings();
                },
              ),
              if (isDesktop(context) &&
                  !state.dashboardUIState.showSidebar) ...[
                SizedBox(width: 4),
                IconButton(
                    tooltip: localization.showSidebar,
                    icon: Icon(Icons.view_sidebar),
                    onPressed: () => viewModel.onShowSidebar()),
              ]
            ],
          ),
        ),
      );
    });
  }

  Widget? _runningTasks(BuildContext context) {
    final state = viewModel.state;

    final runningTasks =
        memoizedRunningTasks(state.taskState.map, state.user.id);

    if (runningTasks.isEmpty) {
      return null;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 12, right: 12),
      child: Wrap(
          spacing: 8,
          children: runningTasks.map((task) {
            final client = state.clientState.map[task!.clientId];
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
    final settings = viewModel.dashboardUIState.settings;
    final userCompanySettings = state.userCompany.settings;
    final runningTasks = _runningTasks(context);

    if (!state.staticState.isLoaded) {
      return LoadingIndicator();
    }

    final currentInvoiceData = memoizedChartInvoices(
      state.staticState.currencyMap,
      state.company,
      settings,
      state.invoiceState.map,
      state.clientState.map,
    );

    final previousInvoiceData = memoizedPreviousChartInvoices(
      state.staticState.currencyMap,
      state.company,
      settings.rebuild((b) => b..offset = settings.offset + 1),
      state.invoiceState.map,
      state.clientState.map,
    );

    final currentPaymentData = memoizedChartPayments(
        state.staticState.currencyMap,
        state.company,
        settings,
        state.invoiceState.map,
        state.clientState.map,
        state.paymentState.map);

    final previousPaymentData = memoizedPreviousChartPayments(
        state.staticState.currencyMap,
        state.company,
        settings.rebuild((b) => b..offset = settings.offset + 1),
        state.invoiceState.map,
        state.clientState.map,
        state.paymentState.map);

    final currentQuoteData = memoizedChartQuotes(
      state.staticState.currencyMap,
      state.company,
      settings,
      state.quoteState.map,
      state.clientState.map,
      state.invoiceState.map,
    );

    final previousQuoteData = memoizedPreviousChartQuotes(
      state.staticState.currencyMap,
      state.company,
      settings.rebuild((b) => b..offset = settings.offset + 1),
      state.quoteState.map,
      state.clientState.map,
      state.invoiceState.map,
    );

    final currentTaskData = memoizedChartTasks(
      state.staticState.currencyMap,
      state.company,
      settings,
      state.taskState.map,
      state.invoiceState.map,
      state.projectState.map,
      state.clientState.map,
      state.groupState.map,
    );

    final previousTaskData = memoizedPreviousChartTasks(
      state.staticState.currencyMap,
      state.company,
      settings.rebuild((b) => b..offset = settings.offset + 1),
      state.taskState.map,
      state.invoiceState.map,
      state.projectState.map,
      state.clientState.map,
      state.groupState.map,
    );

    final currentExpenseData = memoizedChartExpenses(
        state.staticState.currencyMap,
        state.company,
        settings,
        state.invoiceState.map,
        state.expenseState.map);

    final previousExpenseData = memoizedPreviousChartExpenses(
        state.staticState.currencyMap,
        state.company,
        settings.rebuild((b) => b..offset = settings.offset + 1),
        state.invoiceState.map,
        state.expenseState.map);

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

    final sidebarTabs = [
      if (company.isModuleEnabled(EntityType.invoice)) EntityType.invoice,
      if (company.isModuleEnabled(EntityType.payment)) EntityType.payment,
      if (company.isModuleEnabled(EntityType.quote)) EntityType.quote,
      if (company.isModuleEnabled(EntityType.task)) EntityType.task,
      if (company.isModuleEnabled(EntityType.expense)) EntityType.expense,
    ];

    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: kTopBottomBarHeight),
          child: ScrollableListViewBuilder(
            primary: true,
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
                      if (state.showReviewApp ||
                          state.showOneYearReviewApp ||
                          state.showTwoYearReviewApp)
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
                                      Text(localization!.addGatewayHelpMessage),
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

                  final currentFieldMap = {
                    DashboardUISettings.FIELD_ACTIVE_INVOICES:
                        currentInvoiceData[0],
                    DashboardUISettings.FIELD_OUTSTANDING_INVOICES:
                        currentInvoiceData[1],
                    DashboardUISettings.FIELD_COMPLETED_PAYMENTS:
                        currentPaymentData[0],
                    DashboardUISettings.FIELD_REFUNDED_PAYMENTS:
                        currentPaymentData[1],
                    DashboardUISettings.FIELD_ACTIVE_QUOTES:
                        currentQuoteData[0],
                    DashboardUISettings.FIELD_APPROVED_QUOTES:
                        currentQuoteData[1],
                    DashboardUISettings.FIELD_UNAPPROVED_QUOTES:
                        currentQuoteData[2],
                    DashboardUISettings.FIELD_INVOICED_QUOTES:
                        currentQuoteData[3],
                    DashboardUISettings.FIELD_INVOICE_PAID_QUOTES:
                        currentQuoteData[4],
                    DashboardUISettings.FIELD_LOGGED_TASKS: currentTaskData[0],
                    DashboardUISettings.FIELD_INVOICED_TASKS:
                        currentTaskData[1],
                    DashboardUISettings.FIELD_PAID_TASKS: currentTaskData[2],
                    DashboardUISettings.FIELD_LOGGED_EXPENSES:
                        currentExpenseData[0],
                    DashboardUISettings.FIELD_PENDING_EXPENSES:
                        currentExpenseData[1],
                    DashboardUISettings.FIELD_INVOICED_EXPENSES:
                        currentExpenseData[2],
                    DashboardUISettings.FIELD_INVOICE_PAID_EXPENSES:
                        currentExpenseData[3],
                  };

                  final previousFieldMap = {
                    DashboardUISettings.FIELD_ACTIVE_INVOICES:
                        previousInvoiceData[0],
                    DashboardUISettings.FIELD_OUTSTANDING_INVOICES:
                        previousInvoiceData[1],
                    DashboardUISettings.FIELD_COMPLETED_PAYMENTS:
                        previousPaymentData[0],
                    DashboardUISettings.FIELD_REFUNDED_PAYMENTS:
                        previousPaymentData[1],
                    DashboardUISettings.FIELD_ACTIVE_QUOTES:
                        previousQuoteData[0],
                    DashboardUISettings.FIELD_APPROVED_QUOTES:
                        previousQuoteData[1],
                    DashboardUISettings.FIELD_UNAPPROVED_QUOTES:
                        previousQuoteData[2],
                    DashboardUISettings.FIELD_INVOICED_QUOTES:
                        previousQuoteData[3],
                    DashboardUISettings.FIELD_INVOICE_PAID_QUOTES:
                        previousQuoteData[4],
                    DashboardUISettings.FIELD_LOGGED_TASKS: currentTaskData[0],
                    DashboardUISettings.FIELD_INVOICED_TASKS:
                        previousTaskData[1],
                    DashboardUISettings.FIELD_PAID_TASKS: currentTaskData[2],
                    DashboardUISettings.FIELD_LOGGED_EXPENSES:
                        previousExpenseData[0],
                    DashboardUISettings.FIELD_PENDING_EXPENSES:
                        previousExpenseData[1],
                    DashboardUISettings.FIELD_INVOICED_EXPENSES:
                        previousExpenseData[2],
                    DashboardUISettings.FIELD_INVOICE_PAID_EXPENSES:
                        previousExpenseData[3],
                  };

                  return Column(
                    children: [
                      SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: StaggeredGrid.count(
                          crossAxisCount: isMobile(context)
                              ? userCompanySettings.dashboardFieldsPerRowMobile
                              : userCompanySettings
                                  .dashboardFieldsPerRowDesktop,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 12,
                          children: state.userCompany.settings.dashboardFields
                              .map<Widget>((dashboardField) {
                            double value = 0;
                            if (dashboardField.period ==
                                DashboardUISettings.PERIOD_CURRENT) {
                              final data =
                                  currentFieldMap[dashboardField.field]!;
                              value = data.periodTotal;
                            } else if (dashboardField.period ==
                                DashboardUISettings.PERIOD_PREVIOUS) {
                              final data =
                                  previousFieldMap[dashboardField.field]!;
                              value = data.periodTotal;
                            } else if (dashboardField.period ==
                                DashboardUISettings.PERIOD_TOTAL) {
                              final data =
                                  currentFieldMap[dashboardField.field]!;
                              value = data.total;
                            }
                            return FormCard(
                              padding: const EdgeInsets.all(0),
                              children: [
                                Text(localization!.lookup(dashboardField.field),
                                    style: textTheme.titleMedium,
                                    textAlign: TextAlign.center),
                                SizedBox(height: 6),
                                Text(
                                    formatNumber(
                                      value,
                                      context,
                                      currencyId: state
                                          .dashboardUIState.settings.currencyId,
                                    )!,
                                    style: textTheme.headlineSmall,
                                    textAlign: TextAlign.center),
                                SizedBox(height: 6),
                                Text(localization.lookup(dashboardField.period),
                                    style: textTheme.bodySmall,
                                    textAlign: TextAlign.center),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                      _OverviewPanel(
                          viewModel: viewModel,
                          title: localization!.overview,
                          invoiceData: invoiceData,
                          paymentData: paymentData,
                          expenseData: expenseData,
                          isLoaded: isLoaded,
                          onDateSelected: null),
                    ],
                  );
                case DashboardSections.invoices:
                  return _DashboardPanel(
                      viewModel: viewModel,
                      currentData: currentInvoiceData,
                      previousData: previousInvoiceData,
                      isLoaded:
                          state.isLoaded || state.invoiceState.list.isNotEmpty,
                      title: AppLocalization.of(context)!.invoices,
                      onSelected: () => tabController!
                          .animateTo(sidebarTabs.indexOf(EntityType.invoice)),
                      onDateSelected: (index, date) {
                        tabController!
                            .animateTo(sidebarTabs.indexOf(EntityType.invoice));
                        viewModel.onSelectionChanged(EntityType.invoice,
                            currentInvoiceData[index].entityMap[date]);
                      });
                case DashboardSections.payments:
                  return _DashboardPanel(
                      viewModel: viewModel,
                      currentData: currentPaymentData,
                      previousData: previousPaymentData,
                      isLoaded:
                          state.isLoaded || state.paymentState.list.isNotEmpty,
                      title: AppLocalization.of(context)!.payments,
                      onSelected: () => tabController!
                          .animateTo(sidebarTabs.indexOf(EntityType.payment)),
                      onDateSelected: (index, date) {
                        tabController!
                            .animateTo(sidebarTabs.indexOf(EntityType.payment));

                        viewModel.onSelectionChanged(EntityType.payment,
                            currentPaymentData[index].entityMap[date]);
                      });
                case DashboardSections.quotes:
                  return _DashboardPanel(
                      viewModel: viewModel,
                      currentData: currentQuoteData,
                      previousData: previousQuoteData,
                      isLoaded:
                          state.isLoaded || state.quoteState.list.isNotEmpty,
                      title: AppLocalization.of(context)!.quotes,
                      onSelected: () => tabController!
                          .animateTo(sidebarTabs.indexOf(EntityType.quote)),
                      onDateSelected: (index, date) {
                        tabController!
                            .animateTo(sidebarTabs.indexOf(EntityType.quote));

                        viewModel.onSelectionChanged(EntityType.quote,
                            currentQuoteData[index].entityMap[date]);
                      });
                case DashboardSections.tasks:
                  return _DashboardPanel(
                      viewModel: viewModel,
                      currentData: currentTaskData,
                      previousData: previousTaskData,
                      isLoaded:
                          state.isLoaded || state.taskState.list.isNotEmpty,
                      title: AppLocalization.of(context)!.tasks,
                      onSelected: () => tabController!
                          .animateTo(sidebarTabs.indexOf(EntityType.task)),
                      onDateSelected: (index, date) {
                        tabController!
                            .animateTo(sidebarTabs.indexOf(EntityType.task));

                        viewModel.onSelectionChanged(EntityType.task,
                            currentTaskData[index].entityMap[date]);
                      });
                case DashboardSections.expenses:
                  return _DashboardPanel(
                      viewModel: viewModel,
                      currentData: currentExpenseData,
                      previousData: previousExpenseData,
                      isLoaded:
                          state.isLoaded || state.expenseState.list.isNotEmpty,
                      title: AppLocalization.of(context)!.expenses,
                      onSelected: () => tabController!
                          .animateTo(sidebarTabs.indexOf(EntityType.expense)),
                      onDateSelected: (index, date) {
                        tabController!
                            .animateTo(sidebarTabs.indexOf(EntityType.expense));
                        viewModel.onSelectionChanged(EntityType.expense,
                            currentExpenseData[index].entityMap[date]);
                      });
                case DashboardSections.runningTasks:
                  return runningTasks!;
              }
            },
          ),
        ),
        _header(context),
        if (state.isLoading || state.isSaving) LinearProgressIndicator(),
      ],
    );
  }
}

class _DashboardPanel extends StatefulWidget {
  const _DashboardPanel({
    required this.viewModel,
    required this.title,
    required this.currentData,
    required this.previousData,
    required this.isLoaded,
    required this.onDateSelected,
    required this.onSelected,
  });

  final DashboardVM viewModel;
  final String title;
  final List<ChartDataGroup> currentData;
  final List<ChartDataGroup> previousData;
  final bool isLoaded;
  final Function(int, String) onDateSelected;
  final Function onSelected;

  @override
  __DashboardPanelState createState() => __DashboardPanelState();
}

class __DashboardPanelState extends State<_DashboardPanel> {
  List<ChartDataGroup>? _currentData;
  List<ChartDataGroup>? _previousData;
  Widget? _chart;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final settings = viewModel.dashboardUIState.settings;
    final state = viewModel.state;

    if (!widget.isLoaded) {
      return LoadingIndicator(useCard: true);
    }

    // Cache chart to retain user's selection
    // https://github.com/google/charts/issues/286
    if (_chart != null &&
        _currentData == widget.currentData &&
        _previousData == widget.previousData) {
      return _chart!;
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

        dataGroup.previousTotal = widget.previousData[index].periodTotal;

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
            displayName: localization!.previous,
            data: previous,
          ),
        );
      }

      dataGroup.chartSeries.add(charts.Series<ChartMoneyData, DateTime>(
        domainFn: (ChartMoneyData chartData, _) => chartData.date,
        measureFn: (ChartMoneyData chartData, _) => chartData.amount,
        colorFn: (ChartMoneyData chartData, _) =>
            charts.ColorUtil.fromDartColor(state.accentColor!),
        strokeWidthPxFn: (_a, _b) => 2.5,
        id: DashboardChart.PERIOD_CURRENT,
        displayName:
            settings.enableComparison ? localization!.current : widget.title,
        data: dataGroup.rawSeries,
      ));
    });

    _chart = DashboardChart(
      data: widget.currentData,
      title: widget.title,
      onDateSelected: widget.onDateSelected,
      onSelected: widget.onSelected as dynamic Function(),
      currencyId: settings.currencyId.isNotEmpty
          ? settings.currencyId
          : state.company.currencyId,
    );

    return _chart!;
  }
}

class _OverviewPanel extends StatefulWidget {
  const _OverviewPanel({
    required this.viewModel,
    required this.title,
    required this.invoiceData,
    required this.paymentData,
    required this.expenseData,
    required this.isLoaded,
    required this.onDateSelected,
  });

  final DashboardVM viewModel;
  final String title;
  final List<ChartDataGroup> invoiceData;
  final List<ChartDataGroup> paymentData;
  final List<ChartDataGroup> expenseData;
  final bool isLoaded;
  final Function(int, String)? onDateSelected;

  @override
  __OverviewPanelState createState() => __OverviewPanelState();
}

class __OverviewPanelState extends State<_OverviewPanel> {
  List<ChartDataGroup>? invoiceData;
  List<ChartDataGroup>? paymentData;
  List<ChartDataGroup>? expenseData;
  Widget? chart;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final settings = viewModel.dashboardUIState.settings;
    final state = viewModel.state;

    if (!widget.isLoaded) {
      return LoadingIndicator(useCard: true);
    }

    // Cache chart to retain user's selection
    // https://github.com/google/charts/issues/286
    if (chart != null &&
        widget.invoiceData == invoiceData &&
        widget.paymentData == paymentData &&
        widget.expenseData == expenseData) {
      return chart!;
    }

    invoiceData = widget.invoiceData;
    paymentData = widget.paymentData;
    expenseData = widget.expenseData;

    widget.invoiceData.forEach((dataGroup) {
      dataGroup.chartSeries = <Series<dynamic, DateTime>>[];

      final index = invoiceData!.indexOf(dataGroup);
      final invoiceSeries = dataGroup.rawSeries;

      if (state.company.isModuleEnabled(EntityType.expense)) {
        final List<ChartMoneyData> expenses = [];
        final expenseSeries = expenseData![index].rawSeries;
        dataGroup.previousTotal = expenseData![index].periodTotal;

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
          displayName: localization!.expenses,
          data: expenses,
        ));
      }

      final List<ChartMoneyData> payments = [];
      final paymentSeries = paymentData![index].rawSeries;
      dataGroup.previousTotal = paymentData![index].periodTotal;

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
        displayName: localization!.payments,
        data: payments,
      ));

      dataGroup.chartSeries.add(charts.Series<ChartMoneyData, DateTime>(
        domainFn: (ChartMoneyData chartData, _) => chartData.date,
        measureFn: (ChartMoneyData chartData, _) => chartData.amount,
        colorFn: (ChartMoneyData chartData, _) =>
            charts.ColorUtil.fromDartColor(state.accentColor!),
        strokeWidthPxFn: (_a, _b) => 2.5,
        id: DashboardChart.PERIOD_INVOICES,
        displayName: localization.invoices,
        data: dataGroup.rawSeries,
      ));
    });

    chart = DashboardChart(
      data: invoiceData,
      title: widget.title,
      onSelected: () => null,
      onDateSelected: widget.onDateSelected,
      currencyId: settings.currencyId.isNotEmpty
          ? settings.currencyId
          : state.company.currencyId,
      isOverview: true,
    );

    return chart!;
  }
}

class _DashboardSettings extends StatefulWidget {
  const _DashboardSettings({
    Key? key,
    required this.viewModel,
    required this.isWide,
  }) : super(key: key);

  final bool isWide;
  final DashboardVM viewModel;

  @override
  State<_DashboardSettings> createState() => __DashboardSettingsState();
}

class __DashboardSettingsState extends State<_DashboardSettings> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final store = StoreProvider.of<AppState>(context);
    final viewModel = widget.viewModel;
    final state = store.state;
    final clientMap = state.clientState.map;
    final groupMap = state.groupState.map;
    final company = state.company;
    final settings = state.dashboardUIState.settings;
    final userCompanySettings = state.userCompany.settings;

    final hasMultipleCurrencies =
        memoizedHasMultipleCurrencies(company, clientMap, groupMap);

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
            setState(() {});
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
            setState(() {});
          },
          value: settings.includeTaxes,
        ),
      ),
    );

    Widget currencySettings = SizedBox();
    if (hasMultipleCurrencies) {
      currencySettings = Padding(
        padding: const EdgeInsets.only(left: 16),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            items: memoizedGetCurrencyIds(company, clientMap, groupMap)
                .map((currencyId) => DropdownMenuItem<String>(
                      child: Text((currencyId == kCurrencyAll
                          ? localization.all
                          : viewModel.currencyMap[currencyId]?.code)!),
                      value: currencyId,
                    ))
                .toList(),
            onChanged: (currencyId) {
              viewModel.onCurrencyChanged(currencyId);
              setState(() {});
            },
            value: settings.currencyId,
          ),
        ),
      );
    }

    return AlertDialog(
      title: Text(localization.settings),
      actions: [
        TextButton(
          child: Text(localization.close.toUpperCase()),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
            child: Text(localization.save.toUpperCase()),
            onPressed: () {
              final completer = snackBarCompleter<Null>(
                  AppLocalization.of(context)!.savedSettings);
              final user = state.user
                  .rebuild((b) => b..userCompany.replace(state.userCompany));
              store.dispatch(
                SaveUserSettingsRequest(
                  completer: completer,
                  user: user,
                ),
              );

              Navigator.of(context).pop();
            }),
      ],
      content: Container(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (!widget.isWide) ...[
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
              SizedBox(height: 10),
            ],
            Expanded(
              child: ReorderableListView(
                onReorder: (oldIndex, newIndex) {
                  final fields =
                      store.state.userCompany.settings.dashboardFields;

                  // https://stackoverflow.com/a/54164333/497368
                  // These two lines are workarounds for ReorderableListView problems
                  if (newIndex > fields.length) {
                    newIndex = fields.length;
                  }
                  if (oldIndex < newIndex) {
                    newIndex--;
                  }

                  final field = fields[oldIndex];
                  store.dispatch(UpdateDashboardFields(
                      dashboardFields: fields.rebuild((b) => b
                        ..removeAt(oldIndex)
                        ..insert(newIndex, field))));
                  setState(() {});
                },
                children: [
                  for (var dashboardField
                      in userCompanySettings.dashboardFields)
                    ListTile(
                      key: ValueKey(
                          '__${dashboardField.field}_${dashboardField.period}_'),
                      title: Text(localization.lookup(dashboardField.field)),
                      subtitle:
                          Text(localization.lookup(dashboardField.period)),
                      leading: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          store.dispatch(UpdateDashboardFields(
                              dashboardFields: userCompanySettings
                                  .dashboardFields
                                  .rebuild((b) => b..remove(dashboardField))));
                          setState(() {});
                        },
                      ),
                    ),
                ],
              ),
            ),
            AppButton(
              label: localization.addField.toUpperCase(),
              onPressed: () async {
                await showDialog<void>(
                    context: context, builder: (context) => _DashboardField());
                setState(() {});
              },
            ),
            SizedBox(height: 16),
            AppDropdownButton<int>(
                labelText: localization.fieldsPerRow,
                value: isMobile(context)
                    ? userCompanySettings.dashboardFieldsPerRowMobile
                    : userCompanySettings.dashboardFieldsPerRowDesktop,
                onChanged: (dynamic value) {
                  if (isMobile(context)) {
                    store.dispatch(UpdateDashboardFieldSettingss(
                        numberFieldsPerRowMobile: value));
                  } else {
                    store.dispatch(UpdateDashboardFieldSettingss(
                        numberFieldsPerRowDesktop: value));
                  }
                  setState(() {});
                },
                items: List<int>.generate(8, (i) => i + 1)
                    .map((value) => DropdownMenuItem<int>(
                          child: Text('$value'),
                          value: value,
                        ))
                    .toList())
          ],
        ),
      ),
    );
  }
}

class _DashboardField extends StatefulWidget {
  const _DashboardField({Key? key}) : super(key: key);

  @override
  State<_DashboardField> createState() => _DashboardFieldState();
}

class _DashboardFieldState extends State<_DashboardField> {
  String _field = '';
  String _period = '';

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final List<DropdownMenuItem<String>> items = [];
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final company = state.company;
    final dashboardFields = state.userCompany.settings.dashboardFields;

    final fieldMap = {
      EntityType.invoice: [
        DashboardUISettings.FIELD_ACTIVE_INVOICES,
        DashboardUISettings.FIELD_OUTSTANDING_INVOICES,
      ],
      EntityType.payment: [
        DashboardUISettings.FIELD_COMPLETED_PAYMENTS,
        DashboardUISettings.FIELD_REFUNDED_PAYMENTS,
      ],
      EntityType.quote: [
        DashboardUISettings.FIELD_ACTIVE_QUOTES,
        DashboardUISettings.FIELD_APPROVED_QUOTES,
        DashboardUISettings.FIELD_UNAPPROVED_QUOTES,
      ],
      EntityType.task: [
        DashboardUISettings.FIELD_LOGGED_TASKS,
        DashboardUISettings.FIELD_INVOICED_TASKS,
        DashboardUISettings.FIELD_PAID_TASKS,
      ],
      EntityType.expense: [
        DashboardUISettings.FIELD_LOGGED_EXPENSES,
        DashboardUISettings.FIELD_PENDING_EXPENSES,
        DashboardUISettings.FIELD_INVOICED_EXPENSES,
        DashboardUISettings.FIELD_INVOICE_PAID_EXPENSES,
      ],
    };

    fieldMap.forEach((entityType, fields) {
      fields.forEach((field) {
        if (company.isModuleEnabled(entityType)) {
          items.add(DropdownMenuItem<String>(
            child: Text(localization.lookup(field)),
            value: field,
          ));
        }
      });
    });

    return AlertDialog(
      title: Text(localization.addField),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        AppDropdownButton(
          labelText: localization.field,
          value: _field,
          onChanged: (dynamic value) {
            setState(() {
              _field = value;
            });
          },
          items: items,
        ),
        AppDropdownButton(
          labelText: localization.period,
          value: _period,
          onChanged: (dynamic value) {
            setState(() {
              _period = value;
            });
          },
          items: [
            DropdownMenuItem<String>(
              child: Text(localization.currentPeriod),
              value: DashboardUISettings.PERIOD_CURRENT,
            ),
            DropdownMenuItem<String>(
              child: Text(localization.previousPeriod),
              value: DashboardUISettings.PERIOD_PREVIOUS,
            ),
            DropdownMenuItem<String>(
              child: Text(localization.total),
              value: DashboardUISettings.PERIOD_TOTAL,
            ),
          ],
        ),
      ]),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(localization.cancel.toUpperCase()),
        ),
        TextButton(
          onPressed: () {
            if (_field.isEmpty || _period.isEmpty) {
              return;
            }

            if (dashboardFields
                .where(
                    (field) => field.field == _field && field.period == _period)
                .isNotEmpty) {
              Navigator.of(context).pop();
              return;
            }

            store.dispatch(UpdateDashboardFields(
                dashboardFields: dashboardFields.rebuild(
              (b) => b
                ..add(
                  DashboardField(
                    field: _field,
                    period: _period,
                  ),
                ),
            )));

            Navigator.of(context).pop();
          },
          child: Text(localization.add.toUpperCase()),
        ),
      ],
    );
  }
}
