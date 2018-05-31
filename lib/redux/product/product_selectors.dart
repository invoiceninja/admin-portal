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

List<ProductEntity> filteredProductsSelector(
    ProductState productState,
    EntityUIState productUIState) {

  var list = productState.list.toList();

  list.sort((productAId, productBId) {
    var productA = productState.map[productAId];
    var productB = productState.map[productBId];
    return productA.compareTo(productB, productUIState.sortField, productUIState.sortAscending);
  });

  print('== SORTING LIST');
  return list.map((id) => productState.map[id]).toList();
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