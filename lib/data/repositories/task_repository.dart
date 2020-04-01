import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class TaskRepository {
  const TaskRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<TaskEntity> loadItem(Credentials credentials, String entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/tasks/$entityId', credentials.token);

    final TaskItemResponse taskResponse =
        serializers.deserializeWith(TaskItemResponse.serializer, response);

    return taskResponse.data;
  }

  Future<BuiltList<TaskEntity>> loadList(
      Credentials credentials, int updatedAt) async {
    String url = credentials.url + '/tasks?';

    if (updatedAt > 0) {
      url += '&updated_at=${updatedAt - kUpdatedAtBufferSeconds}';
    }

    final dynamic response = await webClient.get(url, credentials.token);

    final TaskListResponse taskResponse =
        serializers.deserializeWith(TaskListResponse.serializer, response);

    return taskResponse.data;
  }

  Future<List<TaskEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    var url = credentials.url + '/tasks/bulk?';
    if (action != null) {
      url += '&action=' + action.toString();
    }
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids}));

    final TaskListResponse taskResponse =
        serializers.deserializeWith(TaskListResponse.serializer, response);

    return taskResponse.data.toList();
  }

  Future<TaskEntity> saveData(Credentials credentials, TaskEntity task) async {
    // Workaround for API issue
    if (task.isNew) {
      task = task.rebuild((b) => b..id = null);
    }

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
}
