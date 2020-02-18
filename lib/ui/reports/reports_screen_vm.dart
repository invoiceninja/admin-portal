//import 'dart:html';
import 'dart:io' as file;
import 'package:flutter_share/flutter_share.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_actions.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/reports/client_report.dart';
import 'package:invoiceninja_flutter/ui/reports/document_report.dart';
import 'package:invoiceninja_flutter/ui/reports/invoice_report.dart';
import 'package:invoiceninja_flutter/ui/reports/payment_report.dart';
import 'package:invoiceninja_flutter/ui/reports/product_report.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:invoiceninja_flutter/ui/reports/task_report.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:memoize/memoize.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';

import 'expense_report.dart';
import 'reports_screen.dart';

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
    @required this.reportTotals,
    @required this.reportResult,
  });

  final AppState state;
  final ReportResult reportResult;
  final Map<String, Map<String, double>> reportTotals;
  final Function(BuildContext, List<String>) onReportColumnsChanged;
  final Function(BuildContext) onExportPressed;
  final Function(BuildContext, BuiltMap<String, String>) onReportFiltersChanged;
  final Function(int, bool) onReportSorted;
  final Function({
    String report,
    String customStartDate,
    String customEndDate,
    String group,
    String subgroup,
    String chart,
  }) onSettingsChanged;

  static ReportsScreenVM fromStore(Store<AppState> store) {
    final state = store.state;
    final report = state.uiState.reportsUIState.report;
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
          state.documentState.map,
          state.invoiceState.map,
          state.expenseState.map,
          state.projectState.map,
          state.vendorState.map,
          state.userState.map,
          state.staticState,
        );
        break;
      case kReportExpense:
        reportResult = memoizedExpenseReport(
          state.userCompany,
          state.uiState.reportsUIState,
          state.expenseState.map,
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
          state.clientState.map,
          state.vendorState.map,
          state.userState.map,
          state.staticState,
        );
        break;
      // TODO: Obtain credit map
      //case kReportCredit:
      //  reportResult = memoizedCreditReport(
      //    state.userCompany,
      //    state.uiState.reportsUIState,
      //    state.creditState.map,
      //    state.clientState.map,
      //    state.userState.map,
      //    state.staticState,
      //  );
      //  break;
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

    return ReportsScreenVM(
        state: state,
        reportResult: reportResult,
        reportTotals:
            memoizedReportTotals(reportResult, state.uiState.reportsUIState),
        onReportSorted: (index, ascending) {
          store.dispatch(UpdateReportSettings(
            report: state.uiState.reportsUIState.report,
            sortIndex: index,
          ));
        },
        onReportFiltersChanged: (context, filterMap) {
          store.dispatch(UpdateReportSettings(
            report: report,
            filters: filterMap,
          ));
        },
        onReportColumnsChanged: (context, columns) {
          final allReportSettings = state.userCompany.settings.reportSettings;
          final reportSettings = (allReportSettings != null &&
                      allReportSettings.containsKey(report)
                  ? allReportSettings[report]
                  : ReportSettingsEntity())
              .rebuild((b) => b..columns.replace(BuiltList<String>(columns)));
          final user = state.user.rebuild((b) => b
            ..userCompany
                    .settings
                    .reportSettings[state.uiState.reportsUIState.report] =
                reportSettings);
          final completer = snackBarCompleter<Null>(
              context, AppLocalization.of(context).savedSettings);
          if (state.authState.hasRecentlyEnteredPassword) {
            store.dispatch(
              SaveUserSettingsRequest(
                completer: completer,
                user: user,
              ),
            );
          } else {
            passwordCallback(
                context: context,
                callback: (password) {
                  store.dispatch(
                    SaveUserSettingsRequest(
                      completer: completer,
                      user: user,
                      password: password,
                    ),
                  );
                });
          }
        },
        onSettingsChanged: ({
          String report,
          String group,
          String subgroup,
          String chart,
          String customStartDate,
          String customEndDate,
        }) {
          final reportState = state.uiState.reportsUIState;
          if (group != null && reportState.group != group) {
            store.dispatch(UpdateReportSettings(
              report: report ?? reportState.report,
              group: group,
              chart: chart,
              subgroup: subgroup,
              customStartDate: '',
              customEndDate: '',
              filters: BuiltMap<String, String>(),
            ));
          } else {
            store.dispatch(UpdateReportSettings(
              report: report ?? reportState.report,
              group: group,
              subgroup: subgroup,
              chart: chart,
              customStartDate: customStartDate,
              customEndDate: customEndDate,
            ));
          }
        },
        onExportPressed: (context) async {
          final localization = AppLocalization.of(context);
          String csvData = '';

          reportResult.columns.forEach((column) {
            csvData += '${localization.lookup(column)},';
          });
          csvData = csvData.substring(0, csvData.length - 1);
          reportResult.data.forEach((row) {
            csvData += '\n';
            for (var i = 0; i < row.length; i++) {
              final column = reportResult.columns[i];
              csvData += '${row[i].renderText(context, column)},';
            }
            csvData = csvData.substring(0, csvData.length - 1);
          });

          final date = convertDateTimeToSqlDate();
          final filename =
              '${state.uiState.reportsUIState.report}_report_$date.csv';

          if (kIsWeb) {
            final encodedFileContents = Uri.encodeComponent(csvData);
            /*
            AnchorElement(
                href: 'data:text/plain;charset=utf-8,$encodedFileContents')
              ..setAttribute('download', filename)
              ..click();
             */
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

var memoizedReportTotals = memo2((
  ReportResult reportResult,
  ReportsUIState reportUIState,
) =>
    calculateReportTotals(
        reportResult: reportResult, reportUIState: reportUIState));

Map<String, Map<String, double>> calculateReportTotals({
  ReportResult reportResult,
  ReportsUIState reportUIState,
}) {
  final Map<String, Map<String, double>> totals = {};
  final data = reportResult.data;
  final columns = reportResult.columns;

  if (reportUIState.group.isEmpty) {
    return totals;
  }

  for (var i = 0; i < data.length; i++) {
    final row = data[i];
    for (var j = 0; j < row.length; j++) {
      final cell = row[j];
      final column = columns[j];
      final columnIndex = columns.indexOf(reportUIState.group);

      if (columnIndex == -1) {
        print('## ERROR: colum not found - ${reportUIState.group}');
        continue;
      }

      dynamic group = row[columnIndex].value;

      if (getReportColumnType(reportUIState.group) ==
              ReportColumnType.dateTime ||
          getReportColumnType(reportUIState.group) == ReportColumnType.date) {
        if ((group as String).isNotEmpty) {
          group = convertDateTimeToSqlDate(DateTime.tryParse(group));
          if (reportUIState.subgroup == kReportGroupYear) {
            group = group.substring(0, 4) + '-01-01';
          } else if (reportUIState.subgroup == kReportGroupMonth) {
            group = group.substring(0, 7) + '-01';
          }
        }
      }

      if (!totals.containsKey(group)) {
        totals['$group'] = {'count': 0};
      }
      if (column == reportUIState.group) {
        totals['$group']['count'] += 1;
      }
      if (cell is ReportNumberValue) {
        if (!totals['$group'].containsKey(column)) {
          totals['$group'][column] = 0;
        }
        totals['$group'][column] += cell.value;
      }
    }
  }

  return totals;
}
