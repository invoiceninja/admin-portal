// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart' show IterableNullableExtension;
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:invoiceninja_flutter/utils/enums.dart';

enum PurchaseOrderItemReportFields {
  productKey,
  description,
  price,
  cost,
  quantity,
  profit,
  total,
  discount,
  custom1,
  custom2,
  custom3,
  custom4,
  purchaseOrderNumber,
  purchaseOrderDate,
  client,
  clientEmail,
  clientNumber,
  clientIdNumber,
  vendor,
  vendorEmail,
  dueDate,
  hasTaxes,
  taxRates,
  taxAmount,
  netTotal,
  currency,
  record_state,
}

var memoizedPurchaseOrderItemReport = memo7((
  UserCompanyEntity? userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, ProductEntity> productMap,
  BuiltMap<String, InvoiceEntity> purchaseOrderMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, VendorEntity> vendorMap,
  StaticState staticState,
) =>
    lineItemReport(userCompany!, reportsUIState, productMap, purchaseOrderMap,
        clientMap, vendorMap, staticState));

ReportResult lineItemReport(
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, ProductEntity> productMap,
  BuiltMap<String, InvoiceEntity> purchaseOrderMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, VendorEntity> vendorMap,
  StaticState staticState,
) {
  final List<List<ReportElement>> data = [];
  BuiltList<PurchaseOrderItemReportFields> columns;

  final reportSettings = userCompany.settings.reportSettings;
  final lineItemReportSettings =
      reportSettings.containsKey(kReportPurchaseOrderItem)
          ? reportSettings[kReportPurchaseOrderItem]!
          : ReportSettingsEntity();

  final defaultColumns = [
    PurchaseOrderItemReportFields.purchaseOrderNumber,
    PurchaseOrderItemReportFields.purchaseOrderDate,
    PurchaseOrderItemReportFields.productKey,
    PurchaseOrderItemReportFields.quantity,
    PurchaseOrderItemReportFields.price,
  ];

  if (lineItemReportSettings.columns.isNotEmpty) {
    columns = BuiltList(lineItemReportSettings.columns
        .map((e) =>
            EnumUtils.fromString(PurchaseOrderItemReportFields.values, e))
        .whereNotNull()
        .toList());
  } else {
    columns = BuiltList(defaultColumns);
  }

  final productKeyMap = <String, String>{};
  for (var entry in productMap.entries) {
    productKeyMap[entry.value.productKey] = entry.value.id;
  }

  for (var entry in purchaseOrderMap.entries) {
    final invoice = entry.value;
    final client = clientMap[invoice.clientId] ?? ClientEntity();
    final vendor = vendorMap[invoice.vendorId] ?? VendorEntity();
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
          case PurchaseOrderItemReportFields.price:
            value = lineItem.cost;
            break;
          case PurchaseOrderItemReportFields.quantity:
            value = lineItem.quantity;
            break;
          case PurchaseOrderItemReportFields.cost:
            if (lineItem.productCost != 0) {
              value = lineItem.productCost;
            } else {
              value = productId == null ? 0.0 : productMap[productId]!.cost;
            }
            break;
          case PurchaseOrderItemReportFields.profit:
            value = lineItem.netTotal(invoice, precision) -
                (productId == null ? 0.0 : productMap[productId]!.cost);
            break;
          case PurchaseOrderItemReportFields.custom1:
            value = lineItem.customValue1;
            break;
          case PurchaseOrderItemReportFields.custom2:
            value = lineItem.customValue2;
            break;
          case PurchaseOrderItemReportFields.custom3:
            value = lineItem.customValue3;
            break;
          case PurchaseOrderItemReportFields.custom4:
            value = lineItem.customValue4;
            break;
          case PurchaseOrderItemReportFields.description:
            value = lineItem.notes;
            break;
          case PurchaseOrderItemReportFields.total:
            value = lineItem.total(invoice, precision);
            break;
          case PurchaseOrderItemReportFields.productKey:
            value = lineItem.productKey;
            break;
          case PurchaseOrderItemReportFields.discount:
            value = lineItem.discount;
            break;
          case PurchaseOrderItemReportFields.purchaseOrderNumber:
            value = invoice.number;
            break;
          case PurchaseOrderItemReportFields.purchaseOrderDate:
            value = invoice.date;
            break;
          case PurchaseOrderItemReportFields.client:
            value = client.displayName;
            break;
          case PurchaseOrderItemReportFields.clientEmail:
            value = client.primaryContact.email;
            break;
          case PurchaseOrderItemReportFields.vendor:
            value = vendor.name;
            break;
          case PurchaseOrderItemReportFields.vendorEmail:
            value = vendor.primaryContact.email;
            break;
          case PurchaseOrderItemReportFields.dueDate:
            value = invoice.dueDate;
            break;
          case PurchaseOrderItemReportFields.hasTaxes:
            value = lineItem.hasTaxes;
            break;
          case PurchaseOrderItemReportFields.taxRates:
            value = lineItem.taxRates;
            break;
          case PurchaseOrderItemReportFields.taxAmount:
            value = lineItem.taxAmount(invoice, precision);
            break;
          case PurchaseOrderItemReportFields.netTotal:
            value = lineItem.netTotal(invoice, precision);
            break;
          case PurchaseOrderItemReportFields.currency:
            value =
                staticState.currencyMap[client.currencyId]?.listDisplayName ??
                    '';
            break;
          case PurchaseOrderItemReportFields.clientNumber:
            value = client.number;
            break;
          case PurchaseOrderItemReportFields.clientIdNumber:
            value = client.idNumber;
            break;
          case PurchaseOrderItemReportFields.record_state:
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
              currencyId: column == PurchaseOrderItemReportFields.quantity
                  ? null
                  : vendor.currencyId));
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
    allColumns: PurchaseOrderItemReportFields.values
        .where((field) =>
            field != PurchaseOrderItemReportFields.discount ||
            userCompany.company.enableProductDiscount)
        .map((e) => EnumUtils.parse(e))
        .toList(),
    columns: selectedColumns,
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
  );
}
