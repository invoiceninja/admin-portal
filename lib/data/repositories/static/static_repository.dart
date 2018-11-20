import 'dart:async';
import 'dart:core';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/data/models/static/static_data_model.dart';

class StaticRepository {
  const StaticRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<StaticDataEntity> loadList(
      CompanyEntity company, AuthState auth) async {
    final dynamic response =
        await webClient.get(auth.url + '/static', company.token);

    final StaticDataItemResponse staticDataResponse = serializers
        .deserializeWith(StaticDataItemResponse.serializer, response);

    return staticDataResponse.data;
  }
}
