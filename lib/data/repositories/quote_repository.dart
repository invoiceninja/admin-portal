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

  Future<InvoiceEntity> loadItem(
      CompanyEntity company, AuthState auth, int entityId) async {
    final dynamic response = await webClient.get(
        '${auth.url}/invoices/$entityId?include=invitations', company.token);

    final InvoiceItemResponse quoteResponse =
        serializers.deserializeWith(InvoiceItemResponse.serializer, response);

    return quoteResponse.data;
  }

  Future<BuiltList<InvoiceEntity>> loadList(
      CompanyEntity company, AuthState auth, int updatedAt) async {
    String url = auth.url + '/invoices?include=invitations&invoice_type_id=2&is_recurring=0';

    if (updatedAt > 0) {
      url += '&updated_at=${updatedAt - 600}';
    }

    final dynamic response = await webClient.get(url, company.token);

    final InvoiceListResponse quoteResponse =
        serializers.deserializeWith(InvoiceListResponse.serializer, response);

    return quoteResponse.data;
  }
  
  Future<InvoiceEntity> saveData(
      CompanyEntity company, AuthState auth, InvoiceEntity quote,
      [EntityAction action]) async {
    final data = serializers.serializeWith(InvoiceEntity.serializer, quote);
    dynamic response;

    if (quote.isNew) {
      response = await webClient.post(
          auth.url + '/invoices?include=invitations',
          company.token,
          json.encode(data));
    } else {
      var url = '${auth.url}/invoices/${quote.id}';
      if (action != null) {
        url += '?action=' + action.toString();
      }
      response = await webClient.put(url, company.token, json.encode(data));
    }

    final InvoiceItemResponse quoteResponse =
    serializers.deserializeWith(InvoiceItemResponse.serializer, response);

    return quoteResponse.data;
  }
}
