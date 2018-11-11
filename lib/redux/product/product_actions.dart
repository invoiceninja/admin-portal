import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';

class ViewProductList implements PersistUI {
  ViewProductList(this.context);

  final BuildContext context;
}

class EditProduct implements PersistUI {
  EditProduct({this.product, this.context});

  final ProductEntity product;
  final BuildContext context;
}

class UpdateProduct implements PersistUI {
  UpdateProduct(this.product);

  final ProductEntity product;
}

class LoadProducts {
  LoadProducts({this.completer, this.force = false});

  final Completer completer;
  final bool force;
}

class LoadProductsRequest implements StartLoading {}

class LoadProductsFailure implements StopLoading {
  LoadProductsFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadProductsFailure{error: $error}';
  }
}

class LoadProductsSuccess implements PersistData, StopLoading {
  LoadProductsSuccess(this.products);

  final BuiltList<ProductEntity> products;

  @override
  String toString() {
    return 'LoadProductsSuccess{products: $products}';
  }
}

class SaveProductRequest implements StartSaving {
  SaveProductRequest({this.product, this.completer});

  final Completer completer;
  final ProductEntity product;
}

class SaveProductSuccess implements StopSaving, PersistData, PersistUI {
  SaveProductSuccess(this.product);

  final ProductEntity product;
}

class AddProductSuccess implements StopSaving, PersistData, PersistUI {
  AddProductSuccess(this.product);

  final ProductEntity product;
}

class SaveProductFailure implements StopSaving {
  SaveProductFailure(this.error);

  final Object error;
}

class ArchiveProductRequest implements StartSaving {
  ArchiveProductRequest(this.completer, this.productId);

  final Completer completer;
  final int productId;
}

class ArchiveProductSuccess implements StopSaving, PersistData {
  ArchiveProductSuccess(this.product);

  final ProductEntity product;
}

class ArchiveProductFailure implements StopSaving {
  ArchiveProductFailure(this.product);

  final ProductEntity product;
}

class DeleteProductRequest implements StartSaving {
  DeleteProductRequest(this.completer, this.productId);

  final Completer completer;
  final int productId;
}

class DeleteProductSuccess implements StopSaving, PersistData {
  DeleteProductSuccess(this.product);

  final ProductEntity product;
}

class DeleteProductFailure implements StopSaving {
  DeleteProductFailure(this.product);

  final ProductEntity product;
}

class RestoreProductRequest implements StartSaving {
  RestoreProductRequest(this.completer, this.productId);

  final Completer completer;
  final int productId;
}

class RestoreProductSuccess implements StopSaving, PersistData {
  RestoreProductSuccess(this.product);

  final ProductEntity product;
}

class RestoreProductFailure implements StopSaving {
  RestoreProductFailure(this.product);

  final ProductEntity product;
}

class FilterProducts {
  FilterProducts(this.filter);

  final String filter;
}

class SortProducts implements PersistUI {
  SortProducts(this.field);

  final String field;
}

class FilterProductsByState implements PersistUI {
  FilterProductsByState(this.state);

  final EntityState state;
}

class FilterProductsByCustom1 implements PersistUI {
  FilterProductsByCustom1(this.value);

  final String value;
}

class FilterProductsByCustom2 implements PersistUI {
  FilterProductsByCustom2(this.value);

  final String value;
}

class FilterProductDropdown {
  FilterProductDropdown(this.filter);

  final String filter;
}
