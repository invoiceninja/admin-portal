// Dart imports:
import 'dart:convert';
import 'dart:core';

// Package imports:
import 'package:built_collection/built_collection.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/payment_term_model.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class PaymentTermRepository {
  const PaymentTermRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<PaymentTermEntity> loadItem(
      Credentials credentials, String? entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/payment_terms/$entityId', credentials.token);

    final PaymentTermItemResponse paymentTermResponse = serializers
        .deserializeWith(PaymentTermItemResponse.serializer, response)!;

    return paymentTermResponse.data;
  }

  Future<BuiltList<PaymentTermEntity>> loadList(Credentials credentials) async {
    final url = credentials.url+ '/payment_terms?';

    final dynamic response = await webClient.get(url, credentials.token);

    final PaymentTermListResponse paymentTermResponse = serializers
        .deserializeWith(PaymentTermListResponse.serializer, response)!;

    return paymentTermResponse.data;
  }

  Future<List<PaymentTermEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    if (ids.length > kMaxEntitiesPerBulkAction && action.applyMaxLimit) {
      ids = ids.sublist(0, kMaxEntitiesPerBulkAction);
    }

    final url = credentials.url+
        '/payment_terms/bulk?per_page=$kMaxEntitiesPerBulkAction';
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids, 'action': action.toApiParam()}));

    final PaymentTermListResponse paymentTermResponse = serializers
        .deserializeWith(PaymentTermListResponse.serializer, response)!;

    return paymentTermResponse.data.toList();
  }

  Future<PaymentTermEntity> saveData(
      Credentials credentials, PaymentTermEntity paymentTerm) async {
    final data =
        serializers.serializeWith(PaymentTermEntity.serializer, paymentTerm);
    dynamic response;

    if (paymentTerm.isNew) {
      response = await webClient.post(
          credentials.url+ '/payment_terms', credentials.token,
          data: json.encode(data));
    } else {
      final url = '${credentials.url}/payment_terms/${paymentTerm.id}';
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final PaymentTermItemResponse paymentTermResponse = serializers
        .deserializeWith(PaymentTermItemResponse.serializer, response)!;

    return paymentTermResponse.data;
  }
}
