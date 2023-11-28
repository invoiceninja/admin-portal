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

class DesignRepository {
  const DesignRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<DesignEntity> loadItem(
      Credentials credentials, String? entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/designs/$entityId', credentials.token);

    final DesignItemResponse designResponse =
        serializers.deserializeWith(DesignItemResponse.serializer, response)!;

    return designResponse.data;
  }

  Future<BuiltList<DesignEntity>> loadList(Credentials credentials) async {
    final url = credentials.url+ '/designs?';

    final dynamic response = await webClient.get(url, credentials.token);

    final DesignListResponse designResponse =
        serializers.deserializeWith(DesignListResponse.serializer, response)!;

    return designResponse.data;
  }

  Future<List<DesignEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    if (ids.length > kMaxEntitiesPerBulkAction && action.applyMaxLimit) {
      ids = ids.sublist(0, kMaxEntitiesPerBulkAction);
    }

    final url =
        credentials.url+ '/designs/bulk?per_page=$kMaxEntitiesPerBulkAction';
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids, 'action': action.toApiParam()}));

    final DesignListResponse designResponse =
        serializers.deserializeWith(DesignListResponse.serializer, response)!;

    return designResponse.data.toList();
  }

  Future<DesignEntity> saveData(
      Credentials credentials, DesignEntity design) async {
    final data = serializers.serializeWith(DesignEntity.serializer, design);
    dynamic response;

    if (design.isNew) {
      response = await webClient.post(
          credentials.url+ '/designs', credentials.token,
          data: json.encode(data));
    } else {
      final url = credentials.url+ '/designs/${design.id}';
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final DesignItemResponse designResponse =
        serializers.deserializeWith(DesignItemResponse.serializer, response)!;

    return designResponse.data;
  }
}
