import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/data/models/product_model.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:invoiceninja_flutter/utils/enums.dart';
import 'package:memoize/memoize.dart';

enum InvoiceItemReportFields {
  productKey,
  notes,
  price,
  cost,
  quantity,
  profit,
  lineTotal,
  discount,
  custom1,
  custom2,
  custom3,
  custom4,
  invoiceNumber,
  invoiceDate,
  client,
}

var memoizedInvoiceItemReport = memo6((
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, ProductEntity> productMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  StaticState staticState,
) =>
    lineItemReport(userCompany, reportsUIState, productMap, invoiceMap,
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
  final lineItemReportSettings =
      reportSettings != null && reportSettings.containsKey(kReportInvoiceItem)
          ? reportSettings[kReportInvoiceItem]
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
        .where((element) => element != null)
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
    final client = clientMap[invoice.clientId];

    if (invoice.isDeleted || client.isDeleted) {
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
            value = productId == null ? 0.0 : productMap[productId].cost;
            break;
          case InvoiceItemReportFields.profit:
            value = productId == null
                ? 0.0
                : lineItem.total - productMap[productId].cost;
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
          case InvoiceItemReportFields.notes:
            value = lineItem.notes;
            break;
          case InvoiceItemReportFields.lineTotal:
            value = lineItem.total;
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
        } else if (value.runtimeType == double) {
          row.add(invoice.getReportDouble(
              value: value, currencyId: client.currencyId));
        } else if (value.runtimeType == int) {
          row.add(invoice.getReportInt(
              value: value, currencyId: client.currencyId));
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
  data.sort((rowA, rowB) =>
      sortReportTableRows(rowA, rowB, lineItemReportSettings, selectedColumns));

  return ReportResult(
    allColumns:
        InvoiceItemReportFields.values.map((e) => EnumUtils.parse(e)).toList(),
    columns: selectedColumns,
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
  );
}
