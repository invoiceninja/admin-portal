import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';

class ViewProductList implements PersistUI {
  final BuildContext context;
  ViewProductList(this.context);
}

class EditProduct implements PersistUI {
  final ProductEntity product;
  final BuildContext context;
  EditProduct({this.product, this.context});
}

class UpdateProduct implements PersistUI {
  final ProductEntity product;
  UpdateProduct(this.product);
}


class LoadProducts {
  final Completer completer;
  final bool force;

  LoadProducts({this.completer, this.force = false});
}

class LoadProductsRequest implements StartLoading {}

class LoadProductsFailure implements StopLoading {
  final dynamic error;
  LoadProductsFailure(this.error);

  @override
  String toString() {
    return 'LoadProductsFailure{error: $error}';
  }
}

class LoadProductsSuccess implements PersistData, StopLoading {
  final BuiltList<ProductEntity> products;
  LoadProductsSuccess(this.products);

  @override
  String toString() {
    return 'LoadProductsSuccess{products: $products}';
  }
}

class SaveProductRequest implements StartSaving {
  final Completer completer;
  final ProductEntity product;
  SaveProductRequest({this.product, this.completer});
}

class SaveProductSuccess implements StopSaving, PersistData, PersistUI {
  final ProductEntity product;

  SaveProductSuccess(this.product);
}

class AddProductSuccess implements StopSaving, PersistData, PersistUI {
  final ProductEntity product;
  AddProductSuccess(this.product);
}

class SaveProductFailure implements StopSaving {
  final Object error;
  SaveProductFailure (this.error);
}

class ArchiveProductRequest implements StartSaving {
  final Completer completer;
  final int productId;

  ArchiveProductRequest(this.completer, this.productId);
}

class ArchiveProductSuccess implements StopSaving, PersistData {
  final ProductEntity product;
  ArchiveProductSuccess(this.product);
}

class ArchiveProductFailure implements StopSaving {
  final ProductEntity product;
  ArchiveProductFailure(this.product);
}

class DeleteProductRequest implements StartSaving {
  final Completer completer;
  final int productId;

  DeleteProductRequest(this.completer, this.productId);
}

class DeleteProductSuccess implements StopSaving, PersistData {
  final ProductEntity product;
  DeleteProductSuccess(this.product);
}

class DeleteProductFailure implements StopSaving {
  final ProductEntity product;
  DeleteProductFailure(this.product);
}

class RestoreProductRequest implements StartSaving {
  final Completer completer;
  final int productId;
  RestoreProductRequest(this.completer, this.productId);
}

class RestoreProductSuccess implements StopSaving, PersistData {
  final ProductEntity product;
  RestoreProductSuccess(this.product);
}

class RestoreProductFailure implements StopSaving {
  final ProductEntity product;
  RestoreProductFailure(this.product);
}


class FilterProducts {
  final String filter;
  FilterProducts(this.filter);
}

class SortProducts implements PersistUI {
  final String field;
  SortProducts(this.field);
}

class FilterProductsByState implements PersistUI {
  final EntityState state;

  FilterProductsByState(this.state);
}

class FilterProductsByCustom1 implements PersistUI {
  final String value;

  FilterProductsByCustom1(this.value);
}

class FilterProductsByCustom2 implements PersistUI {
  final String value;

  FilterProductsByCustom2(this.value);
}

class FilterProductDropdown {
  final String filter;
  FilterProductDropdown(this.filter);
}
