import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/ui/list_ui_state.dart';


//List<ProductEntity> productsSelector(AppState state) =>
//    state.productState().list.map((id) => state.productState().map[id]);

var memoizedProductList = memo2((BuiltMap<int, ProductEntity> productMap, ListUIState productListState) => visibleProductsSelector(productMap, productListState));

List<int> visibleProductsSelector(
    BuiltMap<int, ProductEntity> productMap,
    ListUIState productListState) {

  var list = productMap.keys.toList(growable: false);

  list.sort((productAId, productBId) {
    var productA = productMap[productAId];
    var productB = productMap[productBId];
    return productA.compareTo(productB, productListState.sortField, productListState.sortAscending);
  });

  return list;
}