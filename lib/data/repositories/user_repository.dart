import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class UserRepository {
  const UserRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<UserEntity> loadItem(Credentials credentials, String entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/users/$entityId?include=company_user',
        credentials.token);

    final UserItemResponse userResponse =
        serializers.deserializeWith(UserItemResponse.serializer, response);

    return userResponse.data;
  }

  Future<BuiltList<UserEntity>> loadList(
      Credentials credentials, int updatedAt) async {
    String url = credentials.url + '/users?include=company_user';

    if (updatedAt > 0) {
      url += '&updated_at=${updatedAt - kUpdatedAtBufferSeconds}';
    }

    final dynamic response = await webClient.get(url, credentials.token);

    final UserListResponse userResponse =
        serializers.deserializeWith(UserListResponse.serializer, response);

    return userResponse.data;
  }

  Future<List<UserEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action, String password) async {
    var url = credentials.url + '/users/bulk?include=company_user';
    if (action != null) {
      url += '&action=' + action.toString();
    }
    final dynamic response = await webClient.post(url, credentials.token,
        password: password, data: json.encode({'ids': ids}));

    final UserListResponse userResponse =
        serializers.deserializeWith(UserListResponse.serializer, response);

    return userResponse.data.toList();
  }

  Future<List<UserEntity>> detachFromCompany(
      Credentials credentials, String userId) async {
    final url = credentials.url + '/users/$userId/detachFromCompany';
    final dynamic response = await webClient.delete(url, credentials.token);

    final UserListResponse userResponse =
        serializers.deserializeWith(UserListResponse.serializer, response);

    return userResponse.data.toList();
  }

  Future<UserEntity> saveData(
      Credentials credentials, UserEntity user, String password) async {
    final data = serializers.serializeWith(UserEntity.serializer, user);
    dynamic response;

    if (user.isNew) {
      response = await webClient.post(
        credentials.url + '/users?include=company_user',
        credentials.token,
        data: json.encode(data),
        password: password,
      );
    } else {
      final url = credentials.url +
          '/users/${user.id}?include=company_user';
      response = await webClient.put(
        url,
        credentials.token,
        data: json.encode(data),
        password: password,
      );
    }

    final UserItemResponse userResponse =
        serializers.deserializeWith(UserItemResponse.serializer, response);

    return userResponse.data;
  }
}
