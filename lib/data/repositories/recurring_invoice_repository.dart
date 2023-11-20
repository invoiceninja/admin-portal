// Dart imports:
import 'dart:convert';
import 'dart:core';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:http/http.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class RecurringInvoiceRepository {
  const RecurringInvoiceRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<InvoiceEntity> loadItem(
      Credentials credentials, String? entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/recurring_invoices/$entityId?include=activities,history&show_dates=true',
        credentials.token);

    final InvoiceItemResponse recurringInvoiceResponse =
        serializers.deserializeWith(InvoiceItemResponse.serializer, response)!;

    return recurringInvoiceResponse.data;
  }

  Future<BuiltList<InvoiceEntity>> loadList(
      Credentials credentials, int page, bool filterDeleted) async {
    String url = credentials.url+
        '/recurring_invoices?per_page=$kMaxRecordsPerPage&page=$page';

    if (filterDeleted) {
      url += '&filter_deleted_clients=true';
    }

    final dynamic response = await webClient.get(url, credentials.token);

    final InvoiceListResponse recurringInvoiceResponse =
        serializers.deserializeWith(InvoiceListResponse.serializer, response)!;

    return recurringInvoiceResponse.data;
  }

  Future<List<InvoiceEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action,
      {Map<String, Object>? data}) async {
    if (ids.length > kMaxEntitiesPerBulkAction && action.applyMaxLimit) {
      ids = ids.sublist(0, kMaxEntitiesPerBulkAction);
    }

    final url = credentials.url+
        '/recurring_invoices/bulk?per_page=$kMaxEntitiesPerBulkAction';
    final params = {'ids': ids, 'action': action.toApiParam()};
    if (data != null) {
      params.addAll(data);
    }

    final dynamic response =
        await webClient.post(url, credentials.token, data: json.encode(params));

    final InvoiceListResponse recurringInvoiceResponse =
        serializers.deserializeWith(InvoiceListResponse.serializer, response)!;

    return recurringInvoiceResponse.data.toList();
  }

  Future<InvoiceEntity> saveData(
    Credentials credentials,
    InvoiceEntity recurringInvoice, {
    EntityAction? action,
  }) async {
    final data =
        serializers.serializeWith(InvoiceEntity.serializer, recurringInvoice);
    dynamic response;
    String url;

    if (recurringInvoice.isNew) {
      url = credentials.url+
          '/recurring_invoices?include=activities,history&show_dates=true';
    } else {
      url =
          '${credentials.url}/recurring_invoices/${recurringInvoice.id}?include=activities,history&show_dates=true';
    }

    if (action == EntityAction.start) {
      url += '&start=true';
    } else if (action == EntityAction.stop) {
      url += '&stop=true';
    } else if (action == EntityAction.sendNow) {
      url += '&send_now=true';
    }

    if (recurringInvoice.isNew) {
      response =
          await webClient.post(url, credentials.token, data: json.encode(data));
    } else {
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final InvoiceItemResponse recurringInvoiceResponse =
        serializers.deserializeWith(InvoiceItemResponse.serializer, response)!;

    return recurringInvoiceResponse.data;
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
        '${credentials.url}/recurring_invoices/${entity.id}/upload',
        credentials.token,
        data: fields,
        multipartFiles: multipartFiles);

    final InvoiceItemResponse invoiceResponse =
        serializers.deserializeWith(InvoiceItemResponse.serializer, response)!;

    return invoiceResponse.data;
  }
}
