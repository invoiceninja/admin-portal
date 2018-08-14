import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:built_collection/built_collection.dart';

import 'package:invoiceninja_flutter/redux/auth/auth_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class InvoiceRepository {
  final WebClient webClient;

  const InvoiceRepository({
    this.webClient = const WebClient(),
  });

  Future<InvoiceEntity> loadItem(
      CompanyEntity company, AuthState auth, int entityId) async {
    final dynamic response = await webClient.get(
        '${auth.url}/invoices/$entityId?include=invitations', company.token);

    final InvoiceItemResponse invoiceResponse =
        serializers.deserializeWith(InvoiceItemResponse.serializer, response);

    return invoiceResponse.data;
  }

  Future<BuiltList<InvoiceEntity>> loadList(
      CompanyEntity company, AuthState auth, int updatedAt) async {
    String url = auth.url + '/invoices?include=invitations';

    if (updatedAt > 0) {
      url += '&updated_at=${updatedAt - 600}';
    }

    final dynamic response = await webClient.get(url, company.token);

    final InvoiceListResponse invoiceResponse =
        serializers.deserializeWith(InvoiceListResponse.serializer, response);

    return invoiceResponse.data;
  }

  Future<InvoiceEntity> saveData(
      CompanyEntity company, AuthState auth, InvoiceEntity invoice,
      [EntityAction action]) async {
    final data = serializers.serializeWith(InvoiceEntity.serializer, invoice);
    dynamic response;

    if (invoice.isNew) {
      response = await webClient.post(
          auth.url + '/invoices?include=invitations',
          company.token,
          json.encode(data));
    } else {
      var url = auth.url + '/invoices/' + invoice.id.toString();
      if (action != null) {
        url += '?action=' + action.toString();
      }
      response = await webClient.put(url, company.token, json.encode(data));
    }

    final InvoiceItemResponse invoiceResponse =
        serializers.deserializeWith(InvoiceItemResponse.serializer, response);

    return invoiceResponse.data;
  }

  Future emailInvoice(
      CompanyEntity company,
      AuthState auth,
      InvoiceEntity invoice,
      EmailTemplate template,
      String subject,
      String body) async {

    final data = {
      'reminder': template == EmailTemplate.initial ? '' : template.toString(),
      'template': {
        'body': body,
        'subject': subject,
      }
    };

    final Future<dynamic> response = await webClient.post(
        auth.url + '/email_invoice?invoice_id=${invoice.id}',
        company.token,
        json.encode(data));

    final InvoiceItemResponse invoiceResponse =
        serializers.deserializeWith(InvoiceItemResponse.serializer, response);

    return invoiceResponse.data;
  }
}
