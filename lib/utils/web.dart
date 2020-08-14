import 'dart:async';
import 'dart:html';
import 'dart:ui' as ui;
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:redux/redux.dart';

class WebUtils {
  static String get browserUrl =>
      formatApiUrl(window.location.href.split('#')[0]);

  static Future<String> filePicker() {
    final completer = new Completer<String>();
    final InputElement input = document.createElement('input');
    input
      ..type = 'file'
      ..accept = 'image/*';
    input.onChange.listen((e) async {
      final List<File> files = input.files;
      final reader = new FileReader();
      reader.readAsDataUrl(files[0]);
      reader.onError.listen((error) => completer.completeError(error));
      await reader.onLoad.first;
      completer.complete(reader.result as String);
    });
    input.click();
    return completer.future;
  }

  static void downloadFile(String filename, String data) {
    final encodedFileContents = Uri.encodeComponent(data);
    AnchorElement(href: 'data:text/plain;charset=utf-8,$encodedFileContents')
      ..setAttribute('download', filename)
      ..click();
  }

  static void reloadBrowser() => window.location.reload();

  static void registerWebView(String html) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        html,
        (int viewId) => IFrameElement()
          ..src = html
          ..style.border = 'none');
  }

  static void warnChanges(Store<AppState> store) {
    window.onBeforeUnload.listen((Event e) {
      if (store.state.hasChanges()) {
        (e as BeforeUnloadEvent).returnValue =
            'Changes you made may not be saved.';
      }
    });
  }

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
}
