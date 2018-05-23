import 'dart:async';
import 'dart:core';
import 'package:meta/meta.dart';

import 'package:invoiceninja/redux/auth/auth_state.dart';
import 'package:invoiceninja/data/models/entities.dart';
import 'package:invoiceninja/data/repositories/repositories.dart';
import 'package:invoiceninja/data/file_storage.dart';
import 'package:invoiceninja/data/web_client.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Products and Persist products.
class AuthRepositoryFlutter {
  final FileStorage fileStorage;
  final WebClient webClient;

  const AuthRepositoryFlutter({
    @required this.fileStorage,
    this.webClient = const WebClient(),
  });

  /// Loads products first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Products from a Web Client.
  Future<List<dynamic>> login(String email, String password, String url) async {

    final data = await webClient.postList(url + '/login?api_secret=secret', '', {
      'email': email,
      'password': password,
    });

    print('== LOGN RESPONSE ==');
    print(data);

    // TODO remove handle on server
    for (int i=1; i<data.length; i++) {
      data[i].id = i;
    }

    return data.map((company) => CompanyEntity.fromJson(company)).toList();

    /*
    try {
      return await fileStorage.loadData();
    } catch (exception) {
      final products = await webClient.fetchData(
          auth.url + '/products', auth.token);

      //fileStorage.saveProducts(products);

      return products;
    }
    */
  }
}