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

class SubscriptionRepository {
  const SubscriptionRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<SubscriptionEntity> loadItem(
      Credentials credentials, String? entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/subscriptions/$entityId', credentials.token);

    final SubscriptionItemResponse subscriptionResponse = serializers
        .deserializeWith(SubscriptionItemResponse.serializer, response)!;

    return subscriptionResponse.data;
  }

  Future<BuiltList<SubscriptionEntity>> loadList(
      Credentials credentials) async {
    final String url = credentials.url+ '/subscriptions?';
    final dynamic response = await webClient.get(url, credentials.token);

    final SubscriptionListResponse subscriptionResponse = serializers
        .deserializeWith(SubscriptionListResponse.serializer, response)!;

    return subscriptionResponse.data;
  }

  Future<List<SubscriptionEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    if (ids.length > kMaxEntitiesPerBulkAction && action.applyMaxLimit) {
      ids = ids.sublist(0, kMaxEntitiesPerBulkAction);
    }

    final url = credentials.url+
        '/subscriptions/bulk?per_page=$kMaxEntitiesPerBulkAction';
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids, 'action': action.toApiParam()}));

    final SubscriptionListResponse subscriptionResponse = serializers
        .deserializeWith(SubscriptionListResponse.serializer, response)!;

    return subscriptionResponse.data.toList();
  }

  Future<SubscriptionEntity> saveData(
      Credentials credentials, SubscriptionEntity subscription) async {
    final data =
        serializers.serializeWith(SubscriptionEntity.serializer, subscription);
    dynamic response;

    if (subscription.isNew) {
      response = await webClient.post(
          credentials.url+ '/subscriptions', credentials.token,
          data: json.encode(data));
    } else {
      final url = '${credentials.url}/subscriptions/${subscription.id}';
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final SubscriptionItemResponse subscriptionResponse = serializers
        .deserializeWith(SubscriptionItemResponse.serializer, response)!;

    return subscriptionResponse.data;
  }
}
