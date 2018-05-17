import 'dart:async';
import 'dart:core';
import 'package:meta/meta.dart';

import 'package:invoiceninja/data/models/entities.dart';
import 'package:invoiceninja/data/repositories/repositories.dart';
import 'package:invoiceninja/data/file_storage.dart';
import 'package:invoiceninja/data/web_client.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Products and Persist products.
class ProductsRepositoryFlutter implements ProductsRepository {
  final FileStorage fileStorage;
  final WebClient webClient;

  const ProductsRepositoryFlutter({
    @required this.fileStorage,
    this.webClient = const WebClient(),
  });

  /// Loads products first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Products from a Web Client.
  @override
  Future<List<ProductEntity>> loadProducts() async {

    print('ProductRepo: loadProducts...');

    try {
      return await fileStorage.loadProducts();
    } catch (e) {
      final products = await webClient.fetchProducts();

      print('ProductRepo: result');
      print(products);

      fileStorage.saveProducts(products);

      return products;
    }
  }

  // Persists products to local disk and the web
  @override
  Future saveProducts(List<ProductEntity> products) {
    return Future.wait<dynamic>([
      fileStorage.saveProducts(products),
      webClient.postProducts(products),
    ]);
  }
}