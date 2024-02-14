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

enum CreditItemReportFields {
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
  creditNumber,
  creditDate,
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

var memoizedCreditItemReport = memo6((
  UserCompanyEntity? userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, ProductEntity> productMap,
  BuiltMap<String, InvoiceEntity> creditMap,
  BuiltMap<String, ClientEntity> clientMap,
  StaticState staticState,
) =>
    lineItemReport(userCompany!, reportsUIState, productMap, creditMap,
        clientMap, staticState));

ReportResult lineItemReport(
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, ProductEntity> productMap,
  BuiltMap<String, InvoiceEntity> creditMap,
  BuiltMap<String, ClientEntity> clientMap,
  StaticState staticState,
) {
  final List<List<ReportElement>> data = [];
  BuiltList<CreditItemReportFields> columns;

  final reportSettings = userCompany.settings.reportSettings;
  final lineItemReportSettings = reportSettings.containsKey(kReportCreditItem)
      ? reportSettings[kReportCreditItem]!
      : ReportSettingsEntity();

  final defaultColumns = [
    CreditItemReportFields.creditNumber,
    CreditItemReportFields.creditDate,
    CreditItemReportFields.productKey,
    CreditItemReportFields.quantity,
    CreditItemReportFields.price,
  ];

  if (lineItemReportSettings.columns.isNotEmpty) {
    columns = BuiltList(lineItemReportSettings.columns
        .map((e) => EnumUtils.fromString(CreditItemReportFields.values, e))
        .whereNotNull()
        .toList());
  } else {
    columns = BuiltList(defaultColumns);
  }

  final productKeyMap = <String, String>{};
  for (var entry in productMap.entries) {
    productKeyMap[entry.value.productKey] = entry.value.id;
  }

  for (var entry in creditMap.entries) {
    final credit = entry.value;
    final client = clientMap[credit.clientId] ?? ClientEntity();
    final precision =
        staticState.currencyMap[client.currencyId]?.precision ?? 2;

    if ((credit.isDeleted! && !userCompany.company.reportIncludeDeleted) ||
        client.isDeleted!) {
      continue;
    }

    if (!userCompany.company.reportIncludeDrafts && credit.isDraft) {
      continue;
    }

    for (var lineItem in credit.lineItems) {
      bool skip = false;
      final List<ReportElement> row = [];

      for (var column in columns) {
        dynamic value = '';
        final productId = productKeyMap[lineItem.productKey];

        switch (column) {
          case CreditItemReportFields.price:
            value = lineItem.cost;
            break;
          case CreditItemReportFields.quantity:
            value = lineItem.quantity;
            break;
          case CreditItemReportFields.cost:
            if (lineItem.productCost != 0) {
              value = lineItem.productCost;
            } else {
              value = productId == null ? 0.0 : productMap[productId]!.cost;
            }
            break;
          case CreditItemReportFields.profit:
          case CreditItemReportFields.markup:
            var cost = 0.0;
            if (lineItem.productCost != 0) {
              cost = lineItem.productCost;
            } else {
              cost = productId == null ? 0.0 : productMap[productId]!.cost;
            }
            value = (lineItem.netTotal(credit, precision) *
                    1 /
                    credit.exchangeRate) -
                cost;
            if (column == CreditItemReportFields.markup && cost != 0) {
              value = '${round(value / cost * 100, 2)}%';
            }
            break;
          case CreditItemReportFields.custom1:
            value = lineItem.customValue1;
            break;
          case CreditItemReportFields.custom2:
            value = lineItem.customValue2;
            break;
          case CreditItemReportFields.custom3:
            value = lineItem.customValue3;
            break;
          case CreditItemReportFields.custom4:
            value = lineItem.customValue4;
            break;
          case CreditItemReportFields.description:
            value = lineItem.notes;
            break;
          case CreditItemReportFields.total:
            value = lineItem.total(credit, precision);
            break;
          case CreditItemReportFields.productKey:
            value = lineItem.productKey;
            break;
          case CreditItemReportFields.discount:
            value = lineItem.discount;
            break;
          case CreditItemReportFields.creditNumber:
            value = credit.number;
            break;
          case CreditItemReportFields.creditDate:
            value = credit.date;
            break;
          case CreditItemReportFields.client:
            value = client.displayName;
            break;
          case CreditItemReportFields.clientEmail:
            value = client.primaryContact.email;
            break;
          case CreditItemReportFields.dueDate:
            value = credit.dueDate;
            break;
          case CreditItemReportFields.hasTaxes:
            value = lineItem.hasTaxes;
            break;
          case CreditItemReportFields.taxRates:
            value = lineItem.taxRates;
            break;
          case CreditItemReportFields.taxAmount:
            value = lineItem.taxAmount(credit, precision);
            break;
          case CreditItemReportFields.netTotal:
            value = lineItem.netTotal(credit, precision);
            break;
          case CreditItemReportFields.currency:
            value =
                staticState.currencyMap[client.currencyId]?.listDisplayName ??
                    '';
            break;
          case CreditItemReportFields.clientNumber:
            value = client.number;
            break;
          case CreditItemReportFields.clientIdNumber:
            value = client.idNumber;
            break;
          case CreditItemReportFields.record_state:
            value = AppLocalization.of(navigatorKey.currentContext!)!
                .lookup(credit.entityState);
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
              value: value,
              currencyId: column == CreditItemReportFields.quantity
                  ? null
                  : column == CreditItemReportFields.profit ||
                          column == CreditItemReportFields.cost
                      ? userCompany.company.currencyId
                      : client.currencyId));
        } else {
          row.add(credit.getReportString(value: value));
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
    allColumns: CreditItemReportFields.values
        .where((field) =>
            field != CreditItemReportFields.discount ||
            userCompany.company.enableProductDiscount)
        .map((e) => EnumUtils.parse(e))
        .toList(),
    columns: selectedColumns,
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
  );
}
