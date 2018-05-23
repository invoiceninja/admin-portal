import 'dart:async';
import 'dart:core';
import 'package:meta/meta.dart';

import 'package:invoiceninja/redux/auth/auth_state.dart';
import 'package:invoiceninja/data/models/entities.dart';
import 'package:invoiceninja/data/file_storage.dart';
import 'package:invoiceninja/data/web_client.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Products and Persist products.
class ProductsRepositoryFlutter {
  final FileStorage fileStorage;
  final WebClient webClient;

  const ProductsRepositoryFlutter({
    @required this.fileStorage,
    this.webClient = const WebClient(),
  });

  Future<List<ProductEntity>> loadList(CompanyEntity company, AuthState auth) async {

    final products = await webClient.fetchList(
        auth.url + '/products', company.token);

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

  Future saveData(List<dynamic> products) {
    return Future.wait<dynamic>([
      fileStorage.saveData(products),
      //webClient.postProducts(products),
    ]);
  }
}