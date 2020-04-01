import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class ProjectRepository {
  const ProjectRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<ProjectEntity> loadItem(
      Credentials credentials, String entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/projects/$entityId', credentials.token);

    final ProjectItemResponse projectResponse =
        serializers.deserializeWith(ProjectItemResponse.serializer, response);

    return projectResponse.data;
  }

  Future<BuiltList<ProjectEntity>> loadList(
      Credentials credentials, int updatedAt) async {
    String url = credentials.url + '/projects?';

    if (updatedAt > 0) {
      url += '&updated_at=${updatedAt - kUpdatedAtBufferSeconds}';
    }

    final dynamic response = await webClient.get(url, credentials.token);

    final ProjectListResponse projectResponse =
        serializers.deserializeWith(ProjectListResponse.serializer, response);

    return projectResponse.data;
  }

  Future<List<ProjectEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    var url = credentials.url + '/projects/bulk?';
    if (action != null) {
      url += '&action=' + action.toString();
    }
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids}));

    final ProjectListResponse projectResponse =
        serializers.deserializeWith(ProjectListResponse.serializer, response);

    return projectResponse.data.toList();
  }

  Future<ProjectEntity> saveData(Credentials credentials, ProjectEntity project) async {
    final data = serializers.serializeWith(ProjectEntity.serializer, project);
    dynamic response;

    if (project.isNew) {
      response = await webClient.post(
          credentials.url + '/projects', credentials.token,
          data: json.encode(data));
    } else {
      final url = credentials.url + '/projects/${project.id}';
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final ProjectItemResponse projectResponse =
        serializers.deserializeWith(ProjectItemResponse.serializer, response);

    return projectResponse.data;
  }
}
