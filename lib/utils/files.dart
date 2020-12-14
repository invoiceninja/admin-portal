import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';

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
  } else {
    final permissionType = fileType == FileType.image && Platform.isIOS
        ? Permission.photos
        : Permission.storage;
    final permissionStatus = await [permissionType].request();
    final permission =
        permissionStatus[permissionType] ?? PermissionStatus.undetermined;
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
    type: fileType ?? FileType.any,
    allowedExtensions: allowedExtensions ?? [],
    allowCompression: true,
    withData: true,
  );

  if (result != null) {
    final file = result.files.single;
    return MultipartFile.fromBytes(fileIndex ?? 'file', file.bytes,
        filename: file.name);
  }

  return null;
}
