import 'package:invoiceninja/data/models/models.dart';

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
  final List<ProductEntity> products;

  ProductsLoadedAction(this.products);

  @override
  String toString() {
    return 'ProductsLoadedAction{products: $products}';
  }
}

class UpdateProductAction {
  final ProductEntity product;

  UpdateProductAction(this.product);
}