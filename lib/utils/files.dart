// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';

// Project imports:
import 'package:invoiceninja_flutter/utils/platforms.dart';

// ignore: unused_import
import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';

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
    final permission = await (fileType == FileType.image && Platform.isIOS
        ? Permission.photos.request()
        : Permission.storage.request());

    if (permission == PermissionStatus.granted) {
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
