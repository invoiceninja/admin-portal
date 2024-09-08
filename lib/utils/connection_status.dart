import 'dart:async'; //For StreamController/Stream

import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionStatusSingleton {
  ConnectionStatusSingleton._internal();
  static final ConnectionStatusSingleton _singleton =
      new ConnectionStatusSingleton._internal();

  static ConnectionStatusSingleton getInstance() => _singleton;

  bool hasConnection = true;

  StreamController connectionChangeController =
      new StreamController.broadcast();

  final Connectivity _connectivity = Connectivity();

  void initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
  }

  Stream get connectionChange => connectionChangeController.stream;

  void dispose() {
    connectionChangeController.close();
  }

  void _connectionChange(List<ConnectivityResult> result) {
    checkConnection();
  }

  Future<bool> get isConnected async {
    try {
      final response =
          await http.head(Uri.parse('https://www.example.com')).timeout(
                Duration(seconds: 5),
              );

      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<bool> checkConnection() async {
    final previousConnection = hasConnection;

    hasConnection = await isConnected;

    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }

    return hasConnection;
  }
}
