import 'package:flutter/widgets.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

InvoiceItemEntity convertProductToInvoiceItem({
  @required ProductEntity product,
  @required CompanyEntity company,
}) {
  if (company.fillProducts) {
    return InvoiceItemEntity().rebuild((b) => b
      ..productKey = product.productKey
      ..notes = product.notes
      ..cost = product.price
      ..quantity = company.enableProductQuantity
          ? product.quantity
          : company.defaultQuantity ? 1 : null
      ..customValue1 = product.customValue1
      ..customValue2 = product.customValue2
      ..taxName1 = product.taxName1
      ..taxRate1 = product.taxRate1
      ..taxName2 = product.taxName2
      ..taxRate2 = product.taxRate2);
  } else {
    return InvoiceItemEntity(
        productKey: product.productKey,
        quantity: company.defaultQuantity ? 1 : null);
  }
}

var memoizedDropdownProductList = memo2(
    (BuiltMap<String, ProductEntity> productMap,
            BuiltList<String> productList) =>
        dropdownProductsSelector(productMap, productList));

List<String> dropdownProductsSelector(
    BuiltMap<String, ProductEntity> productMap, BuiltList<String> productList) {
  final list =
      productList.where((productId) => productMap[productId].isActive).toList();

  list.sort((productAId, productBId) {
    final productA = productMap[productAId];
    final productB = productMap[productBId];
    return productA.compareTo(productB, ProductFields.productKey, true);
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

var memoizedFilteredProductList = memo3(
    (BuiltMap<String, ProductEntity> productMap, BuiltList<String> productList,
            ListUIState productListState) =>
        filteredProductsSelector(productMap, productList, productListState));

List<String> filteredProductsSelector(
    BuiltMap<String, ProductEntity> productMap,
    BuiltList<String> productList,
    ListUIState productListState) {
  final list = productList.where((productId) {
    final product = productMap[productId];
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
    return productA.compareTo(
        productB, productListState.sortField, productListState.sortAscending);
  });

  return list;
}

bool hasProductChanges(
        ProductEntity product, BuiltMap<String, ProductEntity> productMap) =>
    product.isNew ? product.isChanged : product != productMap[product.id];
