import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class VendorRepository {

  const VendorRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<VendorEntity> loadItem(
      CompanyEntity company, AuthState auth, int entityId) async {
    final dynamic response = await webClient.get(
        '${auth.url}/vendors/$entityId', company.token);

    final VendorItemResponse vendorResponse =
        serializers.deserializeWith(VendorItemResponse.serializer, response);

    return vendorResponse.data;
  }

  Future<BuiltList<VendorEntity>> loadList(
      CompanyEntity company, AuthState auth, int updatedAt) async {
    String url = auth.url + '/vendors?';

    if (updatedAt > 0) {
      url += '&updated_at=${updatedAt - kUpdatedAtBufferSeconds}';
    }

    final dynamic response = await webClient.get(url, company.token);

    final VendorListResponse vendorResponse =
        serializers.deserializeWith(VendorListResponse.serializer, response);

    return vendorResponse.data;
  }
  
  Future<VendorEntity> saveData(
      CompanyEntity company, AuthState auth, VendorEntity vendor,
      [EntityAction action]) async {
    final data = serializers.serializeWith(VendorEntity.serializer, vendor);
    dynamic response;

    if (vendor.isNew) {
      response = await webClient.post(
          auth.url + '/vendors',
          company.token,
          json.encode(data));
    } else {
      var url = auth.url + '/vendors/' + vendor.id.toString();
      if (action != null) {
        url += '?action=' + action.toString();
      }
      response = await webClient.put(url, company.token, json.encode(data));
    }

    final VendorItemResponse vendorResponse =
    serializers.deserializeWith(VendorItemResponse.serializer, response);

    return vendorResponse.data;
  }
}
