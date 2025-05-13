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

class CreditRepository {
  const CreditRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<InvoiceEntity> loadItem(
      Credentials credentials, String? entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/credits/$entityId?include=activities.history',
        credentials.token);

    final InvoiceItemResponse creditResponse = await compute<dynamic, dynamic>(
        SerializationUtils.deserializeWith,
        <dynamic>[InvoiceItemResponse.serializer, response]);

    return creditResponse.data;
  }

  Future<BuiltList<InvoiceEntity>> loadList(Credentials credentials, int page,
      int createdAt, bool filterDeleted) async {
    String url = credentials.url +
        '/credits?per_page=$kMaxRecordsPerPage&page=$page&created_at=$createdAt';

    if (filterDeleted) {
      url += '&filter_deleted_clients=true';
    }

    final dynamic response = await webClient.get(url, credentials.token);

    final InvoiceListResponse creditResponse = await compute<dynamic, dynamic>(
        SerializationUtils.deserializeWith,
        <dynamic>[InvoiceListResponse.serializer, response]);

    return creditResponse.data;
  }

  Future<List<InvoiceEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action,
      {EmailTemplate? template}) async {
    if (ids.length > kMaxEntitiesPerBulkAction && action.applyMaxLimit) {
      ids = ids.sublist(0, kMaxEntitiesPerBulkAction);
    }

    final url =
        credentials.url + '/credits/bulk?per_page=$kMaxEntitiesPerBulkAction';
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
    InvoiceEntity credit,
    EntityAction? action,
  ) async {
    credit = credit.rebuild((b) => b..documents.clear());
    final data = serializers.serializeWith(InvoiceEntity.serializer, credit);
    String url;
    dynamic response;

    if (credit.isNew) {
      url = credentials.url + '/credits?include=activities.history';
    } else {
      url =
          '${credentials.url}/credits/${credit.id}?include=activities.history';
    }

    if (action == EntityAction.markPaid) {
      url += '&mark_paid=true';
    } else if (action == EntityAction.markSent) {
      url += '&mark_sent=true';
    }

    if (credit.isNew) {
      response =
          await webClient.post(url, credentials.token, data: json.encode(data));
    } else {
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final InvoiceItemResponse creditResponse =
        serializers.deserializeWith(InvoiceItemResponse.serializer, response)!;

    return creditResponse.data;
  }

  Future<InvoiceEntity> emailCredit(
    Credentials credentials,
    InvoiceEntity credit,
    EmailTemplate template,
    String subject,
    String body,
    String ccEmail,
  ) async {
    final data = {
      'entity': '${EntityType.credit.apiValue}',
      'entity_id': credit.id,
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

  Future<InvoiceEntity> uploadDocuments(
      Credentials credentials,
      BaseEntity entity,
      List<MultipartFile> multipartFiles,
      bool isPrivate) async {
    final fields = <String, String>{
      '_method': 'put',
      'is_public': isPrivate ? '0' : '1',
    };

    final dynamic response = await webClient.post(
        '${credentials.url}/credits/${entity.id}/upload', credentials.token,
        data: fields, multipartFiles: multipartFiles);

    final InvoiceItemResponse invoiceResponse =
        serializers.deserializeWith(InvoiceItemResponse.serializer, response)!;

    return invoiceResponse.data;
  }
}
