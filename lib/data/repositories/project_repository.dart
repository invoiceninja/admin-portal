import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class ProjectRepository {
  const ProjectRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<ProjectEntity> loadItem(
      CompanyEntity company, AuthState auth, int entityId) async {
    final dynamic response = await webClient.get(
        '${auth.url}/projects/$entityId', company.token);

    final ProjectItemResponse projectResponse =
        serializers.deserializeWith(ProjectItemResponse.serializer, response);

    return projectResponse.data;
  }

  Future<BuiltList<ProjectEntity>> loadList(
      CompanyEntity company, AuthState auth, int updatedAt) async {
    String url = auth.url + '/projects?';

    if (updatedAt > 0) {
      url += '&updated_at=${updatedAt - kUpdatedAtBufferSeconds}';
    }

    final dynamic response = await webClient.get(url, company.token);

    final ProjectListResponse projectResponse =
        serializers.deserializeWith(ProjectListResponse.serializer, response);

    return projectResponse.data;
  }
  
  Future<ProjectEntity> saveData(
      CompanyEntity company, AuthState auth, ProjectEntity project,
      [EntityAction action]) async {
    final data = serializers.serializeWith(ProjectEntity.serializer, project);
    dynamic response;

    if (project.isNew) {
      response = await webClient.post(
          auth.url + '/projects',
          company.token,
          json.encode(data));
    } else {
      var url = auth.url + '/projects/' + project.id.toString();
      if (action != null) {
        url += '?action=' + action.toString();
      }
      response = await webClient.put(url, company.token, json.encode(data));
    }

    final ProjectItemResponse projectResponse =
    serializers.deserializeWith(ProjectItemResponse.serializer, response);

    return projectResponse.data;
  }
}
