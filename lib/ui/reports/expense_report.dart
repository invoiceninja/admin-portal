// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart' show IterableNullableExtension;
import 'package:invoiceninja_flutter/redux/reports/reports_selectors.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:invoiceninja_flutter/utils/enums.dart';

enum ExpenseReportFields {
  id,
  number,
  amount,
  net_amount,
  tax_amount,
  transaction_reference,
  currency,
  date,
  payment_date,
  payment_type,
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
  invoice_date,
  vendor,
  project,
  expense1,
  expense2,
  expense3,
  expense4,
  category,
  assigned_to,
  created_by,
  public_notes,
  private_notes,
  tax_amount1,
  tax_amount2,
  tax_amount3,
  created_at,
  updated_at,
  converted_amount,
  status,
  record_state,
  is_invoiced,
}

var memoizedExpenseReport = memo10((
  UserCompanyEntity? userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, ExpenseEntity> expenseMap,
  BuiltMap<String, ExpenseCategoryEntity> expenseCategoryMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, VendorEntity> vendorMap,
  BuiltMap<String, ProjectEntity> projectMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) =>
    expenseReport(
      userCompany!,
      reportsUIState,
      expenseMap,
      expenseCategoryMap,
      invoiceMap,
      clientMap,
      vendorMap,
      projectMap,
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
  BuiltMap<String, ProjectEntity> projectMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) {
  final List<List<ReportElement>> data = [];
  final List<BaseEntity> entities = [];
  BuiltList<ExpenseReportFields> columns;

  final reportSettings = userCompany.settings.reportSettings;
  final expenseReportSettings = reportSettings.containsKey(kReportExpense)
      ? reportSettings[kReportExpense]!
      : ReportSettingsEntity();

  final defaultColumns = [
    ExpenseReportFields.amount,
    ExpenseReportFields.transaction_reference,
    ExpenseReportFields.client,
    ExpenseReportFields.invoice,
    ExpenseReportFields.vendor,
    ExpenseReportFields.category,
    ExpenseReportFields.date,
  ];

  if (expenseReportSettings.columns.isNotEmpty) {
    columns = BuiltList(expenseReportSettings.columns
        .map((e) => EnumUtils.fromString(ExpenseReportFields.values, e))
        .whereNotNull()
        .toList());
  } else {
    columns = BuiltList(defaultColumns);
  }

  for (var expenseId in expenseMap.keys) {
    final expense = expenseMap[expenseId]!;
    final client = clientMap[expense.clientId] ?? ClientEntity();
    final invoice = invoiceMap[expense.invoiceId] ?? InvoiceEntity();
    final vendor = vendorMap[expense.vendorId] ?? VendorEntity();
    final project = projectMap[expense.projectId] ?? ProjectEntity();

    if (expense.isDeleted! && !userCompany.company.reportIncludeDeleted) {
      continue;
    }

    bool skip = false;
    final List<ReportElement> row = [];

    for (var column in columns) {
      dynamic value = '';

      switch (column) {
        case ExpenseReportFields.id:
          value = expense.id;
          break;
        case ExpenseReportFields.number:
          value = expense.number;
          break;
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
          value = staticState.currencyMap[expense.currencyId]?.name ?? '';
          break;
        case ExpenseReportFields.date:
          value = expense.date;
          break;
        case ExpenseReportFields.payment_date:
          value = expense.paymentDate;
          break;
        case ExpenseReportFields.payment_type:
          value = staticState
                  .paymentTypeMap[expense.paymentTypeId]?.listDisplayName ??
              '';
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
          value = client.displayName;
          break;
        case ExpenseReportFields.client_balance:
          value = client.balance;
          break;
        case ExpenseReportFields.client_address1:
          value = client.address1;
          break;
        case ExpenseReportFields.client_address2:
          value = client.address2;
          break;
        case ExpenseReportFields.client_shipping_address1:
          value = client.shippingAddress1;
          break;
        case ExpenseReportFields.client_shipping_address2:
          value = client.shippingAddress2;
          break;
        case ExpenseReportFields.invoice:
          value = invoice.listDisplayName;
          break;
        case ExpenseReportFields.invoice_amount:
          value = invoice.amount;
          break;
        case ExpenseReportFields.invoice_date:
          value = invoice.isNew ? '' : invoice.date;
          break;
        case ExpenseReportFields.vendor:
          value = vendor.listDisplayName;
          break;
        case ExpenseReportFields.project:
          value = project.name;
          break;
        case ExpenseReportFields.expense1:
          value = presentCustomField(
            value: expense.customValue1,
            customFieldType: CustomFieldType.expense1,
            company: userCompany.company,
          );
          break;
        case ExpenseReportFields.expense2:
          value = presentCustomField(
            value: expense.customValue2,
            customFieldType: CustomFieldType.expense2,
            company: userCompany.company,
          );
          break;
        case ExpenseReportFields.expense3:
          value = presentCustomField(
            value: expense.customValue3,
            customFieldType: CustomFieldType.expense3,
            company: userCompany.company,
          );
          break;
        case ExpenseReportFields.expense4:
          value = presentCustomField(
            value: expense.customValue4,
            customFieldType: CustomFieldType.expense4,
            company: userCompany.company,
          );
          break;
        case ExpenseReportFields.category:
          value = expenseCategoryMap[expense.categoryId]?.name ?? '';
          break;
        case ExpenseReportFields.assigned_to:
          value = userMap[expense.assignedUserId]?.listDisplayName ?? '';
          break;
        case ExpenseReportFields.created_by:
          value = userMap[expense.createdUserId]?.listDisplayName ?? '';
          break;
        case ExpenseReportFields.public_notes:
          value = expense.publicNotes;
          break;
        case ExpenseReportFields.private_notes:
          value = expense.privateNotes;
          break;
        case ExpenseReportFields.tax_amount1:
          value = expense.calculateTaxAmount1;
          break;
        case ExpenseReportFields.tax_amount2:
          value = expense.calculateTaxAmount2;
          break;
        case ExpenseReportFields.tax_amount3:
          value = expense.calculateTaxAmount3;
          break;
        case ExpenseReportFields.updated_at:
          value = convertTimestampToDateString(expense.updatedAt);
          break;
        case ExpenseReportFields.created_at:
          value = convertTimestampToDateString(expense.createdAt);
          break;
        case ExpenseReportFields.converted_amount:
          value = round(expense.convertedAmount, 2);
          break;
        case ExpenseReportFields.status:
          value = kExpenseStatuses[expense.calculatedStatusId];
          break;
        case ExpenseReportFields.record_state:
          value = AppLocalization.of(navigatorKey.currentContext!)!
              .lookup(expense.entityState);
          break;
        case ExpenseReportFields.is_invoiced:
          value = expense.isInvoiced;
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
      } else if (column == ExpenseReportFields.converted_amount) {
        row.add(expense.getReportDouble(
            value: value, currencyId: expense.invoiceCurrencyId));
      } else if (value.runtimeType == double || value.runtimeType == int) {
        row.add(expense.getReportDouble(
            value: value, currencyId: expense.currencyId));
      } else {
        row.add(expense.getReportString(value: value));
      }
    }

    if (!skip) {
      data.add(row);
      entities.add(expense);
    }
  }

  final selectedColumns = columns.map((item) => EnumUtils.parse(item)).toList();
  data.sort((rowA, rowB) =>
      sortReportTableRows(rowA, rowB, expenseReportSettings, selectedColumns)!);

  return ReportResult(
    allColumns:
        ExpenseReportFields.values.map((e) => EnumUtils.parse(e)).toList(),
    columns: selectedColumns,
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
    entities: entities,
  );
}
