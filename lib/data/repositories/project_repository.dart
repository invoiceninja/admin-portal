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

class ProjectRepository {
  const ProjectRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<ProjectEntity> loadItem(
      Credentials credentials, String entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/projects/$entityId', credentials.token);

    final ProjectItemResponse projectResponse = await compute<dynamic, dynamic>(
        SerializationUtils.computeDecode,
        <dynamic>[ProjectItemResponse.serializer, response]);

    return projectResponse.data;
  }

  Future<BuiltList<ProjectEntity>> loadList(
      Credentials credentials, int createdAt, bool filterDeleted) async {
    String url = credentials.url + '/projects?created_at=$createdAt';

    if (filterDeleted) {
      url += '&filter_deleted_clients=true';
    }

    final dynamic response = await webClient.get(url, credentials.token);

    final ProjectListResponse projectResponse = await compute<dynamic, dynamic>(
        SerializationUtils.computeDecode,
        <dynamic>[ProjectListResponse.serializer, response]);

    return projectResponse.data;
  }

  Future<List<ProjectEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    final url = credentials.url + '/projects/bulk';
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids, 'action': action.toApiParam()}));

    final ProjectListResponse projectResponse =
        serializers.deserializeWith(ProjectListResponse.serializer, response);

    return projectResponse.data.toList();
  }

  Future<ProjectEntity> saveData(
      Credentials credentials, ProjectEntity project) async {
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

  Future<ProjectEntity> uploadDocument(Credentials credentials,
      BaseEntity entity, MultipartFile multipartFile) async {
    final fields = <String, String>{
      '_method': 'put',
    };

    final dynamic response = await webClient.post(
        '${credentials.url}/projects/${entity.id}/upload', credentials.token,
        data: fields, multipartFiles: [multipartFile]);

    final ProjectItemResponse projectResponse =
        serializers.deserializeWith(ProjectItemResponse.serializer, response);

    return projectResponse.data;
  }
}
