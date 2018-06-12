import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'package:invoiceninja/data/models/serializers.dart';
import 'package:built_collection/built_collection.dart';

import 'package:invoiceninja/redux/auth/auth_state.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/data/web_client.dart';

class ProjectsRepository {
  final WebClient webClient;

  const ProjectsRepository({
    this.webClient = const WebClient(),
  });

  Future<BuiltList<ProjectEntity>> loadList(CompanyEntity company, AuthState auth) async {

    final response = await webClient.get(
        auth.url + '/projects?per_page=500', company.token);

    ProjectListResponse projectResponse = serializers.deserializeWith(
        ProjectListResponse.serializer, response);

    return projectResponse.data;
  }

  Future saveData(CompanyEntity company, AuthState auth, ProjectEntity project, [EntityAction action]) async {

    var data = serializers.serializeWith(ProjectEntity.serializer, project);
    var response;

    if (project.id == null) {
      response = await webClient.post(
          auth.url + '/projects', company.token, json.encode(data));
    } else {
      var url = auth.url + '/projects/' + project.id.toString();
      if (action != null) {
        url += '?action=' + action.toString();
      }
      response = await webClient.put(url, company.token, json.encode(data));
    }

    ProjectItemResponse projectResponse = serializers.deserializeWith(
        ProjectItemResponse.serializer, response);

    return projectResponse.data;
  }
}