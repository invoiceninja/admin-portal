import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class TokenRepository {
  const TokenRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<TokenEntity> loadItem(Credentials credentials, String entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/tokens/$entityId', credentials.token);

    final TokenItemResponse tokenResponse =
        serializers.deserializeWith(TokenItemResponse.serializer, response);

    return tokenResponse.data;
  }

  Future<BuiltList<TokenEntity>> loadList(Credentials credentials) async {
    final url = credentials.url + '/tokens?';

    final dynamic response = await webClient.get(url, credentials.token);

    final TokenListResponse tokenResponse =
        serializers.deserializeWith(TokenListResponse.serializer, response);

    return tokenResponse.data;
  }

  Future<List<TokenEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    final url = credentials.url + '/tokens/bulk';
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids, 'action': action.toApiParam()}));

    final TokenListResponse tokenResponse =
        serializers.deserializeWith(TokenListResponse.serializer, response);

    return tokenResponse.data.toList();
  }

  Future<TokenEntity> saveData(
    Credentials credentials,
    TokenEntity token,
    String password,
    String idToken,
  ) async {
    final data = serializers.serializeWith(TokenEntity.serializer, token);
    dynamic response;

    if (token.isNew) {
      response = await webClient.post(
        credentials.url + '/tokens',
        credentials.token,
        data: json.encode(data),
        password: password,
        idToken: idToken,
      );
    } else {
      final url = '${credentials.url}/tokens/${token.id}';
      response = await webClient.put(
        url,
        credentials.token,
        data: json.encode(data),
        password: password,
        idToken: idToken,
      );
    }

    final TokenItemResponse tokenResponse =
        serializers.deserializeWith(TokenItemResponse.serializer, response);

    return tokenResponse.data;
  }
}
