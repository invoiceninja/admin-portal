// Flutter imports:

import 'package:collection/collection.dart' show IterableNullableExtension;
import 'package:flutter/material.dart' as mt;
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/.env.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_actions.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/app_border.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/app_text_button.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/multiselect_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/history_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/menu_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/app/tables/app_paginated_data_table.dart';
import 'package:invoiceninja_flutter/ui/reports/report_charts.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen_vm.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';
import 'package:invoiceninja_flutter/utils/dates.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  static const String route = '/reports';

  final ReportsScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final store = StoreProvider.of<AppState>(context);
    final state = viewModel.state;
    final reportsState = viewModel.reportState;
    final reportResult = viewModel.reportResult!;

    Widget leading = SizedBox();
    final hideReports = state.isHosted && !state.isProPlan && !state.isTrial;

    if (isMobile(context) || state.prefState.isMenuFloated) {
      leading = Builder(
        builder: (context) => InkWell(
          child: IconButton(
            tooltip: localization.menuSidebar,
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      );
    }

    final hasCustomDate = reportsState.filters.keys.where((column) {
      final filter = reportsState.filters[column];
      return (getReportColumnType(column, context) ==
                  ReportColumnType.dateTime ||
              getReportColumnType(column, context) == ReportColumnType.date) &&
          filter == DateRange.custom.toString();
    }).isNotEmpty;

    final reports = [
      kReportClient,
      kReportClientContact,
      if (state.company.isModuleEnabled(EntityType.invoice)) ...[
        kReportInvoice,
        kReportInvoiceItem,
        kReportPayment,
        if (state.company.hasTaxes) ...[
          kReportInvoiceTax,
          kReportPaymentTax,
        ],
        if (state.company.isModuleEnabled(EntityType.recurringInvoice))
          kReportRecurringInvoice,
      ],
      if (state.company.isModuleEnabled(EntityType.quote)) ...[
        kReportQuote,
        kReportQuoteItem,
      ],
      if (state.company.isModuleEnabled(EntityType.credit)) ...[
        kReportCredit,
        kReportCreditItem,
      ],
      kReportDocument,
      if (state.company.isModuleEnabled(EntityType.expense)) ...[
        kReportExpense,
        if (state.company.isModuleEnabled(EntityType.recurringExpense))
          kReportRecurringExpense,
      ],
      kReportProduct,
      kReportProfitAndLoss,
      if (state.company.isModuleEnabled(EntityType.task)) ...[
        kReportTask,
        kReportTaskItem,
      ],
      if (state.company.isModuleEnabled(EntityType.vendor)) ...[
        kReportVendor,
        if (state.company.isModuleEnabled(EntityType.purchaseOrder))
          kReportPurchaseOrder,
        kReportPurchaseOrderItem,
      ],
      if (state.company.isModuleEnabled(EntityType.transaction))
        kReportTransaction,
    ]..sort((a, b) => a.compareTo(b));

    final reportChildren = [
      AppDropdownButton<String>(
        labelText: localization.report,
        value: reportsState.report,
        onChanged: (dynamic value) =>
            viewModel.onSettingsChanged(report: value),
        items: reports
            .map((report) => DropdownMenuItem(
                  value: report,
                  child: Text(localization.lookup(report)),
                ))
            .toList(),
      ),
      AppDropdownButton<String>(
        labelText: localization.group,
        value: reportsState.group,
        blankValue: '',
        showBlank: true,
        onChanged: (dynamic value) {
          viewModel.onSettingsChanged(group: value, selectedGroup: '');
        },
        items: reportResult.columns
            .where((column) =>
                getReportColumnType(column, context) != ReportColumnType.number)
            .map((column) {
          final columnTitle = state.company.getCustomFieldLabel(column);
          return DropdownMenuItem(
            child: Text(columnTitle.isEmpty
                ? localization.lookup(column)
                : columnTitle),
            value: column,
          );
        }).toList(),
      ),
      if (getReportColumnType(reportsState.group, context) ==
              ReportColumnType.dateTime ||
          getReportColumnType(reportsState.group, context) ==
              ReportColumnType.date)
        AppDropdownButton<String>(
          labelText: localization.subgroup,
          value: reportsState.subgroup,
          onChanged: (dynamic value) {
            viewModel.onSettingsChanged(subgroup: value);
          },
          items: [
            DropdownMenuItem(
              child: Text(localization.day),
              value: kReportGroupDay,
            ),
            DropdownMenuItem(
              child: Text(localization.week),
              value: kReportGroupWeek,
            ),
            DropdownMenuItem(
              child: Text(localization.month),
              value: kReportGroupMonth,
            ),
            DropdownMenuItem(
              child: Text(localization.quarter),
              value: kReportGroupQuarter,
            ),
            DropdownMenuItem(
              child: Text(localization.year),
              value: kReportGroupYear,
            ),
          ],
        ),
    ];

    final reportState = viewModel.reportState;
    final filterColumns = reportState.filters.keys.where((column) =>
        [
          ReportColumnType.date,
          ReportColumnType.dateTime,
        ].contains(getReportColumnType(column, context)) &&
        (reportState.filters[column] ?? '').isNotEmpty);
    final dateColumns = reportResult.columns.where((column) => [
          ReportColumnType.date,
          ReportColumnType.dateTime,
        ].contains(getReportColumnType(column, context)));
    final dateField = filterColumns.isNotEmpty ? filterColumns.first : null;
    final dateRange = (reportState.filters[dateField] ?? '').isNotEmpty
        ? DateRange.valueOf(reportState.filters[dateField]!)
        : null;

    final dateChildren = [
      if (dateColumns.length > 1)
        AppDropdownButton<String>(
            labelText: localization.date,
            value: dateField,
            showBlank: true,
            onChanged: (dynamic value) {
              viewModel.onReportFiltersChanged(
                context,
                reportState.filters.rebuild((b) => b
                  ..addAll(
                    (value ?? '').isEmpty
                        ? {
                            if (filterColumns.isNotEmpty)
                              filterColumns.first: ''
                          }
                        : {
                            value: reportState.filters.containsKey(value) &&
                                    (reportState.filters[value] ?? '')
                                        .isNotEmpty
                                ? reportState.filters[value]!
                                : DateRange.thisQuarter.toString(),
                            if (filterColumns.isNotEmpty &&
                                filterColumns.first != value)
                              filterColumns.first: ''
                          },
                  )),
              );
            },
            items: dateColumns
                .map((column) => DropdownMenuItem<String>(
                      value: column,
                      child: Text(
                        localization.lookup(column),
                      ),
                    ))
                .toList()),
      AppDropdownButton<DateRange>(
        labelText: localization.range,
        showBlank: true,
        blankValue: null,
        value: dateRange,
        onChanged: dateColumns.isEmpty
            ? null
            : (dynamic value) {
                viewModel.onReportFiltersChanged(
                    context,
                    reportState.filters.rebuild((b) => b
                      ..addAll({
                        dateField ?? dateColumns.first:
                            value == null ? '' : '$value'
                      })));
              },
        items: DateRange.values
            .where((value) => value != DateRange.allTime)
            .map((dateRange) => DropdownMenuItem<DateRange>(
                  child: Text(localization.lookup(dateRange.toString())),
                  value: dateRange,
                ))
            .toList(),
      ),
      if (hasCustomDate) ...[
        DatePicker(
          labelText: localization.startDate,
          selectedDate: reportsState.customStartDate,
          onSelected: (date, _) =>
              viewModel.onSettingsChanged(customStartDate: date),
        ),
        DatePicker(
          labelText: localization.endDate,
          selectedDate: reportsState.customEndDate,
          onSelected: (date, _) =>
              viewModel.onSettingsChanged(customEndDate: date),
        ),
      ]
    ];

    final cappedEntities = <BaseEntity>[...reportResult.entities ?? []];
    final firstEntity = cappedEntities.isNotEmpty ? cappedEntities.first : null;
    if (cappedEntities.length > kMaxEntitiesPerBulkAction) {
      cappedEntities.removeRange(
          kMaxEntitiesPerBulkAction, cappedEntities.length);
    }

    final chartChildren = [
      AppDropdownButton<String>(
        enabled: reportsState.group.isNotEmpty,
        labelText: localization.chart,
        value: reportsState.group.isNotEmpty ? reportsState.chart : null,
        blankValue: '',
        showBlank: true,
        onChanged: (dynamic value) {
          viewModel.onSettingsChanged(chart: value);
        },
        items: reportResult.columns
            .where((column) => [
                  ReportColumnType.number,
                  ReportColumnType.age,
                  ReportColumnType.duration,
                ].contains(getReportColumnType(column, context)))
            .map((column) => DropdownMenuItem(
                  child: Text(localization.lookup(column)),
                  value: column,
                ))
            .toList(),
      ),
    ];

    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        store.dispatch(ViewDashboard());
      },
      child: Scaffold(
        drawer: isMobile(context) || state.prefState.isMenuFloated
            ? MenuDrawerBuilder()
            : null,
        endDrawer: isMobile(context) || state.prefState.isHistoryFloated
            ? HistoryDrawerBuilder()
            : null,
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          leadingWidth: isMobile(context) ? kMinInteractiveDimension : 0,
          leading: leading,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(child: Text(localization.reports)),
              if (state.isSaving)
                SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
          actions: hideReports
              ? []
              : [
                  if (isDesktop(context)) ...[
                    Builder(builder: (BuildContext context) {
                      return AppTextButton(
                        label: localization.columns,
                        isInHeader: true,
                        onPressed: () {
                          multiselectDialog(
                            // Using the navigatorKey to prevent using the appBarTheme
                            context: navigatorKey.currentContext!,
                            onSelected: (selected) {
                              viewModel.onReportColumnsChanged(
                                  context, selected);
                            },
                            options: reportResult.allColumns,
                            selected: reportResult.columns.toList(),
                            defaultSelected: reportResult.defaultColumns,
                          );
                        },
                      );
                    }),
                    AppTextButton(
                      label: localization.export,
                      isInHeader: true,
                      onPressed: () {
                        viewModel.onExportPressed(context);
                      },
                    ),
                    if (supportsLatestFeatures('5.8.0'))
                      AppTextButton(
                        label: localization.schedule,
                        isInHeader: true,
                        onPressed: () {
                          viewModel.onSchedulePressed(context);
                        },
                      ),
                  ],
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ActionMenuButton(
                        entityActions: firstEntity == null
                            ? null
                            : firstEntity.getActions(
                                userCompany: state.userCompany,
                                multiselect: true),
                        entity: firstEntity,
                        onSelected: (context, action) {
                          final entities = action.applyMaxLimit
                              ? cappedEntities
                              : reportResult.entities!;
                          confirmCallback(
                              context: context,
                              message: localization.lookup(action.toString()) +
                                  ' • ' +
                                  (entities.length == 1
                                      ? '1 ${localization.lookup(firstEntity!.entityType.toString())}'
                                      : '${entities.length} ${localization.lookup(firstEntity!.entityType!.plural)}'),
                              callback: (_) {
                                handleEntitiesActions(entities, action);
                              });
                        }),
                  ),
                  if (isMobile(context) || !state.prefState.isHistoryVisible)
                    Builder(
                      builder: (context) => IconButton(
                        icon: Icon(Icons.history),
                        padding: const EdgeInsets.only(left: 4, right: 20),
                        tooltip: state.prefState.enableTooltips
                            ? localization.history
                            : null,
                        onPressed: () {
                          if (isMobile(context) ||
                              state.prefState.isHistoryFloated) {
                            Scaffold.of(context).openEndDrawer();
                          } else {
                            store.dispatch(UpdateUserPreferences(
                                sidebar: AppSidebar.history));
                          }
                        },
                      ),
                    ),
                ],
        ),
        body: hideReports
            ? Center(
                child: mt.Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HelpText(localization.upgradeToViewReports),
                      SizedBox(height: 10),
                      AppButton(
                        label: localization.upgrade.toUpperCase(),
                        onPressed: () => initiatePurchase(),
                      )
                    ],
                  ),
                ),
              )
            : ScrollableListView(
                primary: true,
                key: ValueKey(
                    '${viewModel.state.company.id}_${viewModel.state.isSaving}_${reportsState.report}_${reportsState.group}'),
                children: <Widget>[
                  isMobile(context)
                      ? FormCard(
                          children: [
                            ...reportChildren,
                            ...dateChildren,
                            ...chartChildren,
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: FormCard(
                                children: reportChildren,
                                padding: const EdgeInsets.only(
                                    top: kMobileDialogPadding,
                                    right: kMobileDialogPadding / 2,
                                    left: kMobileDialogPadding),
                              ),
                            ),
                            Flexible(
                              child: FormCard(
                                children: dateChildren,
                                padding: const EdgeInsets.only(
                                    top: kMobileDialogPadding,
                                    right: kMobileDialogPadding / 2,
                                    left: kMobileDialogPadding / 2),
                              ),
                            ),
                            Flexible(
                              child: FormCard(
                                children: chartChildren,
                                padding: const EdgeInsets.only(
                                    top: kMobileDialogPadding,
                                    right: kMobileDialogPadding,
                                    left: kMobileDialogPadding / 2),
                              ),
                            )
                          ],
                        ),
                  if (isMobile(context))
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Builder(builder: (BuildContext context) {
                            return Expanded(
                              child: AppButton(
                                label: localization.columns,
                                onPressed: () {
                                  multiselectDialog(
                                    context: context,
                                    onSelected: (selected) {
                                      viewModel.onReportColumnsChanged(
                                          context, selected);
                                    },
                                    options: reportResult.allColumns,
                                    selected: reportResult.columns.toList(),
                                    defaultSelected:
                                        reportResult.defaultColumns,
                                  );
                                },
                              ),
                            );
                          }),
                          SizedBox(width: kGutterWidth),
                          Expanded(
                            child: AppButton(
                              label: localization.export,
                              onPressed: () {
                                viewModel.onExportPressed(context);
                              },
                            ),
                          ),
                          if (supportsLatestFeatures('5.8.0')) ...[
                            SizedBox(width: kGutterWidth),
                            Expanded(
                              child: AppButton(
                                label: localization.schedule,
                                onPressed: () {
                                  viewModel.onSchedulePressed(context);
                                },
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ReportDataTable(
                    key: ValueKey(
                        '${viewModel.state.isSaving}_${reportsState.group}_${reportsState.selectedGroup}'),
                    viewModel: viewModel,
                  )
                ],
              ),
      ),
    );
  }
}

