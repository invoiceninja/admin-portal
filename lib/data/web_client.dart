import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:invoiceninja_flutter/.env.dart';
import 'package:http/http.dart' as http;
import 'package:invoiceninja_flutter/constants.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';

class WebClient {
  const WebClient();

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

    _checkResponse(response);

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
      'X-API-SECRET': Config.API_SECRET,
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

    _checkResponse(response);

    return json.decode(response.body);
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

    _checkResponse(response);

    return json.decode(response.body);
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

    _checkResponse(response);

    return json.decode(response.body);
  }
}

String _checkUrl(String url) {
  if (!url.startsWith('http')) {
    if (!url.contains('/api/v1')) {
      url = '/api/v1' + url;
    }

    url = kAppUrl + url;
  }

  if (!url.contains('?')) {
    url += '?';
  }

  return url;
}

void _checkResponse(http.Response response) {
  //debugPrint('response: ${response.statusCode} ${response.body}');
  print('response: ${response.statusCode} ${response.body}');
  print('headers: ${response.headers}');

  final version = response.headers['x-app-version'];

  if (_isVersionSupported(version)) {
    throw 'The minimum web app version is v$kMinMajorAppVersion.$kMinMinorAppVersion.$kMinPatchAppVersion';
  } else if (response.statusCode >= 400) {
    print('==== FAILED ====');
    throw _parseError(response.statusCode, response.body);
  }
}

String _parseError(int code, String response) {
  dynamic message = response;

  if (response.contains('DOCTYPE html')) {
    return '$code: An error occurred';
  }

  try {
    final dynamic jsonResponse = json.decode(response);
    message = jsonResponse['message'] ?? jsonResponse;

    if (jsonResponse['errors'] != null) {
      try {
        jsonResponse['errors'].forEach((String field, dynamic errors) {
          (errors as List<dynamic>)
              .forEach((dynamic error) => message += '\n • $error');
        });
      } catch (error) {
        print('parse error');
        print(error);
        // do nothing
      }
    }
  } catch (error) {
    // do nothing
  }

  return '$code: $message';
}

bool _isVersionSupported(String version) {
  if (version == null || version.isEmpty) {
    return false;
  }

  final parts = version.split('.');

  final int major = int.parse(parts[0]);
  final int minor = int.parse(parts[1]);
  final int patch = int.parse(parts[2]);

  return major >= kMinMajorAppVersion &&
      minor >= kMinMinorAppVersion &&
      patch >= kMinPatchAppVersion;
}
