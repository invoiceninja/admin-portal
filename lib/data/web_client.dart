import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/models/models.dart';

/// A class that is meant to represent a Web Service you would call to fetch
/// and persist Products to and from the cloud.
///
/// Since we're trying to keep this example simple, it doesn't communicate with
/// a real server but simply emulates the functionality.
class WebClient {

  const WebClient();

  /// Mock that "fetches" some Products from a "web service" after a short delay
  Future<List<ProductEntity>> fetchProducts() async {

    print('Web Client: fetchProducts...');

    var url = "";

    final response = await http.Client().get(
      url,
      headers: {'X-Ninja-Token': ""},
    );

    return ProductResponse
        .fromJson(json.decode(response.body))
        .products
        .toList();
  }

  /// Mock that returns true or false for success or failure. In this case,
  /// it will "Always Succeed"
  Future<bool> postProducts(List<ProductEntity> products) async {
    return Future.value(true);
  }
}
