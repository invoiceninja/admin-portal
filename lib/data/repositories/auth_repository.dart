import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/.env.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/mock/mock_login.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class AuthRepository {
  const AuthRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<LoginResponse> signUp({
    String url,
    String firstName,
    String lastName,
    String email,
    String password,
    String secret,
  }) async {
    final credentials = {
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'terms_of_service': true,
      'privacy_policy': true,
      'token_name': '${Config.PLATFORM.toLowerCase()}-client',
    };

    final signupUrl =
        formatApiUrl((url ?? '').isEmpty ? kAppUrl : url) + '/signup';

    return sendRequest(url: signupUrl, data: credentials, secret: secret);
  }

  Future<LoginResponse> login(
      {String email,
      String password,
      String url,
      String secret,
      String platform,
      String oneTimePassword}) async {
    final credentials = {
      'email': email,
      'password': password,
      'one_time_password': oneTimePassword,
    };

    url = formatApiUrl(url) + '/login';

    return sendRequest(url: url, data: credentials, secret: secret);
  }

  Future<LoginResponse> oauthLogin(
      {String token, String url, String secret, String platform}) async {
    final credentials = {
      'token': token,
      'provider': 'google',
    };
    url = formatApiUrl(url) + '/oauth_login';

    return sendRequest(url: url, data: credentials, secret: secret);
  }

  Future<LoginResponse> refresh({String url, String token}) async {
    url = formatApiUrl(url) + '/refresh';

    return sendRequest(url: url, token: token);
  }

  Future<LoginResponse> recoverPassword(
      {String email, String url, String secret, String platform}) async {
    final credentials = {
      'email': email,
    };
    url = formatApiUrl(url) + '/reset_password';

    return sendRequest(url: url, data: credentials);
  }

  Future<dynamic> addCompany({String token}) async {
    final data = {
      'token_name': '${Config.PLATFORM.toLowerCase()}-client',
    };

    return webClient.post('/companies', token, data: json.encode(data));
  }

  Future<dynamic> deleteCompany({
    @required String token,
    @required String companyId,
    @required String password,
  }) async {
    return webClient.delete('/companies/$companyId', token, password: password);
  }

  Future<dynamic> purgeData({
    @required String token,
    @required String companyId,
    @required String password,
  }) async {
    //return webClient.delete('/companies/$companyId', token, password: password);
  }

  Future<LoginResponse> sendRequest(
      {String url, dynamic data, String token, String secret}) async {
    url += '?first_load=true&include_static=true';

    dynamic response;

    if (Config.DEMO_MODE) {
      response = json.decode(kMockLogin);
    } else {
      response = await webClient.post(url, token ?? '',
          secret: secret, data: json.encode(data));
    }

    return serializers.deserializeWith(LoginResponse.serializer, response);
  }
}
