// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart' show IterableNullableExtension;
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/data/models/product_model.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:invoiceninja_flutter/utils/enums.dart';

enum InvoiceItemReportFields {
  productKey,
  description,
  price,
  cost,
  quantity,
  profit,
  markup,
  total,
  discount,
  custom1,
  custom2,
  custom3,
  custom4,
  invoiceNumber,
  invoiceDate,
  client,
  clientEmail,
  clientNumber,
  clientIdNumber,
  dueDate,
  hasTaxes,
  taxRates,
  taxAmount,
  netTotal,
  currency,
  record_state,
}

var memoizedInvoiceItemReport = memo6((
  UserCompanyEntity? userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, ProductEntity> productMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  StaticState staticState,
) =>
    lineItemReport(userCompany!, reportsUIState, productMap, invoiceMap,
        clientMap, staticState));

ReportResult lineItemReport(
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, ProductEntity> productMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  StaticState staticState,
) {
  final List<List<ReportElement>> data = [];
  BuiltList<InvoiceItemReportFields> columns;

  final reportSettings = userCompany.settings.reportSettings;
  final lineItemReportSettings = reportSettings.containsKey(kReportInvoiceItem)
      ? reportSettings[kReportInvoiceItem]!
      : ReportSettingsEntity();

  final defaultColumns = [
    InvoiceItemReportFields.invoiceNumber,
    InvoiceItemReportFields.invoiceDate,
    InvoiceItemReportFields.productKey,
    InvoiceItemReportFields.quantity,
    InvoiceItemReportFields.price,
  ];

  if (lineItemReportSettings.columns.isNotEmpty) {
    columns = BuiltList(lineItemReportSettings.columns
        .map((e) => EnumUtils.fromString(InvoiceItemReportFields.values, e))
        .whereNotNull()
        .toList());
  } else {
    columns = BuiltList(defaultColumns);
  }

  final productKeyMap = <String, String>{};
  for (var entry in productMap.entries) {
    productKeyMap[entry.value.productKey] = entry.value.id;
  }

  for (var entry in invoiceMap.entries) {
    final invoice = entry.value;
    final client = clientMap[invoice.clientId] ?? ClientEntity();
    final precision =
        staticState.currencyMap[client.currencyId]?.precision ?? 2;

    if ((invoice.isDeleted! && !userCompany.company.reportIncludeDeleted) ||
        client.isDeleted!) {
      continue;
    }

    if (!userCompany.company.reportIncludeDrafts && invoice.isDraft) {
      continue;
    }

    for (var lineItem in invoice.lineItems) {
      bool skip = false;
      final List<ReportElement> row = [];

      for (var column in columns) {
        dynamic value = '';
        final productId = productKeyMap[lineItem.productKey];

        switch (column) {
          case InvoiceItemReportFields.price:
            value = lineItem.cost;
            break;
          case InvoiceItemReportFields.quantity:
            value = lineItem.quantity;
            break;
          case InvoiceItemReportFields.cost:
            if (lineItem.productCost != 0) {
              value = lineItem.productCost;
            } else {
              value = productId == null ? 0.0 : productMap[productId]!.cost;
            }
            break;
          case InvoiceItemReportFields.profit:
          case InvoiceItemReportFields.markup:
            var cost = 0.0;
            if (lineItem.productCost != 0) {
              cost = lineItem.productCost;
            } else {
              cost = productId == null ? 0.0 : productMap[productId]!.cost;
            }
            value = (lineItem.netTotal(invoice, precision) *
                    1 /
                    invoice.exchangeRate) -
                cost;
            if (column == InvoiceItemReportFields.markup && cost != 0) {
              value = '${round(value / cost * 100, 2)}%';
            }
            break;
          case InvoiceItemReportFields.custom1:
            value = lineItem.customValue1;
            break;
          case InvoiceItemReportFields.custom2:
            value = lineItem.customValue2;
            break;
          case InvoiceItemReportFields.custom3:
            value = lineItem.customValue3;
            break;
          case InvoiceItemReportFields.custom4:
            value = lineItem.customValue4;
            break;
          case InvoiceItemReportFields.description:
            value = lineItem.notes;
            break;
          case InvoiceItemReportFields.total:
            value = lineItem.total(invoice, precision);
            break;
          case InvoiceItemReportFields.productKey:
            value = lineItem.productKey;
            break;
          case InvoiceItemReportFields.discount:
            value = lineItem.discount;
            break;
          case InvoiceItemReportFields.invoiceNumber:
            value = invoice.number;
            break;
          case InvoiceItemReportFields.invoiceDate:
            value = invoice.date;
            break;
          case InvoiceItemReportFields.client:
            value = client.displayName;
            break;
          case InvoiceItemReportFields.clientEmail:
            value = client.primaryContact.email;
            break;
          case InvoiceItemReportFields.dueDate:
            value = invoice.dueDate;
            break;
          case InvoiceItemReportFields.hasTaxes:
            value = lineItem.hasTaxes;
            break;
          case InvoiceItemReportFields.taxRates:
            value = lineItem.taxRates;
            break;
          case InvoiceItemReportFields.taxAmount:
            value = lineItem.taxAmount(invoice, precision);
            break;
          case InvoiceItemReportFields.netTotal:
            value = lineItem.netTotal(invoice, precision);
            break;
          case InvoiceItemReportFields.currency:
            value =
                staticState.currencyMap[client.currencyId]?.listDisplayName ??
                    '';
            break;
          case InvoiceItemReportFields.clientNumber:
            value = client.number;
            break;
          case InvoiceItemReportFields.clientIdNumber:
            value = client.idNumber;
            break;
          case InvoiceItemReportFields.record_state:
            value = AppLocalization.of(navigatorKey.currentContext!)!
                .lookup(invoice.entityState);
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
              value: value,
              currencyId: column == InvoiceItemReportFields.quantity
                  ? null
                  : column == InvoiceItemReportFields.profit ||
                          column == InvoiceItemReportFields.cost
                      ? userCompany.company.currencyId
                      : client.currencyId));
        } else {
          row.add(invoice.getReportString(value: value));
        }
      }

      if (!skip) {
        data.add(row);
      }
    }
  }

  final selectedColumns = columns.map((item) => EnumUtils.parse(item)).toList();
  data.sort((rowA, rowB) => sortReportTableRows(
      rowA, rowB, lineItemReportSettings, selectedColumns)!);

  return ReportResult(
    allColumns: InvoiceItemReportFields.values
        .where((field) =>
            field != InvoiceItemReportFields.discount ||
            userCompany.company.enableProductDiscount)
        .map((e) => EnumUtils.parse(e))
        .toList(),
    columns: selectedColumns,
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
  );
}
