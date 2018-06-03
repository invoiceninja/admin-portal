import 'package:invoiceninja/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja/redux/ui/list_ui_state.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/product/product_actions.dart';
import 'package:invoiceninja/redux/product/product_state.dart';

EntityUIState productUIReducer(EntityUIState state, action) {
  return state.rebuild((b) => b
    ..listUIState.replace(productListReducer(state.listUIState, action))
  );
}

final productListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortProducts>(_sortProducts),
  TypedReducer<ListUIState, FilterProductsByState>(_filterProductsByState),
]);

ListUIState _filterProductsByState(ListUIState productListState, FilterProductsByState action) {
  if (productListState.stateFilters.contains(action.state)) {
    return productListState.rebuild((b) => b
        ..stateFilters.remove(action.state)
    );
  } else {
    return productListState.rebuild((b) => b
        ..stateFilters.add(action.state)
    );
  }
}

ListUIState _sortProducts(ListUIState productListState, SortProducts action) {
  return productListState.rebuild((b) => b
      ..sortAscending = b.sortField != action.field || ! b.sortAscending
      ..sortField = action.field
  );
}


final productsReducer = combineReducers<ProductState>([
  /*
  TypedReducer<List<Product>, AddProductAction>(_addProduct),
  TypedReducer<List<Product>, DeleteProductAction>(_deleteProduct),
  TypedReducer<List<Product>, ClearCompletedAction>(_clearCompleted),
  TypedReducer<List<Product>, ToggleAllAction>(_toggleAll),
  */
  TypedReducer<ProductState, SaveProductSuccess>(_updateProduct),
  TypedReducer<ProductState, AddProductSuccess>(_addProduct),
  TypedReducer<ProductState, ProductsLoadedAction>(_setLoadedProducts),
  TypedReducer<ProductState, ProductsNotLoadedAction>(_setNoProducts),
  TypedReducer<ProductState, SelectProductAction>(_selectProduct),

  TypedReducer<ProductState, ArchiveProductRequest>(_archiveProductRequest),
  TypedReducer<ProductState, ArchiveProductSuccess>(_archiveProductSuccess),
  TypedReducer<ProductState, ArchiveProductFailure>(_archiveProductFailure),

  TypedReducer<ProductState, DeleteProductRequest>(_deleteProductRequest),
  TypedReducer<ProductState, DeleteProductSuccess>(_deleteProductSuccess),
  TypedReducer<ProductState, DeleteProductFailure>(_deleteProductFailure),

  TypedReducer<ProductState, RestoreProductRequest>(_restoreProductRequest),
  TypedReducer<ProductState, RestoreProductSuccess>(_restoreProductSuccess),
  TypedReducer<ProductState, RestoreProductFailure>(_restoreProductFailure),
]);

ProductState _archiveProductRequest(ProductState productState, ArchiveProductRequest action) {
  var product = productState.map[action.productId];
  return productState.rebuild((b) => b
    ..map[action.productId] = product.rebuild((b) => b
      ..archivedAt = DateTime.now().millisecondsSinceEpoch
    )
  );
}

ProductState _archiveProductSuccess(ProductState productState, ArchiveProductSuccess action) {
  return productState.rebuild((b) => b
    ..map[action.product.id] = action.product
  );
}

ProductState _archiveProductFailure(ProductState productState, ArchiveProductFailure action) {
  return productState.rebuild((b) => b
    ..map[action.product.id] = action.product
  );
}

ProductState _deleteProductRequest(ProductState productState, DeleteProductRequest action) {
  var product = productState.map[action.productId];
  return productState.rebuild((b) => b
    ..map[action.productId] = product.rebuild((b) => b
      ..archivedAt = DateTime.now().millisecondsSinceEpoch
      ..isDeleted = true
    )
  );
}

ProductState _deleteProductSuccess(ProductState productState, DeleteProductSuccess action) {
  return productState.rebuild((b) => b
    ..map[action.product.id] = action.product
  );
}

ProductState _deleteProductFailure(ProductState productState, DeleteProductFailure action) {
  return productState.rebuild((b) => b
    ..map[action.product.id] = action.product
  );
}


ProductState _restoreProductRequest(ProductState productState, RestoreProductRequest action) {
  var product = productState.map[action.productId];
  return productState.rebuild((b) => b
    ..map[action.productId] = product.rebuild((b) => b
      ..archivedAt = null
      ..isDeleted = false
    )
  );
}

ProductState _restoreProductSuccess(ProductState productState, RestoreProductSuccess action) {
  return productState.rebuild((b) => b
    ..map[action.product.id] = action.product
  );
}

ProductState _restoreProductFailure(ProductState productState, RestoreProductFailure action) {
  return productState.rebuild((b) => b
    ..map[action.product.id] = action.product
  );
}


ProductState _addProduct(
    ProductState productState, AddProductSuccess action) {
  return productState.rebuild((b) => b
    ..map[action.product.id] = action.product
    ..list.add(action.product.id)
    ..editing.replace(action.product)
  );
}

ProductState _updateProduct(
    ProductState productState, SaveProductSuccess action) {
  return productState.rebuild((b) => b
      ..map[action.product.id] = action.product
      ..editing.replace(action.product)
  );
}

ProductState _setNoProducts(
    ProductState productState, ProductsNotLoadedAction action) {
  return productState;
}

ProductState _selectProduct(
    ProductState productState, SelectProductAction action) {
  return productState.rebuild((b) => b..editing.replace(action.product));
}

/*
List<ProductEntity> _addProduct(List<ProductEntity> products, AddProductAction action) {
  return List.from(products)..add(action.product);
}

List<ProductEntity> _deleteProduct(List<ProductEntity> products, DeleteProductAction action) {
  return products.where((product) => product.id != action.id).toList();
}

}

List<ProductEntity> _clearCompleted(List<Product> products, ClearCompletedAction action) {
  return products.where((product) => !product.complete).toList();
}

List<ProductEntity> _toggleAll(List<ProductEntity> products, ToggleAllAction action) {
  final allComplete = allCompleteSelector(products);

  return products.map((product) => product.copyWith(complete: !allComplete)).toList();
}
*/

ProductState _setLoadedProducts(
    ProductState productState, ProductsLoadedAction action) {
  return productState.rebuild(
    (b) => b
      ..lastUpdated = DateTime.now().millisecondsSinceEpoch
      ..map.addAll(Map.fromIterable(
        action.products,
        key: (item) => item.id,
        value: (item) => item,
      ))
      ..list.replace(action.products.map(
              (product) => product.id).toList())
  );
}
