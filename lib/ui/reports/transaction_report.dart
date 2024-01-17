// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart' show IterableNullableExtension;
import 'package:invoiceninja_flutter/utils/strings.dart';
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
import 'package:invoiceninja_flutter/utils/formatting.dart';

enum TransactionReportFields {
  id,
  amount,
  date,
  description,
  deposit,
  withdrawal,
  vendor,
  category,
  payment,
  bankAccount,
  invoices,
  expenseNumber,
  status,
  accountType,
  defaultCategory,
  created_at,
  updated_at,
  record_state,
  participant,
  participant_name,
}

var memoizedTransactionReport = memo10((
  UserCompanyEntity? userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, TransactionEntity> transactionMap,
  BuiltMap<String, VendorEntity> vendorMap,
  BuiltMap<String, ExpenseEntity> expenseMap,
  BuiltMap<String, ExpenseCategoryEntity> categoryMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, BankAccountEntity> bankAccountMap,
  BuiltMap<String, PaymentEntity> paymentMap,
  StaticState staticState,
) =>
    transactionReport(
      userCompany!,
      reportsUIState,
      transactionMap,
      vendorMap,
      expenseMap,
      categoryMap,
      invoiceMap,
      bankAccountMap,
      paymentMap,
      staticState,
    ));

ReportResult transactionReport(
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, TransactionEntity> transactionMap,
  BuiltMap<String, VendorEntity> vendorMap,
  BuiltMap<String, ExpenseEntity> expenseMap,
  BuiltMap<String, ExpenseCategoryEntity> categoryMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, BankAccountEntity> bankAccountMap,
  BuiltMap<String, PaymentEntity> paymentMap,
  StaticState staticState,
) {
  final List<List<ReportElement>> data = [];
  final List<BaseEntity> entities = [];
  BuiltList<TransactionReportFields> columns;

  final reportSettings = userCompany.settings.reportSettings;
  final transactionReportSettings =
      reportSettings.containsKey(kReportTransaction)
          ? reportSettings[kReportTransaction]!
          : ReportSettingsEntity();

  final defaultColumns = [
    TransactionReportFields.status,
    TransactionReportFields.deposit,
    TransactionReportFields.withdrawal,
    TransactionReportFields.date,
    TransactionReportFields.description,
    TransactionReportFields.invoices,
    TransactionReportFields.expenseNumber,
  ];

  if (transactionReportSettings.columns.isNotEmpty) {
    columns = BuiltList(transactionReportSettings.columns
        .map((e) => EnumUtils.fromString(TransactionReportFields.values, e))
        .whereNotNull()
        .toList());
  } else {
    columns = BuiltList(defaultColumns);
  }

  for (var transactionId in transactionMap.keys) {
    final transaction = transactionMap[transactionId]!;

    if (transaction.isDeleted! && !userCompany.company.reportIncludeDeleted) {
      continue;
    }

    bool skip = false;
    final List<ReportElement> row = [];

    for (var column in columns) {
      dynamic value = '';

      switch (column) {
        case TransactionReportFields.id:
          value = transaction.id;
          break;
        case TransactionReportFields.accountType:
          value = toTitleCase(
              bankAccountMap[transaction.bankAccountId]?.type ?? '');
          break;
        case TransactionReportFields.amount:
          value = transaction.amount;
          break;
        case TransactionReportFields.withdrawal:
          value = transaction.withdrawal;
          break;
        case TransactionReportFields.deposit:
          value = transaction.deposit;
          break;
        case TransactionReportFields.category:
          value = categoryMap[transaction.categoryId]?.name ?? '';
          break;
        case TransactionReportFields.date:
          value = transaction.date;
          break;
        case TransactionReportFields.description:
          value = transaction.formattedDescription;
          break;
        case TransactionReportFields.vendor:
          value = vendorMap[transaction.vendorId]?.name ?? '';
          break;
        case TransactionReportFields.status:
          value = kTransactionStatuses[transaction.statusId];
          break;
        case TransactionReportFields.bankAccount:
          value = bankAccountMap[transaction.bankAccountId]?.name ?? '';
          break;
        case TransactionReportFields.payment:
          value = paymentMap[transaction.paymentId]?.number ?? '';
          break;
        case TransactionReportFields.defaultCategory:
          value = transaction.category;
          break;
        case TransactionReportFields.expenseNumber:
          value = transaction.expenseId
              .split(',')
              .map((expenseId) => expenseMap[expenseId]?.number ?? '')
              .join(', ');
          break;
        case TransactionReportFields.invoices:
          value = transaction.invoiceIds
              .split(',')
              .map((invoiceId) => invoiceMap[invoiceId]?.number ?? '')
              .where((number) => number.isNotEmpty)
              .join(', ');
          break;
        case TransactionReportFields.updated_at:
          value = convertTimestampToDateString(transaction.updatedAt);
          break;
        case TransactionReportFields.created_at:
          value = convertTimestampToDateString(transaction.createdAt);
          break;
        case TransactionReportFields.record_state:
          value = AppLocalization.of(navigatorKey.currentContext!)!
              .lookup(transaction.entityState);
          break;
        case TransactionReportFields.participant_name:
          value = transaction.participantName;
          break;
        case TransactionReportFields.participant:
          value = transaction.participant;
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
        row.add(transaction.getReportBool(value: value));
      } else if (value.runtimeType == double || value.runtimeType == int) {
        row.add(transaction.getReportDouble(
            value: value, currencyId: transaction.currencyId));
      } else {
        row.add(transaction.getReportString(value: value));
      }
    }

    if (!skip) {
      data.add(row);
      entities.add(transaction);
    }
  }

  final selectedColumns = columns.map((item) => EnumUtils.parse(item)).toList();
  data.sort((rowA, rowB) => sortReportTableRows(
      rowA, rowB, transactionReportSettings, selectedColumns)!);

  return ReportResult(
    allColumns:
        TransactionReportFields.values.map((e) => EnumUtils.parse(e)).toList(),
    columns: selectedColumns,
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
    entities: entities,
  );
}
