// Dart imports:
import 'dart:convert';
import 'dart:core';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:http/http.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/serialization.dart';

class ProductRepository {
  const ProductRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<ProductEntity> loadItem(
      Credentials credentials, String? entityId) async {
    final String url = '${credentials.url}/products/$entityId';

    final dynamic response = await webClient.get(url, credentials.token);

    final ProductItemResponse productResponse = await compute<dynamic, dynamic>(
        SerializationUtils.deserializeWith,
        <dynamic>[ProductItemResponse.serializer, response]);

    return productResponse.data;
  }

  Future<BuiltList<ProductEntity>> loadList(
      Credentials credentials, int page) async {
    final url =
        credentials.url+ '/products?per_page=$kMaxRecordsPerPage&page=$page';

    final dynamic response = await webClient.get(url, credentials.token);

    final ProductListResponse productResponse = await compute<dynamic, dynamic>(
        SerializationUtils.deserializeWith,
        <dynamic>[ProductListResponse.serializer, response]);

    return productResponse.data;
  }

  Future<List<ProductEntity>> bulkAction(
    Credentials credentials,
    List<String> ids,
    EntityAction action, {
    String taxCategoryId = '',
  }) async {
    if (ids.length > kMaxEntitiesPerBulkAction && action.applyMaxLimit) {
      ids = ids.sublist(0, kMaxEntitiesPerBulkAction);
    }

    final url =
        credentials.url+ '/products/bulk?per_page=$kMaxEntitiesPerBulkAction';
    final dynamic response = await webClient.post(
      url,
      credentials.token,
      data: json.encode(
        {
          'ids': ids,
          'action': action.toApiParam(),
          if (taxCategoryId.isNotEmpty) 'tax_id': taxCategoryId,
        },
      ),
    );

    final ProductListResponse productResponse =
        serializers.deserializeWith(ProductListResponse.serializer, response)!;

    return productResponse.data.toList();
  }

  Future<ProductEntity> saveData(Credentials credentials, ProductEntity product,
      {bool changedStock = false}) async {
    product = product.rebuild((b) => b..documents.clear());
    final data = serializers.serializeWith(ProductEntity.serializer, product);
    dynamic response;

    if (product.isNew) {
      response = await webClient.post(
          credentials.url+ '/products', credentials.token,
          data: json.encode(data));
    } else {
      var url = credentials.url+ '/products/${product.id}';
      if (changedStock) {
        url += '?update_in_stock_quantity=true';
      }
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final ProductItemResponse productResponse =
        serializers.deserializeWith(ProductItemResponse.serializer, response)!;

    return productResponse.data;
  }

  Future<ProductEntity> uploadDocument(
      Credentials credentials,
      BaseEntity entity,
      List<MultipartFile> multipartFiles,
      bool isPrivate) async {
    final fields = <String, String>{
      '_method': 'put',
      'is_public': isPrivate ? '0' : '1',
    };

    final dynamic response = await webClient.post(
        '${credentials.url}/products/${entity.id}/upload', credentials.token,
        data: fields, multipartFiles: multipartFiles);

    final ProductItemResponse productResponse =
        serializers.deserializeWith(ProductItemResponse.serializer, response)!;

    return productResponse.data;
  }
}
