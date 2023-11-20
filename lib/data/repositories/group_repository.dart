// Dart imports:
import 'dart:convert';
import 'dart:core';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:http/http.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class GroupRepository {
  const GroupRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<GroupEntity> loadItem(
      Credentials credentials, String? entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/group_settings/$entityId', credentials.token);

    final GroupItemResponse groupResponse =
        serializers.deserializeWith(GroupItemResponse.serializer, response)!;

    return groupResponse.data;
  }

  Future<BuiltList<GroupEntity>> loadList(Credentials credentials) async {
    final url = credentials.url+ '/group_settings?';

    final dynamic response = await webClient.get(url, credentials.token);

    final GroupListResponse groupResponse =
        serializers.deserializeWith(GroupListResponse.serializer, response)!;

    return groupResponse.data;
  }

  Future<List<GroupEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    if (ids.length > kMaxEntitiesPerBulkAction && action.applyMaxLimit) {
      ids = ids.sublist(0, kMaxEntitiesPerBulkAction);
    }

    final url = credentials.url+
        '/group_settings/bulk?per_page=$kMaxEntitiesPerBulkAction';
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids, 'action': action.toApiParam()}));

    final GroupListResponse groupResponse =
        serializers.deserializeWith(GroupListResponse.serializer, response)!;

    return groupResponse.data.toList();
  }

  Future<GroupEntity> saveData(
      Credentials credentials, GroupEntity group) async {
    final data = serializers.serializeWith(GroupEntity.serializer, group);
    dynamic response;

    if (group.isNew) {
      response = await webClient.post(
          credentials.url+ '/group_settings', credentials.token,
          data: json.encode(data));
    } else {
      final url = credentials.url+ '/group_settings/${group.id}';
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final GroupItemResponse groupResponse =
        serializers.deserializeWith(GroupItemResponse.serializer, response)!;

    return groupResponse.data;
  }

  Future<GroupEntity> uploadDocuments(
      Credentials credentials,
      BaseEntity entity,
      List<MultipartFile> multipartFiles,
      bool isPrivate) async {
    final fields = <String, String>{
      '_method': 'put',
      'is_public': isPrivate ? '0' : '1',
    };

    final dynamic response = await webClient.post(
        '${credentials.url}/group_settings/${entity.id}/upload',
        credentials.token,
        data: fields,
        multipartFiles: multipartFiles);

    final GroupItemResponse groupResponse =
        serializers.deserializeWith(GroupItemResponse.serializer, response)!;

    return groupResponse.data;
  }
}
