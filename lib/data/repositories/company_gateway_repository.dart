// Dart imports:
import 'dart:convert';
import 'dart:core';

// Package imports:
import 'package:built_collection/built_collection.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class CompanyGatewayRepository {
  const CompanyGatewayRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  // TODO remove includes in this file
  Future<CompanyGatewayEntity> loadItem(
      Credentials credentials, String? entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/company_gateways/$entityId?include=system_logs',
        credentials.token);

    final CompanyGatewayItemResponse companyGatewayResponse = serializers
        .deserializeWith(CompanyGatewayItemResponse.serializer, response)!;

    return companyGatewayResponse.data;
  }

  Future<BuiltList<CompanyGatewayEntity>> loadList(
      Credentials credentials) async {
    final url = credentials.url+ '/company_gateways';

    final dynamic response = await webClient.get(url, credentials.token);

    final CompanyGatewayListResponse companyGatewayResponse = serializers
        .deserializeWith(CompanyGatewayListResponse.serializer, response)!;

    return companyGatewayResponse.data;
  }

  Future<List<CompanyGatewayEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    if (ids.length > kMaxEntitiesPerBulkAction && action.applyMaxLimit) {
      ids = ids.sublist(0, kMaxEntitiesPerBulkAction);
    }

    final url = credentials.url+
        '/company_gateways/bulk?per_page=$kMaxEntitiesPerBulkAction';
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids, 'action': action.toApiParam()}));

    final CompanyGatewayListResponse companyGatewayResponse = serializers
        .deserializeWith(CompanyGatewayListResponse.serializer, response)!;

    return companyGatewayResponse.data.toList();
  }

  Future<void> disconnect(Credentials credentials, String id, String? password,
      String? idToken) async {
    final url = credentials.url+ '/stripe/disconnect/$id';
    await webClient.post(
      url,
      credentials.token,
      password: password,
      idToken: idToken,
    );
  }

  Future<CompanyGatewayEntity> saveData(
      Credentials credentials, CompanyGatewayEntity companyGateway) async {
    final data = serializers.serializeWith(
        CompanyGatewayEntity.serializer, companyGateway);
    dynamic response;

    if (companyGateway.isNew) {
      response = await webClient.post(
          credentials.url+ '/company_gateways', credentials.token,
          data: json.encode(data));
    } else {
      final url = credentials.url+ '/company_gateways/${companyGateway.id}';
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final CompanyGatewayItemResponse companyGatewayResponse = serializers
        .deserializeWith(CompanyGatewayItemResponse.serializer, response)!;

    return companyGatewayResponse.data;
  }
}
