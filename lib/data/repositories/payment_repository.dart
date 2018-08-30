import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:built_collection/built_collection.dart';

import 'package:invoiceninja_flutter/redux/auth/auth_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class PaymentRepository {
  final WebClient webClient;

  const PaymentRepository({
    this.webClient = const WebClient(),
  });

  Future<BuiltList<PaymentEntity>> loadList(
      CompanyEntity company, AuthState auth, int updatedAt) async {
    String url = auth.url + '/payments';

    if (updatedAt > 0) {
      url += '&updated_at=${updatedAt - kUpdatedAtBufferSeconds}';
    }

    final dynamic response =
        await webClient.get(url, company.token);

    final PaymentListResponse paymentResponse =
        serializers.deserializeWith(PaymentListResponse.serializer, response);

    return paymentResponse.data;
  }

  Future saveData(CompanyEntity company, AuthState auth, PaymentEntity payment,
      [EntityAction action]) async {
    final data = serializers.serializeWith(PaymentEntity.serializer, payment);
    dynamic response;

    if (payment.isNew) {
      response = await webClient.post(
          auth.url + '/payments', company.token, json.encode(data));
    } else {
      var url = auth.url + '/payments/' + payment.id.toString();
      if (action != null) {
        url += '?action=' + action.toString();
      }
      response = await webClient.put(url, company.token, json.encode(data));
    }

    final PaymentItemResponse paymentResponse =
        serializers.deserializeWith(PaymentItemResponse.serializer, response);

    return paymentResponse.data;
  }
}
