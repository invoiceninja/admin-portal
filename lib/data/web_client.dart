import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
        'Content-Type': 'application/json',
      },
    );

    try {
      final jsonResponse = json.decode(response.body);
      return jsonResponse;
    } catch (exception) {
      print(response.body);
      throw('An error occurred');
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

    try {
      final jsonResponse = json.decode(response.body);
      return jsonResponse;
    } catch (exception) {
      print(response.body);
      throw('An error occurred');
    }
  }
}