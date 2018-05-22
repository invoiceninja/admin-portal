import 'package:invoiceninja/data/models/models.dart';

class LoadDashboardAction {}

class DashboardNotLoadedAction {
  final dynamic error;

  DashboardNotLoadedAction(this.error);

  @override
  String toString() {
    return 'DashboardNotLoadedAction{products: $error}';
  }
}

class DashboardLoadedAction {
  final List<ProductEntity> products;

  DashboardLoadedAction(this.products);

  @override
  String toString() {
    return 'DashboardLoadedAction{products: $products}';
  }
}