import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

InvoiceItemEntity convertProductToInvoiceItem({
  @required ProductEntity product,
  @required CompanyEntity company,
  @required InvoiceEntity invoice,
  @required BuiltMap<String, CurrencyEntity> currencyMap,
  ClientEntity client,
}) {
  if (company.fillProducts) {
    double cost = product.price;

    if (company.convertProductExchangeRate &&
        (client?.currencyId ?? '').isNotEmpty) {
      cost = round(cost * invoice.exchangeRate,
          currencyMap[client.currencyId].precision);
    }

    return InvoiceItemEntity().rebuild((b) => b
      ..productKey = product.productKey
      ..notes = product.notes
      ..cost = cost
      ..quantity = company.enableProductQuantity
          ? product.quantity
          : company.defaultQuantity
              ? 1
              : null
      ..customValue1 = product.customValue1
      ..customValue2 = product.customValue2
      ..customValue3 = product.customValue3
      ..customValue4 = product.customValue4
      ..taxName1 = company.numberOfItemTaxRates >= 1 ? product.taxName1 : ''
      ..taxRate1 = company.numberOfItemTaxRates >= 1 ? product.taxRate1 : 0
      ..taxName2 = company.numberOfItemTaxRates >= 2 ? product.taxName2 : ''
      ..taxRate2 = company.numberOfItemTaxRates >= 2 ? product.taxRate2 : 0
      ..taxName3 = company.numberOfItemTaxRates >= 3 ? product.taxName3 : ''
      ..taxRate3 = company.numberOfItemTaxRates >= 3 ? product.taxRate3 : 0);
  } else {
    return InvoiceItemEntity(
        productKey: product.productKey,
        quantity: company.defaultQuantity ? 1 : null);
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
  final list =
      productList.where((productId) => productMap[productId].isActive).toList();

  list.sort((productAId, productBId) {
    final productA = productMap[productAId];
    final productB = productMap[productBId];
    return productA.compareTo(
        productB, ProductFields.productKey, true, userMap);
  });

  return list;
}

var memoizedProductList = memo1(
    (BuiltMap<String, ProductEntity> productMap) => productList(productMap));

List<String> productList(BuiltMap<String, ProductEntity> productMap) {
  final list = productMap.keys
      .where((productId) => productMap[productId].isActive)
      .toList();

  list.sort((idA, idB) => productMap[idA]
      .listDisplayName
      .compareTo(productMap[idB].listDisplayName));

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
    final product = productMap[productId];

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
    }
    if (productListState.custom2Filters.isNotEmpty &&
        !productListState.custom2Filters.contains(product.customValue2)) {
      return false;
    }
    return true;
  }).toList();

  list.sort((productAId, productBId) {
    final productA = productMap[productAId];
    final productB = productMap[productBId];
    return productA.compareTo(productB, productListState.sortField,
        productListState.sortAscending, userMap);
  });

  return list;
}

bool hasProductChanges(
        ProductEntity product, BuiltMap<String, ProductEntity> productMap) =>
    product.isNew ? product.isChanged : product != productMap[product.id];
