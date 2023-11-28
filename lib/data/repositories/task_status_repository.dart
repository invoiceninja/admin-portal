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

class TaskStatusRepository {
  const TaskStatusRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<TaskStatusEntity> loadItem(
      Credentials credentials, String? entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/task_statuses/$entityId', credentials.token);

    final TaskStatusItemResponse taskStatusResponse = serializers
        .deserializeWith(TaskStatusItemResponse.serializer, response)!;

    return taskStatusResponse.data;
  }

  Future<BuiltList<TaskStatusEntity>> loadList(Credentials credentials) async {
    final String url = credentials.url+ '/task_statuses?';
    final dynamic response = await webClient.get(url, credentials.token);

    final TaskStatusListResponse taskStatusResponse = serializers
        .deserializeWith(TaskStatusListResponse.serializer, response)!;

    return taskStatusResponse.data;
  }

  Future<List<TaskStatusEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    if (ids.length > kMaxEntitiesPerBulkAction && action.applyMaxLimit) {
      ids = ids.sublist(0, kMaxEntitiesPerBulkAction);
    }

    final url = credentials.url+
        '/task_statuses/bulk?per_page=$kMaxEntitiesPerBulkAction';
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids, 'action': action.toApiParam()}));

    final TaskStatusListResponse taskStatusResponse = serializers
        .deserializeWith(TaskStatusListResponse.serializer, response)!;

    return taskStatusResponse.data.toList();
  }

  Future<TaskStatusEntity> saveData(
      Credentials credentials, TaskStatusEntity taskStatus) async {
    final data =
        serializers.serializeWith(TaskStatusEntity.serializer, taskStatus);
    dynamic response;

    if (taskStatus.isNew) {
      response = await webClient.post(
          credentials.url+ '/task_statuses', credentials.token,
          data: json.encode(data));
    } else {
      final url = '${credentials.url}/task_statuses/${taskStatus.id}';
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final TaskStatusItemResponse taskStatusResponse = serializers
        .deserializeWith(TaskStatusItemResponse.serializer, response)!;

    return taskStatusResponse.data;
  }
}
