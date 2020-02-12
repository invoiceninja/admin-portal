import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
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
                //key: ObjectKey(state.uiState.reportsUIState),
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
  const ReportDataTable({Key key, @required this.viewModel}) : super(key: key);

  final ReportsScreenVM viewModel;

  @override
  _ReportDataTableState createState() => _ReportDataTableState();
}

class _ReportDataTableState extends State<ReportDataTable> {
  final Map<String, Map<String, TextEditingController>>
      _textEditingControllers = {};

  @override
  void didChangeDependencies() {
    final state = widget.viewModel.state;
    final reportState = state.uiState.reportsUIState;
    final reportResult = widget.viewModel.reportResult;

    for (var column in reportResult.columns) {
      if (_textEditingControllers[reportState.report] == null) {
        _textEditingControllers[reportState.report] = {};
      }
      if (!_textEditingControllers[reportState.report].containsKey(column)) {
        final textEditingController = TextEditingController();
        // TODO figure out how to remove this listener in dispose
        textEditingController.addListener(() {
          _onChanged(column, textEditingController.text);
        });
        if (reportState.filters.containsKey(column)) {
          textEditingController.text = reportState.filters[column];
        }
        _textEditingControllers[reportState.report][column] =
            textEditingController;
      }
    }

    super.didChangeDependencies();
  }

  void _onChanged(String column, String value) {
    print('## On changed - column: $column - $value');
    final state = widget.viewModel.state;
    widget.viewModel.onReportFiltersChanged(
        context,
        state.uiState.reportsUIState.filters
            .rebuild((b) => b..addAll({column: value})));
  }

  @override
  void dispose() {
    _textEditingControllers.keys.forEach((i) {
      _textEditingControllers[i].keys.forEach((j) {
        _textEditingControllers[i][j].dispose();
      });
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.viewModel.state;
    final reportResult = widget.viewModel.reportResult;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        sortColumnIndex: state.userCompany.settings
            .reportSettings[state.uiState.reportsUIState.report].sortIndex,
        sortAscending: state.userCompany.settings
            .reportSettings[state.uiState.reportsUIState.report].sortAscending,
        columns: reportResult.tableColumns(
            context,
            (index, ascending) =>
                widget.viewModel.onReportSorted(index, ascending)),
        rows: [
          reportResult.tableFilters(context,
              _textEditingControllers[state.uiState.reportsUIState.report],
              (column, value) {
            widget.viewModel.onReportFiltersChanged(
                context,
                state.uiState.reportsUIState.filters
                    .rebuild((b) => b..addAll({column: value})));
          }),
          ...reportResult.tableRows(context),
        ],
      ),
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
          tooltip: localization.lookup(column),
          label: Text(
            localization.lookup(column),
            overflow: TextOverflow.ellipsis,
          ),
          onSort: onSortCallback,
        )
    ];
  }

  DataRow tableFilters(
      BuildContext context,
      Map<String, TextEditingController> textEditingControllers,
      Function(String, String) onFilterChanged) {
    final localization = AppLocalization.of(context);
    return DataRow(cells: [
      for (String column in columns)
        if (['updated_at', 'created_at'].contains(column))
          DataCell(AppDropdownButton<DateRange>(
            labelText: null,
            showBlank: true,
            blankValue: null,
            value: (textEditingControllers[column].text ?? '').isNotEmpty &&
                    textEditingControllers[column].text != 'null'
                ? DateRange.valueOf(textEditingControllers[column].text)
                : null,
            onChanged: (dynamic value) {
              if (value == null) {
                textEditingControllers[column].text = '';
                onFilterChanged(column, '');
              } else {
                textEditingControllers[column].text = value.toString();
                onFilterChanged(column, value.toString());
              }
            },
            items: DateRange.values
                .map((dateRange) => DropdownMenuItem<DateRange>(
                      child: Text(localization.lookup(dateRange.toString())),
                      value: dateRange,
                    ))
                .toList(),
          ))
        else
          DataCell(TypeAheadFormField(
            noItemsFoundBuilder: (context) => SizedBox(),
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
              constraints: BoxConstraints(
                minWidth: 300,
              ),
            ),
            suggestionsCallback: (filter) {
              filter = filter.toLowerCase();
              final index = columns.indexOf(column);
              return data
                  .where((row) =>
                      row[index].sortString().toLowerCase().contains(filter) &&
                      row[index].sortString().trim().isNotEmpty)
                  .map((row) => row[index].sortString())
                  .toSet()
                  .toList();
            },
            itemBuilder: (context, String entityId) {
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Text('$entityId'),
              );
            },
            onSuggestionSelected: (String value) {
              textEditingControllers[column].text = value;
              onFilterChanged(column, value);
            },
            textFieldConfiguration: TextFieldConfiguration<String>(
              controller: textEditingControllers[column],
              decoration: InputDecoration(
                  suffixIcon:
                      (textEditingControllers[column]?.text ?? '').isEmpty
                          ? null
                          : IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                textEditingControllers[column].text = '';
                                onFilterChanged(column, '');
                              },
                            )),
            ),
            autoFlipDirection: true,
            animationStart: 1,
            debounceDuration: Duration(seconds: 0),
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
