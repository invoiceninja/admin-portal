import 'dart:math';

import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/utils/enums.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/expense_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:memoize/memoize.dart';

enum ExpenseReportFields {
  amount,
  transaction_reference,
  currency,
  expense_date,
  payment_date,
  tax_rate1,
  tax_rate2,
  tax_rate3,
  client,
  invoice,
  vendor,
  custom_value1,
  custom_value2,
  custom_value3,
  custom_value4,
}

var memoizedExpenseReport = memo8((
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, ExpenseEntity> expenseMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, VendorEntity> vendorMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) =>
    expenseReport(userCompany, reportsUIState, expenseMap, invoiceMap,
        clientMap, vendorMap, userMap, staticState));

ReportResult expenseReport(
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, ExpenseEntity> expenseMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, VendorEntity> vendorMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) {
  final List<List<ReportElement>> data = [];
  BuiltList<ExpenseReportFields> columns;

  final reportSettings = userCompany.settings.reportSettings;
  final expenseReportSettings =
      reportSettings != null && reportSettings.containsKey(kReportExpense)
          ? reportSettings[kReportExpense]
          : ReportSettingsEntity();

  final defaultColumns = [
    ExpenseReportFields.amount,
    ExpenseReportFields.transaction_reference,
    ExpenseReportFields.client,
    ExpenseReportFields.invoice,
    ExpenseReportFields.vendor,
  ];

  if (expenseReportSettings.columns.isNotEmpty) {
    columns = BuiltList(expenseReportSettings.columns
        .map((e) => EnumUtils.fromString(ExpenseReportFields.values, e))
        .toList());
  } else {
    columns = BuiltList(defaultColumns);
  }

  for (var expenseId in expenseMap.keys) {
    final expense = expenseMap[expenseId];
    final client = clientMap[expense.clientId];

    if (expense.isDeleted) {
      continue;
    }

    bool skip = false;
    final List<ReportElement> row = [];

    for (var column in columns) {
      dynamic value = '';

      switch (column) {
        case ExpenseReportFields.amount:
          value = expense.amount;
          break;
        case ExpenseReportFields.transaction_reference:
          value = expense.transactionReference;
          break;
        case ExpenseReportFields.currency:
          value = staticState.currencyMap[expense.expenseCurrencyId];
          break;
        case ExpenseReportFields.expense_date:
          value = expense.expenseDate;
          break;
        case ExpenseReportFields.payment_date:
          value = expense.paymentDate;
          break;
          break;
        case ExpenseReportFields.tax_rate1:
          value = expense.taxRate1;
          break;
        case ExpenseReportFields.tax_rate2:
          value = expense.taxRate2;
          break;
        case ExpenseReportFields.tax_rate3:
          value = expense.taxRate3;
          break;
        case ExpenseReportFields.client:
          value = clientMap[expense.clientId].displayName;
          break;
        case ExpenseReportFields.invoice:
          value = invoiceMap[expense.invoiceId].listDisplayName;
          break;
        case ExpenseReportFields.vendor:
          value = vendorMap[expense.vendorId].listDisplayName;
          break;
        case ExpenseReportFields.custom_value1:
          value = expense.customValue1;
          break;
        case ExpenseReportFields.custom_value2:
          value = expense.customValue2;
          break;
        case ExpenseReportFields.custom_value3:
          value = expense.customValue3;
          break;
        case ExpenseReportFields.custom_value4:
          value = expense.customValue4;
          break;
      }

      if (!ReportResult.matchField(
        value: value,
        userCompany: userCompany,
        reportsUIState: reportsUIState,
        column: EnumUtils.parse(column),
      )) {
        skip = true;
      }

      if (value.runtimeType == bool) {
        row.add(expense.getReportBool(value: value));
      } else if (value.runtimeType == double || value.runtimeType == int) {
        row.add(expense.getReportNumber(
            value: value, currencyId: client.settings.currencyId));
      } else {
        row.add(expense.getReportString(value: value));
      }
    }

    if (!skip) {
      data.add(row);
    }
  }

  data.sort((rowA, rowB) {
    if (rowA.length <= expenseReportSettings.sortIndex ||
        rowB.length <= expenseReportSettings.sortIndex) {
      return 0;
    }

    final String valueA = rowA[expenseReportSettings.sortIndex].value;
    final String valueB = rowB[expenseReportSettings.sortIndex].value;

    if (expenseReportSettings.sortAscending) {
      return valueA.compareTo(valueB);
    } else {
      return valueB.compareTo(valueA);
    }
  });

  return ReportResult(
    allColumns:
        ExpenseReportFields.values.map((e) => EnumUtils.parse(e)).toList(),
    columns: columns.map((item) => EnumUtils.parse(item)).toList(),
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
  );
}
