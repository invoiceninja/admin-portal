import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:invoiceninja_flutter/constants.dart';

class WebClient {

  const WebClient();

  String _checkUrl(String url) {

    if (! url.startsWith('http')) {
      url = kAppUrl + url;
    }

    if (! url.contains('?')) {
      url += '?';
    }

    return url;
  }

  String _parseError(int code, String response) {
    dynamic message = response;

    if (response.contains('DOCTYPE html')) {
      return '$code: An error occurred';
    }
    
    try {
      final dynamic jsonResponse = json.decode(response);
      message = jsonResponse['error'] ?? jsonResponse;
      message = message['message'] ?? message;
    } catch(error) {
      // do nothing
    }

    return '$code: $message';
  }

  Future<dynamic> get(String url, String token) async {

    url = _checkUrl(url);
    print('GET: $url');

    if (url.contains('invoiceninja.com')) {
      url += '&per_page=$kMaxRecordsPerApiPage';
    } else {
      url += '&per_page=999999';
    }

    final http.Response response = await http.Client().get(
      url,
      headers: {
        'X-Ninja-Token': token,
      },
    );

    if (response.statusCode >= 400) {
      print('==== FAILED ====');
      print('body: ${response.body}');

      throw _parseError(response.statusCode, response.body);
    }

    final dynamic jsonResponse = json.decode(response.body);

    //print(jsonResponse);

    return jsonResponse;
  }

  Future<dynamic> post(String url, String token, [dynamic data]) async {
    url = _checkUrl(url);
    print('POST: $url');
    print('Data: $data');

    final http.Response response = await http.Client().post(
      url,
      body: data,
      headers: {
        'X-Ninja-Token': token,
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
      },
    ).timeout(const Duration(seconds: 30));

    if (response.statusCode >= 300) {
      print('==== FAILED ====');
      print('response: ${response.body}');

      throw _parseError(response.statusCode, response.body);
    }

    try {
      final dynamic jsonResponse = json.decode(response.body);
      return jsonResponse;
    } catch (exception) {
      print(response.body);
      throw 'An error occurred';
    }
  }

  Future<dynamic> put(String url, String token, dynamic data) async {
    url = _checkUrl(url);
    print('PUT: $url');
    print('Data: $data');

    final http.Response response = await http.Client().put(
      url,
      body: data,
      headers: {
        'X-Ninja-Token': token,
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
      },
    );

    if (response.statusCode >= 300) {
      print('==== FAILED ====');
      print('response: ${response.body}');

      throw _parseError(response.statusCode, response.body);
    }

    try {
      final dynamic jsonResponse = json.decode(response.body);
      return jsonResponse;
    } catch (exception) {
      print(response.body);
      throw 'An error occurred';
    }
  }
}