class ReportDataTable extends StatefulWidget {
  const ReportDataTable({Key? key, required this.viewModel}) : super(key: key);

  final ReportsScreenVM viewModel;

  @override
  _ReportDataTableState createState() => _ReportDataTableState();
}

class _ReportDataTableState extends State<ReportDataTable> {
  final Map<String, Map<String, TextEditingController>>
      _textEditingControllers = {};
  final Map<String, Map<String, FocusNode>> _textEditingFocusNodes = {};
  late ReportDataTableSource dataTableSource;

  @override
  void initState() {
    super.initState();

    final viewModel = widget.viewModel;

    dataTableSource = ReportDataTableSource(
        viewModel: viewModel,
        context: context,
        textEditingControllers: _textEditingControllers,
        textEditingFocusNodes: _textEditingFocusNodes,
        onFilterChanged: (column, value) {
          final reportState = widget.viewModel.reportState;
          viewModel.onReportFiltersChanged(context,
              reportState.filters.rebuild((b) => b..addAll({column: value})));
        });
  }

  @override
  void didUpdateWidget(ReportDataTable oldWidget) {
    super.didUpdateWidget(oldWidget);

    final viewModel = widget.viewModel;
    dataTableSource.viewModel = viewModel;

    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    dataTableSource.notifyListeners();
  }

