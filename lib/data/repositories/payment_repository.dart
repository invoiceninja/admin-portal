import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/utils/serialization.dart';

class PaymentRepository {
  const PaymentRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<PaymentEntity> loadItem(
      Credentials credentials, String entityId) async {
    final String url = '${credentials.url}/payments/$entityId';

    final dynamic response = await webClient.get(url, credentials.token);

    final PaymentItemResponse paymentResponse = await compute<dynamic, dynamic>(
        SerializationUtils.computeDecode,
        <dynamic>[PaymentItemResponse.serializer, response]);

    return paymentResponse.data;
  }

  Future<BuiltList<PaymentEntity>> loadList(
      Credentials credentials, int createdAt, bool filterDeleted) async {
    String url = credentials.url + '/payments?created_at=$createdAt';

    if (filterDeleted) {
      url += '&filter_deleted_clients=true';
    }

    final dynamic response = await webClient.get(url, credentials.token);

    final PaymentListResponse paymentResponse = await compute<dynamic, dynamic>(
        SerializationUtils.computeDecode,
        <dynamic>[PaymentListResponse.serializer, response]);

    return paymentResponse.data;
  }

  Future<List<PaymentEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    final url = credentials.url + '/payments/bulk';
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids, 'action': action.toApiParam()}));

    final PaymentListResponse paymentResponse =
        serializers.deserializeWith(PaymentListResponse.serializer, response);

    return paymentResponse.data.toList();
  }

  Future<PaymentEntity> saveData(Credentials credentials, PaymentEntity payment,
      {bool sendEmail = false}) async {
    final data = serializers.serializeWith(PaymentEntity.serializer, payment);
    dynamic response;

    if (payment.isNew) {
      var url = credentials.url + '/payments?';
      if (sendEmail) {
        url += '&email_receipt=true';
      }
      response =
          await webClient.post(url, credentials.token, data: json.encode(data));
    } else {
      var url = '${credentials.url}/payments/${payment.id}?';
      if (sendEmail) {
        url += '&email_receipt=true';
      }
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final PaymentItemResponse paymentResponse =
        serializers.deserializeWith(PaymentItemResponse.serializer, response);

    return paymentResponse.data;
  }

  Future<PaymentEntity> refundPayment(
      Credentials credentials, PaymentEntity payment) async {
    final data = serializers.serializeWith(PaymentEntity.serializer, payment);
    dynamic response;

    var url = credentials.url + '/payments/refund?';
    if (payment.sendEmail == true) {
      url += '&email_receipt=true';
    }
    if (payment.gatewayRefund == true) {
      url += '&gateway_refund=true';
    }
    response =
        await webClient.post(url, credentials.token, data: json.encode(data));

    final PaymentItemResponse paymentResponse =
        serializers.deserializeWith(PaymentItemResponse.serializer, response);

    return paymentResponse.data;
  }
}
