// Dart imports:
import 'dart:convert';
import 'dart:core';

// Package imports:
import 'package:built_collection/built_collection.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class WebhookRepository {
  const WebhookRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<WebhookEntity> loadItem(
      Credentials credentials, String? entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/webhooks/$entityId', credentials.token);

    final WebhookItemResponse webhookResponse =
        serializers.deserializeWith(WebhookItemResponse.serializer, response)!;

    return webhookResponse.data;
  }

  Future<BuiltList<WebhookEntity>> loadList(Credentials credentials) async {
    final url = credentials.url+ '/webhooks?';

    final dynamic response = await webClient.get(url, credentials.token);

    final WebhookListResponse webhookResponse =
        serializers.deserializeWith(WebhookListResponse.serializer, response)!;

    return webhookResponse.data;
  }

  Future<List<WebhookEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    if (ids.length > kMaxEntitiesPerBulkAction && action.applyMaxLimit) {
      ids = ids.sublist(0, kMaxEntitiesPerBulkAction);
    }

    final url =
        credentials.url+ '/webhooks/bulk?per_page=$kMaxEntitiesPerBulkAction';
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids, 'action': action.toApiParam()}));

    final WebhookListResponse webhookResponse =
        serializers.deserializeWith(WebhookListResponse.serializer, response)!;

    return webhookResponse.data.toList();
  }

  Future<WebhookEntity> saveData(
      Credentials credentials, WebhookEntity webhook) async {
    final data = serializers.serializeWith(WebhookEntity.serializer, webhook);
    dynamic response;

    if (webhook.isNew) {
      response = await webClient.post(
          credentials.url+ '/webhooks', credentials.token,
          data: json.encode(data));
    } else {
      final url = '${credentials.url}/webhooks/${webhook.id}';
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final WebhookItemResponse webhookResponse =
        serializers.deserializeWith(WebhookItemResponse.serializer, response)!;

    return webhookResponse.data;
  }
}
