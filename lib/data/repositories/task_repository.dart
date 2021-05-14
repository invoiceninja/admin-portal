import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/utils/serialization.dart';

class TaskRepository {
  const TaskRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<TaskEntity> loadItem(Credentials credentials, String entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/tasks/$entityId', credentials.token);

    final TaskItemResponse taskResponse = await compute<dynamic, dynamic>(
        SerializationUtils.computeDecode,
        <dynamic>[TaskItemResponse.serializer, response]);

    return taskResponse.data;
  }

  Future<BuiltList<TaskEntity>> loadList(
      Credentials credentials, int createdAt, bool filterDeleted) async {
    String url = credentials.url + '/tasks?created_at=$createdAt';

    if (filterDeleted) {
      url += '&filter_deleted_clients=true';
    }

    final dynamic response = await webClient.get(url, credentials.token);

    final TaskListResponse taskResponse = await compute<dynamic, dynamic>(
        SerializationUtils.computeDecode,
        <dynamic>[TaskListResponse.serializer, response]);

    return taskResponse.data;
  }

  Future<List<TaskEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    final url = credentials.url + '/tasks/bulk';
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids, 'action': action.toApiParam()}));

    final TaskListResponse taskResponse =
        serializers.deserializeWith(TaskListResponse.serializer, response);

    return taskResponse.data.toList();
  }

  Future<bool> sortTasks(Credentials credentials, List<String> statusIds,
      Map<String, List<String>> taskIds) async {
    final url = credentials.url + '/tasks/sort';

    await webClient.post(url, credentials.token,
        data: json.encode({'status_ids': statusIds, 'task_ids': taskIds}));

    return true;
  }

  Future<TaskEntity> saveData(Credentials credentials, TaskEntity task) async {
    final data = serializers.serializeWith(TaskEntity.serializer, task);

    dynamic response;

    if (task.isNew) {
      response = await webClient.post(
          credentials.url + '/tasks', credentials.token,
          data: json.encode(data));
    } else {
      final url = credentials.url + '/tasks/${task.id}';
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final TaskItemResponse taskResponse =
        serializers.deserializeWith(TaskItemResponse.serializer, response);

    return taskResponse.data;
  }

  Future<TaskEntity> uploadDocument(Credentials credentials, BaseEntity entity,
      MultipartFile multipartFile) async {
    final fields = <String, String>{
      '_method': 'put',
    };

    final dynamic response = await webClient.post(
        '${credentials.url}/tasks/${entity.id}/upload', credentials.token,
        data: fields, multipartFiles: [multipartFile]);

    final TaskItemResponse taskResponse =
        serializers.deserializeWith(TaskItemResponse.serializer, response);

    return taskResponse.data;
  }
}
