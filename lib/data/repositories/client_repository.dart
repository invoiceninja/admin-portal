import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:built_collection/built_collection.dart';

import 'package:invoiceninja_flutter/redux/auth/auth_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class ClientRepository {
  const ClientRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<ClientEntity> loadItem(CompanyEntity company, AuthState auth,
      int entityId, bool loadActivities) async {
    String url = '${auth.url}/clients/$entityId';

    if (loadActivities) {
      url += '?include=activities';
    }

    final dynamic response = await webClient.get(url, company.token);

    final ClientItemResponse clientResponse =
        serializers.deserializeWith(ClientItemResponse.serializer, response);

    return clientResponse.data;
  }

  Future<BuiltList<ClientEntity>> loadList(
      CompanyEntity company, AuthState auth, int updatedAt) async {
    String url = auth.url + '/clients?';

    if (updatedAt > 0) {
      url += '&updated_at=${updatedAt - kUpdatedAtBufferSeconds}';
    }

    final dynamic response = await webClient.get(url, company.token);

    final ClientListResponse clientResponse =
        serializers.deserializeWith(ClientListResponse.serializer, response);

    return clientResponse.data;
  }

  Future<ClientEntity> saveData(
      CompanyEntity company, AuthState auth, ClientEntity client,
      [EntityAction action]) async {
    final data = serializers.serializeWith(ClientEntity.serializer, client);
    dynamic response;

    if (client.isNew) {
      response = await webClient.post(auth.url + '/clients?include=activities',
          company.token, json.encode(data));
    } else {
      var url = auth.url + '/clients/${client.id}?include=activities';
      if (action != null) {
        url += '&action=' + action.toString();
      }
      response = await webClient.put(url, company.token, json.encode(data));
    }

    final ClientItemResponse clientResponse =
        serializers.deserializeWith(ClientItemResponse.serializer, response);

    return clientResponse.data;
  }
}