  @override
  void didChangeDependencies() {
    final viewModel = widget.viewModel;
    final reportState = viewModel.reportState;
    final reportResult = viewModel.reportResult!;

    for (var column in reportResult.columns) {
      if (_textEditingControllers[reportState.report] == null) {
        _textEditingControllers[reportState.report] = {};
        _textEditingFocusNodes[reportState.report] = {};
      }
      if (!_textEditingControllers[reportState.report]!.containsKey(column)) {
        final textEditingController = TextEditingController();
        // TODO figure out how to remove this listener in dispose
        textEditingController.addListener(() {
          _onChanged(column, textEditingController.text);
        });
        if (reportState.filters.containsKey(column)) {
          textEditingController.text = reportState.filters[column]!;
        }
        _textEditingControllers[reportState.report]![column] =
            textEditingController;
        _textEditingFocusNodes[reportState.report]![column] = FocusNode();
      }
    }

    super.didChangeDependencies();
  }

  void _onChanged(String column, String value) {
    widget.viewModel.onReportFiltersChanged(
        context,
        widget.viewModel.reportState.filters
            .rebuild((b) => b..addAll({column: value})));
  }

  @override
  void dispose() {
    _textEditingControllers.keys.forEach((i) {
      _textEditingControllers[i]!.keys.forEach((j) {
        _textEditingControllers[i]![j]!.dispose();
        _textEditingFocusNodes[i]![j]!.dispose();
      });
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.viewModel.state;
    final viewModel = widget.viewModel;
    final reportResult = viewModel.reportResult!;
    final reportState = viewModel.reportState;
    final settings = state.userCompany.settings;
    final reportSettings =
        settings.reportSettings.containsKey(reportState.report)
            ? settings.reportSettings[reportState.report]!
            : ReportSettingsEntity();
    final sortedColumns = reportResult.sortedColumns(reportState);

    return Column(
      children: <Widget>[
        if (reportState.chart.isNotEmpty)
          ClipRect(
            child: ReportCharts(
              viewModel: widget.viewModel,
            ),
          ),
        if (reportResult.showTotals)
          FormCard(
            child: isMobile(context)
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: TotalsDataTable(
                      viewModel: viewModel,
                      reportResult: reportResult,
                      reportSettings: reportSettings,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TotalsDataTable(
                        viewModel: viewModel,
                        reportResult: reportResult,
                        reportSettings: reportSettings,
                      ),
                    ],
                  ),
          ),
        SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: AppPaginatedDataTable(
            sortColumnIndex: sortedColumns.contains(reportSettings.sortColumn)
                ? sortedColumns.indexOf(reportSettings.sortColumn)
                : null,
            sortAscending: reportSettings.sortAscending,
            columns: reportResult.tableColumns(
                context,
                (index, ascending) => widget.viewModel
                    .onReportSorted(sortedColumns[index], ascending)),
            source: dataTableSource,
            showFirstLastButtons: true,
            subtractOne: true,
          ),
        )
      ],
    );
  }
}

class TotalsDataTable extends StatelessWidget {
  const TotalsDataTable({
    required this.reportSettings,
    required this.reportResult,
    required this.viewModel,
  });

  final ReportsScreenVM viewModel;
  final ReportSettingsEntity reportSettings;
  final ReportResult reportResult;

