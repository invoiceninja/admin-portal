import 'dart:async';
import 'dart:core';
import 'dart:convert';
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

    ProductResponse productResponse = serializers.deserializeWith(
        ProductResponse.serializer, response);

    return productResponse.data;
  }

  Future saveData(CompanyEntity company, AuthState auth, ProductEntity product) async {

    print(auth.url + '/products/' + product.id.toString());
    print(company.token);

    var data = serializers.serializeWith(ProductEntity.serializer, product);
    final response = await webClient.put(
        auth.url + '/products/' + product.id.toString(), company.token, json.encode(data));

    print('== SAVE RESPONSE: POST');
    print(response);

    ProductResponse productResponse = serializers.deserializeWith(
        ProductResponse.serializer, response);

    return productResponse.data;
  }
}