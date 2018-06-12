import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'package:invoiceninja/data/models/serializers.dart';
import 'package:built_collection/built_collection.dart';

import 'package:invoiceninja/redux/auth/auth_state.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/data/web_client.dart';

class CreditsRepository {
  final WebClient webClient;

  const CreditsRepository({
    this.webClient = const WebClient(),
  });

  Future<BuiltList<CreditEntity>> loadList(CompanyEntity company, AuthState auth) async {

    final response = await webClient.get(
        auth.url + '/credits?per_page=500', company.token);

    CreditListResponse creditResponse = serializers.deserializeWith(
        CreditListResponse.serializer, response);

    return creditResponse.data;
  }

  Future saveData(CompanyEntity company, AuthState auth, CreditEntity credit, [EntityAction action]) async {

    var data = serializers.serializeWith(CreditEntity.serializer, credit);
    var response;

    if (credit.id == null) {
      response = await webClient.post(
          auth.url + '/credits', company.token, json.encode(data));
    } else {
      var url = auth.url + '/credits/' + credit.id.toString();
      if (action != null) {
        url += '?action=' + action.toString();
      }
      response = await webClient.put(url, company.token, json.encode(data));
    }

    CreditItemResponse creditResponse = serializers.deserializeWith(
        CreditItemResponse.serializer, response);

    return creditResponse.data;
  }
}