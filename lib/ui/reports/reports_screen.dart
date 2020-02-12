import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
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
                  onPressed: () => store
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
                      .map((report) => DropdownMenuItem(
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

class ReportDataTable extends StatefulWidget {
  const ReportDataTable({@required this.viewModel});

  final ReportsScreenVM viewModel;

  @override
  _ReportDataTableState createState() => _ReportDataTableState();
}

class _ReportDataTableState extends State<ReportDataTable> {
  final Map<String, Map<String, TextEditingController>>
      _textEditingControllers = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final state = widget.viewModel.state;
    final reportState = state.uiState.reportsUIState;
    final reportResult = widget.viewModel.reportResult;

    for (var column in reportResult.columns) {
      if (_textEditingControllers[reportState.report].containsKey(column)) {
        print('## CREATINRG ${reportState.report} - $column');
        _textEditingControllers[reportState.report][column] = TextEditingController();
      }
    }
  }

  @override
  void dispose() {
    _textEditingControllers.keys.forEach((i) {
      _textEditingControllers[i].keys.forEach((j) {
        print('## DISPOSING $i - $j');
        _textEditingControllers[i][j].dispose();
      });
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reportResult = widget.viewModel.reportResult;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        DataTable(
          columns: reportResult.tableColumns(
              context,
              (index, ascending) =>
                  widget.viewModel.onReportSorted(index, ascending)),
          rows: [
            reportResult.tableFilters(context),
            ...reportResult.tableRows(context),
          ],
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

  List<DataColumn> tableColumns(
      BuildContext context, Function(int, bool) onSortCallback) {
    final localization = AppLocalization.of(context);

    return [
      for (String column in columns)
        DataColumn(
          label: Text(localization.lookup(column)),
          onSort: onSortCallback,
        )
    ];
  }

  DataRow tableFilters(BuildContext context) {
    return DataRow(cells: [
      for (String column in columns)
        DataCell(TypeAheadFormField(
          suggestionsCallback: (filter) {
            filter = filter.toLowerCase();
            final index = columns.indexOf(column);
            return data
                .where((row) =>
                    row[index].sortString().toLowerCase().contains(filter))
                .map((row) => row[index].sortString())
                .toList();
          },
          itemBuilder: (context, String entityId) {
            return Text('$entityId');
          },
          onSuggestionSelected: (String value) {
            print('## onSuggestionSelected: $value');
          },
          /*
          textFieldConfiguration: TextFieldConfiguration<String>(
            controller: _textController,
          ),          
           */
        ))
    ]);
  }

  List<DataRow> tableRows(BuildContext context) {
    return [
      for (List<ReportElement> row in data)
        DataRow(
          cells: row
              .map(
                (row) => DataCell(
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
  ReportValue({
    this.value,
    EntityType entityType,
    String entityId,
  }) : super(entityType: entityType, entityId: entityId);

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
    EntityType entityType,
    String entityId,
    this.currencyId,
    this.formatNumberType = FormatNumberType.money,
  }) : super(entityType: entityType, entityId: entityId);

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
