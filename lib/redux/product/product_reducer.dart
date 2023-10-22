// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/product_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/redux/product/product_state.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

EntityUIState productUIReducer(ProductUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(productListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action)!)
    ..tabIndex = tabIndexReducer(state.tabIndex, action)
    ..selectedId = selectedIdReducer(state.selectedId, action)
    ..forceSelected = forceSelectedReducer(state.forceSelected, action));
}

final forceSelectedReducer = combineReducers<bool?>([
  TypedReducer<bool?, ViewProduct>((completer, action) => true),
  TypedReducer<bool?, ViewProductList>((completer, action) => false),
  TypedReducer<bool?, FilterProductsByState>((completer, action) => false),
  TypedReducer<bool?, FilterProducts>((completer, action) => false),
  TypedReducer<bool?, FilterProductsByCustom1>((completer, action) => false),
  TypedReducer<bool?, FilterProductsByCustom2>((completer, action) => false),
  TypedReducer<bool?, FilterProductsByCustom3>((completer, action) => false),
  TypedReducer<bool?, FilterProductsByCustom4>((completer, action) => false),
]);

final int? Function(int, dynamic) tabIndexReducer = combineReducers<int?>([
  TypedReducer<int?, UpdateProductTab>((completer, action) {
    return action.tabIndex;
  }),
  TypedReducer<int?, PreviewEntity>((completer, action) {
    return 0;
  }),
]);

/*
Reducer<String> dropdownFilterReducer = combineReducers([
  TypedReducer<String, FilterProductDropdown>(filterProductDropdownReducer),
]);

String filterProductDropdownReducer(
    String dropdownFilter, FilterProductDropdown action) {
  return action.filter;
}
*/

final editingReducer = combineReducers<ProductEntity?>([
  TypedReducer<ProductEntity?, SaveProductSuccess>(_updateEditing),
  TypedReducer<ProductEntity?, AddProductSuccess>(_updateEditing),
  TypedReducer<ProductEntity?, EditProduct>(_updateEditing),
  TypedReducer<ProductEntity?, UpdateProduct>((product, action) {
    return action.product.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<ProductEntity?, RestoreProductsSuccess>((products, action) {
    return action.products[0];
  }),
  TypedReducer<ProductEntity?, ArchiveProductsSuccess>((products, action) {
    return action.products[0];
  }),
  TypedReducer<ProductEntity?, DeleteProductsSuccess>((products, action) {
    return action.products[0];
  }),
  TypedReducer<ProductEntity?, DiscardChanges>(_clearEditing),
]);

ProductEntity _clearEditing(ProductEntity? product, dynamic action) {
  return ProductEntity();
}

ProductEntity? _updateEditing(ProductEntity? product, dynamic action) {
  return action.product;
}

Reducer<String?> selectedIdReducer = combineReducers([
  TypedReducer<String?, ArchiveProductsSuccess>((completer, action) => ''),
  TypedReducer<String?, DeleteProductsSuccess>((completer, action) => ''),
  TypedReducer<String?, PreviewEntity>((selectedId, action) =>
      action.entityType == EntityType.product ? action.entityId : selectedId),
  TypedReducer<String?, ViewProduct>((selectedId, action) => action.productId),
  TypedReducer<String?, AddProductSuccess>(
      (selectedId, action) => action.product.id),
  TypedReducer<String?, SelectCompany>(
      (selectedId, action) => action.clearSelection ? '' : selectedId),
  TypedReducer<String?, ClearEntityFilter>((selectedId, action) => ''),
  TypedReducer<String?, SortProducts>((selectedId, action) => ''),
  TypedReducer<String?, FilterProducts>((selectedId, action) => ''),
  TypedReducer<String?, FilterProductsByState>((selectedId, action) => ''),
  TypedReducer<String?, FilterProductsByCustom1>((selectedId, action) => ''),
  TypedReducer<String?, FilterProductsByCustom2>((selectedId, action) => ''),
  TypedReducer<String?, FilterProductsByCustom3>((selectedId, action) => ''),
  TypedReducer<String?, FilterProductsByCustom4>((selectedId, action) => ''),
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
  TypedReducer<ListUIState, ViewProductList>(_viewProductList),
  TypedReducer<ListUIState, FilterByEntity>(
      (state, action) => state.rebuild((b) => b
        ..filter = null
        ..filterClearedAt = DateTime.now().millisecondsSinceEpoch)),
]);

ListUIState _viewProductList(
    ListUIState productListState, ViewProductList action) {
  return productListState.rebuild((b) => b
    ..selectedIds = null
    ..filter = null
    ..filterClearedAt = DateTime.now().millisecondsSinceEpoch);
}

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
    ..sortAscending = b.sortField != action.field || !b.sortAscending!
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState productListState, StartProductMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState productListState, AddToProductMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds.add(action.entity!.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState productListState, RemoveFromProductMultiselect action) {
  return productListState
      .rebuild((b) => b..selectedIds.remove(action.entity!.id));
}

ListUIState _clearListMultiselect(
    ListUIState productListState, ClearProductMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = null);
}

final productsReducer = combineReducers<ProductState>([
  TypedReducer<ProductState, SaveProductSuccess>(_updateProduct),
  TypedReducer<ProductState, AddProductSuccess>(_addProduct),
  TypedReducer<ProductState, LoadProductsSuccess>(_setLoadedProducts),
  TypedReducer<ProductState, LoadProductSuccess>(_setLoadedProduct),
  TypedReducer<ProductState, LoadCompanySuccess>(_setLoadedCompany),
  TypedReducer<ProductState, ArchiveProductsSuccess>(_archiveProductSuccess),
  TypedReducer<ProductState, DeleteProductsSuccess>(_deleteProductSuccess),
  TypedReducer<ProductState, RestoreProductsSuccess>(_restoreProductSuccess),
  TypedReducer<ProductState, SetTaxCategoryProductsSuccess>(
      _setTaxCategoryProductsSuccess),
]);

ProductState _archiveProductSuccess(
    ProductState productState, ArchiveProductsSuccess action) {
  return productState.rebuild((b) {
    for (final product in action.products) {
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

ProductState _restoreProductSuccess(
    ProductState productState, RestoreProductsSuccess action) {
  return productState.rebuild((b) {
    for (final product in action.products) {
      b.map[product.id] = product;
    }
  });
}

ProductState _setTaxCategoryProductsSuccess(
    ProductState productState, SetTaxCategoryProductsSuccess action) {
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

ProductState _setLoadedProduct(
    ProductState productState, LoadProductSuccess action) {
  return productState
      .rebuild((b) => b..map[action.product.id] = action.product);
}

ProductState _setLoadedProducts(
        ProductState productState, LoadProductsSuccess action) =>
    productState.loadProducts(action.products);

ProductState _setLoadedCompany(
    ProductState productState, LoadCompanySuccess action) {
  final company = action.userCompany.company;
  return productState.loadProducts(company.products);
}
