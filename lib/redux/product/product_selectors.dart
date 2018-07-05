import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/ui/list_ui_state.dart';

var memoizedProductList = memo1((BuiltMap<int, ProductEntity> productMap) =>
    productList(productMap));

List<int> productList(BuiltMap<int, ProductEntity> productMap) {
  final list = productMap.keys.where((productId) => productMap[productId].isActive).toList();

  list.sort((idA, idB) => productMap[idA].listDisplayName
      .compareTo(productMap[idB].listDisplayName));

  return list;
}

var memoizedFilteredProductList = memo3((
    BuiltMap<int, ProductEntity> productMap,
    BuiltList<int> productList,
    ListUIState productListState) => visibleProductsSelector(productMap, productList, productListState)
);

List<int> visibleProductsSelector(
    BuiltMap<int, ProductEntity> productMap,
    BuiltList<int> productList,
    ListUIState productListState) {

  final list = productList.where((productId) {
    final product = productMap[productId];
    if (! product.matchesStates(productListState.stateFilters)) {
      return false;
    }
    if (! product.matchesSearch(productListState.search)) {
      return false;
    }
    return true;
  }).toList();

  list.sort((productAId, productBId) {
    final productA = productMap[productAId];
    final  productB = productMap[productBId];
    return productA.compareTo(productB, productListState.sortField, productListState.sortAscending);
  });

  return list;
}