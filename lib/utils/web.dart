// Dart imports:
import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'dart:ui' as ui;

// Package imports:
import 'package:invoiceninja_flutter/.env.dart';
import 'package:redux/redux.dart';
import 'package:msal_js/msal_js.dart';

// Project imports:
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class WebUtils {
  static String get apiUrl {
    var url = window.location.href;

    if (url.contains('?')) {
      url = url.split('?')[0];
    }

    if (url.contains('#')) {
      url = url.split('#')[0];
    }

    return formatApiUrl(url);
  }

  static String get browserUrl => cleanApiUrl(apiUrl);

  static String get browserRoute => window.location.hash.replaceFirst('#', '');

  static String? getHtmlValue(String field) =>
      window.document.documentElement!.dataset[field];

  static void downloadTextFile(String filename, String data) {
    final encodedFileContents = Uri.encodeComponent(data);
    AnchorElement(href: 'data:text/plain;charset=utf-8,$encodedFileContents')
      ..setAttribute('download', filename)
      ..click();
  }

  static void downloadBinaryFile(String filename, Uint8List data) {
    final encodedFileContents = base64Encode(data);
    AnchorElement(
        href:
            'data:application/octet-stream;charset=utf-16le;base64,$encodedFileContents')
      ..setAttribute('download', filename)
      ..click();
  }

  static void reloadBrowser() => window.location.reload();

  static void registerWebView(String? html) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        html ?? '',
        (int viewId) => IFrameElement()
          ..src = html
          ..style.border = 'none');
  }

  static void warnChanges(Store<AppState>? store) {
    window.onBeforeUnload.listen((Event e) {
      if (store!.state.hasChanges()) {
        (e as BeforeUnloadEvent).returnValue =
            'Changes you made may not be saved.';
      }
    });
  }

  static void microsoftLogin(
    Function(String, String) succesCallback,
    Function(dynamic) failureCallback,
  ) async {
    final config = Configuration()
      ..auth = (BrowserAuthOptions()
        ..redirectUri = cleanApiUrl(apiUrl)
        ..clientId = Config.MICROSOFT_CLIENT_ID);

    final publicClientApp = PublicClientApplication(config);
    final loginRequest = PopupRequest()..scopes = ['user.read'];

    publicClientApp.loginPopup(loginRequest).then((result) {
      succesCallback(
        result.idToken,
        result.accessToken,
      );
    }).catchError((dynamic error) {
      failureCallback(error);
    });
  }

/*
  String loadToken() {
    final cookies = document.cookie;
    final List<String> listValues =
        cookies.isNotEmpty ? cookies.split(';') : [];

    for (int i = 0; i < listValues.length; i++) {
      final cookie = listValues[i];
      final index = cookie.indexOf('=');
      final key = cookie.substring(0, index).trim();
      final value = cookie.substring(index + 1).trim();
      if (key == 'token') {
        return value;
      }
    }

    return null;
  }

  static void saveToken(String token) {
    document.cookie = 'token=$token; max-age=2592000; path=/;';
  }
   */
}
