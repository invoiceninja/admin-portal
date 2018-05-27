import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;

/// A class that is meant to represent a Web Service you would call to fetch
/// and persist Products to and from the cloud.
///
/// Since we're trying to keep this example simple, it doesn't communicate with
/// a real server but simply emulates the functionality.
class WebClient {

  const WebClient();

  Future<dynamic> get(String url, String token) async {
    final http.Response response = await http.Client().get(
      url,
      headers: {
        'X-Ninja-Token': token,
      },
    );

    final jsonResponse = json.decode(response.body);

    //print(jsonResponse);

    return jsonResponse;
  }

  Future<dynamic> post(String url, String token, dynamic data) async {
    final http.Response response = await http.Client().post(
      url,
      body: data,
      headers: {
        'X-Ninja-Token': token,
      },
    );

    try {
      final jsonResponse = json.decode(response.body);

      return jsonResponse;
    } catch (exception) {
      print(response.body);
      throw('An error occurred');
    }

    /*
    if (jsonResponse.error != null && jsonResponse.error.message != null) {
      throw(jsonResponse.error.message);
    }
    */

  }
}