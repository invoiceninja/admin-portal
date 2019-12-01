import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:invoiceninja_flutter/.env.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/mock/mock_clients.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class ClientRepository {
  const ClientRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<ClientEntity> loadItem(
      Credentials credentials, String entityId, bool loadActivities) async {
    String url = '${credentials.url}/clients/$entityId?include=gateway_tokens';

    if (loadActivities) {
      url += ',activities';
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

    dynamic response;

    if (Config.DEMO_MODE) {
      response = json.decode(kMockClients);
    } else {
      response = await webClient.get(url, credentials.token);
    }

    final ClientListResponse clientResponse =
        serializers.deserializeWith(ClientListResponse.serializer, response);

    return clientResponse.data;
  }

  Future<List<ClientEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    var url =
        credentials.url + '/clients/bulk?include=gateway_tokens,activities';
    if (action != null) {
      url += '&action=' + action.toString();
    }
    final dynamic response =
        await webClient.post(url, credentials.token, data: json.encode({'ids':ids}));

    final ClientListResponse clientResponse =
        serializers.deserializeWith(ClientListResponse.serializer, response);

    return clientResponse.data.toList();
  }

  Future<ClientEntity> saveData(
      Credentials credentials, ClientEntity client) async {
    final data = serializers.serializeWith(ClientEntity.serializer, client);
    dynamic response;

    if (client.isNew) {
      response = await webClient.post(
          credentials.url + '/clients?include=gateway_tokens,activities',
          credentials.token,
          data: json.encode(data));
    } else {
      final url = credentials.url +
          '/clients/${client.id}?include=gateway_tokens,activities';
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final ClientItemResponse clientResponse =
        serializers.deserializeWith(ClientItemResponse.serializer, response);

    return clientResponse.data;
  }
}
