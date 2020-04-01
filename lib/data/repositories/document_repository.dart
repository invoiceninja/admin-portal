import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
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

  Future<BuiltList<DocumentEntity>> loadList(
      Credentials credentials, int updatedAt) async {
    String url = credentials.url + '/documents?';

    if (updatedAt > 0) {
      url += '&updated_at=${updatedAt - kUpdatedAtBufferSeconds}';
    }

    final dynamic response = await webClient.get(url, credentials.token);

    final DocumentListResponse documentResponse =
        serializers.deserializeWith(DocumentListResponse.serializer, response);

    return documentResponse.data;
  }

  Future<List<DocumentEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    var url = credentials.url + '/documents/bulk?';
    if (action != null) {
      url += '&action=' + action.toString();
    }
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids}));

    final DocumentListResponse documentResponse =
        serializers.deserializeWith(DocumentListResponse.serializer, response);

    return documentResponse.data.toList();
  }

  Future<DocumentEntity> saveData(
      Credentials credentials, DocumentEntity document) async {
    dynamic response;

    if (document.isNew) {
      final fields = <String, String>{};
      if (document.expenseId != null && document.expenseId.isNotEmpty) {
        fields['expense_id'] = '${document.expenseId}';
      } else {
        fields['invoice_id'] = '${document.invoiceId}';
      }

      response = await webClient.post(
          '${credentials.url}/documents', credentials.token,
          data: fields, filePath: document.path);
    } else {
      final data =
          serializers.serializeWith(DocumentEntity.serializer, document);
      final url = '${credentials.url}/documents/${document.id}?';
      response =
      await webClient.put(url, credentials.token, data: json.encode(data));

      /*
      if (action == EntityAction.delete) {
        response = await webClient.delete(url, credentials.token);
      } else {
        if (action != null) {
          url += '&action=$action';
        }
        response = await webClient.put(url, credentials.token,
            data: json.encode(data));
      }
       */
    }

    final DocumentItemResponse documentResponse =
        serializers.deserializeWith(DocumentItemResponse.serializer, response);

    return documentResponse.data;
  }
}
