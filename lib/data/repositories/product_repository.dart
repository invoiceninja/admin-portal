import 'dart:async';
import 'dart:core';
import 'package:meta/meta.dart';

import 'package:invoiceninja/redux/auth/auth_state.dart';
import 'package:invoiceninja/data/models/entities.dart';
import 'package:invoiceninja/data/repositories/repositories.dart';
import 'package:invoiceninja/data/file_storage.dart';
import 'package:invoiceninja/data/web_client.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Products and Persist products.
class ProductsRepositoryFlutter implements BaseRepository {
  final FileStorage fileStorage;
  final WebClient webClient;

  const ProductsRepositoryFlutter({
    @required this.fileStorage,
    this.webClient = const WebClient(),
  });

  /// Loads products first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Products from a Web Client.
  @override
  Future<List<dynamic>> loadData(AuthState auth) async {
    print('ProductRepo: loadProducts...');

    final products = await webClient.fetchData(
        auth.url + '/products', auth.token);

    //fileStorage.saveProducts(products);

    return products.map((product) => ProductEntity.fromJson(product)).toList();

    /*
    try {
      return await fileStorage.loadData();
    } catch (exception) {
      final products = await webClient.fetchData(
          auth.url + '/products', auth.token);

      //fileStorage.saveProducts(products);

      return products;
    }
    */
  }

  // Persists products to local disk and the web
  @override
  Future saveData(List<dynamic> products) {
    return Future.wait<dynamic>([
      fileStorage.saveData(products),
      webClient.postProducts(products),
    ]);
  }
}