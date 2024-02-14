// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart' show IterableNullableExtension;
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

enum RecurringExpenseReportFields {
  id,
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
  vendor,
  expense1,
  expense2,
  expense3,
  expense4,
  category,
  assigned_to,
  created_by,
  public_notes,
  private_notes,
  frequency,
  start_date,
  remaining_cycles,
  record_state,
}

var memoizedRecurringExpenseReport = memo9((
  UserCompanyEntity? userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, ExpenseEntity> expenseMap,
  BuiltMap<String, ExpenseCategoryEntity> expenseCategoryMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, VendorEntity> vendorMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) =>
    recurringExpenseReport(
      userCompany!,
      reportsUIState,
      expenseMap,
      expenseCategoryMap,
      invoiceMap,
      clientMap,
      vendorMap,
      userMap,
      staticState,
    ));

ReportResult recurringExpenseReport(
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
  final List<BaseEntity> entities = [];
  BuiltList<RecurringExpenseReportFields> columns;

  final localization = AppLocalization.of(navigatorKey.currentContext!);
  final reportSettings = userCompany.settings.reportSettings;
  final expenseReportSettings =
      reportSettings.containsKey(kReportRecurringExpense)
          ? reportSettings[kReportRecurringExpense]!
          : ReportSettingsEntity();

  final defaultColumns = [
    RecurringExpenseReportFields.amount,
    RecurringExpenseReportFields.transaction_reference,
    RecurringExpenseReportFields.client,
    RecurringExpenseReportFields.vendor,
    RecurringExpenseReportFields.category,
    RecurringExpenseReportFields.frequency,
    RecurringExpenseReportFields.start_date,
    RecurringExpenseReportFields.remaining_cycles,
  ];

  if (expenseReportSettings.columns.isNotEmpty) {
    columns = BuiltList(expenseReportSettings.columns
        .map(
            (e) => EnumUtils.fromString(RecurringExpenseReportFields.values, e))
        .whereNotNull()
        .toList());
  } else {
    columns = BuiltList(defaultColumns);
  }

  for (var expenseId in expenseMap.keys) {
    final expense = expenseMap[expenseId]!;
    final client = clientMap[expense.clientId] ?? ClientEntity();
    final vendor = vendorMap[expense.vendorId] ?? VendorEntity();

    if (expense.isDeleted! && !userCompany.company.reportIncludeDeleted) {
      continue;
    }

    bool skip = false;
    final List<ReportElement> row = [];

    for (var column in columns) {
      dynamic value = '';

      switch (column) {
        case RecurringExpenseReportFields.id:
          value = expense.id;
          break;
        case RecurringExpenseReportFields.amount:
          value = expense.grossAmount;
          break;
        case RecurringExpenseReportFields.net_amount:
          value = expense.netAmount;
          break;
        case RecurringExpenseReportFields.tax_amount:
          value = expense.taxAmount;
          break;
        case RecurringExpenseReportFields.transaction_reference:
          value = expense.transactionReference;
          break;
        case RecurringExpenseReportFields.currency:
          value = staticState.currencyMap[expense.currencyId]?.name ?? '';
          break;
        case RecurringExpenseReportFields.date:
          value = expense.date;
          break;
        case RecurringExpenseReportFields.payment_date:
          value = expense.paymentDate;
          break;
        case RecurringExpenseReportFields.payment_type:
          value = staticState
                  .paymentTypeMap[expense.paymentTypeId]?.listDisplayName ??
              '';
          break;
        case RecurringExpenseReportFields.tax_rate1:
          value = expense.taxRate1;
          break;
        case RecurringExpenseReportFields.tax_rate2:
          value = expense.taxRate2;
          break;
        case RecurringExpenseReportFields.tax_rate3:
          value = expense.taxRate3;
          break;
        case RecurringExpenseReportFields.client:
          value = client.displayName;
          break;
        case RecurringExpenseReportFields.client_balance:
          value = client.balance;
          break;
        case RecurringExpenseReportFields.client_address1:
          value = client.address1;
          break;
        case RecurringExpenseReportFields.client_address2:
          value = client.address2;
          break;
        case RecurringExpenseReportFields.client_shipping_address1:
          value = client.shippingAddress1;
          break;
        case RecurringExpenseReportFields.client_shipping_address2:
          value = client.shippingAddress2;
          break;
        case RecurringExpenseReportFields.vendor:
          value = vendor.listDisplayName;
          break;
        case RecurringExpenseReportFields.expense1:
          value = expense.customValue1;
          break;
        case RecurringExpenseReportFields.expense2:
          value = expense.customValue2;
          break;
        case RecurringExpenseReportFields.expense3:
          value = expense.customValue3;
          break;
        case RecurringExpenseReportFields.expense4:
          value = expense.customValue4;
          break;
        case RecurringExpenseReportFields.category:
          value = expenseCategoryMap[expense.categoryId]?.name ?? '';
          break;
        case RecurringExpenseReportFields.assigned_to:
          value = userMap[expense.assignedUserId]?.listDisplayName ?? '';
          break;
        case RecurringExpenseReportFields.created_by:
          value = userMap[expense.createdUserId]?.listDisplayName ?? '';
          break;
        case RecurringExpenseReportFields.public_notes:
          value = expense.publicNotes;
          break;
        case RecurringExpenseReportFields.private_notes:
          value = expense.privateNotes;
          break;
        case RecurringExpenseReportFields.frequency:
          value = localization!.lookup(kFrequencies[expense.frequencyId]);
          break;
        case RecurringExpenseReportFields.start_date:
          value = expense.nextSendDate;
          break;
        case RecurringExpenseReportFields.remaining_cycles:
          value = expense.remainingCycles == -1
              ? localization!.endless
              : '${expense.remainingCycles}';
          break;
        case RecurringExpenseReportFields.record_state:
          value = AppLocalization.of(navigatorKey.currentContext!)!
              .lookup(expense.entityState);
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
    allColumns: RecurringExpenseReportFields.values
        .map((e) => EnumUtils.parse(e))
        .toList(),
    columns: selectedColumns,
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
    entities: entities,
  );
}
