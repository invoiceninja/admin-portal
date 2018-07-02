import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'package:invoiceninja/data/models/serializers.dart';
import 'package:built_collection/built_collection.dart';

import 'package:invoiceninja/redux/auth/auth_state.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/data/web_client.dart';

class InvoiceRepository {
  final WebClient webClient;

  const InvoiceRepository({
    this.webClient = const WebClient(),
  });

  Future<BuiltList<InvoiceEntity>> loadList(CompanyEntity company, AuthState auth) async {

    final response = await webClient.get(
        auth.url + '/invoices?include=invitations', company.token);

    InvoiceListResponse invoiceResponse = serializers.deserializeWith(
        InvoiceListResponse.serializer, response);

    return invoiceResponse.data;
  }

  Future saveData(CompanyEntity company, AuthState auth, InvoiceEntity invoice, [EntityAction action]) async {

    var data = serializers.serializeWith(InvoiceEntity.serializer, invoice);
    var response;

    if (invoice.isNew()) {
      response = await webClient.post(
          auth.url + '/invoices?include=invitations', company.token, json.encode(data));
    } else {
      var url = auth.url + '/invoices/' + invoice.id.toString();
      if (action != null) {
        url += '?action=' + action.toString();
      }
      response = await webClient.put(url, company.token, json.encode(data));
    }

    InvoiceItemResponse invoiceResponse = serializers.deserializeWith(
        InvoiceItemResponse.serializer, response);

    return invoiceResponse.data;
  }

  Future emailInvoice(CompanyEntity company, AuthState auth, InvoiceEntity invoice) async {

    var response = await webClient.post(
          auth.url + '/email_invoice?invoice_id=${invoice.id}', company.token, null);

    InvoiceItemResponse invoiceResponse = serializers.deserializeWith(
        InvoiceItemResponse.serializer, response);

    return invoiceResponse.data;
  }
}