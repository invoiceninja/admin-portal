import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class DocumentRepository {
  const DocumentRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<DocumentEntity> loadItem(
      Credentials credentials, String entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/documents/$entityId', credentials.token);

    final DocumentItemResponse documentResponse =
        serializers.deserializeWith(DocumentItemResponse.serializer, response);

    return documentResponse.data;
  }

  Future<BuiltList<DocumentEntity>> loadList(Credentials credentials) async {
    final url = credentials.url + '/documents?';

    final dynamic response = await webClient.get(url, credentials.token);

    final DocumentListResponse documentResponse =
        serializers.deserializeWith(DocumentListResponse.serializer, response);

    return documentResponse.data;
  }

  Future<List<DocumentEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    final url = credentials.url + '/documents/bulk';
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids, 'action': action.toApiParam()}));

    final DocumentListResponse documentResponse =
        serializers.deserializeWith(DocumentListResponse.serializer, response);

    return documentResponse.data.toList();
  }

  Future<bool> delete(Credentials credentials, String documentId,
      String password, String idToken) async {
    await webClient.delete(
      '${credentials.url}/documents/$documentId',
      credentials.token,
      password: password,
      idToken: idToken,
    );

    return true;
  }
}
