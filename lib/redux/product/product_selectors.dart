import 'package:flutter/widgets.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

InvoiceItemEntity convertProductToInvoiceItem({BuildContext context, ProductEntity product}) {
  return InvoiceItemEntity().rebuild((b) => b
    ..productKey = product.productKey
    ..notes = product.notes
    ..cost = product.cost
    ..qty = 1.0
    ..customValue1 = product.customValue1
    ..customValue2 = product.customValue2
    ..taxName1 = product.taxName1
    ..taxRate1 = product.taxRate1
    ..taxName2 = product.taxName2
    ..taxRate2 = product.taxRate2);
}

var memoizedProductList =
    memo1((BuiltMap<int, ProductEntity> productMap) => productList(productMap));

List<int> productList(BuiltMap<int, ProductEntity> productMap) {
  final list = productMap.keys
      .where((productId) => productMap[productId].isActive)
      .toList();

  list.sort((idA, idB) => productMap[idA]
      .listDisplayName
      .compareTo(productMap[idB].listDisplayName));

  return list;
}

var memoizedFilteredProductList = memo3(
    (BuiltMap<int, ProductEntity> productMap, BuiltList<int> productList,
            ListUIState productListState) =>
        filteredProductsSelector(productMap, productList, productListState));

List<int> filteredProductsSelector(BuiltMap<int, ProductEntity> productMap,
    BuiltList<int> productList, ListUIState productListState) {
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
