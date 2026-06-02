// Dart imports:
import 'dart:convert';
import 'dart:typed_data';
import 'dart:js_interop';

// Flutter imports:
import 'dart:ui_web' as ui_web;

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/.env.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:msal_js/msal_js.dart';
import 'package:redux/redux.dart';
import 'package:web/web.dart' as web;

// Project imports:
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class WebUtils {
  // ---------------------------------------------------------------------------
  // URL Utilities
  // ---------------------------------------------------------------------------

  static String get apiUrl {
    var url = web.window.location.href.toString();

    if (url.contains('?')) {
      url = url.split('?')[0];
    }
    if (url.contains('#')) {
      url = url.split('#')[0];
    }

    return formatApiUrl(url);
  }

  static String get browserUrl => cleanApiUrl(apiUrl);

  static String get browserRoute =>
      web.window.location.hash.toString().replaceFirst('#', '');

  // ---------------------------------------------------------------------------
  // DOM Helpers
  // ---------------------------------------------------------------------------

  static String? getHtmlValue(String field) {
    final element = web.window.document.documentElement;
    if (element == null) {
      return null;
    }
    final value = element.getAttribute('data-$field');
    return value?.toString();
  }

  // ---------------------------------------------------------------------------
  // File Downloads
  // ---------------------------------------------------------------------------

  static void downloadTextFile(String filename, String data) {
    final encodedFileContents = Uri.encodeComponent(data);
    final anchor = web.HTMLAnchorElement()
      ..href = 'data:text/plain;charset=utf-8,$encodedFileContents'
      ..download = filename;
    anchor.click();
  }

  static void downloadBinaryFile(String filename, Uint8List data) {
    final encodedFileContents = base64Encode(data);
    final anchor = web.HTMLAnchorElement()
      ..href =
          'data:application/octet-stream;charset=utf-16le;base64,$encodedFileContents'
      ..download = filename;
    anchor.click();
  }

  // ---------------------------------------------------------------------------
  // Browser Actions
  // ---------------------------------------------------------------------------

  static void reloadBrowser() {
    web.window.location.reload();
  }

  // ---------------------------------------------------------------------------
  // HTML View Registration
  // ---------------------------------------------------------------------------

  static void registerWebView(String? html) {
    // Still required for HtmlElementView on Flutter Web
    // ignore: undefined_prefixed_name
    ui_web.platformViewRegistry.registerViewFactory(
      html ?? '',
      (int viewId) => web.HTMLIFrameElement()
        ..src = html ?? ''
        ..style.border = 'none',
    );
  }

  // ---------------------------------------------------------------------------
  // Warn About Unsaved Changes
  // ---------------------------------------------------------------------------

  static void warnChanges(Store<AppState>? store) {
    // define the Dart callback
    void handleBeforeUnload(web.Event event) {
      if (store != null && store.state.hasChanges()) {
        final beforeUnload = event as web.BeforeUnloadEvent;
        beforeUnload.returnValue = 'Changes you made may not be saved.';
      }
    }

    // convert it to a JS listener
    final jsListener = handleBeforeUnload.toJS;

    // attach safely
    web.window.addEventListener('beforeunload', jsListener);
  }

  // ---------------------------------------------------------------------------
  // Microsoft Login (MSAL.js)
  // ---------------------------------------------------------------------------

  static void microsoftLogin(
    Function(String, String) successCallback,
    Function(dynamic) failureCallback,
  ) async {
    final store = StoreProvider.of<AppState>(navigatorKey.currentContext!);
    final state = store.state;

    String clientId = Config.MICROSOFT_CLIENT_ID;
    if (state.isSelfHosted) {
      clientId = WebUtils.getHtmlValue('microsoft-client-id') ?? '';
    }

    final config = Configuration()
      ..auth = (BrowserAuthOptions()
        ..redirectUri = cleanApiUrl(apiUrl)
        ..clientId = clientId);

    final publicClientApp = PublicClientApplication(config);
    final loginRequest = PopupRequest()..scopes = ['user.read'];

    publicClientApp.loginPopup(loginRequest).then((result) {
      successCallback(result.idToken, result.accessToken);
    }).catchError(failureCallback);
  }

  // ---------------------------------------------------------------------------
  // (Optional) Cookie Helpers (commented out)
  // ---------------------------------------------------------------------------

  /*
  static String? loadToken() {
    final cookies = web.window.document.cookie?.toString() ?? '';
    final listValues = cookies.isNotEmpty ? cookies.split(';') : [];

    for (final cookie in listValues) {
      final index = cookie.indexOf('=');
      if (index == -1) continue;
      final key = cookie.substring(0, index).trim();
      final value = cookie.substring(index + 1).trim();
      if (key == 'token') {
        return value;
      }
    }

    return null;
  }

  static void saveToken(String token) {
    web.window.document.cookie = 'token=$token; max-age=2592000; path=/;';
  }
  */
}
