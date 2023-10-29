// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart' show IterableNullableExtension;
import 'package:invoiceninja_flutter/redux/product/product_selectors.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_selectors.dart';
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:invoiceninja_flutter/utils/enums.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

enum ProductReportFields {
  id,
  name,
  price,
  description,
  cost,
  quantity,
  tax_rate1,
  tax_rate2,
  tax_rate3,
  product1,
  product2,
  product3,
  product4,
  stock_quantity,
  notification_threshold,
  created_at,
  updated_at,
  record_state,
}

var memoizedProductReport = memo6((
  UserCompanyEntity? userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, ProductEntity> productMap,
  BuiltMap<String, VendorEntity> vendorMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) =>
    productReport(userCompany!, reportsUIState, productMap, vendorMap, userMap,
        staticState));

ReportResult productReport(
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, ProductEntity> productMap,
  BuiltMap<String, VendorEntity> vendorMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) {
  final List<List<ReportElement>> data = [];
  final List<BaseEntity> entities = [];
  BuiltList<ProductReportFields> columns;

  final reportSettings = userCompany.settings.reportSettings;
  final productReportSettings = reportSettings.containsKey(kReportProduct)
      ? reportSettings[kReportProduct]!
      : ReportSettingsEntity();

  final defaultColumns = [
    ProductReportFields.name,
    ProductReportFields.price,
    ProductReportFields.cost,
    ProductReportFields.quantity,
    ProductReportFields.created_at,
  ];

  if (productReportSettings.columns.isNotEmpty) {
    columns = BuiltList(productReportSettings.columns
        .map((e) => EnumUtils.fromString(ProductReportFields.values, e))
        .whereNotNull()
        .toList());
  } else {
    columns = BuiltList(defaultColumns);
  }

  for (var productId in productMap.keys) {
    final product = productMap[productId]!;

    if (product.isDeleted! && !userCompany.company.reportIncludeDeleted) {
      continue;
    }

    bool skip = false;
    final List<ReportElement> row = [];

    for (var column in columns) {
      dynamic value = '';

      switch (column) {
        case ProductReportFields.id:
          value = product.id;
          break;
        case ProductReportFields.name:
          value = product.listDisplayName;
          break;
        case ProductReportFields.price:
          value = product.price;
          break;
        case ProductReportFields.cost:
          value = product.cost;
          break;
        case ProductReportFields.description:
          value = product.notes;
          break;
        case ProductReportFields.quantity:
          value = product.quantity;
          break;
        case ProductReportFields.tax_rate1:
          value = product.taxRate1;
          break;
        case ProductReportFields.tax_rate2:
          value = product.taxRate2;
          break;
        case ProductReportFields.tax_rate3:
          value = product.taxRate3;
          break;
        case ProductReportFields.product1:
          value = presentCustomField(
            value: product.customValue1,
            customFieldType: CustomFieldType.product1,
            company: userCompany.company,
          );
          break;
        case ProductReportFields.product2:
          value = presentCustomField(
            value: product.customValue2,
            customFieldType: CustomFieldType.product2,
            company: userCompany.company,
          );
          break;
        case ProductReportFields.product3:
          value = presentCustomField(
            value: product.customValue3,
            customFieldType: CustomFieldType.product3,
            company: userCompany.company,
          );
          break;
        case ProductReportFields.product4:
          value = presentCustomField(
            value: product.customValue4,
            customFieldType: CustomFieldType.product4,
            company: userCompany.company,
          );
          break;
        case ProductReportFields.stock_quantity:
          value = product.stockQuantity.toDouble();
          break;
        case ProductReportFields.notification_threshold:
          value = productNotificationThreshold(
              product: product, company: userCompany.company);
          break;
        case ProductReportFields.updated_at:
          value = convertTimestampToDateString(product.updatedAt);
          break;
        case ProductReportFields.created_at:
          value = convertTimestampToDateString(product.createdAt);
          break;
        case ProductReportFields.record_state:
          value = AppLocalization.of(navigatorKey.currentContext!)!
              .lookup(product.entityState);
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
        row.add(product.getReportBool(value: value));
      } else if ([
        ProductReportFields.quantity,
        ProductReportFields.stock_quantity
      ].contains(column)) {
        row.add(product.getReportDouble(
          value: value,
          currencyId: userCompany.company.currencyId,
          formatNumberType: FormatNumberType.double,
        ));
      } else if (column == ProductReportFields.notification_threshold) {
        row.add(product.getReportInt(
          value: value,
        ));
      } else if (value.runtimeType == double || value.runtimeType == int) {
        row.add(product.getReportDouble(
            value: value, currencyId: userCompany.company.currencyId));
      } else {
        row.add(product.getReportString(value: value));
      }
    }

    if (!skip) {
      data.add(row);
      entities.add(product);
    }
  }

  final selectedColumns = columns.map((item) => EnumUtils.parse(item)).toList();
  data.sort((rowA, rowB) =>
      sortReportTableRows(rowA, rowB, productReportSettings, selectedColumns)!);

  return ReportResult(
    allColumns:
        ProductReportFields.values.map((e) => EnumUtils.parse(e)).toList(),
    columns: selectedColumns,
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
    entities: entities,
  );
}
