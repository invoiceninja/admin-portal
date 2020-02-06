import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
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
      headers: _getHeaders(token),
    );

    _checkResponse(response);

    final dynamic jsonResponse = json.decode(response.body);

    //debugPrint(response.body, wrapWidth: 1000);

    return jsonResponse;
  }

  Future<dynamic> post(
    String url,
    String token, {
    dynamic data,
    String filePath,
    String fileIndex,
    String secret,
  }) async {
    url = _checkUrl(url);
    print('POST: $url');
    debugPrint('Data: $data', wrapWidth: 1000);
    http.Response response;

    if (filePath != null) {
      response = await _uploadFile(url, token, filePath,
          fileIndex: fileIndex, data: data);
    } else {
      response = await http.Client()
          .post(url, body: data, headers: _getHeaders(token, secret: secret))
          .timeout(const Duration(seconds: kMaxPostSeconds));
    }

    _checkResponse(response);

    return json.decode(response.body);
  }

  Future<dynamic> put(String url, String token,
      {dynamic data,
      String filePath,
      String fileIndex = 'file',
      String password}) async {
    url = _checkUrl(url);
    print('PUT: $url');
    debugPrint('Data: $data', wrapWidth: 1000);

    http.Response response;

    if (filePath != null) {
      response = await _uploadFile(url, token, filePath,
          fileIndex: fileIndex, data: data, method: 'PUT');
    } else {
      response = await http.Client().put(
        url,
        body: data,
        headers: _getHeaders(token, password: password),
      );
    }

    _checkResponse(response);

    return json.decode(response.body);
  }

  Future<dynamic> delete(String url, String token) async {
    url = _checkUrl(url);
    print('Delete: $url');

    final http.Response response = await http.Client().delete(
      url,
      headers: _getHeaders(token),
    );

    _checkResponse(response);

    return json.decode(response.body);
  }
}

String _checkUrl(String url) {
  if (!url.contains('/api/v1')) {
    url = '/api/v1' + url;
  }

  if (!url.startsWith('http')) {
    url = kAppUrl + url;
  }

  if (!url.contains('?')) {
    url += '?';
  }

  return url;
}

Map<String, String> _getHeaders(String token,
    {String secret, String password}) {
  final headers = {
    'X-API-Secret': (secret ?? '').isNotEmpty ? secret : Config.API_SECRET,
    'X-Requested-With': 'XMLHttpRequest',
    'Content-Type': 'application/json',
  };

  if (token != null && token.isNotEmpty) {
    headers['X-API-Token'] = token;
  }

  if (password != null && password.isNotEmpty) {
    headers['X-API-PASSWORD'] = password;
  }

  return headers;
}

void _checkResponse(http.Response response) {
  if (Config.DEMO_MODE) {
    throw 'Server requests are not supported in the demo';
  }

  debugPrint(
      'response: ${response.statusCode} ${response.body.substring(0, min(response.body.length, 20000))}',
      wrapWidth: 1000);
  //print('response: ${response.statusCode} ${response.body}');
  print('headers: ${response.headers}');

  final version = response.headers['x-app-version'];

  if (version != null && !_isVersionSupported(version)) {
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

Future<http.Response> _uploadFile(String url, String token, String filePath,
    {String method = 'POST', String fileIndex = 'file', dynamic data}) async {
  final file = File(filePath);
  final stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
  final length = await file.length();

  final request = http.MultipartRequest(method, Uri.parse(url))
    ..fields.addAll(data ?? {})
    ..headers.addAll(_getHeaders(token))
    ..files.add(http.MultipartFile(fileIndex, stream, length,
        filename: basename(file.path)));

  return await http.Response.fromStream(await request.send())
      .timeout(const Duration(minutes: 10));
}
