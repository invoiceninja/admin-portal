import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'package:invoiceninja/data/models/serializers.dart';
import 'package:built_collection/built_collection.dart';

import 'package:invoiceninja/redux/auth/auth_state.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/data/web_client.dart';

class VendorRepository {
  final WebClient webClient;

  const VendorRepository({
    this.webClient = const WebClient(),
  });

  Future<BuiltList<VendorEntity>> loadList(CompanyEntity company, AuthState auth) async {

    final Future<dynamic> response = await webClient.get(
        auth.url + '/vendors?per_page=500', company.token);

    VendorListResponse vendorResponse = serializers.deserializeWith(
        VendorListResponse.serializer, response);

    return vendorResponse.data;
  }

  Future saveData(CompanyEntity company, AuthState auth, VendorEntity vendor, [EntityAction action]) async {

    var data = serializers.serializeWith(VendorEntity.serializer, vendor);
    Future<dynamic> response;

    if (vendor.isNew) {
      response = await webClient.post(
          auth.url + '/vendors', company.token, json.encode(data));
    } else {
      var url = auth.url + '/vendors/' + vendor.id.toString();
      if (action != null) {
        url += '?action=' + action.toString();
      }
      response = await webClient.put(url, company.token, json.encode(data));
    }

    VendorItemResponse vendorResponse = serializers.deserializeWith(
        VendorItemResponse.serializer, response);

    return vendorResponse.data;
  }
}