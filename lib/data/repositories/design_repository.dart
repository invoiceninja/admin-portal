import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class DesignRepository {
  const DesignRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<DesignEntity> loadItem(
      Credentials credentials, String entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/designs/$entityId', credentials.token);

    final DesignItemResponse designResponse =
        serializers.deserializeWith(DesignItemResponse.serializer, response);

    return designResponse.data;
  }

  Future<BuiltList<DesignEntity>> loadList(
      Credentials credentials, int updatedAt) async {
    String url = credentials.url + '/designs?';

    if (updatedAt > 0) {
      url += '&updated_at=${updatedAt - kUpdatedAtBufferSeconds}';
    }

    final dynamic response = await webClient.get(url, credentials.token);

    final DesignListResponse designResponse =
        serializers.deserializeWith(DesignListResponse.serializer, response);

    return designResponse.data;
  }

  Future<List<DesignEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    var url = credentials.url + '/designs/bulk?';
    if (action != null) {
      url += '&action=' + action.toString();
    }
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids}));

    final DesignListResponse designResponse =
        serializers.deserializeWith(DesignListResponse.serializer, response);

    return designResponse.data.toList();
  }

  Future<DesignEntity> saveData(Credentials credentials, DesignEntity design) async {
    final data = serializers.serializeWith(DesignEntity.serializer, design);
    dynamic response;

    if (design.isNew) {
      response = await webClient.post(
          credentials.url + '/designs', credentials.token,
          data: json.encode(data));
    } else {
      final url = credentials.url + '/designs/${design.id}';
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final DesignItemResponse designResponse =
        serializers.deserializeWith(DesignItemResponse.serializer, response);

    return designResponse.data;
  }
}
