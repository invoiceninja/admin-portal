import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class CompanyGatewayRepository {
  const CompanyGatewayRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<CompanyGatewayEntity> loadItem(
      Credentials credentials, String entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/company_gateways/$entityId?include=gateway',
        credentials.token);

    final CompanyGatewayItemResponse companyGatewayResponse = serializers
        .deserializeWith(CompanyGatewayItemResponse.serializer, response);

    return companyGatewayResponse.data;
  }

  Future<BuiltList<CompanyGatewayEntity>> loadList(
      Credentials credentials, int updatedAt) async {
    String url = credentials.url + '/company_gateways?include=gateway';

    if (updatedAt > 0) {
      url += '&updated_at=${updatedAt - kUpdatedAtBufferSeconds}';
    }

    final dynamic response = await webClient.get(url, credentials.token);

    final CompanyGatewayListResponse companyGatewayResponse = serializers
        .deserializeWith(CompanyGatewayListResponse.serializer, response);

    return companyGatewayResponse.data;
  }

  Future<List<CompanyGatewayEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    var url = credentials.url + '/company_gateways/bulk?include=gateway';
    if (action != null) {
      url += '&action=' + action.toString();
    }
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids}));

    final CompanyGatewayListResponse companyGatewayResponse = serializers
        .deserializeWith(CompanyGatewayListResponse.serializer, response);

    return companyGatewayResponse.data.toList();
  }

  Future<CompanyGatewayEntity> saveData(
      Credentials credentials, CompanyGatewayEntity companyGateway) async {
    final data = serializers.serializeWith(
        CompanyGatewayEntity.serializer, companyGateway);
    dynamic response;

    if (companyGateway.isNew) {
      response = await webClient.post(
          credentials.url + '/company_gateways?include=gateway',
          credentials.token,
          data: json.encode(data));
    } else {
      final url = credentials.url +
          '/company_gateways/${companyGateway.id}?include=gateway';
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final CompanyGatewayItemResponse companyGatewayResponse = serializers
        .deserializeWith(CompanyGatewayItemResponse.serializer, response);

    return companyGatewayResponse.data;
  }
}
