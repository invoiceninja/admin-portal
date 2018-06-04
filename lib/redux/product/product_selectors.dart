import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/ui/list_ui_state.dart';

var memoizedProductList = memo3((
    BuiltMap<int, ProductEntity> productMap,
    BuiltList<int> productList,
    ListUIState productListState) => visibleProductsSelector(productMap, productList, productListState)
);

List<int> visibleProductsSelector(
    BuiltMap<int, ProductEntity> productMap,
    BuiltList<int> productList,
    ListUIState productListState) {

  var list = productList.where((productId) {
    var product = productMap[productId];
    return product.matchesStates(productListState.stateFilters);
  }).toList();

  list.sort((productAId, productBId) {
    var productA = productMap[productAId];
    var productB = productMap[productBId];
    return productA.compareTo(productB, productListState.sortField, productListState.sortAscending);
  });

  return list;
}