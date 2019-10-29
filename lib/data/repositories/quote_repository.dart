import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class QuoteRepository {
  const QuoteRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<InvoiceEntity> loadItem(
      Credentials credentials, String entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/invoices/$entityId?include=invitations',
        credentials.token);

    final InvoiceItemResponse quoteResponse =
        serializers.deserializeWith(InvoiceItemResponse.serializer, response);

    return quoteResponse.data;
  }

  Future<BuiltList<InvoiceEntity>> loadList(
      Credentials credentials, int updatedAt) async {
    String url = credentials.url +
        '/invoices?include=invitations&invoice_type_id=2&is_recurring=0';

    if (updatedAt > 0) {
      url += '&updated_at=${updatedAt - kUpdatedAtBufferSeconds}';
    }

    final dynamic response = await webClient.get(url, credentials.token);

    final InvoiceListResponse quoteResponse =
        serializers.deserializeWith(InvoiceListResponse.serializer, response);

    return quoteResponse.data;
  }

  Future<List<InvoiceEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    dynamic response;

    switch (action) {
      case EntityAction.restore:
      case EntityAction.archive:
      case EntityAction.delete:
        var url = credentials.url + '/quotes/bulk?include=activities';
        if (action != null) {
          url += '&action=' + action.toString();
        }
        response = await webClient.put(url, credentials.token,
            data: json.encode([ids]));
        break;
      default:
      // Might have other actions in the future
        break;
    }

    final InvoiceListResponse invoiceResponse =
    serializers.deserializeWith(InvoiceListResponse.serializer, response);

    return invoiceResponse.data.toList();
  }

  Future<InvoiceEntity> saveData(Credentials credentials, InvoiceEntity quote,
      [EntityAction action]) async {
    final data = serializers.serializeWith(InvoiceEntity.serializer, quote);
    dynamic response;

    if (quote.isNew) {
      response = await webClient.post(
          credentials.url + '/invoices?include=invitations', credentials.token,
          data: json.encode(data));
    } else {
      var url = '${credentials.url}/invoices/${quote.id}';
      if (action != null) {
        url += '?action=' + action.toString();
      }
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final InvoiceItemResponse quoteResponse =
        serializers.deserializeWith(InvoiceItemResponse.serializer, response);

    return quoteResponse.data;
  }

  Future<Null> emailQuote(Credentials credentials, InvoiceEntity quote,
      EmailTemplate template, String subject, String body) async {
    final data = {
      'reminder': template == EmailTemplate.initial ? '' : template.toString(),
      'template': {
        'body': body,
        'subject': subject,
      }
    };

    await webClient.post(
        credentials.url + '/email_invoice?invoice_id=${quote.id}',
        credentials.token,
        data: json.encode(data));
  }
}
