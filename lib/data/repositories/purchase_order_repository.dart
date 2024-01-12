import 'dart:convert';
import 'dart:core';
import 'package:built_collection/built_collection.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class PurchaseOrderRepository {
  const PurchaseOrderRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<InvoiceEntity> loadItem(
      Credentials credentials, String? entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/purchase_orders/$entityId?include=activities.history',
        credentials.token);

    final InvoiceItemResponse purchaseOrderResponse =
        serializers.deserializeWith(InvoiceItemResponse.serializer, response)!;

    return purchaseOrderResponse.data;
  }

  Future<BuiltList<InvoiceEntity>> loadList(
    Credentials credentials,
    int page,
    int createdAt,
    //bool filterDeleted,
  ) async {
    final url = credentials.url +
        '/purchase_orders?per_page=$kMaxRecordsPerPage&page=$page&created_at=$createdAt';

    /*
    if (filterDeleted) {
      url += '&filter_deleted_clients=true';
    }
    */

    final dynamic response = await webClient.get(url, credentials.token);

    final InvoiceListResponse purchaseOrderResponse =
        serializers.deserializeWith(InvoiceListResponse.serializer, response)!;

    return purchaseOrderResponse.data;
  }

  Future<List<InvoiceEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action,
      {EmailTemplate? template}) async {
    if (ids.length > kMaxEntitiesPerBulkAction && action.applyMaxLimit) {
      ids = ids.sublist(0, kMaxEntitiesPerBulkAction);
    }

    final url = credentials.url +
        '/purchase_orders/bulk?per_page=$kMaxEntitiesPerBulkAction';
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({
          'ids': ids,
          'action': action.toApiParam(),
          if (template != null) 'email_type': 'email_template_$template',
        }));

    print(
        '## DATA: ${json.encode({'ids': ids, 'action': action.toApiParam()})}');

    final InvoiceListResponse purchaseOrderResponse =
        serializers.deserializeWith(InvoiceListResponse.serializer, response)!;

    return purchaseOrderResponse.data.toList();
  }

  Future<InvoiceEntity> saveData(
    Credentials credentials,
    InvoiceEntity purchaseOrder,
    EntityAction? action,
  ) async {
    purchaseOrder = purchaseOrder.rebuild((b) => b..documents.clear());
    final data =
        serializers.serializeWith(InvoiceEntity.serializer, purchaseOrder);
    String url;
    dynamic response;

    if (purchaseOrder.isNew) {
      url = credentials.url + '/purchase_orders?include=activities.history';
    } else {
      url =
          '${credentials.url}/purchase_orders/${purchaseOrder.id}?include=activities.history';
    }

    if (action == EntityAction.markSent) {
      url += '&mark_sent=true';
    } else if (action == EntityAction.accept) {
      url += '&accept=true';
    }

    if (purchaseOrder.saveDefaultTerms) {
      url += '&save_default_terms=true';
    }
    if (purchaseOrder.saveDefaultFooter) {
      url += '&save_default_footer=true';
    }

    if (purchaseOrder.isNew) {
      response =
          await webClient.post(url, credentials.token, data: json.encode(data));
    } else {
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final InvoiceItemResponse purchaseOrderResponse =
        serializers.deserializeWith(InvoiceItemResponse.serializer, response)!;

    return purchaseOrderResponse.data;
  }

  Future<InvoiceEntity> emailPurchaseOrder(
    Credentials credentials,
    InvoiceEntity purchaseOrder,
    EmailTemplate template,
    String subject,
    String body,
    String ccEmail,
  ) async {
    final data = {
      'entity': '${EntityType.purchaseOrder.apiValue}',
      'entity_id': purchaseOrder.id,
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
        '${credentials.url}/purchase_orders/${entity.id}/upload',
        credentials.token,
        data: fields,
        multipartFiles: multipartFiles);

    final InvoiceItemResponse invoiceResponse =
        serializers.deserializeWith(InvoiceItemResponse.serializer, response)!;

    return invoiceResponse.data;
  }
}
