import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'package:invoiceninja/data/models/serializers.dart';
import 'package:built_collection/built_collection.dart';

import 'package:invoiceninja/redux/auth/auth_state.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/data/web_client.dart';

class PaymentsRepository {
  final WebClient webClient;

  const PaymentsRepository({
    this.webClient = const WebClient(),
  });

  Future<BuiltList<PaymentEntity>> loadList(CompanyEntity company, AuthState auth) async {

    final Future<dynamic> response = await webClient.get(
        auth.url + '/payments?per_page=500', company.token);

    final PaymentListResponse paymentResponse = serializers.deserializeWith(
        PaymentListResponse.serializer, response);

    return paymentResponse.data;
  }

  Future saveData(CompanyEntity company, AuthState auth, PaymentEntity payment, [EntityAction action]) async {

    final data = serializers.serializeWith(PaymentEntity.serializer, payment);
    Future<dynamic> response;

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

    final PaymentItemResponse paymentResponse = serializers.deserializeWith(
        PaymentItemResponse.serializer, response);

    return paymentResponse.data;
  }
}