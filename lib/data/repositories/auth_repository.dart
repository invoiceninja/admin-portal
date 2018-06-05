import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja/data/models/serializers.dart';
import 'package:invoiceninja/data/models/entities.dart';
import 'package:invoiceninja/data/file_storage.dart';
import 'package:invoiceninja/data/web_client.dart';

class AuthRepository {
  final WebClient webClient;

  const AuthRepository({
    this.webClient = const WebClient(),
  });

  Future<BuiltList<CompanyEntity>> login(String email, String password, String url, String secret) async {

    final credentials = {
      'token_name': 'mobile-app',
      'api_secret': secret,
      'email': email,
      'password': password,
    };

    final response = await webClient.post(url + '/login', '', json.encode(credentials));

    LoginResponse loginResponse = serializers.deserializeWith(
        LoginResponse.serializer, response);

    if (loginResponse.error != null) {
      throw (loginResponse.error.message);
    }

    return loginResponse.data.toBuiltList();
 }
}