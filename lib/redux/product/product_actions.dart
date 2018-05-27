import 'package:invoiceninja/data/models/models.dart';
import 'package:built_collection/built_collection.dart';

class LoadProductsAction {}

class ProductsNotLoadedAction {
  final dynamic error;

  ProductsNotLoadedAction(this.error);

  @override
  String toString() {
    return 'ProductsNotLoadedAction{error: $error}';
  }
}

class ProductsLoadedAction {
  final BuiltList<ProductEntity> products;

  ProductsLoadedAction(this.products);

  @override
  String toString() {
    return 'ProductsLoadedAction{products: $products}';
  }
}

class SelectProductAction {
  final ProductEntity product;

  SelectProductAction(this.product);
}

class SaveProductRequest {
  final ProductEntity product;

  SaveProductRequest(this.product);
}

class SaveProductSuccess {
  final ProductEntity product;

  SaveProductSuccess(this.product);
}

class SaveProductFailure {
  final String error;

  SaveProductFailure (this.error);
}