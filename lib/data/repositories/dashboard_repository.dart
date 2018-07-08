import 'dart:async';
import 'dart:core';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_state.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class DashboardRepository {
  final WebClient webClient;

  const DashboardRepository({
    this.webClient = const WebClient(),
  });

  Future<DashboardEntity> loadItem(CompanyEntity company, AuthState auth) async {

    final dynamic response = await webClient.get(
        auth.url + '/dashboard', company.token);

    final DashboardResponse dashboardResponse = serializers.deserializeWith(
        DashboardResponse.serializer, response);

    return dashboardResponse.data;
  }
}