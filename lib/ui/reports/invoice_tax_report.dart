// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart' show IterableNullableExtension;
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:invoiceninja_flutter/utils/enums.dart';

enum TaxRateReportFields {
  client,
  client_number,
  number,
  amount,
  net_amount,
  date,
  tax_name,
  tax_rate,
  tax_amount,
  tax_paid,
  currency
}

var memoizedInvoiceTaxReport = memo9((
  UserCompanyEntity? userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String?, TaxRateEntity?> taxRateMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, InvoiceEntity> creditMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, PaymentEntity> paymentMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) =>
    taxReport(userCompany!, reportsUIState, taxRateMap, invoiceMap, creditMap,
        clientMap, paymentMap, userMap, staticState));

ReportResult taxReport(
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String?, TaxRateEntity?> taxRateMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, InvoiceEntity> creditMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, PaymentEntity> paymentMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) {
  final List<List<ReportElement>> data = [];
  BuiltList<TaxRateReportFields> columns;

  final reportSettings = userCompany.settings.reportSettings;
  final taxRateReportSettings = reportSettings.containsKey(kReportInvoiceTax)
      ? reportSettings[kReportInvoiceTax]!
      : ReportSettingsEntity();

  final defaultColumns = [
    TaxRateReportFields.tax_name,
    TaxRateReportFields.tax_amount,
    TaxRateReportFields.tax_paid,
    TaxRateReportFields.amount,
    TaxRateReportFields.date,
    TaxRateReportFields.number,
  ];

  if (taxRateReportSettings.columns.isNotEmpty) {
    columns = BuiltList(taxRateReportSettings.columns
        .map((e) => EnumUtils.fromString(TaxRateReportFields.values, e))
        .whereNotNull()
        .toList());
  } else {
    columns = BuiltList(defaultColumns);
  }

  for (var invoiceId in invoiceMap.keys) {
    final invoice = invoiceMap[invoiceId];

    if (!userCompany.company.reportIncludeDrafts && invoice!.isDraft) {
      continue;
    }

    if (!invoice!.isDeleted! && invoice.isSent) {
      final client = clientMap[invoice.clientId] ?? ClientEntity();
      final precision =
          staticState.currencyMap[client.currencyId]?.precision ?? 2;
      final taxes = invoice.getTaxes(precision);

      for (final key in taxes.keys) {
        bool skip = false;

        final List<ReportElement> row = [];
        final String? taxName = taxes[key]!['name'];
        final double? taxRate = taxes[key]!['rate'];

        for (var column in columns) {
          dynamic value = '';

          switch (column) {
            case TaxRateReportFields.client:
              value = client.displayName;
              break;
            case TaxRateReportFields.number:
              value = invoice.number;
              break;
            case TaxRateReportFields.date:
              value = invoice.date;
              break;
            case TaxRateReportFields.amount:
              value = invoice.amount;
              break;
            case TaxRateReportFields.net_amount:
              value = invoice.netAmount;
              break;
            case TaxRateReportFields.tax_name:
              value = taxName;
              break;
            case TaxRateReportFields.tax_rate:
              value = taxRate;
              break;
            case TaxRateReportFields.tax_amount:
              value = taxes[key]!['amount'] ?? 0.0;
              break;
            case TaxRateReportFields.tax_paid:
              value = taxes[key]!['paid'] ?? 0.0;
              break;
            case TaxRateReportFields.currency:
              value = staticState.currencyMap[client.currencyId]?.name ??
                  staticState.currencyMap[client.settings.currencyId]?.name;
              break;
            case TaxRateReportFields.client_number:
              value = client.number;
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

  for (var creditId in creditMap.keys) {
    final credit = creditMap[creditId]!;
    if (!credit.isDeleted! && credit.isSent) {
      final client =
          clientMap[credit.clientId] ?? ClientEntity(id: credit.clientId);
      final precision =
          staticState.currencyMap[client.currencyId]?.precision ?? 2;
      final taxes = credit.getTaxes(precision);

      for (final key in taxes.keys) {
        bool skip = false;

        final List<ReportElement> row = [];
        final String? taxName = taxes[key]!['name'];
        final double? taxRate = taxes[key]!['rate'];

        for (var column in columns) {
          dynamic value = '';

          switch (column) {
            case TaxRateReportFields.client:
              value = client.displayName;
              break;
            case TaxRateReportFields.number:
              value = credit.number;
              break;
            case TaxRateReportFields.date:
              value = credit.date;
              break;
            case TaxRateReportFields.amount:
              value = credit.amount * -1;
              break;
            case TaxRateReportFields.net_amount:
              value = credit.netAmount * -1;
              break;
            case TaxRateReportFields.tax_name:
              value = taxName;
              break;
            case TaxRateReportFields.tax_rate:
              value = taxRate;
              break;
            case TaxRateReportFields.tax_amount:
              value = (taxes[key]!['amount'] ?? 0.0) * -1;
              break;
            case TaxRateReportFields.tax_paid:
              value = (taxes[key]!['paid'] ?? 0.0) * -1;
              break;
            case TaxRateReportFields.currency:
              value = staticState.currencyMap[client.currencyId]?.name ??
                  staticState.currencyMap[client.settings.currencyId]?.name;
              break;
            case TaxRateReportFields.client_number:
              value = client.number;
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
            row.add(credit.getReportBool(value: value));
          } else if (value.runtimeType == double || value.runtimeType == int) {
            row.add(credit.getReportDouble(
                value: value, currencyId: client.settings.currencyId));
          } else {
            row.add(credit.getReportString(value: value));
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
      sortReportTableRows(rowA, rowB, taxRateReportSettings, selectedColumns)!);

  return ReportResult(
    allColumns:
        TaxRateReportFields.values.map((e) => EnumUtils.parse(e)).toList(),
    columns: columns.map((item) => EnumUtils.parse(item)).toList(),
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
  );
}
