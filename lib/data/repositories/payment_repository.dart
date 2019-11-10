import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class PaymentRepository {
  const PaymentRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<BuiltList<PaymentEntity>> loadList(
      Credentials credentials, int updatedAt) async {
    String url = credentials.url + '/payments?';

    if (updatedAt > 0) {
      url += '&updated_at=${updatedAt - kUpdatedAtBufferSeconds}';
    }

    final dynamic response = await webClient.get(url, credentials.token);

    final PaymentListResponse paymentResponse =
        serializers.deserializeWith(PaymentListResponse.serializer, response);

    return paymentResponse.data;
  }

  Future<List<PaymentEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    dynamic response;

    switch (action) {
      case EntityAction.restore:
      case EntityAction.archive:
      case EntityAction.delete:
        var url = credentials.url + '/payments/bulk?include=activities';
        if (action != null) {
          url += '&action=' + action.toString();
        }
        response = await webClient.post(url, credentials.token,
            data: json.encode(ids));
        break;
      default:
        // Might have other actions in the future
        break;
    }

    final PaymentListResponse paymentResponse =
        serializers.deserializeWith(PaymentListResponse.serializer, response);

    return paymentResponse.data.toList();
  }

  Future<PaymentEntity> saveData(Credentials credentials, PaymentEntity payment,
      {EntityAction action, bool sendEmail = false}) async {
    final data = serializers.serializeWith(PaymentEntity.serializer, payment);
    dynamic response;

    if (payment.isNew) {
      var url = credentials.url + '/payments';
      if (sendEmail) {
        url += '?email_receipt=true';
      }
      response =
          await webClient.post(url, credentials.token, data: json.encode(data));
    } else {
      var url = '${credentials.url}/payments/${payment.id}?';
      if (sendEmail) {
        url += '&email_receipt=true';
      }
      if (action != null) {
        url += '&action=' + action.toString();
      }
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final PaymentItemResponse paymentResponse =
        serializers.deserializeWith(PaymentItemResponse.serializer, response);

    return paymentResponse.data;
  }
}
