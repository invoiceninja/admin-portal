import 'dart:convert';
import 'dart:core';
import 'package:built_collection/built_collection.dart';
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
      Credentials credentials, String entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/purchase_orders/$entityId', credentials.token);

    final InvoiceItemResponse purchaseOrderResponse =
        serializers.deserializeWith(InvoiceItemResponse.serializer, response);

    return purchaseOrderResponse.data;
  }

  Future<BuiltList<InvoiceEntity>> loadList(Credentials credentials) async {
    final String url = credentials.url + '/purchase_orders?';
    final dynamic response = await webClient.get(url, credentials.token);

    final InvoiceListResponse purchaseOrderResponse =
        serializers.deserializeWith(InvoiceListResponse.serializer, response);

    return purchaseOrderResponse.data;
  }

  Future<List<InvoiceEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    if (ids.length > kMaxEntitiesPerBulkAction) {
      ids = ids.sublist(0, kMaxEntitiesPerBulkAction);
    }

    final url = credentials.url + '/purchase_orders/bulk';
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids, 'action': action.toApiParam()}));

    final InvoiceListResponse purchaseOrderResponse =
        serializers.deserializeWith(InvoiceListResponse.serializer, response);

    return purchaseOrderResponse.data.toList();
  }

  Future<InvoiceEntity> saveData(
      Credentials credentials, InvoiceEntity purchaseOrder) async {
    final data =
        serializers.serializeWith(InvoiceEntity.serializer, purchaseOrder);
    dynamic response;

    if (purchaseOrder.isNew) {
      response = await webClient.post(
          credentials.url + '/purchase_orders', credentials.token,
          data: json.encode(data));
    } else {
      final url = '${credentials.url}/purchase_orders/${purchaseOrder.id}';
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final InvoiceItemResponse purchaseOrderResponse =
        serializers.deserializeWith(InvoiceItemResponse.serializer, response);

    return purchaseOrderResponse.data;
  }
}
