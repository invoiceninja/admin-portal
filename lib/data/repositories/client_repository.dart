import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:built_collection/built_collection.dart';

import 'package:invoiceninja_flutter/redux/auth/auth_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class ClientRepository {
  final WebClient webClient;

  const ClientRepository({
    this.webClient = const WebClient(),
  });

  Future<BuiltList<ClientEntity>> loadList(CompanyEntity company, AuthState auth) async {

    final dynamic response = await webClient.get(
        auth.url + '/clients', company.token);

    final ClientListResponse clientResponse = serializers.deserializeWith(
        ClientListResponse.serializer, response);

    return clientResponse.data;
  }

  Future saveData(CompanyEntity company, AuthState auth, ClientEntity client, [EntityAction action]) async {

    final data = serializers.serializeWith(ClientEntity.serializer, client);
    dynamic response;

    if (client.isNew) {
      response = await webClient.post(
          auth.url + '/clients', company.token, json.encode(data));
    } else {
      var url = auth.url + '/clients/' + client.id.toString();
      if (action != null) {
        url += '?action=' + action.toString();
      }
      response = await webClient.put(url, company.token, json.encode(data));
    }

    final ClientItemResponse clientResponse = serializers.deserializeWith(
        ClientItemResponse.serializer, response);

    return clientResponse.data;
  }
}