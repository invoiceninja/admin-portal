import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/product_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/redux/product/product_state.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:redux/redux.dart';

EntityUIState productUIReducer(ProductUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(productListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action))
    ..selectedId = selectedIdReducer(state.selectedId, action));
}

Reducer<String> dropdownFilterReducer = combineReducers([
  TypedReducer<String, FilterProductDropdown>(filterProductDropdownReducer),
]);

String filterProductDropdownReducer(
    String dropdownFilter, FilterProductDropdown action) {
  return action.filter;
}

final editingReducer = combineReducers<ProductEntity>([
  TypedReducer<ProductEntity, SaveProductSuccess>(_updateEditing),
  TypedReducer<ProductEntity, AddProductSuccess>(_updateEditing),
  TypedReducer<ProductEntity, EditProduct>(_updateEditing),
  TypedReducer<ProductEntity, UpdateProduct>((product, action) {
    return action.product.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<ProductEntity, RestoreProductsSuccess>((products, action) {
    return action.products[0];
  }),
  TypedReducer<ProductEntity, ArchiveProductsSuccess>((products, action) {
    return action.products[0];
  }),
  TypedReducer<ProductEntity, DeleteProductsSuccess>((products, action) {
    return action.products[0];
  }),
  TypedReducer<ProductEntity, SelectCompany>(_clearEditing),
  TypedReducer<ProductEntity, DiscardChanges>(_clearEditing),
]);

ProductEntity _clearEditing(ProductEntity product, dynamic action) {
  return ProductEntity();
}

ProductEntity _updateEditing(ProductEntity product, dynamic action) {
  return action.product;
}

Reducer<String> selectedIdReducer = combineReducers([
  TypedReducer<String, ViewProduct>((selectedId, action) => action.productId),
  TypedReducer<String, AddProductSuccess>(
      (selectedId, action) => action.product.id),
  TypedReducer<String, SelectCompany>((selectedId, action) => ''),
]);

final productListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortProducts>(_sortProducts),
  TypedReducer<ListUIState, FilterProducts>(_filterProducts),
  TypedReducer<ListUIState, FilterProductsByState>(_filterProductsByState),
  TypedReducer<ListUIState, FilterProductsByCustom1>(_filterProductsByCustom1),
  TypedReducer<ListUIState, FilterProductsByCustom2>(_filterProductsByCustom2),
  TypedReducer<ListUIState, FilterProductsByCustom3>(_filterProductsByCustom3),
  TypedReducer<ListUIState, FilterProductsByCustom4>(_filterProductsByCustom4),
  TypedReducer<ListUIState, StartProductMultiselect>(_startListMultiselect),
  TypedReducer<ListUIState, AddToProductMultiselect>(_addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromProductMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearProductMultiselect>(_clearListMultiselect),
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

ListUIState _filterProductsByCustom3(
    ListUIState productListState, FilterProductsByCustom3 action) {
  if (productListState.custom3Filters.contains(action.value)) {
    return productListState
        .rebuild((b) => b..custom3Filters.remove(action.value));
  } else {
    return productListState.rebuild((b) => b..custom3Filters.add(action.value));
  }
}

ListUIState _filterProductsByCustom4(
    ListUIState productListState, FilterProductsByCustom4 action) {
  if (productListState.custom4Filters.contains(action.value)) {
    return productListState
        .rebuild((b) => b..custom4Filters.remove(action.value));
  } else {
    return productListState.rebuild((b) => b..custom4Filters.add(action.value));
  }
}

ListUIState _filterProducts(
    ListUIState productListState, FilterProducts action) {
  return productListState.rebuild((b) => b
    ..filter = action.filter
    ..filterClearedAt = action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : productListState.filterClearedAt);
}

ListUIState _sortProducts(ListUIState productListState, SortProducts action) {
  return productListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState productListState, StartProductMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState productListState, AddToProductMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds.add(action.entity.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState productListState, RemoveFromProductMultiselect action) {
  return productListState
      .rebuild((b) => b..selectedIds.remove(action.entity.id));
}

ListUIState _clearListMultiselect(
    ListUIState productListState, ClearProductMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = null);
}

final productsReducer = combineReducers<ProductState>([
  TypedReducer<ProductState, SaveProductSuccess>(_updateProduct),
  TypedReducer<ProductState, AddProductSuccess>(_addProduct),
  TypedReducer<ProductState, LoadProductsSuccess>(_setLoadedProducts),
  TypedReducer<ProductState, ArchiveProductsRequest>(_archiveProductRequest),
  TypedReducer<ProductState, ArchiveProductsSuccess>(_archiveProductSuccess),
  TypedReducer<ProductState, ArchiveProductsFailure>(_archiveProductFailure),
  TypedReducer<ProductState, DeleteProductsRequest>(_deleteProductRequest),
  TypedReducer<ProductState, DeleteProductsSuccess>(_deleteProductSuccess),
  TypedReducer<ProductState, DeleteProductsFailure>(_deleteProductFailure),
  TypedReducer<ProductState, RestoreProductsRequest>(_restoreProductRequest),
  TypedReducer<ProductState, RestoreProductsSuccess>(_restoreProductSuccess),
  TypedReducer<ProductState, RestoreProductsFailure>(_restoreProductFailure),
]);

ProductState _archiveProductRequest(
    ProductState productState, ArchiveProductsRequest action) {
  final products = action.productIds.map((id) => productState.map[id]).toList();

  for (int i = 0; i < products.length; i++) {
    products[i] = products[i]
        .rebuild((b) => b..archivedAt = DateTime.now().millisecondsSinceEpoch);
  }
  return productState.rebuild((b) {
    for (final product in products) {
      b.map[product.id] = product;
    }
  });
}

ProductState _archiveProductSuccess(
    ProductState productState, ArchiveProductsSuccess action) {
  return productState.rebuild((b) {
    for (final product in action.products) {
      b.map[product.id] = product;
    }
  });
}

ProductState _archiveProductFailure(
    ProductState productState, ArchiveProductsFailure action) {
  return productState.rebuild((b) {
    for (final product in action.products) {
      b.map[product.id] = product;
    }
  });
}

ProductState _deleteProductRequest(
    ProductState productState, DeleteProductsRequest action) {
  final products = action.productIds.map((id) => productState.map[id]).toList();

  for (int i = 0; i < products.length; i++) {
    products[i] = products[i].rebuild((b) => b
      ..archivedAt = DateTime.now().millisecondsSinceEpoch
      ..isDeleted = true);
  }
  return productState.rebuild((b) {
    for (final product in products) {
      b.map[product.id] = product;
    }
  });
}

ProductState _deleteProductSuccess(
    ProductState productState, DeleteProductsSuccess action) {
  return productState.rebuild((b) {
    for (final product in action.products) {
      b.map[product.id] = product;
    }
  });
}

ProductState _deleteProductFailure(
    ProductState productState, DeleteProductsFailure action) {
  return productState.rebuild((b) {
    for (final product in action.products) {
      b.map[product.id] = product;
    }
  });
}

ProductState _restoreProductRequest(
    ProductState productState, RestoreProductsRequest action) {
  final products = action.productIds.map((id) => productState.map[id]).toList();

  for (int i = 0; i < products.length; i++) {
    products[i] = products[i].rebuild((b) => b
      ..archivedAt = null
      ..isDeleted = false);
  }
  return productState.rebuild((b) {
    for (final product in products) {
      b.map[product.id] = product;
    }
  });
}

ProductState _restoreProductSuccess(
    ProductState productState, RestoreProductsSuccess action) {
  return productState.rebuild((b) {
    for (final product in action.products) {
      b.map[product.id] = product;
    }
  });
}

ProductState _restoreProductFailure(
    ProductState productState, RestoreProductsFailure action) {
  return productState.rebuild((b) {
    for (final product in action.products) {
      b.map[product.id] = product;
    }
  });
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
        ProductState productState, LoadProductsSuccess action) =>
    productState.loadProducts(action.products);
