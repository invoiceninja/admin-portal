// Flutter imports:

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

int productNotificationThreshold({
  required ProductEntity product,
  required CompanyEntity? company,
}) {
  if (product.stockNotificationThreshold != 0) {
    return product.stockNotificationThreshold;
  }

  return company!.stockNotificationThreshold;
}

InvoiceItemEntity convertProductToInvoiceItem({
  required ProductEntity? product,
  required CompanyEntity company,
  required InvoiceEntity invoice,
  required BuiltMap<String, CurrencyEntity> currencyMap,
  ClientEntity? client,
}) {
  if (company.fillProducts) {
    double cost = (invoice.isPurchaseOrder &&
            company.enableProductCost &&
            product!.cost != 0)
        ? product.cost
        : product!.price;

    if (company.convertProductExchangeRate &&
        (client?.currencyId ?? '').isNotEmpty) {
      double exchangeRate = invoice.exchangeRate;
      if (!company.convertRateToClient && exchangeRate != 0) {
        exchangeRate = 1 / exchangeRate;
      }
      cost = round(
          cost * exchangeRate, currencyMap[client!.currencyId]!.precision);
    }

    return InvoiceItemEntity().rebuild((b) => b
      ..productKey = product.productKey
      ..notes = product.notes
      ..cost = cost
      ..productCost = product.cost
      ..quantity = product.quantity == 0 ? 1 : product.quantity
      ..customValue1 = product.customValue1
      ..customValue2 = product.customValue2
      ..customValue3 = product.customValue3
      ..customValue4 = product.customValue4
      ..taxCategoryId = product.taxCategoryId
      ..taxName1 = company.numberOfItemTaxRates >= 1 ? product.taxName1 : ''
      ..taxRate1 = company.numberOfItemTaxRates >= 1 ? product.taxRate1 : 0
      ..taxName2 = company.numberOfItemTaxRates >= 2 ? product.taxName2 : ''
      ..taxRate2 = company.numberOfItemTaxRates >= 2 ? product.taxRate2 : 0
      ..taxName3 = company.numberOfItemTaxRates >= 3 ? product.taxName3 : ''
      ..taxRate3 = company.numberOfItemTaxRates >= 3 ? product.taxRate3 : 0);
  } else {
    return InvoiceItemEntity(productKey: product!.productKey);
  }
}

var memoizedDropdownProductList = memo3(
    (BuiltMap<String, ProductEntity> productMap, BuiltList<String> productList,
            BuiltMap<String, UserEntity> userMap) =>
        dropdownProductsSelector(productMap, productList, userMap));

List<String> dropdownProductsSelector(
    BuiltMap<String, ProductEntity> productMap,
    BuiltList<String> productList,
    BuiltMap<String, UserEntity> userMap) {
  final list = productList
      .where((productId) => productMap[productId]!.isActive)
      .toList();

  list.sort((productAId, productBId) {
    final productA = productMap[productAId]!;
    final productB = productMap[productBId];
    return productA.compareTo(
        productB, ProductFields.productKey, true, userMap);
  });

  return list;
}

var memoizedProductList = memo1(
    (BuiltMap<String, ProductEntity> productMap) => productList(productMap));

List<String?> productList(BuiltMap<String, ProductEntity> productMap) {
  final list = productMap.keys
      .where((productId) => productMap[productId]!.isActive)
      .toList();

  list.sort((idA, idB) => productMap[idA]!
      .listDisplayName
      .compareTo(productMap[idB]!.listDisplayName));

  return list;
}

var memoizedFilteredProductList = memo5((SelectionState selectionState,
        BuiltMap<String, ProductEntity> productMap,
        BuiltList<String> productList,
        ListUIState productListState,
        BuiltMap<String, UserEntity> userMap) =>
    filteredProductsSelector(
        selectionState, productMap, productList, productListState, userMap));

List<String> filteredProductsSelector(
    SelectionState selectionState,
    BuiltMap<String, ProductEntity> productMap,
    BuiltList<String> productList,
    ListUIState productListState,
    BuiltMap<String, UserEntity> userMap) {
  final list = productList.where((productId) {
    final product = productMap[productId]!;

    if (product.id == selectionState.selectedId) {
      return true;
    }

    if (!product.matchesStates(productListState.stateFilters)) {
      return false;
    }
    if (!product.matchesFilter(productListState.filter)) {
      return false;
    }
    if (productListState.custom1Filters.isNotEmpty &&
        !productListState.custom1Filters.contains(product.customValue1)) {
      return false;
    } else if (productListState.custom2Filters.isNotEmpty &&
        !productListState.custom2Filters.contains(product.customValue2)) {
      return false;
    } else if (productListState.custom3Filters.isNotEmpty &&
        !productListState.custom3Filters.contains(product.customValue3)) {
      return false;
    } else if (productListState.custom4Filters.isNotEmpty &&
        !productListState.custom4Filters.contains(product.customValue4)) {
      return false;
    }

    return true;
  }).toList();

  list.sort((productAId, productBId) {
    final productA = productMap[productAId]!;
    final productB = productMap[productBId];
    return productA.compareTo(productB, productListState.sortField,
        productListState.sortAscending, userMap);
  });

  return list;
}
