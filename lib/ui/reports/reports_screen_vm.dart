import 'dart:async';
import 'dart:io' as file;
import 'package:flutter_share/flutter_share.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/static/currency_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_actions.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/reports/client_report.dart';
import 'package:invoiceninja_flutter/ui/reports/document_report.dart';
import 'package:invoiceninja_flutter/ui/reports/expense_report.dart';
import 'package:invoiceninja_flutter/ui/reports/invoice_report.dart';
import 'package:invoiceninja_flutter/ui/reports/invoice_item_report.dart';
import 'package:invoiceninja_flutter/ui/reports/payment_report.dart';
import 'package:invoiceninja_flutter/ui/reports/payment_tax_report.dart';
import 'package:invoiceninja_flutter/ui/reports/product_report.dart';
import 'package:invoiceninja_flutter/ui/reports/profit_loss_report.dart';
import 'package:invoiceninja_flutter/ui/reports/quote_item_report.dart';
import 'package:invoiceninja_flutter/ui/reports/quote_report.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:invoiceninja_flutter/ui/reports/task_report.dart';
import 'package:invoiceninja_flutter/ui/reports/tax_report.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/money.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';
import 'package:memoize/memoize.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';

import 'credit_report.dart';

class ReportsScreenBuilder extends StatelessWidget {
  const ReportsScreenBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ReportsScreenVM>(
      converter: ReportsScreenVM.fromStore,
      builder: (context, vm) {
        return ReportsScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class ReportsScreenVM {
  ReportsScreenVM({
    @required this.state,
    @required this.onSettingsChanged,
    @required this.onReportColumnsChanged,
    @required this.onReportFiltersChanged,
    @required this.onExportPressed,
    @required this.onReportSorted,
    @required this.groupTotals,
    @required this.reportResult,
    @required this.onReportTotalsSorted,
    @required this.reportState,
  });

  final AppState state;
  final ReportResult reportResult;
  final ReportsUIState reportState;
  final GroupTotals groupTotals;
  final Function(BuildContext, List<String>) onReportColumnsChanged;
  final Function(BuildContext) onExportPressed;
  final Function(BuildContext, BuiltMap<String, String>) onReportFiltersChanged;
  final Function(String, bool) onReportSorted;
  final Function(int, bool) onReportTotalsSorted;
  final Function({
    String report,
    String customStartDate,
    String customEndDate,
    String group,
    String selectedGroup,
    String subgroup,
    String chart,
  }) onSettingsChanged;

  static ReportsScreenVM fromStore(Store<AppState> store) {
    final state = store.state;
    final report = state.uiState.reportsUIState.report;
    final allReportSettings = state.userCompany?.settings?.reportSettings;
    final reportSettings =
        allReportSettings != null && allReportSettings.containsKey(report)
            ? allReportSettings[report]
            : ReportSettingsEntity();

    ReportResult reportResult;

    switch (state.uiState.reportsUIState.report) {
      case kReportInvoice:
        reportResult = memoizedInvoiceReport(
          state.userCompany,
          state.uiState.reportsUIState,
          state.invoiceState.map,
          state.clientState.map,
          state.userState.map,
          state.staticState,
        );
        break;
      case kReportDocument:
        reportResult = memoizedDocumentReport(
          state.userCompany,
          state.uiState.reportsUIState,
          state.clientState.map,
          state.productState.map,
          state.invoiceState.map,
          state.quoteState.map,
          state.expenseState.map,
          state.projectState.map,
          state.vendorState.map,
          state.userState.map,
        );
        break;
      case kReportExpense:
        reportResult = memoizedExpenseReport(
          state.userCompany,
          state.uiState.reportsUIState,
          state.expenseState.map,
          state.expenseCategoryState.map,
          state.invoiceState.map,
          state.clientState.map,
          state.vendorState.map,
          state.userState.map,
          state.staticState,
        );
        break;
      case kReportPayment:
        reportResult = memoizedPaymentReport(
          state.userCompany,
          state.uiState.reportsUIState,
          state.paymentState.map,
          state.clientState.map,
          state.vendorState.map,
          state.userState.map,
          state.staticState,
        );
        break;
      case kReportProduct:
        reportResult = memoizedProductReport(
          state.userCompany,
          state.uiState.reportsUIState,
          state.productState.map,
          state.vendorState.map,
          state.userState.map,
          state.staticState,
        );
        break;
      case kReportTask:
        reportResult = memoizedTaskReport(
          state.userCompany,
          state.uiState.reportsUIState,
          state.taskState.map,
          state.invoiceState.map,
          state.groupState.map,
          state.clientState.map,
          state.taskStatusState.map,
          state.userState.map,
          state.projectState.map,
          state.staticState,
        );
        break;
      case kReportQuote:
        reportResult = memoizedQuoteReport(
          state.userCompany,
          state.uiState.reportsUIState,
          state.quoteState.map,
          state.clientState.map,
          state.vendorState.map,
          state.userState.map,
          state.staticState,
        );
        break;
      case kReportTax:
        reportResult = memoizedTaxReport(
          state.userCompany,
          state.uiState.reportsUIState,
          state.taxRateState.map,
          state.invoiceState.map,
          state.creditState.map,
          state.clientState.map,
          state.paymentState.map,
          state.userState.map,
          state.staticState,
        );
        break;
      case kReportPaymentTax:
        reportResult = memoizedPaymentTaxReport(
          state.userCompany,
          state.uiState.reportsUIState,
          state.taxRateState.map,
          state.invoiceState.map,
          state.creditState.map,
          state.clientState.map,
          state.paymentState.map,
          state.userState.map,
          state.staticState,
        );
        break;
      case kReportCredit:
        reportResult = memoizedCreditReport(
          state.userCompany,
          state.uiState.reportsUIState,
          state.creditState.map,
          state.clientState.map,
          state.userState.map,
          state.staticState,
        );
        break;
      case kReportProfitAndLoss:
        reportResult = memoizedProfitAndLossReport(
          state.userCompany,
          state.uiState.reportsUIState,
          state.clientState.map,
          state.paymentState.map,
          state.expenseState.map,
          state.expenseCategoryState.map,
          state.vendorState.map,
          state.userState.map,
          state.staticState,
        );
        break;
      case kReportInvoiceItem:
        reportResult = memoizedInvoiceItemReport(
          state.userCompany,
          state.uiState.reportsUIState,
          state.productState.map,
          state.invoiceState.map,
          state.clientState.map,
          state.staticState,
        );
        break;
      case kReportQuoteItem:
        reportResult = memoizedQuoteItemReport(
          state.userCompany,
          state.uiState.reportsUIState,
          state.productState.map,
          state.invoiceState.map,
          state.clientState.map,
          state.staticState,
        );
        break;
      default:
        reportResult = memoizedClientReport(
          state.userCompany,
          state.uiState.reportsUIState,
          state.clientState.map,
          state.userState.map,
          state.staticState,
        );
        break;
    }

    final groupTotals = memoizeedGroupTotals(
      reportResult,
      state.uiState.reportsUIState,
      reportSettings,
      state.staticState.currencyMap,
      state.company,
    );

    return ReportsScreenVM(
        state: state,
        reportResult: reportResult,
        reportState: state.uiState.reportsUIState,
        groupTotals: groupTotals,
        onReportSorted: (column, ascending) {
          store.dispatch(UpdateReportSettings(
            report: state.uiState.reportsUIState.report,
            sortColumn: column,
          ));
        },
        onReportTotalsSorted: (index, ascending) {
          store.dispatch(UpdateReportSettings(
            report: state.uiState.reportsUIState.report,
            sortTotalsIndex: index,
          ));
        },
        onReportFiltersChanged: (context, filterMap) {
          Timer(Duration(milliseconds: 100), () {
            store.dispatch(UpdateReportSettings(
              report: report,
              filters: filterMap,
              selectedGroup: '',
            ));
          });
        },
        onReportColumnsChanged: (context, columns) {
          final settings = state.userCompany.settings.rebuild((b) => b
            ..reportSettings[state.uiState.reportsUIState.report] =
                reportSettings.rebuild(
                    (b) => b..columns.replace(BuiltList<String>(columns))));
          final userCompany =
              state.userCompany.rebuild((b) => b..settings.replace(settings));
          final user =
              state.user.rebuild((b) => b..userCompany.replace(userCompany));
          final completer = snackBarCompleter<Null>(
              context, AppLocalization.of(context).savedSettings);
          store.dispatch(
            SaveUserSettingsRequest(
              completer: completer,
              user: user,
            ),
          );
        },
        onSettingsChanged: ({
          String report,
          String group,
          String selectedGroup,
          String subgroup,
          String chart,
          String customStartDate,
          String customEndDate,
        }) {
          Timer(Duration(milliseconds: 100), () {
            final reportState = state.uiState.reportsUIState;
            if (group != null && reportState.group != group) {
              store.dispatch(UpdateReportSettings(
                report: report ?? reportState.report,
                group: group,
                chart: chart,
                subgroup: subgroup,
                selectedGroup: '',
                customStartDate: '',
                customEndDate: '',
                filters: BuiltMap<String, String>(),
              ));
            } else {
              store.dispatch(UpdateReportSettings(
                report: report ?? reportState.report,
                group: group,
                selectedGroup: selectedGroup,
                subgroup: subgroup,
                chart: chart,
                customStartDate: customStartDate,
                customEndDate: customEndDate,
              ));
            }
          });
        },
        onExportPressed: (context) async {
          final localization = AppLocalization.of(context);
          final reportState = state.uiState.reportsUIState;
          String csvData = '';

          if (reportState.group.isEmpty || reportState.isGroupByFiltered) {
            reportResult.columns.forEach((column) {
              final value = localization.lookup(column);
              csvData += '"$value",';
            });
            csvData = csvData.substring(0, csvData.length - 1);
            reportResult.data.forEach((row) {
              csvData += '\n';
              for (var i = 0; i < row.length; i++) {
                final column = reportResult.columns[i];
                final value = row[i].renderText(context, column).trim();
                csvData += '"$value",';
              }
              csvData = csvData.substring(0, csvData.length - 1);
            });
          } else {
            final columns = reportResult.columns
                .where((column) =>
                    getReportColumnType(column, context) ==
                    ReportColumnType.number)
                .toList();
            columns.sort((String str1, String str2) => str1.compareTo(str2));

            csvData += localization.lookup(reportState.group) +
                ',' +
                localization.count;

            columns.forEach((column) {
              csvData += ',' + localization.lookup(column);
            });

            csvData += '\n';

            groupTotals.rows.forEach((group) {
              final row = groupTotals.totals[group];
              csvData += '$group,${row['count'].toInt()}';

              columns.forEach((column) {
                final value = row[column].toString();
                csvData += value.contains(' ') ? '"$value",' : '$value,';
              });

              csvData += '\n';
            });
          }

          final date = convertDateTimeToSqlDate();
          final filename =
              '${state.uiState.reportsUIState.report}_report_$date.csv';

          if (kIsWeb) {
            WebUtils.downloadTextFile(filename, csvData);
          } else {
            final directory = await getExternalStorageDirectory();
            final filePath = '${directory.path}/$filename';
            final csvFile = file.File(filePath);
            csvFile.writeAsString(csvData);
            await FlutterShare.shareFile(
                title: filename,
                //text: 'Example share text',
                filePath: filePath);
          }
        });
  }
}

class GroupTotals {
  GroupTotals({this.totals, this.rows});

  final Map<String, Map<String, double>> totals;
  final List<String> rows;
}

var memoizeedGroupTotals = memo5((
  ReportResult reportResult,
  ReportsUIState reportUIState,
  ReportSettingsEntity reportSettings,
  BuiltMap<String, CurrencyEntity> currencyMap,
  CompanyEntity company,
) =>
    calculateReportTotals(
      reportResult: reportResult,
      reportState: reportUIState,
      reportSettings: reportSettings,
      currencyMap: currencyMap,
      company: company,
    ));

GroupTotals calculateReportTotals({
  ReportResult reportResult,
  ReportsUIState reportState,
  ReportSettingsEntity reportSettings,
  BuiltMap<String, CurrencyEntity> currencyMap,
  CompanyEntity company,
}) {
  final Map<String, Map<String, double>> totals = {};
  final data = reportResult.data;
  final columns = reportResult.columns;

  if (reportState.group.isEmpty) {
    return GroupTotals();
  }

  for (var i = 0; i < data.length; i++) {
    final row = data[i];
    for (var j = 0; j < row.length; j++) {
      final cell = row[j];
      final column = columns[j];
      final columnIndex = columns.indexOf(reportState.group);

      if (columnIndex == -1) {
        print('## ERROR: colum not found - ${reportState.group}');
        continue;
      }

      final groupCell = row[columnIndex];
      String group = groupCell.stringValue;

      if (groupCell is ReportAgeValue) {
        final age = groupCell.doubleValue;
        if (age < 30) {
          group = kAgeGroup0;
        } else if (age < 60) {
          group = kAgeGroup30;
        } else if (age < 90) {
          group = kAgeGroup60;
        } else if (age < 120) {
          group = kAgeGroup90;
        } else {
          group = kAgeGroup120;
        }
      } else if (group.isNotEmpty && isValidDate(group)) {
        group = convertDateTimeToSqlDate(DateTime.tryParse(group));
        if (reportState.subgroup == kReportGroupYear) {
          group = group.substring(0, 4) + '-01-01';
        } else if (reportState.subgroup == kReportGroupMonth) {
          group = group.substring(0, 7) + '-01';
        }
      }

      if (!totals.containsKey(group)) {
        totals[group] = {'count': 0};
      }
      if (column == reportState.group) {
        totals[group]['count'] += 1;
      }
      if (cell is ReportNumberValue ||
          cell is ReportAgeValue ||
          cell is ReportDurationValue) {
        if (!totals[group].containsKey(column)) {
          totals[group][column] = 0;
        }

        if (cell is ReportNumberValue &&
            cell.currencyId != company.currencyId) {
          double cellValue = cell.value;
          var rate = cell.exchangeRate;
          if (rate == null || rate == 0 || rate == 1) {
            rate = getExchangeRate(currencyMap,
                fromCurrencyId: cell.currencyId,
                toCurrencyId: company.currencyId);
          }
          cellValue = cellValue * 1 / rate;
          totals[group][column] += cellValue;
        } else {
          totals[group][column] += cell.doubleValue;
        }
      }
    }
  }

  final rows = totals.keys.toList();
  final sortedColumns = reportResult.sortedColumns(reportState);
  final index = sortedColumns.contains(reportSettings.sortColumn)
      ? sortedColumns.indexOf(reportSettings.sortColumn)
      : 0;

  rows.sort((rowA, rowB) {
    final valuesA = totals[rowA];
    final valuesB = totals[rowB];
    if (index != null && index < columns.length) {
      final sort = sortedColumns[index];
      if (index == 0) {
        return reportSettings.sortAscending
            ? rowA.compareTo(rowB)
            : rowB.compareTo(rowA);
      } else {
        if (valuesA.containsKey(sort) && valuesB.containsKey(sort)) {
          return reportSettings.sortAscending
              ? valuesA[sort].compareTo(valuesB[sort])
              : valuesB[sort].compareTo(valuesA[sort]);
        }
      }
    }
    return 0;
  });

  return GroupTotals(totals: totals, rows: rows);
}
