import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/app/entity_ui_state.dart';
import 'package:invoiceninja/redux/product/product_state.dart';

bool isLoadingSelector(AppState state) => state.isLoading;

enum VisibilityFilter {all, active, completed}
//VisibilityFilter activeFilterSelector(AppState state) => state.activeFilter;

List<ProductEntity> productsSelector(AppState state) =>
    state.productState().list.map((id) => state.productState().map[id]);

var memoizedProductList = memo2((BuiltMap<int, ProductEntity> productMap, EntityUIState productUIState) => filteredProductsSelector(productMap, productUIState));

List<int> filteredProductsSelector(
    BuiltMap<int, ProductEntity> productMap,
    EntityUIState productUIState) {

  print('== SORTING LIST ===');
  var list = productMap.keys.toList(growable: false);

  list.sort((productAId, productBId) {
    var productA = productMap[productAId];
    var productB = productMap[productBId];
    return productA.compareTo(productB, productUIState.sortField, productUIState.sortAscending);
  });

  return list;
}

/*
Optional<ProductEntity> productSelector(List<ProductEntity> products, int id) {
  try {
    return Optional.of(products.firstWhere((product) => product.id == id));
  } catch (e) {
    return Optional.absent();
  }
}
*/