  @override
  Widget build(BuildContext context) {
    return mt.DataTable(
      sortColumnIndex:
          reportResult.columns.length > reportSettings.sortTotalsIndex
              ? reportSettings.sortTotalsIndex
              : null,
      sortAscending: reportSettings.sortTotalsAscending,
      columns: reportResult.totalColumns(
          context,
          (index, ascending) =>
              viewModel.onReportTotalsSorted(index, ascending)),
      rows: reportResult.totalRows(context),
    );
  }
}

enum ReportColumnType {
  string,
  dateTime,
  date,
  number,
  bool,
  age,
  duration,
}

bool canTotalColumn(String? column) {
  if (['notification_threshold', 'age'].contains(column)) {
    return false;
  }

  if (column!.contains('_rate')) {
    return false;
  }

  return true;
}

ReportColumnType getReportColumnType(String? column, BuildContext context) {
  column = toSnakeCase(column);

  ReportColumnType convertCustomFieldType(String type) {
    if (type == kFieldTypeDate) {
      return ReportColumnType.date;
    } else if (type == kFieldTypeSwitch) {
      return ReportColumnType.bool;
    } else {
      return ReportColumnType.string;
    }
  }

  final store = StoreProvider.of<AppState>(context);
  final company = store.state.userCompany.company;

  if (column.startsWith('surcharge')) {
    return ReportColumnType.number;
  } else if (column == 'duration') {
    return ReportColumnType.duration;
  } else if (company.hasCustomField(column)) {
    return convertCustomFieldType(company.getCustomFieldType(column));
  } else if (EntityPresenter.isFieldNumeric(column)) {
    return ReportColumnType.number;
  } else if (['updated_at', 'created_at', 'start_time', 'end_time']
      .contains(column)) {
    return ReportColumnType.dateTime;
  } else if ((column.contains('_date') && column != 'paid_to_date') ||
      ['date', 'valid_until'].contains(column)) {
    return ReportColumnType.date;
  } else if (column == 'age') {
    return ReportColumnType.age;
  } else if (column.startsWith('is_')) {
    return ReportColumnType.bool;
  } else {
    return ReportColumnType.string;
  }
}

class ReportDataTableSource extends DataTableSource {
  ReportDataTableSource({
    required this.context,
    required this.textEditingControllers,
    required this.textEditingFocusNodes,
    required this.onFilterChanged,
    required this.viewModel,
  });

  ReportsScreenVM viewModel;
  final BuildContext context;
  final Map<String, Map<String, TextEditingController>> textEditingControllers;
  final Map<String, Map<String, FocusNode>> textEditingFocusNodes;
  final Function(String, String) onFilterChanged;

  @override
  int get selectedRowCount => 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount {
    final reportState = viewModel.reportState;

    if (reportState.group.isEmpty || reportState.isGroupByFiltered) {
      return viewModel.reportResult!.data.length + 1;
    } else {
      return viewModel.groupTotals.totals == null
          ? 1
          : viewModel.groupTotals.totals!.length + 1;
    }
  }

  @override
  DataRow getRow(int index) {
    final reportResult = viewModel.reportResult;
    if (index == 0) {
      return reportResult!.tableFilters(
          context,
          textEditingControllers[viewModel.reportState.report],
          textEditingFocusNodes[viewModel.reportState.report],
          (column, value) => onFilterChanged(column, value));
    } else {
      return reportResult!.tableRow(context, viewModel, index);
    }
  }
}

class ReportResult {
  ReportResult({
    required this.columns,
    required this.allColumns,
    required this.defaultColumns,
    required this.data,
    this.entities,
    this.showTotals = true,
  });

  final List<String> columns;
  final List<String> allColumns;
  final List<String> defaultColumns;
  final List<List<ReportElement>> data;
  final List<BaseEntity>? entities;
  final bool showTotals;

  static bool? matchField({
    required String column,
    required dynamic value,
    required UserCompanyEntity userCompany,
    required ReportsUIState reportsUIState,
    AppLocalization? localization,
  }) {
    if (reportsUIState.filters.containsKey(column)) {
      final filter = reportsUIState.filters[column]!;

      if (filter.isNotEmpty) {
        if (column == 'age') {
          final min = kAgeGroups[filter];
          if (filter == kAgeGroupPaid) {
            return value == -1;
          } else if (filter == kAgeGroup120) {
            return value > min;
          } else {
            final max = min! + 30;
            if (value < min || value >= max) {
              return false;
            }
          }
        } else if (value.runtimeType == int || value.runtimeType == double) {
          if (!ReportResult.matchAmount(filter: filter, amount: value)) {
            return false;
          }
        } else if (value.runtimeType == bool ||
            filter == 'true' ||
            filter == 'false') {
          // Support custom fields
          String boolFilter = filter;
          if (filter.toLowerCase() == 'yes') {
            boolFilter = 'true';
          } else if (filter.toLowerCase() == 'no') {
            boolFilter = 'false';
          }
          if (value.runtimeType == String) {
            if (value.toLowerCase() == 'yes') {
              value = 'true';
            } else if (value.toLowerCase() == 'no') {
              value = 'false';
            }
          }
          if (boolFilter != '$value') {
            return false;
          }
        } else if (value.runtimeType == EntityType) {
          return filter.toLowerCase() == '$value'.toLowerCase();
        } else if (isValidDate(value)) {
          if (!ReportResult.matchDateTime(
              filter: filter,
              value: value,
              reportsUIState: reportsUIState,
              userCompany: userCompany)) {
            return false;
          }
        } else if (!ReportResult.matchString(filter: filter, value: value)) {
          return false;
        }
      }
    }

    return true;
  }

  static bool matchString({
    required String filter,
    String? value,
  }) {
    filter = filter.trim();

    if (filter.isEmpty) {
      return true;
    }

    value = (value ?? '').toLowerCase();
    filter = filter.toLowerCase();

    if (filter == 'null' && value.isEmpty) {
      return true;
    }

    if (value.contains(filter)) {
      return true;
    }

    final localization = AppLocalization.of(navigatorKey.currentContext!)!;
    if (localization.lookup(value).toLowerCase().contains(filter)) {
      return true;
    }

    return false;
  }

  static bool matchAmount({required String filter, required num amount}) {
    final String range = filter.replaceAll(',', '-') + '-';
    final List<String> parts = range.split('-');
    final min = parseDouble(parts[0])!;
    final max = parts.length > 1 ? parseDouble(parts[1]) : 0;

    if (amount < min || (max! > 0 && amount > max)) {
      return false;
    }

    return true;
  }

