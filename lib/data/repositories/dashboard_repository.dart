import 'dart:async';
import 'dart:core';
import 'package:meta/meta.dart';

import 'package:invoiceninja/redux/auth/auth_state.dart';
import 'package:invoiceninja/data/models/entities.dart';
import 'package:invoiceninja/data/file_storage.dart';
import 'package:invoiceninja/data/web_client.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Dashboard and Persist products.
class DashboardRepositoryFlutter {
  final FileStorage fileStorage;
  final WebClient webClient;

  const DashboardRepositoryFlutter({
    @required this.fileStorage,
    this.webClient = const WebClient(),
  });

  Future<DashboardEntity> loadItem(CompanyEntity company, AuthState auth) async {

    final data = await webClient.fetchItem(
        auth.url + '/dashboard', company.token);

    //fileStorage.saveDashboard(products);

    return DashboardEntity.fromJson(data);

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