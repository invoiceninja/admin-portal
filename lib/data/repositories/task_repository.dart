import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'package:invoiceninja/data/models/serializers.dart';
import 'package:built_collection/built_collection.dart';

import 'package:invoiceninja/redux/auth/auth_state.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/data/web_client.dart';

class TasksRepository {
  final WebClient webClient;

  const TasksRepository({
    this.webClient = const WebClient(),
  });

  Future<BuiltList<TaskEntity>> loadList(CompanyEntity company, AuthState auth) async {

    final Future<dynamic> response = await webClient.get(
        auth.url + '/tasks?per_page=500', company.token);

    TaskListResponse taskResponse = serializers.deserializeWith(
        TaskListResponse.serializer, response);

    return taskResponse.data;
  }

  Future saveData(CompanyEntity company, AuthState auth, TaskEntity task, [EntityAction action]) async {

    var data = serializers.serializeWith(TaskEntity.serializer, task);
    Future<dynamic> response;

    if (task.isNew) {
      response = await webClient.post(
          auth.url + '/tasks', company.token, json.encode(data));
    } else {
      var url = auth.url + '/tasks/' + task.id.toString();
      if (action != null) {
        url += '?action=' + action.toString();
      }
      response = await webClient.put(url, company.token, json.encode(data));
    }

    TaskItemResponse taskResponse = serializers.deserializeWith(
        TaskItemResponse.serializer, response);

    return taskResponse.data;
  }
}