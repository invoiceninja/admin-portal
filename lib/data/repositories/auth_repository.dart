import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'package:meta/meta.dart';

import 'package:invoiceninja/redux/auth/auth_state.dart';
import 'package:invoiceninja/data/models/entities.dart';
import 'package:invoiceninja/data/file_storage.dart';
import 'package:invoiceninja/data/web_client.dart';

class AuthRepository {
  final FileStorage fileStorage;
  final WebClient webClient;

  const AuthRepository({
    @required this.fileStorage,
    this.webClient = const WebClient(),
  });

  Future<List<CompanyEntity>> login(String email, String password, String url) async {

    final data = await webClient.postList(url + '/login', '', {
      'api_secret': 'secret',
      'token_name': 'mobile-app',
      'email': email,
      'password': password,
    }).catchError((error) {
      throw ('An error occurred');
    });

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