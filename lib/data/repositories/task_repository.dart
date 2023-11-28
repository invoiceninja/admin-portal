// Dart imports:
import 'dart:convert';
import 'dart:core';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:http/http.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/serialization.dart';

class TaskRepository {
  const TaskRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<TaskEntity> loadItem(Credentials credentials, String? entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/tasks/$entityId', credentials.token);

    final TaskItemResponse taskResponse = await compute<dynamic, dynamic>(
        SerializationUtils.deserializeWith,
        <dynamic>[TaskItemResponse.serializer, response]);

    return taskResponse.data;
  }

  Future<BuiltList<TaskEntity>> loadList(Credentials credentials, int page,
      int createdAt, bool filterDeleted) async {
    final url = credentials.url+
        '/tasks?per_page=$kMaxRecordsPerPage&page=$page&created_at=$createdAt';

    /* Server is incorrect if client isn't set
    if (filterDeleted) {
      url += '&filter_deleted_clients=true';
    }
    */

    final dynamic response = await webClient.get(url, credentials.token);

    final TaskListResponse taskResponse = await compute<dynamic, dynamic>(
        SerializationUtils.deserializeWith,
        <dynamic>[TaskListResponse.serializer, response]);

    return taskResponse.data;
  }

  Future<List<TaskEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    if (ids.length > kMaxEntitiesPerBulkAction && action.applyMaxLimit) {
      ids = ids.sublist(0, kMaxEntitiesPerBulkAction);
    }

    final url =
        credentials.url+ '/tasks/bulk?per_page=$kMaxEntitiesPerBulkAction';
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids, 'action': action.toApiParam()}));

    final TaskListResponse taskResponse =
        serializers.deserializeWith(TaskListResponse.serializer, response)!;

    return taskResponse.data.toList();
  }

  Future<bool> sortTasks(Credentials credentials, List<String>? statusIds,
      Map<String, List<String>>? taskIds) async {
    final url = credentials.url+ '/tasks/sort';

    await webClient.post(url, credentials.token,
        data: json.encode({'status_ids': statusIds, 'task_ids': taskIds}));

    return true;
  }

  Future<TaskEntity> saveData(Credentials credentials, TaskEntity task,
      {EntityAction? action}) async {
    final data = serializers.serializeWith(TaskEntity.serializer, task);

    dynamic response;
    String url;

    if (task.isNew) {
      url = credentials.url+ '/tasks?';
    } else {
      url = credentials.url+ '/tasks/${task.id}?';
    }

    if ([
      EntityAction.start,
      EntityAction.resume,
    ].contains(action)) {
      url += '&start=true';
    } else if (action == EntityAction.stop) {
      url += '&stop=true';
    }

    if (task.isNew) {
      response =
          await webClient.post(url, credentials.token, data: json.encode(data));
    } else {
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final TaskItemResponse taskResponse =
        serializers.deserializeWith(TaskItemResponse.serializer, response)!;

    return taskResponse.data;
  }

  Future<TaskEntity> uploadDocument(Credentials credentials, BaseEntity entity,
      List<MultipartFile> multipartFiles, bool isPrivate) async {
    final fields = <String, String>{
      '_method': 'put',
      'is_public': isPrivate ? '0' : '1',
    };

    final dynamic response = await webClient.post(
        '${credentials.url}/tasks/${entity.id}/upload', credentials.token,
        data: fields, multipartFiles: multipartFiles);

    final TaskItemResponse taskResponse =
        serializers.deserializeWith(TaskItemResponse.serializer, response)!;

    return taskResponse.data;
  }
}
