import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:invoiceninja_flutter/.env.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/mock/mock_invoices.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class InvoiceRepository {
  const InvoiceRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<InvoiceEntity> loadItem(
      Credentials credentials, String entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/invoices/$entityId?include=invitations',
        credentials.token);

    final InvoiceItemResponse invoiceResponse =
        serializers.deserializeWith(InvoiceItemResponse.serializer, response);

    return invoiceResponse.data;
  }

  Future<BuiltList<InvoiceEntity>> loadList(
      Credentials credentials, int updatedAt) async {
    String url =
        credentials.url + '/invoices?include=invitations'; // invoice_type_id=1

    if (updatedAt > 0) {
      url += '&updated_at=${updatedAt - kUpdatedAtBufferSeconds}';
    }

    dynamic response;

    if (Config.DEMO_MODE) {
      response = json.decode(kMockInvoices);
    } else {
      response = await webClient.get(url, credentials.token);
    }

    final InvoiceListResponse invoiceResponse =
        serializers.deserializeWith(InvoiceListResponse.serializer, response);

    return invoiceResponse.data;
  }

  Future<List<InvoiceEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    var url = credentials.url + '/invoices/bulk?include=invitations';
    if (action != null) {
      url += '&action=' + action.toString();
    }
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids}));

    final InvoiceListResponse invoiceResponse =
        serializers.deserializeWith(InvoiceListResponse.serializer, response);

    return invoiceResponse.data.toList();
  }

  Future<InvoiceEntity> saveData(Credentials credentials, InvoiceEntity invoice,
      [EntityAction action]) async {
    final data = serializers.serializeWith(InvoiceEntity.serializer, invoice);
    dynamic response;

    if (invoice.isNew) {
      response = await webClient.post(
          credentials.url + '/invoices?include=invitations', credentials.token,
          data: json.encode(data));
    } else {
      var url = '${credentials.url}/invoices/${invoice.id}';
      if (action != null) {
        url += '?action=' + action.toString();
      }
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final InvoiceItemResponse invoiceResponse =
        serializers.deserializeWith(InvoiceItemResponse.serializer, response);

    return invoiceResponse.data;
  }

  Future<Null> emailInvoice(Credentials credentials, InvoiceEntity invoice,
      EmailTemplate template, String subject, String body) async {
    final data = {
      //'reminder': template == EmailTemplate.initial ? '' : template.toString(),
      'template': {
        'body': body,
        'subject': subject,
      }
    };

    await webClient.post(
        credentials.url + '/email_invoice?invoice_id=${invoice.id}',
        credentials.token,
        data: json.encode(data));

    /*
    final Future<dynamic> response = await webClient.post(
        credentials.url + '/email_invoice?invoice_id=${invoice.id}',
        credentials.token,
        json.encode(data));

    final InvoiceItemResponse invoiceResponse =
        serializers.deserializeWith(InvoiceItemResponse.serializer, response);

    return invoiceResponse.data;
    */
  }
}
