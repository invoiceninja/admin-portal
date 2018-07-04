import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:invoiceninja/data/models/serializers.dart';
import 'package:invoiceninja/data/models/entities.dart';
import 'package:invoiceninja/data/web_client.dart';

class AuthRepository {
  final WebClient webClient;

  const AuthRepository({
    this.webClient = const WebClient(),
  });

  Future<LoginResponseData> login(String email, String password, String url, String secret) async {

    final credentials = {
      'token_name': 'mobile-app',
      'api_secret': secret,
      'email': email,
      'password': password,
    };

    final dynamic response = await webClient.post(url + '/login?include=tax_rates&include_static=true', '', json.encode(credentials));

    final LoginResponse loginResponse = serializers.deserializeWith(
        LoginResponse.serializer, response);

    if (loginResponse.error != null) {
      throw loginResponse.error.message;
    }

    return loginResponse.data;
 }
}