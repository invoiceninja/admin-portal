import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja/redux/app/app_actions.dart';

class LoadProducts {
  final Completer completer;
  final bool force;

  LoadProducts([this.completer, this.force = false]);
}

class LoadProductsRequest {}

class LoadProductsFailure {
  final dynamic error;
  LoadProductsFailure(this.error);

  @override
  String toString() {
    return 'LoadProductsFailure{error: $error}';
  }
}

class LoadProductsSuccess implements PersistData {
  final BuiltList<ProductEntity> products;
  LoadProductsSuccess(this.products);

  @override
  String toString() {
    return 'LoadProductsSuccess{products: $products}';
  }
}

class EditProduct {
  final ProductEntity product;
  final BuildContext context;
  EditProduct({this.product, this.context});
}

class SaveProductRequest {
  final Completer completer;
  final ProductEntity product;
  SaveProductRequest(this.completer, this.product);
}

class SaveProductSuccess implements PersistData {
  final ProductEntity product;

  SaveProductSuccess(this.product);
}

class SaveProductFailure {
  final String error;
  SaveProductFailure (this.error);
}

class ArchiveProductRequest {
  final Completer completer;
  final int productId;

  ArchiveProductRequest(this.completer, this.productId);
}

class ArchiveProductSuccess implements PersistData {
  final ProductEntity product;
  ArchiveProductSuccess(this.product);
}

class ArchiveProductFailure {
  final ProductEntity product;
  ArchiveProductFailure(this.product);
}

class DeleteProductRequest {
  final Completer completer;
  final int productId;

  DeleteProductRequest(this.completer, this.productId);
}

class DeleteProductSuccess implements PersistData {
  final ProductEntity product;
  DeleteProductSuccess(this.product);
}

class DeleteProductFailure {
  final ProductEntity product;
  DeleteProductFailure(this.product);
}

class RestoreProductRequest {
  final Completer completer;
  final int productId;
  RestoreProductRequest(this.completer, this.productId);
}

class RestoreProductSuccess implements PersistData {
  final ProductEntity product;
  RestoreProductSuccess(this.product);
}

class RestoreProductFailure {
  final ProductEntity product;
  RestoreProductFailure(this.product);
}

class AddProductSuccess implements PersistData {
  final ProductEntity product;
  AddProductSuccess(this.product);
}


class SearchProducts {
  final String search;
  SearchProducts(this.search);
}

class SortProducts implements PersistUI {
  final String field;
  SortProducts(this.field);
}

class FilterProductsByState implements PersistUI {
  final EntityState state;

  FilterProductsByState(this.state);
}
