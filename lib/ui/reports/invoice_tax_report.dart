import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/utils/enums.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/tax_rate_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:memoize/memoize.dart';

enum TaxRateReportFields {
  client,
  invoice,
  invoice_amount,
  invoice_balance,
  invoice_date,
  tax_name,
  tax_rate,
  tax_amount,
  tax_paid,
  currency
}

var memoizedInvoiceTaxReport = memo8((
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, TaxRateEntity> taxRateMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, PaymentEntity> paymentMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) =>
    invoiceTaxReport(userCompany, reportsUIState, taxRateMap, invoiceMap,
        clientMap, paymentMap, userMap, staticState));

ReportResult invoiceTaxReport(
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, TaxRateEntity> taxRateMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, PaymentEntity> paymentMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) {
  final List<List<ReportElement>> data = [];
  BuiltList<TaxRateReportFields> columns;

  final reportSettings = userCompany.settings.reportSettings;
  final taxRateReportSettings =
      reportSettings != null && reportSettings.containsKey(kReportInvoiceTax)
          ? reportSettings[kReportInvoiceTax]
          : ReportSettingsEntity();

  final defaultColumns = [
    TaxRateReportFields.tax_name,
    TaxRateReportFields.tax_amount,
    TaxRateReportFields.tax_paid,
    TaxRateReportFields.invoice_amount,
    TaxRateReportFields.invoice_balance,
    TaxRateReportFields.invoice_date,
    TaxRateReportFields.invoice,
  ];

  if (taxRateReportSettings.columns.isNotEmpty) {
    columns = BuiltList(taxRateReportSettings.columns
        .map((e) => EnumUtils.fromString(TaxRateReportFields.values, e))
        .where((element) => element != null)
        .toList());
  } else {
    columns = BuiltList(defaultColumns);
  }

  for (var invoiceId in invoiceMap.keys) {
    final invoice = invoiceMap[invoiceId];

    if (invoice.isActive) {
      final client = clientMap[invoice.clientId];
      final precision = staticState.currencyMap[client.currencyId].precision;
      final taxes = invoice.getTaxes(precision);

      for (final key in taxes.keys) {
        bool skip = false;

        final List<ReportElement> row = [];
        final String taxName = taxes[key]['name'];
        final double taxRate = taxes[key]['rate'];

        if (taxRate == null || taxRate == 0) {
          continue;
        }

        for (var column in columns) {
          dynamic value = '';

          switch (column) {
            case TaxRateReportFields.client:
              value = client.displayName;
              break;
            case TaxRateReportFields.invoice:
              value = invoice.listDisplayName;
              break;
            case TaxRateReportFields.invoice_date:
              value = invoice.date;
              break;
            case TaxRateReportFields.invoice_amount:
              value = invoice.amount;
              break;
            case TaxRateReportFields.tax_name:
              value = taxName;
              break;
            case TaxRateReportFields.tax_rate:
              value = taxRate;
              break;
            case TaxRateReportFields.tax_amount:
              value = taxes[key]['amount'] ?? 0.0;
              break;
            case TaxRateReportFields.tax_paid:
              value = taxes[key]['paid'] ?? 0.0;
              break;
            case TaxRateReportFields.invoice_balance:
              value = invoice.balance;
              break;
            case TaxRateReportFields.currency:
              value = staticState.currencyMap[client.currencyId]?.name ??
                  staticState.currencyMap[client.settings.currencyId]?.name;
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
            row.add(invoice.getReportBool(value: value));
          } else if (value.runtimeType == double || value.runtimeType == int) {
            row.add(invoice.getReportDouble(
                value: value, currencyId: client.settings.currencyId));
          } else {
            row.add(invoice.getReportString(value: value));
          }
        }

        if (!skip) {
          data.add(row);
        }
      }
    }
  }

  final selectedColumns = columns.map((item) => EnumUtils.parse(item)).toList();
  data.sort((rowA, rowB) =>
      sortReportTableRows(rowA, rowB, taxRateReportSettings, selectedColumns));

  return ReportResult(
    allColumns:
        TaxRateReportFields.values.map((e) => EnumUtils.parse(e)).toList(),
    columns: columns.map((item) => EnumUtils.parse(item)).toList(),
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
  );
}
