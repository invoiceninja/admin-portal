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

Future<MultipartFile> pickFile(
    {String fileIndex,
    FileType fileType,
    List<String> allowedExtensions}) async {
  if (kIsWeb || isDesktopOS()) {
    return _pickFile(
      fileIndex: fileIndex,
      fileType: fileType,
      allowedExtensions: allowedExtensions,
    );
  } else {
    final permission = await (fileType == FileType.image && Platform.isIOS
        ? Permission.photos.request()
        : Permission.storage.request());

    if (permission == PermissionStatus.granted) {
      return _pickFile(
        fileIndex: fileIndex,
        fileType: fileType,
        allowedExtensions: allowedExtensions,
      );
    } else {
      openAppSettings();
      return null;
    }
  }
}

Future<MultipartFile> _pickFile(
    {String fileIndex,
    FileType fileType,
    List<String> allowedExtensions}) async {
  final result = await FilePicker.platform.pickFiles(
    type: fileType ?? FileType.custom,
    allowedExtensions:
        fileType == FileType.image ? [] : allowedExtensions ?? [],
    allowCompression: true,
    withData: true,
    allowMultiple: false,
  );

  if (result != null && result.files.isNotEmpty) {
    final file = result.files.first;
    return MultipartFile.fromBytes(fileIndex ?? 'file', file.bytes,
        filename: file.name);
  }

  return null;
}
