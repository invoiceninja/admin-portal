import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class SettingsRepository {
  const SettingsRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<CompanyEntity> saveCompany(
      Credentials credentials, CompanyEntity company) async {
    final data = serializers.serializeWith(CompanyEntity.serializer, company);
    dynamic response;

    final url = credentials.url + '/companies/${company.id}';
    response =
        await webClient.put(url, credentials.token, data: json.encode(data));

    final CompanyItemResponse companyResponse =
        serializers.deserializeWith(CompanyItemResponse.serializer, response);

    return companyResponse.data;
  }

  Future<UserEntity> saveAuthUser(
      Credentials credentials, UserEntity user, String password) async {
    final data = serializers.serializeWith(UserEntity.serializer, user);
    dynamic response;

    final url = credentials.url + '/users/${user.id}?include=company_user';
    response = await webClient.put(
      url,
      credentials.token,
      data: json.encode(data),
      password: password,
    );

    final UserItemResponse userResponse =
        serializers.deserializeWith(UserItemResponse.serializer, response);

    return userResponse.data;
  }

  Future<UserCompanyEntity> saveUserSettings(
      Credentials credentials, UserEntity user) async {
    final data = serializers.serializeWith(UserEntity.serializer, user);
    dynamic response;

    final url = credentials.url + '/company_users/${user.id}';
    response = await webClient.put(
      url,
      credentials.token,
      data: json.encode(data),
    );

    final UserCompanyItemResponse userResponse = serializers.deserializeWith(
        UserCompanyItemResponse.serializer, response);

    return userResponse.data;
  }

  Future<BaseEntity> uploadLogo(Credentials credentials, String entityId,
      String path, EntityType type) async {
    final route = type == EntityType.company
        ? 'companies'
        : type == EntityType.group ? 'group_settings' : 'clients';
    final url = '${credentials.url}/$route/$entityId';

    final dynamic response = await webClient.post(url, credentials.token,
        data: {'_method': 'PUT'}, filePath: path, fileIndex: 'company_logo');

    if (type == EntityType.client) {
      return serializers
          .deserializeWith(ClientItemResponse.serializer, response)
          .data;
    } else if (type == EntityType.group) {
      return serializers
          .deserializeWith(GroupItemResponse.serializer, response)
          .data;
    } else {
      return serializers
          .deserializeWith(CompanyItemResponse.serializer, response)
          .data;
    }
  }
}
