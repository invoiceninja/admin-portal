import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:built_collection/built_collection.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class RecurringInvoiceRepository {
  const RecurringInvoiceRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<InvoiceEntity> loadItem(
      Credentials credentials, String entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/recurring_invoices/$entityId?include=activities,history',
        credentials.token);

    final InvoiceItemResponse recurringInvoiceResponse =
        serializers.deserializeWith(InvoiceItemResponse.serializer, response);

    return recurringInvoiceResponse.data;
  }

  Future<BuiltList<InvoiceEntity>> loadList(
      Credentials credentials, int createdAt, bool filterDeleted) async {
    String url = credentials.url + '/recurring_invoices?created_at=$createdAt';

    if (filterDeleted) {
      url += '&filter_deleted_clients=true';
    }

    final dynamic response = await webClient.get(url, credentials.token);

    final InvoiceListResponse recurringInvoiceResponse =
        serializers.deserializeWith(InvoiceListResponse.serializer, response);

    return recurringInvoiceResponse.data;
  }

  Future<List<InvoiceEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    final url = credentials.url + '/recurring_invoices/bulk';
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids, 'action': action.toApiParam()}));

    final InvoiceListResponse recurringInvoiceResponse =
        serializers.deserializeWith(InvoiceListResponse.serializer, response);

    return recurringInvoiceResponse.data.toList();
  }

  Future<InvoiceEntity> saveData(
      Credentials credentials, InvoiceEntity recurringInvoice) async {
    final data =
        serializers.serializeWith(InvoiceEntity.serializer, recurringInvoice);
    dynamic response;

    if (recurringInvoice.isNew) {
      response = await webClient.post(
          credentials.url + '/recurring_invoices?include=activities,history',
          credentials.token,
          data: json.encode(data));
    } else {
      final url =
          '${credentials.url}/recurring_invoices/${recurringInvoice.id}?include=activities,history';
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final InvoiceItemResponse recurringInvoiceResponse =
        serializers.deserializeWith(InvoiceItemResponse.serializer, response);

    return recurringInvoiceResponse.data;
  }

  Future<InvoiceEntity> uploadDocument(Credentials credentials,
      BaseEntity entity, MultipartFile multipartFile) async {
    final fields = <String, String>{
      '_method': 'put',
    };

    final dynamic response = await webClient.post(
        '${credentials.url}/recurring_invoices/${entity.id}/upload',
        credentials.token,
        data: fields,
        multipartFiles: [multipartFile]);

    final InvoiceItemResponse invoiceResponse =
        serializers.deserializeWith(InvoiceItemResponse.serializer, response);

    return invoiceResponse.data;
  }
}
