// Dart imports:
import 'dart:typed_data';

// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class WebUtils {
  static String? get apiUrl => null;

  static String? get browserUrl => null;

  static String? get browserRoute => null;

  static String? getHtmlValue(String field) => null;

  static void downloadTextFile(String filename, String data) {}

  static void downloadBinaryFile(String filename, Uint8List data) {}

  static void reloadBrowser() {}

  static void registerWebView(String? html) {}

  static void warnChanges(Store<AppState>? store) {}

  static void microsoftLogin(
    Function(String, String) successCallback,
    Function(dynamic) failureCallback,
  ) async {}

/*
  static String loadToken() => null;

  static void saveToken(String token) {}
   */
}
