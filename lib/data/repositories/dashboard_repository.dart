import 'dart:async';
import 'dart:core';
import 'package:meta/meta.dart';

import 'package:invoiceninja/redux/auth/auth_state.dart';
import 'package:invoiceninja/data/models/entities.dart';
import 'package:invoiceninja/data/repositories/repositories.dart';
import 'package:invoiceninja/data/file_storage.dart';
import 'package:invoiceninja/data/web_client.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Dashboard and Persist products.
class DashboardRepositoryFlutter implements BaseRepository {
  final FileStorage fileStorage;
  final WebClient webClient;

  const DashboardRepositoryFlutter({
    @required this.fileStorage,
    this.webClient = const WebClient(),
  });

  /// Loads products first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Dashboard from a Web Client.
  @override
  Future<dynamic> loadItem(AuthState auth) async {
    print('ProductRepo: loadDashboard...');

    final data = await webClient.fetchItem(
        auth.url + '/dashboard', auth.token);

    //fileStorage.saveDashboard(products);
    print('== LOAD DASHBOARD ==');
    print(data);
    return data.map((data) => ProductEntity.fromJson(data)).toList();

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

  @override
  Future<List<dynamic>> loadItems(dynamic product) {
    return Future.wait<dynamic>([]);
  }

  // Persists products to local disk and the web
  @override
  Future saveData(List<dynamic> products) {
    return Future.wait<dynamic>([]);
  }
}