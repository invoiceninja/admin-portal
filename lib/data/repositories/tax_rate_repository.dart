import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class TaxRateRepository {
  const TaxRateRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<TaxRateEntity> loadItem(
      Credentials credentials, String entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/tax_rates/$entityId', credentials.token);

    final TaxRateItemResponse taxRateResponse =
        serializers.deserializeWith(TaxRateItemResponse.serializer, response);

    return taxRateResponse.data;
  }

  Future<BuiltList<TaxRateEntity>> loadList(
      Credentials credentials, int updatedAt) async {
    String url = credentials.url + '/tax_rates?';

    if (updatedAt > 0) {
      url += '&updated_at=${updatedAt - kUpdatedAtBufferSeconds}';
    }

    final dynamic response = await webClient.get(url, credentials.token);

    final TaxRateListResponse taxRateResponse =
        serializers.deserializeWith(TaxRateListResponse.serializer, response);

    return taxRateResponse.data;
  }

  Future<TaxRateEntity> saveData(Credentials credentials, TaxRateEntity taxRate,
      [EntityAction action]) async {
    final data = serializers.serializeWith(TaxRateEntity.serializer, taxRate);
    dynamic response;

    if (taxRate.isNew) {
      response = await webClient.post(
          credentials.url + '/tax_rates', credentials.token,
          data: json.encode(data));
    } else {
      var url = credentials.url + '/tax_rates/' + taxRate.id.toString();
      if (action != null) {
        url += '?action=' + action.toString();
      }
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final TaxRateItemResponse taxRateResponse =
        serializers.deserializeWith(TaxRateItemResponse.serializer, response);

    return taxRateResponse.data;
  }
}
