import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
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
    String secret,
  }) async {
    final credentials = {
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'terms_of_service': true,
      'privacy_policy': true,
      'token_name': '${Platform.operatingSystem}-client',
    };

    final url = formatApiUrl(kAppUrl) + '/signup';

    return sendRequest(url: url, data: credentials, secret: secret);
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

  Future<LoginResponse> refresh(
      {String url, String token, String platform}) async {
    final credentials = {
      'token_name': 'invoice-ninja-$platform-app',
    };

    url = formatApiUrl(url) + '/refresh';

    return sendRequest(url: url, data: credentials, token: token);
  }

  Future<LoginResponse> recoverPassword(
      {String email, String url, String secret, String platform}) async {
    final credentials = {
      'email': email,
    };
    url = formatApiUrl(url) + '/reset_password';

    return sendRequest(url: url, data: credentials);
  }

  Future<LoginResponse> sendRequest(
      {String url, dynamic data, String token, String secret}) async {

    final includes = [
      'account',
      'user.company_user',
      'token',
      'company.activities',
      'company.users.company_user',
      'company.tax_rates',
      'company.groups',
      'company.company_gateways.gateway',
      'company.clients',
      'company.products',
      'company.invoices',
      'company.payments.paymentables',
      'company.quotes',
      //'company.credits',
      //'company.tasks',
      //'company.projects',
      //'company.expenses',
      //'company.vendors',
      // TODO add to starter
    ];
    url += '?include=${includes.join(',')}&include_static=true';

    //url += '?first_load=true&include_static=true';

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