  static bool matchDateTime({
    required String filter,
    required String value,
    required UserCompanyEntity userCompany,
    required ReportsUIState reportsUIState,
  }) {
    DateRange dateRange = DateRange.last30Days;
    try {
      dateRange = DateRange.valueOf(filter);
    } catch (exception) {
      //
    }

    final startDate = calculateStartDate(
      dateRange: dateRange,
      company: userCompany.company,
      customStartDate: reportsUIState.customStartDate,
      customEndDate: reportsUIState.customEndDate,
    );
    final endDate = calculateEndDate(
      dateRange: dateRange,
      company: userCompany.company,
      customStartDate: reportsUIState.customStartDate,
      customEndDate: reportsUIState.customEndDate,
    );

    final customStartDate = reportsUIState.customStartDate;
    final customEndDate = reportsUIState.customEndDate;

    value = value.split('T').first;

    if (dateRange == DateRange.custom) {
      if (customStartDate.isNotEmpty && customEndDate.isNotEmpty) {
        if (!(startDate!.compareTo(value) <= 0 &&
            endDate!.compareTo(value) >= 0)) {
          return false;
        }
      } else if (customStartDate.isNotEmpty) {
        if (!(startDate!.compareTo(value) <= 0)) {
          return false;
        }
      } else if (customEndDate.isNotEmpty) {
        if (!(endDate!.compareTo(value) >= 0)) {
          return false;
        }
      }
    } else {
      if (!(startDate!.compareTo(value) <= 0 &&
          endDate!.compareTo(value) >= 0)) {
        return false;
      }
    }

    return true;
  }

  List<String> sortedColumns(ReportsUIState reportState) {
    final data = columns.toList();
    final group = reportState.group;

    if (group.isNotEmpty) {
      data.remove(group);
      data.insert(0, group);
    }

    return data;
  }

  List<DataColumn> tableColumns(
      BuildContext context, Function(int, bool) onSortCallback) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final company = store.state.company;
    final reportState = store.state.uiState.reportsUIState;

    return [
      for (String? column in sortedColumns(reportState))
        DataColumn(
          label: Container(
            constraints: BoxConstraints(minWidth: kTableColumnWidthMin),
            child: Row(
              children: [
                Text(
                  (company.getCustomFieldLabel(column!).isNotEmpty
                          ? company.getCustomFieldLabel(column)
                          : localization!.lookup(column)) +
                      '   ',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (column == reportState.group)
                  IconButton(
                      onPressed: () {
                        store.dispatch(UpdateReportSettings(
                          report: reportState.report,
                          group: '',
                        ));
                      },
                      icon: Icon(Icons.clear, color: Colors.grey))
              ],
            ),
          ),
          numeric:
              getReportColumnType(column, context) == ReportColumnType.number,
          onSort: onSortCallback,
        )
    ];
  }

