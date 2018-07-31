import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class AuthRepository {
  final WebClient webClient;

  const AuthRepository({
    this.webClient = const WebClient(),
  });

  Future<LoginResponseData> login(String email, String password, String url, String secret, String platform) async {

    final credentials = {
      'token_name': 'invoice-ninja-$platform-app',
      'api_secret': secret,
      'email': email,
      'password': password,
    };

    return sendRequest(url, credentials);
  }

  Future<LoginResponseData> refresh(String url, String token, String platform) async {

    final credentials = {
      'token_name': 'invoice-ninja-$platform-app',
    };

    return sendRequest(url, credentials, token);
  }

  Future<LoginResponseData> sendRequest(String url, dynamic data, [String token]) async {

    url = formatApiUrlMachine(url);

    final dynamic response = await webClient.post(url + '/login?include=tax_rates&include_static=true', token ?? '', json.encode(data));

    final LoginResponse loginResponse = serializers.deserializeWith(
        LoginResponse.serializer, response);

    if (loginResponse.error != null) {
      throw loginResponse.error.message;
    }

    return loginResponse.data;
  }

}