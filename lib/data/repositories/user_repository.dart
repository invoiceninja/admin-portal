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

  Future<UserEntity> loadItem(
      Credentials credentials, String entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/users/$entityId', credentials.token);

    final UserItemResponse userResponse =
        serializers.deserializeWith(UserItemResponse.serializer, response);

    return userResponse.data;
  }

  Future<BuiltList<UserEntity>> loadList(
      Credentials credentials, int updatedAt) async {
    String url = credentials.url + '/users?';

    if (updatedAt > 0) {
      url += '&updated_at=${updatedAt - kUpdatedAtBufferSeconds}';
    }

    final dynamic response = await webClient.get(url, credentials.token);

    final UserListResponse userResponse =
        serializers.deserializeWith(UserListResponse.serializer, response);

    return userResponse.data;
  }
  
  Future<UserEntity> saveData(
      Credentials credentials, UserEntity user,
      [EntityAction action]) async {
    final data = serializers.serializeWith(UserEntity.serializer, user);
    dynamic response;

    if (user.isNew) {
      response = await webClient.post(
          credentials.url + '/users',
          credentials.token,
          data: json.encode(data));
    } else {
      var url = credentials.url + '/users/' + user.id.toString();
      if (action != null) {
        url += '?action=' + action.toString();
      }
      response = await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final UserItemResponse userResponse =
    serializers.deserializeWith(UserItemResponse.serializer, response);

    return userResponse.data;
  }
}
