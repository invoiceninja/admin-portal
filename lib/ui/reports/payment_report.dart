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

enum PaymentReportFields {
  id,
  number,
  amount,
  client,
  client_balance,
  client_address1,
  client_address2,
  client_shipping_address1,
  client_shipping_address2,
  transaction_reference,
  date,
  type,
  payment1,
  payment2,
  payment3,
  payment4,
  exchange_rate,
  converted_amount,
  invoices,
  credits,
}

var memoizedPaymentReport = memo8(
  (
    UserCompanyEntity userCompany,
    ReportsUIState reportsUIState,
    BuiltMap<String, PaymentEntity> paymentMap,
    BuiltMap<String, ClientEntity> clientMap,
    BuiltMap<String, UserEntity> userMap,
    BuiltMap<String, InvoiceEntity> invoiceMap,
    BuiltMap<String, InvoiceEntity> creditMap,
    StaticState staticState,
  ) =>
      paymentReport(
    userCompany,
    reportsUIState,
    paymentMap,
    clientMap,
    userMap,
    invoiceMap,
    creditMap,
    staticState,
  ),
);

ReportResult paymentReport(
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, PaymentEntity> paymentMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, UserEntity> userMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, InvoiceEntity> creditMap,
  StaticState staticState,
) {
  final List<List<ReportElement>> data = [];
  BuiltList<PaymentReportFields> columns;

  final reportSettings = userCompany.settings?.reportSettings;
  final paymentReportSettings =
      reportSettings != null && reportSettings.containsKey(kReportPayment)
          ? reportSettings[kReportPayment]
          : ReportSettingsEntity();

  final defaultColumns = [
    PaymentReportFields.number,
    PaymentReportFields.amount,
    PaymentReportFields.client,
    PaymentReportFields.date,
    PaymentReportFields.transaction_reference,
  ];

  if (paymentReportSettings.columns.isNotEmpty) {
    columns = BuiltList(paymentReportSettings.columns
        .map((e) => EnumUtils.fromString(PaymentReportFields.values, e))
        .where((element) => element != null)
        .toList());
  } else {
    columns = BuiltList(defaultColumns);
  }

  final Map<String, List<String>> paymentInvoiceMap = {};
  final Map<String, List<String>> paymentCreditMap = {};

  if (columns.contains(PaymentReportFields.invoices)) {
    for (var paymentId in paymentMap.keys) {
      final payment = paymentMap[paymentId] ?? PaymentEntity();
      paymentInvoiceMap[payment.id] = [];
      if (payment.isDeleted) {
        continue;
      }
      for (var invoicePaymentable in payment.invoicePaymentables) {
        final invoice =
            invoiceMap[invoicePaymentable.invoiceId] ?? InvoiceEntity();
        if (invoice.isDeleted) {
          continue;
        }
        paymentInvoiceMap[payment.id].add(invoice.number);
      }
    }
  }

  if (columns.contains(PaymentReportFields.credits)) {
    for (var paymentId in paymentMap.keys) {
      final payment = paymentMap[paymentId] ?? PaymentEntity();
      paymentCreditMap[payment.id] = [];
      if (payment.isDeleted) {
        continue;
      }
      for (var creditPaymentable in payment.invoicePaymentables) {
        final credit =
            creditMap[creditPaymentable.invoiceId] ?? InvoiceEntity();
        if (credit.isDeleted) {
          continue;
        }
        paymentCreditMap[payment.id].add(credit.number);
      }
    }
  }

  for (var paymentId in paymentMap.keys) {
    final payment = paymentMap[paymentId] ?? PaymentEntity();
    final client = clientMap[payment.clientId] ?? ClientEntity();

    if (payment.isDeleted || client.isDeleted) {
      continue;
    }

    bool skip = false;
    final List<ReportElement> row = [];

    for (var column in columns) {
      dynamic value = '';

      switch (column) {
        case PaymentReportFields.id:
          value = payment.id;
          break;
        case PaymentReportFields.number:
          value = payment.number;
          break;
        case PaymentReportFields.type:
          value = staticState.paymentTypeMap[payment.typeId]?.name ?? '';
          break;
        case PaymentReportFields.amount:
          value = payment.completedAmount;
          break;
        case PaymentReportFields.client:
          value = client.displayName;
          break;
        case PaymentReportFields.client_balance:
          value = client.balance;
          break;
        case PaymentReportFields.client_address1:
          value = client.address1;
          break;
        case PaymentReportFields.client_address2:
          value = client.address2;
          break;
        case PaymentReportFields.client_shipping_address1:
          value = client.shippingAddress1;
          break;
        case PaymentReportFields.client_shipping_address2:
          value = client.shippingAddress2;
          break;
        case PaymentReportFields.transaction_reference:
          value = payment.transactionReference;
          break;
        case PaymentReportFields.date:
          value = payment.date;
          break;
        case PaymentReportFields.payment1:
          value = payment.customValue1;
          break;
        case PaymentReportFields.payment2:
          value = payment.customValue2;
          break;
        case PaymentReportFields.payment3:
          value = payment.customValue3;
          break;
        case PaymentReportFields.payment4:
          value = payment.customValue4;
          break;
        case PaymentReportFields.exchange_rate:
          value = payment.exchangeRate;
          break;
        case PaymentReportFields.converted_amount:
          value = payment.completedAmount * payment.exchangeRate;
          break;
        case PaymentReportFields.invoices:
          value = (paymentInvoiceMap[payment.id] ?? []).join(', ');
          break;
        case PaymentReportFields.credits:
          value = (paymentCreditMap[payment.id] ?? []).join(', ');
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
        row.add(payment.getReportBool(value: value));
      } else if (column == PaymentReportFields.converted_amount) {
        row.add(payment.getReportDouble(
            value: value, currencyId: payment.exchangeCurrencyId));
      } else if (value.runtimeType == double || value.runtimeType == int) {
        row.add(payment.getReportDouble(
            value: value, currencyId: payment.currencyId));
      } else {
        row.add(payment.getReportString(value: value));
      }
    }

    if (!skip) {
      data.add(row);
    }
  }

  final selectedColumns = columns.map((item) => EnumUtils.parse(item)).toList();
  data.sort((rowA, rowB) =>
      sortReportTableRows(rowA, rowB, paymentReportSettings, selectedColumns));

  return ReportResult(
    allColumns:
        PaymentReportFields.values.map((e) => EnumUtils.parse(e)).toList(),
    columns: selectedColumns,
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
  );
}
