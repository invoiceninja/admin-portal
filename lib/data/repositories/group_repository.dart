import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class GroupRepository {
  const GroupRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<GroupEntity> loadItem(Credentials credentials, String entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/group_settings/$entityId', credentials.token);

    final GroupItemResponse groupResponse =
        serializers.deserializeWith(GroupItemResponse.serializer, response);

    return groupResponse.data;
  }

  Future<BuiltList<GroupEntity>> loadList(
      Credentials credentials, int updatedAt) async {
    String url = credentials.url + '/group_settings?';

    if (updatedAt > 0) {
      url += '&updated_at=${updatedAt - kUpdatedAtBufferSeconds}';
    }

    final dynamic response = await webClient.get(url, credentials.token);

    final GroupListResponse groupResponse =
        serializers.deserializeWith(GroupListResponse.serializer, response);

    return groupResponse.data;
  }

  Future<List<GroupEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    var url = credentials.url + '/groups/bulk?';
    if (action != null) {
      url += '&action=' + action.toString();
    }
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids}));

    final GroupListResponse groupResponse =
        serializers.deserializeWith(GroupListResponse.serializer, response);

    return groupResponse.data.toList();
  }

  Future<GroupEntity> saveData(Credentials credentials, GroupEntity group) async {
    final data = serializers.serializeWith(GroupEntity.serializer, group);
    dynamic response;

    if (group.isNew) {
      response = await webClient.post(
          credentials.url + '/group_settings', credentials.token,
          data: json.encode(data));
    } else {
      final url = credentials.url + '/group_settings/${group.id}';
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final GroupItemResponse groupResponse =
        serializers.deserializeWith(GroupItemResponse.serializer, response);

    return groupResponse.data;
  }
}
