import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/multiselect_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/history_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/menu_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  static const String route = '/reports';

  final ReportsScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = viewModel.state;
    final reportsUIState = state.uiState.reportsUIState;
    final reportResult = viewModel.reportResult;

    return WillPopScope(
      onWillPop: () async {
        store.dispatch(ViewDashboard(navigator: Navigator.of(context)));
        return false;
      },
      child: Scaffold(
        drawer: isMobile(context) || state.prefState.isMenuFloated
            ? MenuDrawerBuilder()
            : null,
        endDrawer: isMobile(context) || state.prefState.isHistoryFloated
            ? HistoryDrawerBuilder()
            : null,
        appBar: AppBar(
          leading: isMobile(context) || state.prefState.isMenuFloated
              ? null
              : IconButton(
            icon: Icon(Icons.menu),
            onPressed: () =>
                store
                    .dispatch(UserSettingsChanged(sidebar: AppSidebar.menu)),
          ),
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
        ),
        body: ListView(
          children: <Widget>[
            FormCard(
              children: <Widget>[
                AppDropdownButton<String>(
                  labelText: localization.report,
                  value: reportsUIState.report,
                  onChanged: (dynamic value) =>
                      viewModel.onSettingsChanged(report: value),
                  items: [
                    kReportActivity,
                    kReportAging,
                    kReportClient,
                    kReportCredit,
                    kReportDocument,
                    kReportExpense,
                    kReportInvoice,
                    kReportPayment,
                    kReportProduct,
                    kReportProfitAndLoss,
                    kReportTask,
                    kReportTaxRate,
                    kReportQuote,
                  ]
                      .map((report) =>
                      DropdownMenuItem(
                        value: report,
                        child: Text(localization.lookup(report)),
                      ))
                      .toList(),
                ),

                /*
                AppDropdownButton<DateRange>(
                  labelText: localization.dateRange,
                  value: reportsUIState.dateRange,
                  onChanged: (dynamic value) =>
                      viewModel.onSettingsChanged(dateRange: value),
                  items: DateRange.values
                      .map((dateRange) => DropdownMenuItem<DateRange>(
                            child:
                                Text(localization.lookup(dateRange.toString())),
                            value: dateRange,
                          ))
                      .toList(),
                ),
                if (reportsUIState.dateRange == DateRange.custom) ...[
                  DatePicker(
                    labelText: localization.startDate,
                    selectedDate: reportsUIState.customStartDate,
                    onSelected: (value) =>
                        viewModel.onSettingsChanged(customStartDate: value),
                  ),
                  DatePicker(
                    labelText: localization.endDate,
                    selectedDate: reportsUIState.customEndDate,
                    onSelected: (value) =>
                        viewModel.onSettingsChanged(customEndDate: value),
                  ),
                ],
                 */
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Builder(builder: (BuildContext context) {
                  return FlatButton(
                    child: Text(localization.editColumns.toUpperCase()),
                    onPressed: () {
                      multiselectDialog(
                        context: context,
                        onSelected: (selected) {
                          viewModel.onReportColumnsChanged(context, selected);
                        },
                        options: reportResult.allColumns,
                        selected: reportResult.columns.toList(),
                        title: localization.editColumns,
                        addTitle: localization.addColumn,
                      );
                    },
                  );
                }),
              ],
            ),
            FormCard(
              child: ReportDataTable(
                viewModel: viewModel,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ReportDataTable extends StatelessWidget {
  const ReportDataTable({@required this.viewModel});

  final ReportsScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final reportResult = viewModel.reportResult;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        DataTable(
          columns: reportResult.tableColumns(context, (index, ascending) {
            viewModel.onReportSorted(index, ascending);
          }),
          rows: reportResult.tableRows(context),
        ),
      ],
    );
  }
}

class ReportResult {
  ReportResult({
    this.columns,
    this.allColumns,
    this.data,
  });

  final List<String> columns;
  final List<String> allColumns;
  final List<List<ReportElement>> data;

  List<DataColumn> tableColumns(BuildContext context,
      Function(int, bool) onSortCallback) {
    final localization = AppLocalization.of(context);

    return [
      for (String column in columns)
        DataColumn(
          label: Text(localization.lookup(column)),
          onSort: onSortCallback,
        )
    ];
  }

  List<DataRow> tableRows(BuildContext context) {
    return [
      for (List<ReportElement> row in data)
        DataRow(
          cells: row
              .map(
                (row) =>
                DataCell(
                  row.renderWidget(context),
                ),
          )
              .toList(),
        )
    ];
  }
}

abstract class ReportElement {

  ReportElement({this.entityType, this.entityId});
  final EntityType entityType;
  final String entityId;

  Widget renderWidget(BuildContext context) {
    throw 'Error: need to override renderWidget()';
  }

  String sortString() {
    throw 'Error: need to override sortString()';
  }
}

class ReportValue extends ReportElement {
  ReportValue({this.value});

  final String value;

  @override
  Widget renderWidget(BuildContext context) {
    return Text(value);
  }

  @override
  String sortString() {
    return value;
  }
}

class ReportAmount extends ReportElement {
  ReportAmount({
    this.value,
    this.currencyId,
    this.formatNumberType = FormatNumberType.money,
  });

  final double value;
  final FormatNumberType formatNumberType;
  final String currencyId;

  @override
  Widget renderWidget(BuildContext context) {
    return Text(formatNumber(value, context,
        currencyId: currencyId, formatNumberType: formatNumberType));
  }


  @override
  String sortString() {
    return value.toString();
  }
}
