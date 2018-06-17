import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja/redux/app/app_actions.dart';

class LoadProductsAction {
  final Completer completer;
  final bool force;

  LoadProductsAction([this.completer, this.force = false]);
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

class LoadProductsSuccess extends PersistData {
  final BuiltList<ProductEntity> products;
  LoadProductsSuccess(this.products);

  @override
  String toString() {
    return 'LoadProductsSuccess{products: $products}';
  }
}

class EditProductAction {
  final ProductEntity product;
  final BuildContext context;
  EditProductAction({this.product, this.context});
}

class SaveProductRequest {
  final Completer completer;
  final ProductEntity product;
  SaveProductRequest(this.completer, this.product);
}

class SaveProductSuccess extends PersistData {
  final ProductEntity product;

  SaveProductSuccess(this.product);
}

class ArchiveProductRequest {
  final Completer completer;
  final int productId;

  ArchiveProductRequest(this.completer, this.productId);
}
class ArchiveProductSuccess extends PersistData {
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
class DeleteProductSuccess extends PersistData {
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
class RestoreProductSuccess extends PersistData {
  final ProductEntity product;
  RestoreProductSuccess(this.product);
}
class RestoreProductFailure {
  final ProductEntity product;
  RestoreProductFailure(this.product);
}

class AddProductSuccess extends PersistData {
  final ProductEntity product;
  AddProductSuccess(this.product);
}

class SaveProductFailure {
  final String error;
  SaveProductFailure (this.error);
}


class SearchProducts {
  final String search;
  SearchProducts(this.search);
}

class SortProducts {
  final String field;
  SortProducts(this.field);
}

class FilterProductsByState {
  final EntityState state;

  FilterProductsByState(this.state);
}
