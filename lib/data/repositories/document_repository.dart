// Dart imports:
import 'dart:convert';
import 'dart:core';
import 'dart:typed_data';

// Package imports:
import 'package:built_collection/built_collection.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class DocumentRepository {
  const DocumentRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<DocumentEntity> loadItem(
      Credentials credentials, String? entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/documents/$entityId', credentials.token);

    final DocumentItemResponse documentResponse =
        serializers.deserializeWith(DocumentItemResponse.serializer, response)!;

    return documentResponse.data;
  }

  Future<Uint8List?> loadData(
      Credentials credentials, DocumentEntity document) async {
    final url = '${cleanApiUrl(credentials.url)}/documents/${document.hash}';
    final dynamic response =
        await WebClient().get(url, credentials.token, rawResponse: true);

    return response.bodyBytes;
  }

  Future<BuiltList<DocumentEntity>> loadList(Credentials credentials) async {
    final url = credentials.url+ '/documents?';

    final dynamic response = await webClient.get(url, credentials.token);

    final DocumentListResponse documentResponse =
        serializers.deserializeWith(DocumentListResponse.serializer, response)!;

    return documentResponse.data;
  }

  Future<DocumentEntity> saveData(
      Credentials credentials, DocumentEntity document) async {
    final data = serializers.serializeWith(DocumentEntity.serializer, document);
    dynamic response;

    final url = credentials.url+ '/documents/${document.id}';

    response =
        await webClient.put(url, credentials.token, data: json.encode(data));

    final DocumentItemResponse documentResponse =
        serializers.deserializeWith(DocumentItemResponse.serializer, response)!;

    return documentResponse.data;
  }

  Future<List<DocumentEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    if (ids.length > kMaxEntitiesPerBulkAction && action.applyMaxLimit) {
      ids = ids.sublist(0, kMaxEntitiesPerBulkAction);
    }

    final url = credentials.url+
        '/documents/bulk?per_page=$kMaxEntitiesPerBulkAction';
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids, 'action': action.toApiParam()}));

    final DocumentListResponse documentResponse =
        serializers.deserializeWith(DocumentListResponse.serializer, response)!;

    return documentResponse.data.toList();
  }

  Future<bool> delete(Credentials credentials, String documentId,
      String? password, String? idToken) async {
    await webClient.delete(
      '${credentials.url}/documents/$documentId',
      credentials.token,
      password: password,
      idToken: idToken,
    );

    return true;
  }
}
