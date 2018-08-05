import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:built_collection/built_collection.dart';

import 'package:invoiceninja_flutter/redux/auth/auth_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class ProductRepository {
  final WebClient webClient;

  const ProductRepository({
    this.webClient = const WebClient(),
  });

  Future<BuiltList<ProductEntity>> loadList(CompanyEntity company, AuthState auth) async {

    final dynamic response = await webClient.get(
        auth.url + '/products', company.token);

    final ProductListResponse productResponse = serializers.deserializeWith(
        ProductListResponse.serializer, response);

    return productResponse.data;
  }

  Future<ProductEntity> saveData(CompanyEntity company, AuthState auth, ProductEntity product, [EntityAction action]) async {

    final data = serializers.serializeWith(ProductEntity.serializer, product);
    dynamic response;

    if (product.isNew) {
      response = await webClient.post(
          auth.url + '/products', company.token, json.encode(data));
    } else {
      var url = auth.url + '/products/' + product.id.toString();
      if (action != null) {
        url += '?action=' + action.toString();
      }
      response = await webClient.put(url, company.token, json.encode(data));
    }

    final ProductItemResponse productResponse = serializers.deserializeWith(
        ProductItemResponse.serializer, response);

    return productResponse.data;
  }
}