import 'package:invoiceninja/data/models/product_model.dart';
import 'package:invoiceninja/redux/company/company_actions.dart';
import 'package:invoiceninja/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja/redux/ui/list_ui_state.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/product/product_actions.dart';
import 'package:invoiceninja/redux/product/product_state.dart';

EntityUIState productUIReducer(ProductUIState state, action) {
  return state.rebuild((b) => b
    ..listUIState.replace(productListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action))
    ..dropdownFilter = dropdownFilterReducer(state.dropdownFilter, action)
  );
}

Reducer<String> dropdownFilterReducer = combineReducers([
  TypedReducer<String, FilterProductDropdown>(filterClientDropdownReducer),
]);

String filterClientDropdownReducer(String dropdownFilter, FilterProductDropdown action) {
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

ProductEntity _clearEditing(ProductEntity client, action) {
  return ProductEntity();
}

ProductEntity _updateEditing(ProductEntity client, action) {
  return action.product;
}

final productListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortProducts>(_sortProducts),
  TypedReducer<ListUIState, FilterProductsByState>(_filterProductsByState),
  TypedReducer<ListUIState, SearchProducts>(_searchProducts),
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

ListUIState _searchProducts(ListUIState productListState, SearchProducts action) {
  return productListState.rebuild((b) => b
    ..search = action.search
  );
}

ListUIState _sortProducts(ListUIState productListState, SortProducts action) {
  return productListState.rebuild((b) => b
      ..sortAscending = b.sortField != action.field || ! b.sortAscending
      ..sortField = action.field
  );
}


final productsReducer = combineReducers<ProductState>([
  TypedReducer<ProductState, SaveProductSuccess>(_updateProduct),
  TypedReducer<ProductState, AddProductSuccess>(_addProduct),
  TypedReducer<ProductState, LoadProductsSuccess>(_setLoadedProducts),
  TypedReducer<ProductState, LoadProductsFailure>(_setNoProducts),

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
  var product = productState.map[action.productId].rebuild((b) => b
    ..archivedAt = DateTime.now().millisecondsSinceEpoch
  );

  return productState.rebuild((b) => b
    ..map[action.productId] = product
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
  var product = productState.map[action.productId].rebuild((b) => b
    ..archivedAt = DateTime.now().millisecondsSinceEpoch
    ..isDeleted = true
  );

  return productState.rebuild((b) => b
    ..map[action.productId] = product
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
  var product = productState.map[action.productId].rebuild((b) => b
    ..archivedAt = null
    ..isDeleted = false
  );
  return productState.rebuild((b) => b
    ..map[action.productId] = product
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
  );
}

ProductState _updateProduct(
    ProductState productState, SaveProductSuccess action) {
  return productState.rebuild((b) => b
      ..map[action.product.id] = action.product
  );
}

ProductState _setNoProducts(
    ProductState productState, LoadProductsFailure action) {
  return productState;
}

ProductState _setLoadedProducts(
    ProductState productState, LoadProductsSuccess action) {
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
