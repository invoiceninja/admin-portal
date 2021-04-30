import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/utils/enums.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/payment_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:memoize/memoize.dart';

enum PaymentReportFields {
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
  vendor,
  custom_value1,
  custom_value2,
  custom_value3,
  custom_value4,
}

var memoizedPaymentReport = memo7((
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, PaymentEntity> paymentMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, VendorEntity> vendorMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) =>
    paymentReport(userCompany, reportsUIState, paymentMap, clientMap, vendorMap,
        userMap, staticState));

ReportResult paymentReport(
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, PaymentEntity> paymentMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, VendorEntity> vendorMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) {
  final List<List<ReportElement>> data = [];
  BuiltList<PaymentReportFields> columns;

  final reportSettings = userCompany.settings.reportSettings;
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

  for (var paymentId in paymentMap.keys) {
    final payment = paymentMap[paymentId];
    final client = clientMap[payment.clientId];

    if (payment.isDeleted || client.isDeleted) {
      continue;
    }

    bool skip = false;
    final List<ReportElement> row = [];

    for (var column in columns) {
      dynamic value = '';

      switch (column) {
        case PaymentReportFields.number:
          value = payment.number;
          break;
        case PaymentReportFields.amount:
          value = payment.amount;
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
        case PaymentReportFields.vendor:
          value = vendorMap[payment.vendorId].listDisplayName;
          break;
        case PaymentReportFields.custom_value1:
          value = payment.customValue1;
          break;
        case PaymentReportFields.custom_value2:
          value = payment.customValue2;
          break;
        case PaymentReportFields.custom_value3:
          value = payment.customValue3;
          break;
        case PaymentReportFields.custom_value4:
          value = payment.customValue4;
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
      } else if (value.runtimeType == double || value.runtimeType == int) {
        row.add(payment.getReportDouble(
            value: value, currencyId: client.settings.currencyId));
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
