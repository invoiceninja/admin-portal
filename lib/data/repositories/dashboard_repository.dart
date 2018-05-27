import 'dart:async';
import 'dart:core';
import 'package:meta/meta.dart';
import 'package:invoiceninja/data/models/serializers.dart';
import 'package:built_collection/built_collection.dart';

import 'package:invoiceninja/redux/auth/auth_state.dart';
import 'package:invoiceninja/data/models/entities.dart';
import 'package:invoiceninja/data/file_storage.dart';
import 'package:invoiceninja/data/web_client.dart';

class DashboardRepository {
  final FileStorage fileStorage;
  final WebClient webClient;

  const DashboardRepository({
    @required this.fileStorage,
    this.webClient = const WebClient(),
  });

  Future<DashboardEntity> loadItem(CompanyEntity company, AuthState auth) async {

    final response = await webClient.get(
        auth.url + '/dashboard', company.token);

    //fileStorage.saveDashboard(products);

    DashboardResponse dashboardResponse = serializers.deserializeWith(
        DashboardResponse.serializer, response);

    return dashboardResponse.data;

    /*
    try {
      return await fileStorage.loadData();
    } catch (exception) {
      final products = await webClient.fetchData(
          auth.url + '/products', auth.token);

      //fileStorage.saveDashboard(products);

      return products;
    }
    */
  }
}