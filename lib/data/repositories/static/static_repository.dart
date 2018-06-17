import 'dart:async';
import 'dart:core';
import 'package:invoiceninja/data/models/serializers.dart';
import 'package:invoiceninja/redux/auth/auth_state.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/data/web_client.dart';
import 'package:invoiceninja/data/models/static/static_data_model.dart';

class StaticRepository {
  final WebClient webClient;

  const StaticRepository({
    this.webClient = const WebClient(),
  });

  Future<StaticDataEntity> loadList(CompanyEntity company, AuthState auth) async {

    final response = await webClient.get(
        auth.url + '/static', company.token);

    StaticDataItemResponse staticDataResponse = serializers.deserializeWith(
        StaticDataItemResponse.serializer, response);

    return staticDataResponse.data;
  }

  
}