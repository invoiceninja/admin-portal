import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:redux/redux.dart';

class WebUtils {
  static String get browserUrl => null;

  static Future<String> filePicker() => null;

  static void downloadFile(String filename, String data) {}

  static void reloadBrowser() {}

  static void registerWebView(String html) {}

  static void warnChanges(Store<AppState> store) {}

  /*
  static String loadToken() => null;

  static void saveToken(String token) {}
   */
}
