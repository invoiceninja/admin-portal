import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/app/entity_ui_state.dart';


//List<ProductEntity> productsSelector(AppState state) =>
//    state.productState().list.map((id) => state.productState().map[id]);

var memoizedProductList = memo2((BuiltMap<int, ProductEntity> productMap, EntityUIState productUIState) => visibleProductsSelector(productMap, productUIState));

List<int> visibleProductsSelector(
    BuiltMap<int, ProductEntity> productMap,
    EntityUIState productUIState) {

  var list = productMap.keys.toList(growable: false);

  list.sort((productAId, productBId) {
    var productA = productMap[productAId];
    var productB = productMap[productBId];
    return productA.compareTo(productB, productUIState.sortField, productUIState.sortAscending);
  });

  return list;
}