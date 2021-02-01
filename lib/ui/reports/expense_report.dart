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
  net_amount,
  tax_amount,
  transaction_reference,
  currency,
  date,
  payment_date,
  tax_rate1,
  tax_rate2,
  tax_rate3,
  client,
  client_balance,
  client_address1,
  client_address2,
  client_shipping_address1,
  client_shipping_address2,
  invoice,
  invoice_amount,
  vendor,
  custom_value1,
  custom_value2,
  custom_value3,
  custom_value4,
  category,
}

var memoizedExpenseReport = memo9((
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, ExpenseEntity> expenseMap,
  BuiltMap<String, ExpenseCategoryEntity> expenseCategoryMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, VendorEntity> vendorMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) =>
    expenseReport(
      userCompany,
      reportsUIState,
      expenseMap,
      expenseCategoryMap,
      invoiceMap,
      clientMap,
      vendorMap,
      userMap,
      staticState,
    ));

ReportResult expenseReport(
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, ExpenseEntity> expenseMap,
  BuiltMap<String, ExpenseCategoryEntity> expenseCategoryMap,
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
    ExpenseReportFields.category,
  ];

  if (expenseReportSettings.columns.isNotEmpty) {
    columns = BuiltList(expenseReportSettings.columns
        .map((e) => EnumUtils.fromString(ExpenseReportFields.values, e))
        .where((element) => element != null)
        .toList());
  } else {
    columns = BuiltList(defaultColumns);
  }

  for (var expenseId in expenseMap.keys) {
    final expense = expenseMap[expenseId];
    final client = clientMap[expense.clientId];
    final invoice = invoiceMap[expense.invoiceId];
    final vendor = vendorMap[expense.vendorId];

    if (expense.isDeleted) {
      continue;
    }

    bool skip = false;
    final List<ReportElement> row = [];

    for (var column in columns) {
      dynamic value = '';

      switch (column) {
        case ExpenseReportFields.amount:
          value = expense.grossAmount;
          break;
        case ExpenseReportFields.net_amount:
          value = expense.netAmount;
          break;
        case ExpenseReportFields.tax_amount:
          value = expense.taxAmount;
          break;
        case ExpenseReportFields.transaction_reference:
          value = expense.transactionReference;
          break;
        case ExpenseReportFields.currency:
          value = staticState.currencyMap[expense.currencyId];
          break;
        case ExpenseReportFields.date:
          value = expense.date;
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
          value = client?.displayName;
          break;
        case ExpenseReportFields.client_balance:
          value = client?.balance;
          break;
        case ExpenseReportFields.client_address1:
          value = client?.address1;
          break;
        case ExpenseReportFields.client_address2:
          value = client?.address2;
          break;
        case ExpenseReportFields.client_shipping_address1:
          value = client?.shippingAddress1;
          break;
        case ExpenseReportFields.client_shipping_address2:
          value = client?.shippingAddress2;
          break;
        case ExpenseReportFields.invoice:
          value = invoice?.listDisplayName;
          break;
        case ExpenseReportFields.invoice_amount:
          value = invoice?.amount;
          break;
        case ExpenseReportFields.vendor:
          value = vendor?.listDisplayName;
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
        case ExpenseReportFields.category:
          value = expenseCategoryMap[expense.categoryId]?.name ?? '';
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
        row.add(expense.getReportDouble(
            value: value, currencyId: expense.currencyId));
      } else {
        row.add(expense.getReportString(value: value));
      }
    }

    if (!skip) {
      data.add(row);
    }
  }

  final selectedColumns = columns.map((item) => EnumUtils.parse(item)).toList();
  data.sort((rowA, rowB) =>
      sortReportTableRows(rowA, rowB, expenseReportSettings, selectedColumns));

  return ReportResult(
    allColumns:
        ExpenseReportFields.values.map((e) => EnumUtils.parse(e)).toList(),
    columns: selectedColumns,
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
  );
}
