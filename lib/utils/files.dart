// Dart imports:
import 'dart:io';
import 'dart:io' as file;

// Flutter imports:
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:file_picker/file_picker.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

// Project imports:
import 'package:invoiceninja_flutter/utils/platforms.dart';

// ignore: unused_import
import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';
import 'package:share_plus/share_plus.dart';

Future<List<MultipartFile>?> pickFiles({
  String? fileIndex,
  FileType? fileType,
  List<String>? allowedExtensions,
  bool allowMultiple = true,
}) async {
  if (kIsWeb || isDesktopOS()) {
    return _pickFiles(
      fileIndex: fileIndex,
      fileType: fileType,
      allowedExtensions: allowedExtensions,
      allowMultiple: allowMultiple,
    );
  } else {
    PermissionStatus? status;

    if (Platform.isIOS) {
      if (fileType == FileType.image) {
        status = await Permission.photos.request();
      } else {
        status = await Permission.storage.request();
      }
    } else if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        status = await Permission.photos.request();
      } else {
        status = await Permission.storage.request();
      }
    }

    if (status == PermissionStatus.granted) {
      return _pickFiles(
        fileIndex: fileIndex,
        fileType: fileType,
        allowedExtensions: allowedExtensions,
        allowMultiple: allowMultiple,
      );
    } else {
      openAppSettings();
      return null;
    }
  }
}

Future<List<MultipartFile>?> _pickFiles({
  String? fileIndex,
  FileType? fileType,
  List<String>? allowedExtensions,
  required bool allowMultiple,
}) async {
  final result = await FilePicker.platform.pickFiles(
    type: fileType ?? FileType.custom,
    allowedExtensions:
        fileType == FileType.image ? [] : allowedExtensions ?? [],
    allowCompression: true,
    withData: true,
    allowMultiple: allowMultiple,
  );

  if (result != null && result.files.isNotEmpty) {
    final multipartFiles = <MultipartFile>[];
    for (var index = 0; index < result.files.length; index++) {
      final file = result.files[index];
      multipartFiles.add(MultipartFile.fromBytes(
          allowMultiple ? 'documents[$index]' : fileIndex!, file.bytes!,
          filename: file.name));
    }

    return multipartFiles;
  }

  return null;
}

void saveDownloadedFile(
  Uint8List data,
  String fileName, {
  String? prefix,
  String languageId = kLanguageEnglish,
}) async {
  if (prefix != null) {
    final localization = AppLocalization.of(navigatorKey.currentContext!)!;
    final store = StoreProvider.of<AppState>(navigatorKey.currentContext!);
    final localeCode = store.state.staticState.languageMap[languageId]!.locale;

    fileName = localization.lookup(prefix, overrideLocaleCode: localeCode) +
        '_' +
        fileName;
  }

  if (kIsWeb) {
    WebUtils.downloadBinaryFile(fileName, data);
  } else {
    final directory = await getAppDownloadDirectory();
    if (directory != null) {
      String filePath = '$directory/${file.Platform.pathSeparator}$fileName';

      if (file.File(filePath).existsSync()) {
        final extension = fileName.split('.').last;
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        filePath =
            filePath.replaceFirst('.$extension', '_$timestamp.$extension');
      }

      await File(filePath).writeAsBytes(data);

      if (isDesktopOS()) {
        showToast(AppLocalization.of(navigatorKey.currentContext!)!
            .fileSavedInPath
            .replaceFirst(':path', directory));
      } else {
        await Share.shareXFiles([XFile(filePath)]);
      }
    }
  }
}

Future<String?> getAppDownloadDirectory() async {
  var path = '';

  final store = StoreProvider.of<AppState>(navigatorKey.currentContext!);
  final state = store.state;

  if (state.prefState.donwloadsFolder.isNotEmpty) {
    path = state.prefState.donwloadsFolder;
  } else {
    final directory = await (isDesktopOS()
        ? getDownloadsDirectory()
        : getApplicationDocumentsDirectory());

    if (directory == null) {
      return null;
    }

    path = directory.path;
  }

  if (!Directory(path).existsSync()) {
    showErrorDialog(
        message: AppLocalization.of(navigatorKey.currentContext!)!
            .downloadsFolderDoesNotExist
            .replaceFirst(':value', path));

    return null;
  }

  return path;
}
