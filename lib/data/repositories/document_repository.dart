import 'dart:async';
import 'dart:core';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class DocumentRepository {
  const DocumentRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<DocumentEntity> loadItem(
      CompanyEntity company, AuthState auth, int entityId) async {
    final dynamic response =
        await webClient.get('${auth.url}/documents/$entityId', company.token);

    final DocumentItemResponse documentResponse =
        serializers.deserializeWith(DocumentItemResponse.serializer, response);

    return documentResponse.data;
  }

  Future<BuiltList<DocumentEntity>> loadList(
      CompanyEntity company, AuthState auth, int updatedAt) async {
    String url = auth.url + '/documents?';

    if (updatedAt > 0) {
      url += '&updated_at=${updatedAt - kUpdatedAtBufferSeconds}';
    }

    final dynamic response = await webClient.get(url, company.token);

    final DocumentListResponse documentResponse =
        serializers.deserializeWith(DocumentListResponse.serializer, response);

    return documentResponse.data;
  }

  Future<DocumentEntity> saveData(
      CompanyEntity company, AuthState auth, DocumentEntity document,
      [EntityAction action]) async {
    //final data = serializers.serializeWith(DocumentEntity.serializer, document);
    dynamic response;

    if (document.isNew) {
      final fields = <String, String>{};
      if (document.expenseId != null && document.expenseId > 0) {
        fields['expense_id'] = '${document.expenseId}';
      } else {
        fields['invoice_id'] = '${document.invoiceId}';
      }

      response = await webClient.post(
          auth.url + '/documents', company.token, fields, document.path);
    } else {
      /*
      var url = auth.url + '/documents/' + document.id.toString();
      if (action != null) {
        url += '?action=' + action.toString();
      }
      response = await webClient.put(url, company.token, json.encode(data));
      */
    }

    final DocumentItemResponse documentResponse =
        serializers.deserializeWith(DocumentItemResponse.serializer, response);

    return documentResponse.data;
  }
}
