import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:invoiceninja/data/models/models.dart';

/// A class that is meant to represent a Web Service you would call to fetch
/// and persist Products to and from the cloud.
///
/// Since we're trying to keep this example simple, it doesn't communicate with
/// a real server but simply emulates the functionality.
class WebClient {

  const WebClient();

  Future<http.Response> sendGetRequest(String url, String token) {
    return http.Client().get(
      url,
      headers: {
        'X-Ninja-Token': token,
      },
    );
  }

  Future<http.Response> sendPostRequest(String url, String token, dynamic data) {
    return http.Client().post(
      url,
      body: data,
      headers: {
        'X-Ninja-Token': token,
      },
    );
  }


  Future<dynamic> fetchItem(String url, String token) async {
    final http.Response response = await sendGetRequest(url, token);
    final result = BaseItemResponse.fromJson(json.decode(response.body));

    if (result.error != null && result.error.message != null) {
      throw(result.error.message);
    } else {
      return result.data;
    }
  }


  Future<List<dynamic>> fetchList(String url, String token) async {
    final http.Response response = await sendGetRequest(url, token);
    final result = BaseListResponse.fromJson(json.decode(response.body));

    if (result.error != null && result.error.message != null) {
      throw(result.error.message);
    } else {
      return result.data.toList();
    }
  }

  Future<List<dynamic>> postList(String url, String token, var data) async {
    final http.Response response = await sendPostRequest(url, token, data);
    final result = BaseListResponse.fromJson(json.decode(response.body));

    if (result.error != null && result.error.message != null) {
      throw(result.error.message);
    } else {
      return result.data.toList();
    }
  }
}
