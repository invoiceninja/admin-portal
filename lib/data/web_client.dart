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

  Future<http.Response> sendRequest(String url, String token) {
    return http.Client().get(
      url,
      headers: {'X-Ninja-Token': token},
    );
  }

  Future<dynamic> fetchItem(String url, String token) async {
    final http.Response response = await sendRequest(url, token);
    return BaseItemResponse
        .fromJson(json.decode(response.body))
        .data;
  }

  Future<List<dynamic>> fetchList(String url, String token) async {
    final http.Response response = await sendRequest(url, token);
    return BaseListResponse
        .fromJson(json.decode(response.body))
        .data
        .toList();
  }

  /// Mock that returns true or false for success or failure. In this case,
  /// it will "Always Succeed"
  Future<bool> postProducts(List<ProductEntity> products) async {
    return Future.value(true);
  }
}
