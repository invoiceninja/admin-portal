import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:invoiceninja_flutter/constants.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';

class WebClient {
  const WebClient();

  String _checkUrl(String url) {
    if (!url.startsWith('http')) {
      url = kAppUrl + url;
    }

    if (!url.contains('?')) {
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
      try {
        jsonResponse['errors'].forEach((String field, List<String> errors) =>
            errors.forEach((error) => message += '\n$field: $error'));
      } catch (error) {
        // do nothing
      }
    } catch (error) {
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

  Future<dynamic> post(String url, String token,
      [dynamic data, String filePath]) async {
    url = _checkUrl(url);
    print('POST: $url');
    print('Data: $data');
    http.Response response;

    final Map<String, String> headers = {
      'X-Ninja-Token': token,
      'Content-Type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
    };

    if (filePath != null) {
      final file = File(filePath);
      final stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
      final length = await file.length();

      final request = http.MultipartRequest('POST', Uri.parse(url))
        ..fields.addAll(data)
        ..headers.addAll(headers)
        ..files.add(http.MultipartFile('file', stream, length,
            filename: basename(file.path)));

      response = await http.Response.fromStream(await request.send())
          .timeout(const Duration(minutes: 10));
    } else {
      response = await http.Client()
          .post(url, body: data, headers: headers)
          .timeout(const Duration(seconds: 30));
    }

    print('response: ${response.body}');

    if (response.statusCode >= 300) {
      print('==== FAILED ====');

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

    print('response: ${response.body}');

    if (response.statusCode >= 300) {
      print('==== FAILED ====');
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

  Future<dynamic> delete(String url, String token) async {
    url = _checkUrl(url);
    print('Delete: $url');

    final http.Response response = await http.Client().delete(
      url,
      headers: {
        'X-Ninja-Token': token,
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
      },
    );

    print('response: ${response.body}');

    if (response.statusCode >= 300) {
      print('==== FAILED ====');
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
