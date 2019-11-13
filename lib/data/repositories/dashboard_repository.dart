import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:invoiceninja_flutter/.env.dart';
import 'package:invoiceninja_flutter/data/mock/mock_dashboard.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class DashboardRepository {
  const DashboardRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<DashboardEntity> loadItem(Credentials connectionInfo) async {
    dynamic response;
    if (Config.DEMO_MODE) {
      response = json.decode(kAPIResponseDashboard);
    } else {
      response = await webClient.get(
          connectionInfo.url + '/dashboard?only_activity=true',
          connectionInfo.token);
    }

    final DashboardResponse dashboardResponse =
        serializers.deserializeWith(DashboardResponse.serializer, response);

    return dashboardResponse.data;
  }
}
