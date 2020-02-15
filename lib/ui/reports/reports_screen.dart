import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_actions.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/multiselect_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/history_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/menu_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen_vm.dart';
import 'package:invoiceninja_flutter/utils/dates.dart';
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

    final hasCustomDate = reportsUIState.filters.keys.where((column) {
      final filter = reportsUIState.filters[column];
      return getReportColumnType(column) == ReportColumnType.dateTime &&
          filter == DateRange.custom.toString();
    }).isNotEmpty;

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
          actions: <Widget>[
            Builder(builder: (BuildContext context) {
              return FlatButton(
                child: Text(localization.columns),
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
        body: ListView(
          key: ValueKey('${viewModel.state.isSaving} ${reportsUIState.group}'),
          children: <Widget>[
            FormCard(
              children: <Widget>[
                AppDropdownButton<String>(
                  labelText: localization.report,
                  value: reportsUIState.report,
                  onChanged: (dynamic value) =>
                      viewModel.onSettingsChanged(report: value),
                  items: [
                    //kReportActivity,
                    //kReportAging,
                    kReportClient,
                    //kReportCredit,
                    //kReportDocument,
                    //kReportExpense,
                    //kReportInvoice,
                    //kReportPayment,
                    //kReportProduct,
                    //kReportProfitAndLoss,
                    //kReportTask,
                    //kReportTaxRate,
                    //kReportQuote,
                  ]
                      .map((report) => DropdownMenuItem(
                            value: report,
                            child: Text(localization.lookup(report)),
                          ))
                      .toList(),
                ),
                AppDropdownButton<String>(
                  labelText: localization.group,
                  value: reportsUIState.group,
                  blankValue: '',
                  showBlank: true,
                  onChanged: (dynamic value) {
                    viewModel.onSettingsChanged(group: value);
                  },
                  items: reportResult.columns
                      .where((column) =>
                          getReportColumnType(column) !=
                          ReportColumnType.number)
                      .map((column) => DropdownMenuItem(
                            child: Text(localization.lookup(column)),
                            value: column,
                          ))
                      .toList(),
                ),
                if (getReportColumnType(reportsUIState.group) ==
                    ReportColumnType.dateTime)
                  AppDropdownButton<String>(
                      labelText: localization.subgroup,
                      value: reportsUIState.subgroup,
                      onChanged: (dynamic value) {
                        viewModel.onSettingsChanged(subgroup: value);
                      },
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
                      ]),
                if (hasCustomDate) ...[
                  DatePicker(
                    labelText: localization.startDate,
                    selectedDate: reportsUIState.customStartDate,
                    allowClearing: true,
                    onSelected: (date) =>
                        viewModel.onSettingsChanged(customStartDate: date),
                  ),
                  DatePicker(
                    labelText: localization.endDate,
                    selectedDate: reportsUIState.customEndDate,
                    allowClearing: true,
                    onSelected: (date) =>
                        viewModel.onSettingsChanged(customEndDate: date),
                  ),
                ]
              ],
            ),
            ReportDataTable(
              key: ValueKey(
                  '${viewModel.state.isSaving} ${reportsUIState.group}'),
              viewModel: viewModel,
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
    final reportSettings = state.userCompany.settings
            ?.reportSettings[state.uiState.reportsUIState.report] ??
        ReportSettingsEntity();

    return Column(
      children: <Widget>[
        FormCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DataTable(
                columns: reportResult.totalColumns(context),
                rows: reportResult.totalRows(context),
              ),
            ],
          ),
        ),
        FormCard(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              sortColumnIndex: reportSettings.sortIndex,
              sortAscending: reportSettings.sortAscending,
              columns: reportResult.tableColumns(
                  context,
                  (index, ascending) =>
                      widget.viewModel.onReportSorted(index, ascending)),
              rows: [
                reportResult.tableFilters(
                    context,
                    _textEditingControllers[
                        state.uiState.reportsUIState.report], (column, value) {
                  widget.viewModel.onReportFiltersChanged(
                      context,
                      state.uiState.reportsUIState.filters
                          .rebuild((b) => b..addAll({column: value})));
                }),
                ...reportResult.tableRows(context),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

enum ReportColumnType {
  string,
  dateTime,
  number,
  bool,
}

ReportColumnType getReportColumnType(String column) {
  if (['updated_at', 'created_at'].contains(column)) {
    return ReportColumnType.dateTime;
  } else if (['balance', 'paid_to_date'].contains(column)) {
    return ReportColumnType.number;
  } else if (['is_active'].contains(column)) {
    return ReportColumnType.bool;
  } else {
    return ReportColumnType.string;
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

  static bool matchField({
    String column,
    dynamic value,
    UserCompanyEntity userCompany,
    ReportsUIState reportsUIState,
  }) {
    if (reportsUIState.filters.containsKey(column)) {
      final filter = reportsUIState.filters[column];
      if (filter.isNotEmpty) {
        if (getReportColumnType(column) == ReportColumnType.number) {
          if (!ReportResult.matchAmount(filter: filter, amount: value)) {
            return false;
          }
        } else if (getReportColumnType(column) == ReportColumnType.dateTime) {
          if (!ReportResult.matchDateTime(
              filter: filter,
              value: value,
              reportsUIState: reportsUIState,
              userCompany: userCompany)) {
            return false;
          }
        } else if (getReportColumnType(column) == ReportColumnType.bool) {
          if (filter != '$value') {
            return false;
          }
        } else {
          if (!ReportResult.matchString(filter: filter, value: value)) {
            return false;
          }
        }
      }
    }

    return true;
  }

  static bool matchString({String filter, String value}) {
    return value.toLowerCase().contains(filter.toLowerCase());
  }

  static bool matchAmount({String filter, double amount}) {
    final String range = filter.replaceAll(',', '-') + '-';
    final List<String> parts = range.split('-');
    final min = parseDouble(parts[0]);
    final max = parseDouble(parts[1]);
    if (amount < min || (max > 0 && amount > max)) {
      return false;
    }

    return true;
  }

  static bool matchDateTime({
    String filter,
    String value,
    UserCompanyEntity userCompany,
    ReportsUIState reportsUIState,
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
    if (reportsUIState.customStartDate.isNotEmpty &&
        reportsUIState.customEndDate.isNotEmpty) {
      if (!(startDate.compareTo(value) <= 0 && endDate.compareTo(value) >= 0)) {
        return false;
      }
    } else if (reportsUIState.customStartDate.isNotEmpty) {
      if (!(startDate.compareTo(value) <= 0)) {
        return false;
      }
    } else if (reportsUIState.customEndDate.isNotEmpty) {
      if (!(endDate.compareTo(value) >= 0)) {
        return false;
      }
    }

    return true;
  }

  List<DataColumn> tableColumns(
      BuildContext context, Function(int, bool) onSortCallback) {
    final localization = AppLocalization.of(context);

    return [
      for (String column in columns)
        DataColumn(
          tooltip: localization.lookup(column),
          label: Container(
            constraints: BoxConstraints(minWidth: 80),
            child: Text(
              localization.lookup(column) + '   ',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          numeric: getReportColumnType(column) == ReportColumnType.number,
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
        if (getReportColumnType(column) == ReportColumnType.bool)
          DataCell(AppDropdownButton<bool>(
            labelText: null,
            showBlank: true,
            blankValue: null,
            value: textEditingControllers[column].text == 'true'
                ? true
                : textEditingControllers[column].text == 'false' ? false : null,
            onChanged: (dynamic value) {
              if (value == null) {
                textEditingControllers[column].text = '';
                onFilterChanged(column, '');
              } else {
                textEditingControllers[column].text = value.toString();
                onFilterChanged(column, value.toString());
              }
            },
            items: [
              DropdownMenuItem(
                child: Text(AppLocalization.of(context).yes),
                value: true,
              ),
              DropdownMenuItem(
                child: Text(AppLocalization.of(context).no),
                value: false,
              ),
            ],
          ))
        else if (getReportColumnType(column) == ReportColumnType.number)
          DataCell(DecoratedFormField(
            label: '',
            controller: textEditingControllers[column],
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ))
        else if (getReportColumnType(column) == ReportColumnType.dateTime)
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
                      row[index]
                          .renderText(context, column)
                          .toLowerCase()
                          .contains(filter) &&
                      row[index].renderText(context, column).trim().isNotEmpty)
                  .map((row) => row[index].renderText(context, column))
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
    final rows = <DataRow>[];
    final store = StoreProvider.of<AppState>(context);
    final reportState = store.state.uiState.reportsUIState;
    final groupBy = reportState.group;

    if (groupBy.isEmpty) {
      for (var i = 0; i < data.length; i++) {
        final row = data[i];
        final cells = <DataCell>[];
        for (var j = 0; j < row.length; j++) {
          final cell = row[j];
          final column = columns[j];
          cells.add(DataCell(cell.renderWidget(context, column)));
        }
        rows.add(DataRow(cells: cells));
      }
    } else {
      final Map<String, Map<String, double>> totals = {};

      for (var i = 0; i < data.length; i++) {
        final row = data[i];
        for (var j = 0; j < row.length; j++) {
          final cell = row[j];
          final column = columns[j];
          final columnIndex = columns.indexOf(groupBy);

          String value = row[columnIndex].renderText(context, column);

          if (getReportColumnType(reportState.group) ==
              ReportColumnType.dateTime) {
            value = convertDateTimeToSqlDate(DateTime.tryParse(value));
            if (reportState.subgroup == kReportGroupYear) {
              value = value.substring(0, 4) + '-01-01';
            } else if (reportState.subgroup == kReportGroupMonth) {
              value = value.substring(0, 7) + '-01';
            }
          }

          if (!totals.containsKey(value)) {
            totals[value] = {'count': 0};
          }
          if (column == groupBy) {
            totals[value]['count'] += 1;
          }
          if (cell is ReportNumberValue) {
            if (!totals[value].containsKey(column)) {
              totals[value][column] = 0;
            }
            totals[value][column] += cell.value;
          }
        }
      }

      totals.forEach((group, values) {
        final cells = <DataCell>[];
        for (var column in columns) {
          String value = '';
          if (column == groupBy) {
            if (getReportColumnType(column) == ReportColumnType.dateTime) {
              value = formatDate(group, context);
            } else if (group.isEmpty) {
              value = AppLocalization.of(context).blank;
            } else {
              value = group;
            }

            value = value + ' (' + values['count'].floor().toString() + ')';
          } else if (getReportColumnType(column) == ReportColumnType.number) {
            value = formatNumber(values[column], context);
          }
          cells.add(DataCell(Text(value), onTap: () {
            if (column == groupBy) {
              String filter = group;
              String customStartDate = '';
              String customEndDate = '';
              if (getReportColumnType(column) == ReportColumnType.dateTime) {
                filter = DateRange.custom.toString();
                final date = DateTime.tryParse(group);
                customStartDate = group;
                if (reportState.subgroup == kReportGroupDay) {
                  customEndDate = convertDateTimeToSqlDate(addDays(date, 1));
                } else if (reportState.subgroup == kReportGroupMonth) {
                  customEndDate = convertDateTimeToSqlDate(addMonths(date, 1));
                } else {
                  customEndDate = convertDateTimeToSqlDate(addYears(date, 1));
                }
              } else if (getReportColumnType(column) == ReportColumnType.bool) {
                filter = filter == AppLocalization.of(context).yes
                    ? 'true'
                    : filter == AppLocalization.of(context).no ? 'false' : '';
              }
              store.dispatch(
                UpdateReportSettings(
                  report: reportState.report,
                  group: '',
                  customStartDate: customStartDate,
                  customEndDate: customEndDate,
                  filters: reportState.filters
                      .rebuild((b) => b..addAll({column: filter})),
                ),
              );
            }
          }));
        }
        rows.add(DataRow(cells: cells));
      });
    }

    return rows;
  }

  List<DataColumn> totalColumns(BuildContext context) {
    final localization = AppLocalization.of(context);
    columns.toList().sort((String str1, String str2) => str1.compareTo(str2));

    return [
      DataColumn(
        label: Text(localization.currency),
        tooltip: localization.currency,
      ),
      DataColumn(
        label: Text(localization.count),
        tooltip: localization.count,
      ),
      for (String column in columns)
        if (getReportColumnType(column) == ReportColumnType.number)
          DataColumn(
            tooltip: localization.lookup(column),
            label: Text(
              localization.lookup(column),
              overflow: TextOverflow.ellipsis,
            ),
            numeric: true,
          )
    ];
  }

  List<DataRow> totalRows(BuildContext context) {
    final rows = <DataRow>[];
    final store = StoreProvider.of<AppState>(context);

    final Map<String, Map<String, double>> totals = {};

    for (var i = 0; i < data.length; i++) {
      final row = data[i];
      bool countedRow = false;
      for (var j = 0; j < row.length; j++) {
        final cell = row[j];
        final column = columns[j];
        if (cell is ReportNumberValue) {
          final String currencyId = cell.currencyId;

          if (!totals.containsKey(currencyId)) {
            totals[currencyId] = {'count': 0};
          }
          if (!countedRow) {
            totals[currencyId]['count']++;
            countedRow = true;
          }
          if (!totals[currencyId].containsKey(column)) {
            totals[currencyId][column] = 0;
          }
          totals[currencyId][column] += cell.value;
        }
      }
    }

    totals.forEach((currencyId, values) {
      final cells = <DataCell>[
        DataCell(Text(
            store.state.staticState.currencyMap[currencyId]?.listDisplayName ??
                '')),
        DataCell(Text(values['count'].toInt().toString())),
      ];

      final List<String> fields = values.keys.toList()
        ..sort((String str1, String str2) => str1.compareTo(str2));
      fields.forEach((field) {
        final amount = values[field];
        final value = formatNumber(amount, context, currencyId: currencyId);
        if (field != 'count') {
          cells.add(DataCell(Text(value)));
        }
      });

      rows.add(DataRow(cells: cells));
    });

    print('## TOTALS: $totals');
    return rows;
  }
}

abstract class ReportElement {
  ReportElement({this.value, this.entityType, this.entityId});

  final dynamic value;
  final EntityType entityType;
  final String entityId;

  Widget renderWidget(BuildContext context, String column) {
    throw 'Error: need to override renderWidget()';
  }

  String renderText(BuildContext context, String column) {
    throw 'Error: need to override sortString()';
  }
}

class ReportStringValue extends ReportElement {
  ReportStringValue({
    dynamic value,
    EntityType entityType,
    String entityId,
  }) : super(value: value, entityType: entityType, entityId: entityId);

  @override
  Widget renderWidget(BuildContext context, String column) {
    if (getReportColumnType(column) == ReportColumnType.dateTime) {
      return Text(formatDate(value, context, showTime: true));
    } else {
      return Text(value ?? '');
    }
  }

  @override
  String renderText(BuildContext context, String column) {
    return value;
  }
}

class ReportNumberValue extends ReportElement {
  ReportNumberValue({
    dynamic value,
    EntityType entityType,
    String entityId,
    this.currencyId,
    this.formatNumberType = FormatNumberType.money,
  }) : super(value: value, entityType: entityType, entityId: entityId);

  final FormatNumberType formatNumberType;
  final String currencyId;

  @override
  Widget renderWidget(BuildContext context, String column) {
    return Text(formatNumber(value, context,
        currencyId: currencyId, formatNumberType: formatNumberType));
  }

  @override
  String renderText(BuildContext context, String column) {
    return value.toString();
  }
}

class ReportBoolValue extends ReportElement {
  ReportBoolValue({
    dynamic value,
    EntityType entityType,
    String entityId,
  }) : super(value: value, entityType: entityType, entityId: entityId);

  @override
  Widget renderWidget(BuildContext context, String column) {
    final localization = AppLocalization.of(context);
    return SizedBox(
      width: 80,
      child: Text(
        value == true ? localization.yes : localization.no,
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  String renderText(BuildContext context, String column) {
    final localization = AppLocalization.of(context);
    return value == true ? localization.yes : localization.no;
  }
}
