import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class QuoteRepository {
  final WebClient webClient;

  const QuoteRepository({
    this.webClient = const WebClient(),
  });

  Future<QuoteEntity> loadItem(
      CompanyEntity company, AuthState auth, int entityId) async {
    final dynamic response = await webClient.get(
        '${auth.url}/quotes/$entityId', company.token);

    final QuoteItemResponse quoteResponse =
        serializers.deserializeWith(QuoteItemResponse.serializer, response);

    return quoteResponse.data;
  }

  Future<BuiltList<QuoteEntity>> loadList(
      CompanyEntity company, AuthState auth, int updatedAt) async {
    String url = auth.url + '/quotes';

    if (updatedAt > 0) {
      url += '&updated_at=${updatedAt - 600}';
    }

    final dynamic response = await webClient.get(url, company.token);

    final QuoteListResponse quoteResponse =
        serializers.deserializeWith(QuoteListResponse.serializer, response);

    return quoteResponse.data;
  }
  
  Future<QuoteEntity> saveData(
      CompanyEntity company, AuthState auth, QuoteEntity quote,
      [EntityAction action]) async {
    final data = serializers.serializeWith(QuoteEntity.serializer, quote);
    dynamic response;

    if (quote.isNew) {
      response = await webClient.post(
          auth.url + '/quotes',
          company.token,
          json.encode(data));
    } else {
      var url = auth.url + '/quotes/' + quote.id.toString();
      if (action != null) {
        url += '?action=' + action.toString();
      }
      response = await webClient.put(url, company.token, json.encode(data));
    }

    final QuoteItemResponse quoteResponse =
    serializers.deserializeWith(QuoteItemResponse.serializer, response);

    return quoteResponse.data;
  }
}
