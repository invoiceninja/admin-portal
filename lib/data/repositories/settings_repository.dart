import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class SettingsRepository {
  const SettingsRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<LoginResponse> saveCompany(
      Credentials credentials, CompanyEntity company,
      [EntityAction action]) async {
    final data = serializers.serializeWith(CompanyEntity.serializer, company);
    dynamic response;

    final url = credentials.url + '/companies/${company.id}';
    response = await webClient.put(url, credentials.token, json.encode(data));

    final LoginResponse clientResponse =
        serializers.deserializeWith(LoginResponse.serializer, response);

    return clientResponse;
  }

  Future<LoginResponse> saveUser(
      Credentials credentials, UserEntity user) async {
    final data = serializers.serializeWith(UserEntity.serializer, user);
    dynamic response;

    final url = credentials.url + '/users/${user.id}';
    response = await webClient.put(url, credentials.token, json.encode(data));

    final LoginResponse clientResponse =
        serializers.deserializeWith(LoginResponse.serializer, response);

    return clientResponse;
  }
}
