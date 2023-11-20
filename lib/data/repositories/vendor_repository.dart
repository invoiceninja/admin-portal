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

class VendorRepository {
  const VendorRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<VendorEntity> loadItem(
      Credentials credentials, String? entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/vendors/$entityId?include=activities',
        credentials.token);

    final VendorItemResponse vendorResponse = await compute<dynamic, dynamic>(
        SerializationUtils.deserializeWith,
        <dynamic>[VendorItemResponse.serializer, response]);

    return vendorResponse.data;
  }

  Future<BuiltList<VendorEntity>> loadList(
      Credentials credentials, int page) async {
    final String url =
        credentials.url+ '/vendors?per_page=$kMaxRecordsPerPage&page=$page';

    final dynamic response = await webClient.get(url, credentials.token);

    final VendorListResponse vendorResponse = await compute<dynamic, dynamic>(
        SerializationUtils.deserializeWith,
        <dynamic>[VendorListResponse.serializer, response]);

    return vendorResponse.data;
  }

  Future<List<VendorEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    if (ids.length > kMaxEntitiesPerBulkAction && action.applyMaxLimit) {
      ids = ids.sublist(0, kMaxEntitiesPerBulkAction);
    }

    final url = credentials.url+
        '/vendors/bulk?per_page=$kMaxEntitiesPerBulkAction&include=activities';
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids, 'action': action.toApiParam()}));

    final VendorListResponse vendorResponse =
        serializers.deserializeWith(VendorListResponse.serializer, response)!;

    return vendorResponse.data.toList();
  }

  Future<VendorEntity> saveData(
      Credentials credentials, VendorEntity vendor) async {
    final data = serializers.serializeWith(VendorEntity.serializer, vendor);
    dynamic response;

    if (vendor.isNew) {
      response = await webClient.post(
          credentials.url+ '/vendors?include=activities', credentials.token,
          data: json.encode(data));
    } else {
      final url = credentials.url+ '/vendors/${vendor.id}?include=activities';
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final VendorItemResponse vendorResponse =
        serializers.deserializeWith(VendorItemResponse.serializer, response)!;

    return vendorResponse.data;
  }

  Future<VendorEntity> uploadDocument(
      Credentials credentials,
      BaseEntity entity,
      List<MultipartFile> multipartFiles,
      bool isPrivate) async {
    final fields = <String, String>{
      '_method': 'put',
      'is_public': isPrivate ? '0' : '1',
    };

    final dynamic response = await webClient.post(
        '${credentials.url}/vendors/${entity.id}/upload', credentials.token,
        data: fields, multipartFiles: multipartFiles);

    final VendorItemResponse vendorResponse =
        serializers.deserializeWith(VendorItemResponse.serializer, response)!;

    return vendorResponse.data;
  }
}
