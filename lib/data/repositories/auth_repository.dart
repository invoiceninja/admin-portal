import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/.env.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/mock/mock_login.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/serialization.dart';

class AuthRepository {
  const AuthRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<LoginResponse> signUp({
    String url,
    String email,
    String password,
    String secret,
  }) async {
    final credentials = {
      'email': email,
      'password': password,
      'terms_of_service': true,
      'privacy_policy': true,
      'token_name': _tokenName,
    };

    if ((url ?? '').isEmpty) {
      url = Constants.hostedApiUrl;
    }

    return sendRequest(
        url: formatApiUrl(url) + '/signup', data: credentials, secret: secret);
  }

  Future<LoginResponse> oauthSignUp({
    @required String idToken,
    @required String accessToken,
  }) async {
    final credentials = {
      'terms_of_service': true,
      'privacy_policy': true,
      'token_name': _tokenName,
      'id_token': idToken,
      //'access_token': accessToken,
      'provider': 'google',
    };

    return sendRequest(
        url: formatApiUrl(Constants.hostedApiUrl) + '/oauth_login?create=true',
        data: credentials,
        secret: Config.API_SECRET);
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
      {@required String idToken,
      @required String accessToken,
      @required String url,
      @required String secret,
      @required String platform}) async {
    final credentials = {
      'id_token': idToken,
      //'access_token': accessToken,
      'provider': 'google',
    };
    url = formatApiUrl(url) + '/oauth_login';

    return sendRequest(url: url, data: credentials, secret: secret);
  }

  Future<LoginResponse> refresh(
      {@required String url,
      @required String token,
      @required int updatedAt,
      @required bool includeStatic}) async {
    url = formatApiUrl(url) + '/refresh';

    if (updatedAt > 0) {
      url += '?updated_at=$updatedAt';
      includeStatic = includeStatic ||
          DateTime.now().millisecondsSinceEpoch - (updatedAt * 1000) >
              kMillisecondsToRefreshStaticData;
    } else {
      includeStatic = true;
    }

    print('## Refresh data - include static: $includeStatic');

    return sendRequest(url: url, token: token, includeStatic: includeStatic);
  }

  Future<LoginResponse> recoverPassword(
      {String email, String url, String secret, String platform}) async {
    final credentials = {
      'email': email,
    };
    url = formatApiUrl(url) + '/reset_password';

    return sendRequest(url: url, data: credentials);
  }

  Future<dynamic> addCompany({
    @required Credentials credentials,
  }) async {
    final url = '${credentials.url}/companies';
    final data = {
      'token_name': _tokenName,
    };

    return webClient.post(url, credentials.token, data: json.encode(data));
  }

  Future<dynamic> deleteCompany({
    @required Credentials credentials,
    @required String companyId,
    @required String password,
  }) async {
    final url = '${credentials.url}/companies/$companyId';
    return webClient.delete(url, credentials.token, password: password);
  }

  Future<dynamic> purgeData({
    @required Credentials credentials,
    @required String companyId,
    @required String password,
    @required String idToken,
  }) async {
    return webClient.post(
      '${credentials.url}/companies/purge_save_settings/$companyId',
      credentials.token,
      password: password,
      idToken: idToken,
    );
  }

  Future<dynamic> resendConfirmation(
      {@required Credentials credentials, @required String userId}) async {
    return webClient.post(
      '${credentials.url}/user/$userId/reconfirm',
      credentials.token,
    );
  }

  Future<LoginResponse> sendRequest({
    String url,
    dynamic data,
    String token,
    String secret,
    bool includeStatic = true,
  }) async {
    if (url.contains('?')) {
      url += '&';
    } else {
      url += '?';
    }

    url += 'first_load=true';

    if (includeStatic) {
      url += '&include_static=true';
    }

    dynamic response;

    if (Config.DEMO_MODE) {
      response = json.decode(kMockLogin);
    } else {
      response = await webClient.post(url, token ?? '',
          secret: secret, data: json.encode(data));
    }

    return await compute<dynamic, dynamic>(SerializationUtils.computeDecode,
        <dynamic>[LoginResponse.serializer, response]);
  }

  String get _tokenName => kIsWeb
      ? 'web_client'
      : Platform.isAndroid
          ? 'android_client'
          : 'ios_client';
}
