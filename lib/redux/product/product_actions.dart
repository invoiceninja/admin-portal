import 'package:invoiceninja/data/models/models.dart';

class LoadProductsAction {}

class ProductsNotLoadedAction {}

class ProductsLoadedAction {
  final List<ProductEntity> products;

  ProductsLoadedAction(this.products);

  @override
  String toString() {
    return 'ProductsLoadedAction{products: $products}';
  }
}
