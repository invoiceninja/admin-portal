import 'dart:async';
import 'dart:core';
import 'package:meta/meta.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja/data/models/serializers.dart';
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

  Future<BuiltList<CompanyEntity>> login(String email, String password, String url) async {
    final response = await webClient.post(url + '/login', '', {
      'api_secret': 'secret',
      'token_name': 'mobile-app',
      'email': email,
      'password': password,
    });

    LoginResponse loginResponse = serializers.deserializeWith(
        LoginResponse.serializer, response);

    return loginResponse.data.toBuiltList();

    //return data.map((company) => CompanyEntity.fromJson(company)).toList();

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