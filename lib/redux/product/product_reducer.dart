import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/product/product_actions.dart';
import 'package:invoiceninja/redux/product/product_state.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja/data/models/models.dart';

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
]);

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
