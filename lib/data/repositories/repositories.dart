import 'dart:async';
import 'dart:core';

import '../../data/models/entities.dart';

/// A class that Loads and Persists products. The data layer of the app.
///
/// How and where it stores the entities should defined in a concrete
/// implementation, such as products_repository_flutter or products_repository_web.
///
/// The domain layer should depend on this abstract class, and each app can
/// inject the correct implementation depending on the environment, such as
/// web or Flutter.
abstract class ProductsRepository {
  /// Loads products first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Todos from a Web Client.
  Future<List<ProductEntity>> loadProducts();

  // Persists products to local disk and the web
  Future saveProducts(List<ProductEntity> products);
}