  DataRow tableFilters(
      BuildContext context,
      Map<String, TextEditingController>? textEditingControllers,
      Map<String, FocusNode>? textEditingFocusNodes,
      Function(String, String) onFilterChanged) {
    final localization = AppLocalization.of(context);
    final theme = Theme.of(context);
    final store = StoreProvider.of<AppState>(context);
    final reportState = store.state.uiState.reportsUIState;

    return DataRow(cells: [
      for (String column in sortedColumns(reportState))
        if (textEditingControllers == null ||
            !textEditingControllers.containsKey(column))
          DataCell(Text(''))
        else if (getReportColumnType(column, context) == ReportColumnType.bool)
          DataCell(AppDropdownButton<bool>(
            labelText: null,
            showBlank: true,
            blankValue: null,
            value: textEditingControllers[column]!.text == 'true'
                ? true
                : textEditingControllers[column]!.text == 'false'
                    ? false
                    : null,
            onChanged: (dynamic value) {
              if (value == null) {
                textEditingControllers[column]!.text = '';
                onFilterChanged(column, '');
              } else {
                textEditingControllers[column]!.text = value.toString();
                onFilterChanged(column, value.toString());
              }
            },
            items: [
              DropdownMenuItem(
                child: Text(AppLocalization.of(context)!.yes),
                value: true,
              ),
              DropdownMenuItem(
                child: Text(AppLocalization.of(context)!.no),
                value: false,
              ),
            ],
          ))
        else if (getReportColumnType(column, context) == ReportColumnType.age)
          DataCell(AppDropdownButton<String>(
            value: textEditingControllers[column]!.text.isNotEmpty &&
                    textEditingControllers[column]!.text != 'null'
                ? textEditingControllers[column]!.text
                : null,
            showBlank: true,
            onChanged: (dynamic value) {
              textEditingControllers[column]!.text = value;
              onFilterChanged(column, value);
            },
            items: kAgeGroups.keys
                .map((ageGroup) => DropdownMenuItem(
                      child: Text(localization!.lookup(ageGroup)),
                      value: ageGroup,
                    ))
                .toList(),
          ))
        else if ([
          ReportColumnType.number,
          ReportColumnType.duration,
        ].contains(getReportColumnType(column, context)))
          DataCell(TextFormField(
            controller: textEditingControllers[column],
            keyboardType:
                TextInputType.numberWithOptions(decimal: true, signed: true),
            decoration: InputDecoration(
                suffixIcon: (textEditingControllers[column]?.text ?? '').isEmpty
                    ? null
                    : IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          textEditingControllers[column]!.text = '';
                          onFilterChanged(column, '');
                        },
                      )),
          ))
        else if ([
          ReportColumnType.date,
          ReportColumnType.dateTime,
        ].contains(getReportColumnType(column, context)))
          DataCell(AppDropdownButton<DateRange>(
            labelText: null,
            showBlank: true,
            blankValue: null,
            value: (reportState.filters[column] ?? '').isNotEmpty
                ? DateRange.valueOf(reportState.filters[column]!)
                : null,
            onChanged: (dynamic value) {
              if (value == null) {
                textEditingControllers[column]!.text = '';
                onFilterChanged(column, '');
              } else {
                textEditingControllers[column]!.text = value.toString();
                onFilterChanged(column, value.toString());
              }
            },
            items: DateRange.values
                .where((value) => value != DateRange.allTime)
                .map((dateRange) => DropdownMenuItem<DateRange>(
                      child: Text(localization!.lookup(dateRange.toString())),
                      value: dateRange,
                    ))
                .toList(),
          ))
        // TODO remove DEMO_MODE check
        else if (Config.DEMO_MODE)
          DataCell(TextFormField(
            controller: textEditingControllers[column],
            decoration: InputDecoration(
                suffixIcon: (textEditingControllers[column]?.text ?? '').isEmpty
                    ? null
                    : IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          textEditingControllers[column]!.text = '';
                          onFilterChanged(column, '');
                        },
                      )),
          ))
        else
          DataCell(
            RawAutocomplete<String>(
              textEditingController: textEditingControllers[column],
              focusNode: textEditingFocusNodes![column],
              optionsBuilder: (TextEditingValue textEditingValue) {
                final filter = textEditingValue.text.toLowerCase();
                final index = columns.indexOf(column);
                final options = data
                    .where((row) =>
                        row[index]
                            .renderText(context, column)!
                            .toLowerCase()
                            .contains(filter) &&
                        row[index]
                            .renderText(context, column)!
                            .trim()
                            .isNotEmpty)
                    .map((row) => row[index].renderText(context, column))
                    .whereType<String>()
                    .toSet()
                    .toList();

                return options;
              },
              onSelected: (value) {
                final textEditingController = textEditingControllers[column]!;
                textEditingController.text = value;
                onFilterChanged(column, value);
                textEditingFocusNodes[column]!.requestFocus();
                WidgetsBinding.instance.addPostFrameCallback((duration) {
                  textEditingController.selection = TextSelection.fromPosition(
                      TextPosition(offset: textEditingController.text.length));
                });
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted) {
                return DecoratedFormField(
                  keyboardType: TextInputType.text,
                  decoration: textEditingController.text.isEmpty
                      ? null
                      : InputDecoration(
                          suffixIcon: IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            textEditingControllers[column]!.text = '';
                            onFilterChanged(column, '');
                            textEditingFocusNodes[column]!.unfocus();
                          },
                        )),
                  controller: textEditingController,
                  focusNode: focusNode,
                  onFieldSubmitted: (String value) {
                    onFieldSubmitted();
                  },
                );
              },
              optionsViewBuilder: (BuildContext context,
                  AutocompleteOnSelected<String> onSelected,
                  Iterable<String> options) {
                final highlightedIndex =
                    AutocompleteHighlightedOption.of(context);
                return Theme(
                  data: theme,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      elevation: 4,
                      child: AppBorder(
                        child: Container(
                          color: Theme.of(context).cardColor,
                          width: 250,
                          constraints: BoxConstraints(maxHeight: 270),
                          child: ScrollableListViewBuilder(
                            itemCount: options.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                color: highlightedIndex == index
                                    ? convertHexStringToColor(
                                        store.state.prefState.enableDarkMode
                                            ? kDefaultDarkSelectedColor
                                            : kDefaultLightSelectedColor)
                                    : Theme.of(context).cardColor,
                                child: ListTile(
                                  title: Text(options.elementAt(index),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                  onTap: () => onSelected(
                                    options.elementAt(index),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
    ]);
  }

  DataRow tableRow(BuildContext context, ReportsScreenVM viewModel, int index) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final reportState = state.uiState.reportsUIState;
    final groupBy = reportState.group;
    final sorted = sortedColumns(reportState);

    if (groupBy.isEmpty || reportState.isGroupByFiltered) {
      final row = data[index - 1];
      final cells = <DataCell>[];
      for (var j = 0; j < row.length; j++) {
        final index = columns.indexOf(sorted[j]);
        final cell = row[index];
        final column = sorted[j];
        cells.add(
          DataCell(
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: kTableColumnWidthMax),
              child: cell.renderWidget(context, column),
            ),
            onTap: () {
              viewEntityById(
                  entityId: cell.entityId, entityType: cell.entityType);
            },
          ),
        );
      }
      return DataRow(cells: cells);
    } else {
      final groupTotals = viewModel.groupTotals;
      final group = groupTotals.rows![index - 1];
      final values = viewModel.groupTotals.totals![group];
      final cells = <DataCell>[];
      final localization = AppLocalization.of(context);

      for (var column in sortedColumns(reportState)) {
        String? value = '';
        final columnType = getReportColumnType(column, context);
        if (column == groupBy) {
          if (group!.isEmpty) {
            value = localization!.blank;
          } else if (columnType == ReportColumnType.dateTime ||
              columnType == ReportColumnType.date) {
            value = formatDate(group, context);
          } else if (columnType == ReportColumnType.age ||
              EntityPresenter.isFieldLocalized(column)) {
            value = localization!.lookup(group);
          } else {
            value = group == 'null' ? localization!.blank : group;
          }
          value = value + ' (' + values!['count']!.floor().toString() + ')';
        } else if (columnType == ReportColumnType.number) {
          final currencyId = values!['${column}_currency_id'];
          value = formatNumber(values[column], context,
              formatNumberType: column.toLowerCase().contains('quantity')
                  ? FormatNumberType.double
                  : FormatNumberType.money,
              currencyId:
                  currencyId == null ? null : currencyId.round().toString());
        } else if (columnType == ReportColumnType.duration) {
          value = formatDuration(Duration(seconds: values![column]!.toInt()));
        }

        cells.add(DataCell(Text(value!), onTap: () {
          if (group!.isEmpty) {
            return;
          }
          if (column == groupBy) {
            String filter = group;
            String? customStartDate;
            String? customEndDate;
            if (getReportColumnType(column, context) ==
                    ReportColumnType.dateTime ||
                getReportColumnType(column, context) == ReportColumnType.date) {
              filter = DateRange.custom.toString();
              final date = DateTime.tryParse(group);
              customStartDate = group;
              if (reportState.subgroup == kReportGroupDay) {
                customEndDate = convertDateTimeToSqlDate(date);
              } else if (reportState.subgroup == kReportGroupQuarter) {
                customEndDate =
                    convertDateTimeToSqlDate(addDays(addMonths(date!, 3), -1));
              } else if (reportState.subgroup == kReportGroupMonth) {
                customEndDate =
                    convertDateTimeToSqlDate(addDays(addMonths(date!, 1), -1));
              } else if (reportState.subgroup == kReportGroupWeek) {
                customEndDate = convertDateTimeToSqlDate(addDays(date!, 6));
              } else {
                customEndDate =
                    convertDateTimeToSqlDate(addDays(addYears(date!, 1), -1));
              }
            } else if (getReportColumnType(column, context) ==
                ReportColumnType.bool) {
              filter = filter == localization!.yes
                  ? 'true'
                  : filter == localization.no
                      ? 'false'
                      : '';
            }
            store.dispatch(
              UpdateReportSettings(
                report: reportState.report,
                selectedGroup: filter,
                customStartDate: customStartDate,
                customEndDate: customEndDate,
                filters: reportState.filters
                    .rebuild((b) => b..addAll({column: filter})),
              ),
            );
          }
        }));
      }

      return DataRow(cells: cells);
    }
  }

  List<mt.DataColumn> totalColumns(
      BuildContext context, Function(int, bool) onSortCallback) {
    final store = StoreProvider.of<AppState>(context);
    final company = store.state.company;
    final localization = AppLocalization.of(context)!;
    final sortedColumns = columns
        .where((column) => canTotalColumn(column))
        .toList()
      ..sort((String? str1, String? str2) => str1!.compareTo(str2!));

    //for (String column in sortedColumns)
    //  print('## $column => ${getReportColumnType(column, context)}');

    final totalColumns = [
      mt.DataColumn(
        label: Text(localization.currency),
        onSort: onSortCallback,
      ),
      mt.DataColumn(
        label: Text(localization.count),
        onSort: onSortCallback,
      ),
      for (String? column in sortedColumns)
        if ([
          ReportColumnType.number,
          ReportColumnType.age,
          ReportColumnType.duration,
        ].contains(getReportColumnType(column, context)))
          mt.DataColumn(
            label: Text(
              company.getCustomFieldLabel(column!).isEmpty
                  ? localization.lookup(column)
                  : company.getCustomFieldLabel(column),
              overflow: TextOverflow.ellipsis,
            ),
            numeric: true,
            onSort: onSortCallback,
          )
    ];

    //print('## Total Columns: ${totalColumns.length}');

    return totalColumns;
  }

  List<mt.DataRow> totalRows(BuildContext context) {
    final rows = <mt.DataRow>[];
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final reportState = state.uiState.reportsUIState;
    final settings = state.userCompany.settings;
    final reportSettings =
        settings.reportSettings.containsKey(reportState.report)
            ? settings.reportSettings[reportState.report]!
            : ReportSettingsEntity();

    final Map<String, Map<String?, double>> totals = {};

    final allColumns = <String?>[];

    for (var i = 0; i < data.length; i++) {
      final row = data[i];
      bool countedRow = false;
      for (var j = 0; j < row.length; j++) {
        final cell = row[j];
        final column = columns[j];
        final canTotal = (cell is ReportIntValue ||
                cell is ReportNumberValue ||
                cell is ReportDurationValue ||
                cell is ReportAgeValue) &&
            canTotalColumn(column);
        String currencyId = '';
        if (canTotal) {
          if (!allColumns.contains(column)) {
            allColumns.add(column);
          }

          if (cell is ReportNumberValue) {
            currencyId = cell.currencyId ?? '';
          } else if (cell is ReportAgeValue) {
            currencyId = cell.currencyId ?? '';
          } else if (cell is ReportDurationValue) {
            currencyId = cell.currencyId ?? '';
          }

          // if the specific cell doesn't have a currency
          // set then find it in the row
          if (currencyId.isEmpty) {
            for (var k = 0; k < row.length; k++) {
              final cell = row[k];
              if (cell is ReportNumberValue) {
                currencyId = cell.currencyId ?? '';
              } else if (cell is ReportAgeValue) {
                currencyId = cell.currencyId ?? '';
              } else if (cell is ReportDurationValue) {
                currencyId = cell.currencyId ?? '';
              }
            }
          }

          if (!totals.containsKey(currencyId)) {
            totals[currencyId] = {'count': 0};
          }
          if (!countedRow) {
            totals[currencyId]!['count'] = totals[currencyId]!['count']! + 1;
            countedRow = true;
          }
          if (!totals[currencyId]!.containsKey(column)) {
            totals[currencyId]![column] = 0;
          }
          totals[currencyId]![column] =
              totals[currencyId]![column]! + cell.doubleValue!;
        }
      }
    }

    for (var currencyId in totals.keys) {
      for (var column in allColumns) {
        if (!totals[currencyId]!.containsKey(column)) {
          totals[currencyId]![column] = 0;
        }
      }
    }

    final keys = totals.keys.whereNotNull().toList();
    keys.sort((rowA, rowB) {
      dynamic valueA;
      dynamic valueB;

      if (reportSettings.sortTotalsIndex == 0) {
        final currencyMap = state.staticState.currencyMap;
        valueA = currencyMap[rowA]?.listDisplayName;
        valueB = currencyMap[rowB]?.listDisplayName;
      } else if (reportSettings.sortTotalsIndex == 1) {
        valueA = totals[rowA]!['count'];
        valueB = totals[rowB]!['count'];
      } else {
        final List<String?> fields = totals[rowA]!.keys.toList()
          ..remove('count')
          ..sort((String? str1, String? str2) => str1!.compareTo(str2!));
        final sortColumn = fields[reportSettings.sortTotalsIndex - 2];
        valueA = totals[rowA]![sortColumn];
        valueB = totals[rowB]![sortColumn];
      }

      if (valueA == null || valueB == null) {
        return 0;
      }

      return reportSettings.sortTotalsAscending
          ? valueA.compareTo(valueB)
          : valueB.compareTo(valueA);
    });

    List<String?> allFields = [];
    keys.forEach((currencyId) {
      final values = totals[currencyId]!;
      allFields.addAll(values.keys);
    });
    allFields = allFields.toSet().toList()
      ..sort((String? str1, String? str2) => str1!.compareTo(str2!));

    keys.forEach((currencyId) {
      final values = totals[currencyId]!;
      final cells = <mt.DataCell>[
        mt.DataCell(Text(
            store.state.staticState.currencyMap[currencyId]?.listDisplayName ??
                '')),
        mt.DataCell(Text(values['count']!.toInt().toString())),
      ];

      allFields.forEach((field) {
        final amount = values[field];
        if (field != 'count') {
          String? value;
          if (field == 'age') {
            value = formatNumber(amount! / values['count']!, context,
                formatNumberType: FormatNumberType.double);
          } else if (field == 'duration') {
            value = formatDuration(Duration(seconds: amount!.toInt()));
          } else {
            value = formatNumber(amount, context,
                currencyId: currencyId,
                formatNumberType: EntityPresenter.isFieldAmount(field)
                    ? FormatNumberType.double
                    : FormatNumberType.money);
          }
          cells.add(mt.DataCell(Text(value!)));
        }
      });

      //print('## Total Rows: ${cells.length}');
      rows.add(mt.DataRow(cells: cells));
    });

    return rows;
  }
}

abstract class ReportElement {
  ReportElement({this.entityType, this.entityId});

  final EntityType? entityType;
  final String? entityId;

  double? get doubleValue => 0;

  String? get stringValue => '';

  Widget renderWidget(BuildContext context, String? column) {
    throw 'Error: need to override renderWidget()';
  }

  String? renderText(BuildContext context, String? column) {
    throw 'Error: need to override sortString()';
  }
}

class ReportStringValue extends ReportElement {
  ReportStringValue({
    required this.value,
    required EntityType? entityType,
    required String entityId,
  }) : super(entityType: entityType, entityId: entityId);

  final String? value;

  @override
  String? get stringValue => value;

  @override
  Widget renderWidget(BuildContext context, String? column) {
    return Text(
      renderText(context, column)!,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  @override
  String? renderText(BuildContext context, String? column) {
    if (getReportColumnType(column, context) == ReportColumnType.dateTime ||
        getReportColumnType(column, context) == ReportColumnType.date) {
      return formatDate(value, context,
          showTime: getReportColumnType(column, context) ==
              ReportColumnType.dateTime);
    } else if (EntityPresenter.isFieldLocalized(column)) {
      return AppLocalization.of(context)!.lookup(value);
    } else {
      return value ?? '';
    }
  }
}

class ReportEntityTypeValue extends ReportElement {
  ReportEntityTypeValue({
    required this.value,
    required EntityType? entityType,
    required String? entityId,
  }) : super(entityType: entityType, entityId: entityId);

  final EntityType? value;

  @override
  String get stringValue => '$value';

  @override
  Widget renderWidget(BuildContext context, String? column) {
    return Text(renderText(context, column)!);
  }

  @override
  String? renderText(BuildContext context, String? column) {
    return AppLocalization.of(context)!.lookup('$value');
  }
}

class ReportAgeValue extends ReportElement {
  ReportAgeValue({
    required this.value,
    required EntityType? entityType,
    required String entityId,
    required this.currencyId,
  }) : super(entityType: entityType, entityId: entityId);

  final int? value;
  final String? currencyId;

  @override
  String get stringValue => '$value';

  @override
  double get doubleValue => value == -1 ? 0 : value!.toDouble();

  @override
  Widget renderWidget(BuildContext context, String? column) {
    return Text(renderText(context, column));
  }

  @override
  String renderText(BuildContext context, String? column) {
    return value == -1 ? AppLocalization.of(context)!.paid : '$value';
  }
}

class ReportDurationValue extends ReportElement {
  ReportDurationValue({
    required this.value,
    required EntityType? entityType,
    required String entityId,
    required this.currencyId,
  }) : super(entityType: entityType, entityId: entityId);

  final int? value;
  final String? currencyId;

  @override
  String get stringValue => '$value';

  @override
  double get doubleValue => value!.toDouble();

  @override
  Widget renderWidget(BuildContext context, String? column) {
    return Text(renderText(context, column));
  }

  @override
  String renderText(BuildContext context, String? column) {
    return formatDuration(Duration(seconds: value!));
  }
}

class ReportIntValue extends ReportElement {
  ReportIntValue({
    this.value,
    EntityType? entityType,
    String? entityId,
  }) : super(entityType: entityType, entityId: entityId);

  final int? value;

  @override
  String get stringValue => '$value';

  @override
  double get doubleValue => value!.toDouble();

  @override
  Widget renderWidget(BuildContext context, String? column) {
    return Text(renderText(context, column)!);
  }

  @override
  String? renderText(BuildContext context, String? column) {
    return formatNumber(value!.toDouble(), context,
        formatNumberType: FormatNumberType.int);
  }
}

class ReportNumberValue extends ReportElement {
  ReportNumberValue({
    required this.value,
    required EntityType? entityType,
    required String entityId,
    required this.currencyId,
    required this.exchangeRate,
    this.formatNumberType = FormatNumberType.money,
  }) : super(entityType: entityType, entityId: entityId);

  final double? value;
  final FormatNumberType? formatNumberType;
  final String? currencyId;
  final double? exchangeRate;

  @override
  double? get doubleValue => value;

  @override
  String get stringValue => '$value';

  @override
  Widget renderWidget(BuildContext context, String? column) {
    return Text(renderText(context, column)!);
  }

  @override
  String? renderText(BuildContext context, String? column) {
    if (currencyId == null ||
        column!.endsWith('_rate') ||
        column.endsWith('_rate1') ||
        column.endsWith('_rate2') ||
        column.endsWith('_rate3')) {
      return formatNumber(value, context,
          formatNumberType: FormatNumberType.double);
    }

    return formatNumber(value, context,
        currencyId: currencyId,
        formatNumberType: formatNumberType ?? FormatNumberType.money);
  }
}

class ReportBoolValue extends ReportElement {
  ReportBoolValue({
    required this.value,
    required EntityType? entityType,
    required String entityId,
  }) : super(entityType: entityType, entityId: entityId);

  final bool? value;

  @override
  String get stringValue => '$value';

  @override
  Widget renderWidget(BuildContext context, String? column) {
    final localization = AppLocalization.of(context);
    return SizedBox(
      width: 80,
      child: Text(
        value == true ? localization!.yes : localization!.no,
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  String renderText(BuildContext context, String? column) {
    final localization = AppLocalization.of(context);
    return value == true ? localization!.yes : localization!.no;
  }
}

int? sortReportTableRows(dynamic rowA, dynamic rowB,
    ReportSettingsEntity reportSettings, List<String?> columns) {
  if (reportSettings.sortColumn.isEmpty) {
    return 0;
  }

  final index = columns.indexOf(reportSettings.sortColumn);

  if (index == -1) {
    return 0;
  } else if (rowA.length <= index || rowB.length <= index) {
    return 0;
  }

  final dynamic valueA = rowA[index].value;
  final dynamic valueB = rowB[index].value;

  if (valueA is bool) {
    if (reportSettings.sortAscending) {
      return valueA ? 1 : -1;
    } else {
      return valueA ? -1 : 1;
    }
  }

  if (reportSettings.sortAscending) {
    return valueA.compareTo(valueB);
  } else {
    return valueB.compareTo(valueA);
  }
}
