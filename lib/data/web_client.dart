import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:invoiceninja/constants.dart';

class WebClient {

  const WebClient();

  String _parseError(String response) {
    dynamic message = response;

    try {
      final dynamic jsonResponse = json.decode(response);
      message = jsonResponse['error'] ?? jsonResponse;
      message = message['message'] ?? message;
    } catch(error) {
      // do nothing
    }

    return message.toString();
  }

  Future<dynamic> get(String url, String token) async {

    if (! url.contains('?')) 
      url += '?';
    url += '&per_page=$kMaxRecordsPerApiPage';

    final http.Response response = await http.Client().get(
      url,
      headers: {
        'X-Ninja-Token': token,
      },
    );

    if (response.statusCode >= 400) {
      throw _parseError(response.body);
    }

    final dynamic jsonResponse = json.decode(response.body);

    //print(jsonResponse);

    return jsonResponse;
  }

  Future<dynamic> post(String url, String token, dynamic data) async {
    final http.Response response = await http.Client().post(
      url,
      body: data,
      headers: {
        'X-Ninja-Token': token,
        'Content-Type': 'application/json',
      },
    );
    print('== 1 == ${_parseError(response.body)}');
    if (response.statusCode >= 400) {
      throw _parseError(response.body);
    }
    print('== 2 ==');
    try {
      final dynamic jsonResponse = json.decode(response.body);
      return jsonResponse;
    } catch (exception) {
      print(response.body);
      throw 'An error occurred';
    }
  }

  Future<dynamic> put(String url, String token, dynamic data) async {
    final http.Response response = await http.Client().put(
      url,
      body: data,
      headers: {
        'X-Ninja-Token': token,
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode >= 400) {
      throw _parseError(response.body);
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