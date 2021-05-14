import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/utils/serialization.dart';

class QuoteRepository {
  const QuoteRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<InvoiceEntity> loadItem(
      Credentials credentials, String entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/quotes/$entityId?include=history,activities',
        credentials.token);

    final InvoiceItemResponse quoteResponse = await compute<dynamic, dynamic>(
        SerializationUtils.computeDecode,
        <dynamic>[InvoiceItemResponse.serializer, response]);

    return quoteResponse.data;
  }

  Future<BuiltList<InvoiceEntity>> loadList(
      Credentials credentials, int createdAt, bool filterDeleted) async {
    String url = credentials.url + '/quotes?created_at=$createdAt';

    if (filterDeleted) {
      url += '&filter_deleted_clients=true';
    }

    final dynamic response = await webClient.get(url, credentials.token);

    final InvoiceListResponse quoteResponse = await compute<dynamic, dynamic>(
        SerializationUtils.computeDecode,
        <dynamic>[InvoiceListResponse.serializer, response]);

    return quoteResponse.data;
  }

  Future<List<InvoiceEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    final url = credentials.url + '/quotes/bulk';
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids, 'action': action.toApiParam()}));

    final InvoiceListResponse invoiceResponse =
        serializers.deserializeWith(InvoiceListResponse.serializer, response);

    return invoiceResponse.data.toList();
  }

  Future<InvoiceEntity> saveData(
      Credentials credentials, InvoiceEntity quote) async {
    quote = quote.rebuild((b) => b..documents.clear());
    final data = serializers.serializeWith(InvoiceEntity.serializer, quote);
    dynamic response;

    if (quote.isNew) {
      response = await webClient.post(
          credentials.url + '/quotes?include=history,activities',
          credentials.token,
          data: json.encode(data));
    } else {
      final url =
          '${credentials.url}/quotes/${quote.id}?include=history,activities';
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final InvoiceItemResponse quoteResponse =
        serializers.deserializeWith(InvoiceItemResponse.serializer, response);

    return quoteResponse.data;
  }

  Future<InvoiceEntity> emailQuote(Credentials credentials, InvoiceEntity quote,
      EmailTemplate template, String subject, String body) async {
    final data = {
      'entity': '${quote.entityType}',
      'entity_id': quote.id,
      'template': 'email_template_$template',
      'body': body,
      'subject': subject,
    };

    final dynamic response = await webClient.post(
        credentials.url + '/emails', credentials.token,
        data: json.encode(data));

    final InvoiceItemResponse invoiceResponse =
        serializers.deserializeWith(InvoiceItemResponse.serializer, response);

    return invoiceResponse.data;
  }

  Future<InvoiceEntity> uploadDocument(Credentials credentials,
      BaseEntity entity, MultipartFile multipartFile) async {
    final fields = <String, String>{
      '_method': 'put',
    };

    final dynamic response = await webClient.post(
        '${credentials.url}/quotes/${entity.id}/upload', credentials.token,
        data: fields, multipartFiles: [multipartFile]);

    final InvoiceItemResponse invoiceResponse =
        serializers.deserializeWith(InvoiceItemResponse.serializer, response);

    return invoiceResponse.data;
  }
}
