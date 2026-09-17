// Package imports:
import 'package:built_collection/built_collection.dart';

import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:invoiceninja_flutter/utils/enums.dart';

enum ExpenseTaxReportFields {
  number,
  amount,
  net_amount,
  tax_name,
  tax_rate,
  tax_amount,
  date,
  payment_date,
  vendor,
  client,
  category,
  currency,
}

var memoizedExpenseTaxReport = memo7(
  (
    UserCompanyEntity? userCompany,
    ReportsUIState reportsUIState,
    BuiltMap<String, ExpenseEntity> expenseMap,
    BuiltMap<String, ExpenseCategoryEntity> expenseCategoryMap,
    BuiltMap<String, ClientEntity> clientMap,
    BuiltMap<String, VendorEntity> vendorMap,
    StaticState staticState,
  ) => expenseTaxReport(
    userCompany!,
    reportsUIState,
    expenseMap,
    expenseCategoryMap,
    clientMap,
    vendorMap,
    staticState,
  ),
);

ReportResult expenseTaxReport(
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, ExpenseEntity> expenseMap,
  BuiltMap<String, ExpenseCategoryEntity> expenseCategoryMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, VendorEntity> vendorMap,
  StaticState staticState,
) {
  final List<List<ReportElement>> data = [];
  BuiltList<ExpenseTaxReportFields> columns;

  final reportSettings = userCompany.settings.reportSettings;
  final expenseTaxReportSettings = reportSettings.containsKey(kReportExpenseTax)
      ? reportSettings[kReportExpenseTax]!
      : ReportSettingsEntity();

  final defaultColumns = [
    ExpenseTaxReportFields.tax_name,
    ExpenseTaxReportFields.tax_rate,
    ExpenseTaxReportFields.tax_amount,
    ExpenseTaxReportFields.amount,
    ExpenseTaxReportFields.date,
    ExpenseTaxReportFields.number,
  ];

  if (expenseTaxReportSettings.columns.isNotEmpty) {
    columns = BuiltList(
      expenseTaxReportSettings.columns
          .map((e) => EnumUtils.fromString(ExpenseTaxReportFields.values, e))
          .nonNulls
          .toList(),
    );
  } else {
    columns = BuiltList(defaultColumns);
  }

  for (var expenseId in expenseMap.keys) {
    final expense = expenseMap[expenseId]!;

    if (expense.isDeleted! && !userCompany.company.reportIncludeDeleted) {
      continue;
    }

    final client = clientMap[expense.clientId] ?? ClientEntity();
    final vendor = vendorMap[expense.vendorId] ?? VendorEntity();
    final category = expenseCategoryMap[expense.categoryId];

    final taxes = <Map<String, dynamic>>[];

    if (expense.taxName1.isNotEmpty) {
      taxes.add({
        'name': expense.taxName1,
        'rate': expense.calculatetaxRate1,
        'amount': expense.calculateTaxAmount1,
      });
    }

    if (expense.taxName2.isNotEmpty) {
      taxes.add({
        'name': expense.taxName2,
        'rate': expense.calculatetaxRate2,
        'amount': expense.calculateTaxAmount2,
      });
    }

    if (expense.taxName3.isNotEmpty) {
      taxes.add({
        'name': expense.taxName3,
        'rate': expense.calculatetaxRate3,
        'amount': expense.calculateTaxAmount3,
      });
    }

    for (final tax in taxes) {
      bool skip = false;

      final List<ReportElement> row = [];

      for (var column in columns) {
        dynamic value = '';

        switch (column) {
          case ExpenseTaxReportFields.number:
            value = expense.number;
            break;
          case ExpenseTaxReportFields.amount:
            value = expense.grossAmount;
            break;
          case ExpenseTaxReportFields.net_amount:
            value = expense.netAmount;
            break;
          case ExpenseTaxReportFields.tax_name:
            value = tax['name'];
            break;
          case ExpenseTaxReportFields.tax_rate:
            value = tax['rate'];
            break;
          case ExpenseTaxReportFields.tax_amount:
            value = tax['amount'];
            break;
          case ExpenseTaxReportFields.date:
            value = expense.date;
            break;
          case ExpenseTaxReportFields.payment_date:
            value = expense.paymentDate;
            break;
          case ExpenseTaxReportFields.vendor:
            value = vendor.listDisplayName;
            break;
          case ExpenseTaxReportFields.client:
            value = client.displayName;
            break;
          case ExpenseTaxReportFields.category:
            value = category?.name ?? '';
            break;
          case ExpenseTaxReportFields.currency:
            value = staticState.currencyMap[expense.currencyId]?.name ?? '';
            break;
        }

        if (!ReportResult.matchField(
          value: value,
          userCompany: userCompany,
          reportsUIState: reportsUIState,
          column: EnumUtils.parse(column),
        )!) {
          skip = true;
        }

        if (value.runtimeType == bool) {
          row.add(expense.getReportBool(value: value));
        } else if (value.runtimeType == double || value.runtimeType == int) {
          row.add(
            expense.getReportDouble(
              value: value,
              currencyId: expense.currencyId,
            ),
          );
        } else {
          row.add(expense.getReportString(value: value));
        }
      }

      if (!skip) {
        data.add(row);
      }
    }
  }

  final selectedColumns = columns.map((item) => EnumUtils.parse(item)).toList();
  data.sort(
    (rowA, rowB) => sortReportTableRows(
      rowA,
      rowB,
      expenseTaxReportSettings,
      selectedColumns,
    )!,
  );

  return ReportResult(
    allColumns: ExpenseTaxReportFields.values
        .map((e) => EnumUtils.parse(e))
        .toList(),
    columns: columns.map((item) => EnumUtils.parse(item)).toList(),
    defaultColumns: defaultColumns
        .map((item) => EnumUtils.parse(item))
        .toList(),
    data: data,
  );
}
