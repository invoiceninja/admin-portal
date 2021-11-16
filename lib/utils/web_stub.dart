// Dart imports:
import 'dart:typed_data';

// Package imports:
import 'package:file_picker/file_picker.dart';
import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:http/http.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class WebUtils {
  static String get browserUrl => null;

  static String get browserRoute => null;

  static String getHtmlValue(String field) => null;

  static void downloadTextFile(String filename, String data) {}

  static void downloadBinaryFile(String filename, Uint8List data) {}

  static void reloadBrowser() {}

  static void registerWebView(String html) {}

  static void warnChanges(Store<AppState> store) {}

  static Future<MultipartFile> pickFile(
      {String fileIndex,
      FileType fileType,
      List<String> allowedExtensions}) async {
    final filePicker = OpenFilePicker();
    final file = filePicker.getFile();

    if (file == null) {
      return null;
    }

    return MultipartFile.fromBytes(
        fileIndex ?? 'file', await file.readAsBytes(),
        filename: file.path.split('\\').last.split('/').last);
  }

/*
  static String loadToken() => null;

  static void saveToken(String token) {}
   */
}
