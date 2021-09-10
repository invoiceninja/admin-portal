import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:permission_handler/permission_handler.dart';
// ignore: unused_import
import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';

Future<MultipartFile> pickFile(
    {String fileIndex,
    FileType fileType,
    List<String> allowedExtensions}) async {
  if (kIsWeb) {
    return _pickFile(
      fileIndex: fileIndex,
      fileType: fileType,
      allowedExtensions: allowedExtensions,
    );
  } else if (isWindows()) {
    return WebUtils.pickFile(
        fileIndex: fileIndex,
        allowedExtensions: allowedExtensions,
        fileType: fileType);
  } else {
    final permission = await (fileType == FileType.image && Platform.isIOS
        ? Permission.photos.status
        : Permission.storage.status);

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
    allowedExtensions: allowedExtensions ?? [],
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
