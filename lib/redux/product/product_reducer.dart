import 'package:invoiceninja_flutter/data/models/product_model.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/redux/product/product_state.dart';

EntityUIState productUIReducer(ProductUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(productListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action)));
}

Reducer<String> dropdownFilterReducer = combineReducers([
  TypedReducer<String, FilterProductDropdown>(filterClientDropdownReducer),
]);

String filterClientDropdownReducer(
    String dropdownFilter, FilterProductDropdown action) {
  return action.filter;
}

final editingReducer = combineReducers<ProductEntity>([
  TypedReducer<ProductEntity, SaveProductSuccess>(_updateEditing),
  TypedReducer<ProductEntity, AddProductSuccess>(_updateEditing),
  TypedReducer<ProductEntity, EditProduct>(_updateEditing),
  TypedReducer<ProductEntity, UpdateProduct>(_updateEditing),
  TypedReducer<ProductEntity, RestoreProductSuccess>(_updateEditing),
  TypedReducer<ProductEntity, ArchiveProductSuccess>(_updateEditing),
  TypedReducer<ProductEntity, DeleteProductSuccess>(_updateEditing),
  TypedReducer<ProductEntity, SelectCompany>(_clearEditing),
]);

ProductEntity _clearEditing(ProductEntity client, dynamic action) {
  return ProductEntity();
}

ProductEntity _updateEditing(ProductEntity client, dynamic action) {
  return action.product;
}

final productListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortProducts>(_sortProducts),
  TypedReducer<ListUIState, FilterProducts>(_filterProducts),
  TypedReducer<ListUIState, FilterProductsByState>(_filterProductsByState),
  TypedReducer<ListUIState, FilterProductsByCustom1>(_filterProductsByCustom1),
  TypedReducer<ListUIState, FilterProductsByCustom2>(_filterProductsByCustom2),
]);

ListUIState _filterProductsByState(
    ListUIState productListState, FilterProductsByState action) {
  if (productListState.stateFilters.contains(action.state)) {
    return productListState
        .rebuild((b) => b..stateFilters.remove(action.state));
  } else {
    return productListState.rebuild((b) => b..stateFilters.add(action.state));
  }
}

ListUIState _filterProductsByCustom1(
    ListUIState productListState, FilterProductsByCustom1 action) {
  if (productListState.custom1Filters.contains(action.value)) {
    return productListState
        .rebuild((b) => b..custom1Filters.remove(action.value));
  } else {
    return productListState.rebuild((b) => b..custom1Filters.add(action.value));
  }
}

ListUIState _filterProductsByCustom2(
    ListUIState productListState, FilterProductsByCustom2 action) {
  if (productListState.custom2Filters.contains(action.value)) {
    return productListState
        .rebuild((b) => b..custom2Filters.remove(action.value));
  } else {
    return productListState.rebuild((b) => b..custom2Filters.add(action.value));
  }
}

ListUIState _filterProducts(
    ListUIState productListState, FilterProducts action) {
  return productListState.rebuild((b) => b..filter = action.filter);
}

ListUIState _sortProducts(ListUIState productListState, SortProducts action) {
  return productListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending
    ..sortField = action.field);
}

final productsReducer = combineReducers<ProductState>([
  TypedReducer<ProductState, SaveProductSuccess>(_updateProduct),
  TypedReducer<ProductState, AddProductSuccess>(_addProduct),
  TypedReducer<ProductState, LoadProductsSuccess>(_setLoadedProducts),
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

ProductState _archiveProductRequest(
    ProductState productState, ArchiveProductRequest action) {
  final product = productState.map[action.productId]
      .rebuild((b) => b..archivedAt = DateTime.now().millisecondsSinceEpoch);

  return productState.rebuild((b) => b..map[action.productId] = product);
}

ProductState _archiveProductSuccess(
    ProductState productState, ArchiveProductSuccess action) {
  return productState
      .rebuild((b) => b..map[action.product.id] = action.product);
}

ProductState _archiveProductFailure(
    ProductState productState, ArchiveProductFailure action) {
  return productState
      .rebuild((b) => b..map[action.product.id] = action.product);
}

ProductState _deleteProductRequest(
    ProductState productState, DeleteProductRequest action) {
  final product = productState.map[action.productId].rebuild((b) => b
    ..archivedAt = DateTime.now().millisecondsSinceEpoch
    ..isDeleted = true);

  return productState.rebuild((b) => b..map[action.productId] = product);
}

ProductState _deleteProductSuccess(
    ProductState productState, DeleteProductSuccess action) {
  return productState
      .rebuild((b) => b..map[action.product.id] = action.product);
}

ProductState _deleteProductFailure(
    ProductState productState, DeleteProductFailure action) {
  return productState
      .rebuild((b) => b..map[action.product.id] = action.product);
}

ProductState _restoreProductRequest(
    ProductState productState, RestoreProductRequest action) {
  final product = productState.map[action.productId].rebuild((b) => b
    ..archivedAt = null
    ..isDeleted = false);
  return productState.rebuild((b) => b..map[action.productId] = product);
}

ProductState _restoreProductSuccess(
    ProductState productState, RestoreProductSuccess action) {
  return productState
      .rebuild((b) => b..map[action.product.id] = action.product);
}

ProductState _restoreProductFailure(
    ProductState productState, RestoreProductFailure action) {
  return productState
      .rebuild((b) => b..map[action.product.id] = action.product);
}

ProductState _addProduct(ProductState productState, AddProductSuccess action) {
  return productState.rebuild((b) => b
    ..map[action.product.id] = action.product
    ..list.add(action.product.id));
}

ProductState _updateProduct(
    ProductState productState, SaveProductSuccess action) {
  return productState
      .rebuild((b) => b..map[action.product.id] = action.product);
}

ProductState _setLoadedProducts(
    ProductState productState, LoadProductsSuccess action) {
  final state = productState.rebuild((b) => b
    ..lastUpdated = DateTime.now().millisecondsSinceEpoch
    ..map.addAll(Map.fromIterable(
      action.products,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    )));

  return state.rebuild((b) => b..list.replace(state.map.keys));
}
