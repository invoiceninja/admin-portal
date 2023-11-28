// Dart imports:
import 'dart:convert';
import 'dart:core';

// Package imports:
import 'package:built_collection/built_collection.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class TaxRateRepository {
  const TaxRateRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<TaxRateEntity> loadItem(
      Credentials credentials, String? entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/tax_rates/$entityId', credentials.token);

    final TaxRateItemResponse taxRateResponse =
        serializers.deserializeWith(TaxRateItemResponse.serializer, response)!;

    return taxRateResponse.data;
  }

  Future<BuiltList<TaxRateEntity>> loadList(Credentials credentials) async {
    final url = credentials.url+ '/tax_rates?';

    final dynamic response = await webClient.get(url, credentials.token);

    final TaxRateListResponse taxRateResponse =
        serializers.deserializeWith(TaxRateListResponse.serializer, response)!;

    return taxRateResponse.data;
  }

  Future<List<TaxRateEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    if (ids.length > kMaxEntitiesPerBulkAction && action.applyMaxLimit) {
      ids = ids.sublist(0, kMaxEntitiesPerBulkAction);
    }

    final url = credentials.url+
        '/tax_rates/bulk?per_page=$kMaxEntitiesPerBulkAction';
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids, 'action': action.toApiParam()}));

    final TaxRateListResponse taxRateResponse =
        serializers.deserializeWith(TaxRateListResponse.serializer, response)!;

    return taxRateResponse.data.toList();
  }

  Future<TaxRateEntity> saveData(
      Credentials credentials, TaxRateEntity taxRate) async {
    final data = serializers.serializeWith(TaxRateEntity.serializer, taxRate);
    dynamic response;

    if (taxRate.isNew) {
      response = await webClient.post(
          credentials.url+ '/tax_rates', credentials.token,
          data: json.encode(data));
    } else {
      final url = credentials.url+ '/tax_rates/${taxRate.id}';
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final TaxRateItemResponse taxRateResponse =
        serializers.deserializeWith(TaxRateItemResponse.serializer, response)!;

    return taxRateResponse.data;
  }
}
