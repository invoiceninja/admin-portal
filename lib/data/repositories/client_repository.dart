import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

import 'package:invoiceninja_flutter/redux/auth/auth_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class ClientRepository {
  const ClientRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<ClientEntity> loadItem(
      Credentials credentials, String entityId, bool loadActivities) async {
    String url = '${credentials.url}/clients/$entityId';

    if (loadActivities) {
      url += '?include=activities';
    }

    final dynamic response = await webClient.get(url, credentials.token);

    final ClientItemResponse clientResponse =
        serializers.deserializeWith(ClientItemResponse.serializer, response);

    return clientResponse.data;
  }

  Future<BuiltList<ClientEntity>> loadList(
      Credentials credentials, int updatedAt) async {
    String url = credentials.url + '/clients?';

    if (updatedAt > 0) {
      url += '&updated_at=${updatedAt - kUpdatedAtBufferSeconds}';
    }

    final dynamic response = await webClient.get(url, credentials.token);

    final ClientListResponse clientResponse =
        serializers.deserializeWith(ClientListResponse.serializer, response);

    return clientResponse.data;
  }

  Future<ClientEntity> saveData(Credentials credentials, ClientEntity client,
      [EntityAction action]) async {
    final data = serializers.serializeWith(ClientEntity.serializer, client);
    dynamic response;

    if (client.isNew) {
      response = await webClient.post(
          credentials.url + '/clients?include=activities',
          credentials.token,
          json.encode(data));
    } else {
      var url = credentials.url + '/clients/${client.id}?include=activities';
      if (action != null) {
        url += '&action=' + action.toString();
      }
      response = await webClient.put(url, credentials.token, json.encode(data));
    }

    final ClientItemResponse clientResponse =
        serializers.deserializeWith(ClientItemResponse.serializer, response);

    return clientResponse.data;
  }
}
