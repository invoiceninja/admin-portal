import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class VendorRepository {
  const VendorRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<VendorEntity> loadItem(
      Credentials credentials, String entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/vendors/$entityId', credentials.token);

    final VendorItemResponse vendorResponse =
        serializers.deserializeWith(VendorItemResponse.serializer, response);

    return vendorResponse.data;
  }

  Future<BuiltList<VendorEntity>> loadList(
      Credentials credentials, int updatedAt) async {
    String url = credentials.url + '/vendors?';

    if (updatedAt > 0) {
      url += '&updated_at=${updatedAt - kUpdatedAtBufferSeconds}';
    }

    final dynamic response = await webClient.get(url, credentials.token);

    final VendorListResponse vendorResponse =
        serializers.deserializeWith(VendorListResponse.serializer, response);

    return vendorResponse.data;
  }

  Future<List<VendorEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    var url = credentials.url + '/vendors/bulk?';
    if (action != null) {
      url += '&action=' + action.toString();
    }
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids}));

    final VendorListResponse vendorResponse =
        serializers.deserializeWith(VendorListResponse.serializer, response);

    return vendorResponse.data.toList();
  }

  Future<VendorEntity> saveData(Credentials credentials, VendorEntity vendor) async {
    final data = serializers.serializeWith(VendorEntity.serializer, vendor);
    dynamic response;

    if (vendor.isNew) {
      response = await webClient.post(
          credentials.url + '/vendors', credentials.token,
          data: json.encode(data));
    } else {
      final url = credentials.url + '/vendors/${vendor.id}';
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final VendorItemResponse vendorResponse =
        serializers.deserializeWith(VendorItemResponse.serializer, response);

    return vendorResponse.data;
  }
}
