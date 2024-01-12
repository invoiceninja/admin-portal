// Dart imports:
import 'dart:convert';
import 'dart:core';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:http/http.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/serialization.dart';

class QuoteRepository {
  const QuoteRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<InvoiceEntity> loadItem(
      Credentials credentials, String? entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/quotes/$entityId?include=activities.history',
        credentials.token);

    final InvoiceItemResponse quoteResponse = await compute<dynamic, dynamic>(
        SerializationUtils.deserializeWith,
        <dynamic>[InvoiceItemResponse.serializer, response]);

    return quoteResponse.data;
  }

  Future<BuiltList<InvoiceEntity>> loadList(Credentials credentials, int page,
      int createdAt, bool filterDeleted) async {
    String url = credentials.url +
        '/quotes?per_page=$kMaxRecordsPerPage&page=$page&created_at=$createdAt';

    if (filterDeleted) {
      url += '&filter_deleted_clients=true';
    }

    final dynamic response = await webClient.get(url, credentials.token);

    final InvoiceListResponse quoteResponse = await compute<dynamic, dynamic>(
        SerializationUtils.deserializeWith,
        <dynamic>[InvoiceListResponse.serializer, response]);

    return quoteResponse.data;
  }

  Future<List<InvoiceEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action,
      {EmailTemplate? template}) async {
    if (ids.length > kMaxEntitiesPerBulkAction && action.applyMaxLimit) {
      ids = ids.sublist(0, kMaxEntitiesPerBulkAction);
    }

    final url =
        credentials.url + '/quotes/bulk?per_page=$kMaxEntitiesPerBulkAction';
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({
          'ids': ids,
          'action': action.toApiParam(),
          if (template != null) 'email_type': 'email_template_$template',
        }));

    final InvoiceListResponse invoiceResponse =
        serializers.deserializeWith(InvoiceListResponse.serializer, response)!;

    return invoiceResponse.data.toList();
  }

  Future<InvoiceEntity> saveData(
    Credentials credentials,
    InvoiceEntity quote,
    EntityAction? action,
  ) async {
    quote = quote.rebuild((b) => b..documents.clear());
    final data = serializers.serializeWith(InvoiceEntity.serializer, quote);
    String url;
    dynamic response;

    if (quote.isNew) {
      url = credentials.url + '/quotes?include=activities.history';
    } else {
      url = '${credentials.url}/quotes/${quote.id}?include=activities.history';
    }

    if (action == EntityAction.convertToInvoice) {
      url += '&convert=true';
    } else if (action == EntityAction.markSent) {
      url += '&mark_sent=true';
    } else if (action == EntityAction.approve) {
      url += '&approve=true';
    }

    if (quote.saveDefaultTerms) {
      url += '&save_default_terms=true';
    }
    if (quote.saveDefaultFooter) {
      url += '&save_default_footer=true';
    }

    if (quote.isNew) {
      response =
          await webClient.post(url, credentials.token, data: json.encode(data));
    } else {
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final InvoiceItemResponse quoteResponse =
        serializers.deserializeWith(InvoiceItemResponse.serializer, response)!;

    return quoteResponse.data;
  }

  Future<InvoiceEntity> emailQuote(
    Credentials credentials,
    InvoiceEntity quote,
    EmailTemplate template,
    String subject,
    String body,
    String ccEmail,
  ) async {
    final data = {
      'entity': '${EntityType.quote.apiValue}',
      'entity_id': quote.id,
      'template': 'email_template_$template',
      'body': body,
      'subject': subject,
      'cc_email': ccEmail,
    };

    final dynamic response = await webClient.post(
        credentials.url + '/emails', credentials.token,
        data: json.encode(data));

    final InvoiceItemResponse invoiceResponse =
        serializers.deserializeWith(InvoiceItemResponse.serializer, response)!;

    return invoiceResponse.data;
  }

  Future<InvoiceEntity> uploadDocument(
      Credentials credentials,
      BaseEntity entity,
      List<MultipartFile> multipartFiles,
      bool isPrivate) async {
    final fields = <String, String>{
      '_method': 'put',
      'is_public': isPrivate ? '0' : '1',
    };

    final dynamic response = await webClient.post(
        '${credentials.url}/quotes/${entity.id}/upload', credentials.token,
        data: fields, multipartFiles: multipartFiles);

    final InvoiceItemResponse invoiceResponse =
        serializers.deserializeWith(InvoiceItemResponse.serializer, response)!;

    return invoiceResponse.data;
  }
}
