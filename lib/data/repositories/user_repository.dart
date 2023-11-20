// Dart imports:
import 'dart:convert';
import 'dart:core';

// Package imports:
import 'package:built_collection/built_collection.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class UserRepository {
  const UserRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<UserEntity> loadItem(Credentials credentials, String? entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/users/$entityId?include=company_user',
        credentials.token);

    final UserItemResponse userResponse =
        serializers.deserializeWith(UserItemResponse.serializer, response)!;

    return userResponse.data;
  }

  Future<BuiltList<UserEntity>> loadList(Credentials credentials) async {
    final url = credentials.url+ '/users?include=company_user';

    final dynamic response = await webClient.get(url, credentials.token);

    final UserListResponse userResponse =
        serializers.deserializeWith(UserListResponse.serializer, response)!;

    return userResponse.data;
  }

  Future<List<UserEntity>> bulkAction(
    Credentials credentials,
    List<String> ids,
    EntityAction action,
    String? password,
    String? idToken,
  ) async {
    if (ids.length > kMaxEntitiesPerBulkAction && action.applyMaxLimit) {
      ids = ids.sublist(0, kMaxEntitiesPerBulkAction);
    }

    final url = credentials.url+
        '/users/bulk?per_page=$kMaxEntitiesPerBulkAction&include=company_user';
    final dynamic response = await webClient.post(
      url,
      credentials.token,
      data: json.encode({'ids': ids, 'action': action.toApiParam()}),
      password: password,
      idToken: idToken,
    );

    final UserListResponse userResponse =
        serializers.deserializeWith(UserListResponse.serializer, response)!;

    return userResponse.data.toList();
  }

  Future<List<UserEntity>> detachFromCompany(
    Credentials credentials,
    String? userId,
    String? password,
    String? idToken,
  ) async {
    final url = credentials.url+ '/users/$userId/detach_from_company';
    final dynamic response = await webClient.delete(
      url,
      credentials.token,
      password: password,
      idToken: idToken,
    );

    final UserListResponse userResponse =
        serializers.deserializeWith(UserListResponse.serializer, response)!;

    return userResponse.data.toList();
  }

  Future<List<UserEntity>?> resendInvite(
    Credentials credentials,
    String? userId,
    String? password,
    String? idToken,
  ) async {
    final url = credentials.url+ '/users/$userId/invite';
    final dynamic response = await webClient.post(
      url,
      credentials.token,
      password: password,
      idToken: idToken,
    );

    print('## invite: $response');
    /*
    final UserListResponse userResponse =
        serializers.deserializeWith(UserListResponse.serializer, response);

    return userResponse.data.toList();
    */

    return null;
  }

  Future<UserEntity> saveData(
    Credentials credentials,
    UserEntity user,
    String? password,
    String? idToken,
  ) async {
    final data = serializers.serializeWith(UserEntity.serializer, user);
    dynamic response;

    if (user.isNew) {
      response = await webClient.post(
        credentials.url+ '/users?include=company_user',
        credentials.token,
        data: json.encode(data),
        password: password,
        idToken: idToken,
      );
    } else {
      final url = credentials.url+ '/users/${user.id}?include=company_user';
      response = await webClient.put(
        url,
        credentials.token,
        data: json.encode(data),
        password: password,
        idToken: idToken,
      );
    }

    final UserItemResponse userResponse =
        serializers.deserializeWith(UserItemResponse.serializer, response)!;

    return userResponse.data;
  }
}
