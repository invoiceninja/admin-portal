import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/product/product_actions.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/product/product_selectors.dart';

final productsReducer = combineReducers<List<ProductEntity>>([
  /*
  TypedReducer<List<Product>, AddProductAction>(_addProduct),
  TypedReducer<List<Product>, DeleteProductAction>(_deleteProduct),
  TypedReducer<List<Product>, UpdateProductAction>(_updateProduct),
  TypedReducer<List<Product>, ClearCompletedAction>(_clearCompleted),
  TypedReducer<List<Product>, ToggleAllAction>(_toggleAll),
  */
  TypedReducer<List<ProductEntity>, ProductsLoadedAction>(_setLoadedProducts),
  TypedReducer<List<ProductEntity>, ProductsNotLoadedAction>(_setNoProducts),
]);

/*
List<ProductEntity> _addProduct(List<ProductEntity> products, AddProductAction action) {
  return List.from(products)..add(action.product);
}

List<ProductEntity> _deleteProduct(List<ProductEntity> products, DeleteProductAction action) {
  return products.where((product) => product.id != action.id).toList();
}

List<ProductEntity> _updateProduct(List<ProductEntity> products, UpdateProductAction action) {
  return products
      .map((product) => product.id == action.id ? action.updatedProduct : product)
      .toList();
}

List<ProductEntity> _clearCompleted(List<Product> products, ClearCompletedAction action) {
  return products.where((product) => !product.complete).toList();
}

List<ProductEntity> _toggleAll(List<ProductEntity> products, ToggleAllAction action) {
  final allComplete = allCompleteSelector(products);

  return products.map((product) => product.copyWith(complete: !allComplete)).toList();
}
*/

List<ProductEntity> _setLoadedProducts(List<ProductEntity> products, ProductsLoadedAction action) {
  return action.products;
}

List<ProductEntity> _setNoProducts(List<ProductEntity> products, ProductsNotLoadedAction action) {
  return [];
}
