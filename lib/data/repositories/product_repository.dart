import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/utils/network.dart';

class ProductRepository {
  const ProductRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<ProductEntity> loadItem(
      Credentials credentials, String entityId) async {
    final String url =
        '${credentials.url}/products/$entityId?include=documents'; // TODO remove this include

    final dynamic response = await webClient.get(url, credentials.token);

    final ProductItemResponse productResponse = await compute<dynamic, dynamic>(
        computeDecode, <dynamic>[ProductItemResponse.serializer, response]);

    return productResponse.data;
  }
  
  Future<BuiltList<ProductEntity>> loadList(Credentials credentials) async {
    final url = credentials.url + '/products?';

    final dynamic response = await webClient.get(url, credentials.token);

    final ProductListResponse productResponse = await compute<dynamic, dynamic>(
        computeDecode, <dynamic>[ProductListResponse.serializer, response]);

    return productResponse.data;
  }

  Future<List<ProductEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    final url = credentials.url + '/products/bulk';
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids, 'action': '$action'}));

    final ProductListResponse productResponse =
        serializers.deserializeWith(ProductListResponse.serializer, response);

    return productResponse.data.toList();
  }

  Future<ProductEntity> saveData(
      Credentials credentials, ProductEntity product) async {
    final data = serializers.serializeWith(ProductEntity.serializer, product);
    dynamic response;

    if (product.isNew) {
      response = await webClient.post(
          credentials.url + '/products', credentials.token,
          data: json.encode(data));
    } else {
      final url = credentials.url + '/products/${product.id}';
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final ProductItemResponse productResponse =
        serializers.deserializeWith(ProductItemResponse.serializer, response);

    return productResponse.data;
  }

  Future<ProductEntity> uploadDocument(
      Credentials credentials, BaseEntity entity, String filePath) async {
    final fields = <String, String>{
      '_method': 'put',
    };

    // TODO remove this include
    final dynamic response = await webClient.post(
        '${credentials.url}/products/${entity.id}?include=documents', credentials.token,
        data: fields, filePath: filePath, fileIndex: 'documents[]');

    final ProductItemResponse productResponse =
    serializers.deserializeWith(ProductItemResponse.serializer, response);

    return productResponse.data;
  }
}
