import 'dart:async';
import 'dart:convert';
import 'dart:core';
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
    String firstName,
    String lastName,
    String email,
    String password,
    String platform,
  }) async {
    final credentials = {
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'terms_of_service': true,
      'privacy_policy': true
      //'token_name': 'invoice-ninja-$platform-app',
    };

    final url = formatApiUrl(kAppUrl) + '/signup';

    return sendRequest(url: url, data: credentials);
  }

  Future<LoginResponse> login(
      {String email,
      String password,
      String url,
      String secret,
      String platform,
      String oneTimePassword}) async {
    final credentials = {
      'token_name': 'invoice-ninja-$platform-app',
      'api_secret': url.isEmpty ? Config.API_SECRET : secret,
      'email': email,
      'password': password,
      'one_time_password': oneTimePassword,
    };

    url = formatApiUrl(url) + '/login';

    return sendRequest(url: url, data: credentials);
  }

  Future<LoginResponse> oauthLogin(
      {String token, String url, String secret, String platform}) async {
    final credentials = {
      'token_name': 'invoice-ninja-$platform-app',
      'api_secret': url.isEmpty ? Config.API_SECRET : secret,
      'token': token,
      'provider': 'google',
    };
    url = formatApiUrl(url) + '/oauth_login';

    return sendRequest(url: url, data: credentials);
  }

  Future<LoginResponse> refresh(
      {String url, String token, String platform}) async {
    final credentials = {
      'token_name': 'invoice-ninja-$platform-app',
    };

    url = formatApiUrl(url) + '/refresh';

    return sendRequest(url: url, data: credentials, token: token);
  }

  Future<LoginResponse> sendRequest(
      {String url, dynamic data, String token}) async {
    final includes = [
      'account',
      'user',
      'token',
      'company.users',
      'company.tax_rates',
      'company.groups',
      'company.company_gateways.gateway',
    ];
    url += '?include=${includes.join(',')}&include_static=true';

    dynamic response;

    if (Config.DEMO_MODE) {
      response = json.decode(kAPIResponseLogin);
    } else {
      response =
          await webClient.post(url, token ?? '', data: json.encode(data));
    }

    return serializers.deserializeWith(LoginResponse.serializer, response);
  }

  Future<LoginResponse> recoverPassword(
      {String email, String url, String secret, String platform}) async {
    final credentials = {
      'api_secret': url.isEmpty ? Config.API_SECRET : secret,
      'email': email,
    };
    url = formatApiUrl(url) + '/reset_password';

    return sendRequest(url: url, data: credentials);
  }
}
