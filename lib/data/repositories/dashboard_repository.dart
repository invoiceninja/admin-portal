import 'dart:async';
import 'dart:core';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_state.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class DashboardRepository {
  const DashboardRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<DashboardEntity> loadItem(
      CompanyEntity company, AuthState auth) async {
    final dynamic response = await webClient.get(
        auth.url + '/dashboard?only_activity=true', company.token);

    final DashboardResponse dashboardResponse =
        serializers.deserializeWith(DashboardResponse.serializer, response);

    return dashboardResponse.data;
  }
}
