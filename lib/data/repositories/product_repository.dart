import 'dart:async';
import 'dart:core';
import 'package:meta/meta.dart';
import 'package:invoiceninja/data/models/serializers.dart';
import 'package:built_collection/built_collection.dart';

import 'package:invoiceninja/redux/auth/auth_state.dart';
import 'package:invoiceninja/data/models/entities.dart';
import 'package:invoiceninja/data/file_storage.dart';
import 'package:invoiceninja/data/web_client.dart';

class ProductsRepository {
  final FileStorage fileStorage;
  final WebClient webClient;

  const ProductsRepository({
    @required this.fileStorage,
    this.webClient = const WebClient(),
  });

  Future<BuiltList<ProductEntity>> loadList(CompanyEntity company, AuthState auth) async {

    final response = await webClient.get(
        auth.url + '/products', company.token);

    //fileStorage.saveProducts(products);

    ProductResponse productResponse = serializers.deserializeWith(
        ProductResponse.serializer, response);

    return productResponse.data;

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