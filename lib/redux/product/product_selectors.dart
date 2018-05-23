import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/app/app_state.dart';

bool isLoadingSelector(AppState state) => state.isLoading;

enum VisibilityFilter {all, active, completed}
//VisibilityFilter activeFilterSelector(AppState state) => state.activeFilter;

List<ProductEntity> productsSelector(AppState state) =>
    state.product().list.map((id) => state.product().map[id]);

List<ProductEntity> filteredProductsSelector(
    List<ProductEntity> products,
    //VisibilityFilter activeFilter,
    ) {
  return products.where((product) {
    return true;
    /*
    if (activeFilter == VisibilityFilter.all) {
      return true;
    } else if (activeFilter == VisibilityFilter.active) {
      return !product.complete;
    } else if (activeFilter == VisibilityFilter.completed) {
      return product.complete;
    }
    */
  }).toList();
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