import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';

Future<MultipartFile> pickFile({String fileIndex = 'file'}) async {
  if (kIsWeb) {
    return _pickFile(fileIndex: fileIndex);
  } else {
    final permissionStatus = await [Permission.photos].request();
    final permission =
        permissionStatus[Permission.photos] ?? PermissionStatus.undetermined;
    if (permission == PermissionStatus.granted) {
      return _pickFile(fileIndex: fileIndex);
    } else {
      openAppSettings();
      return null;
    }
  }
}

Future<MultipartFile> _pickFile({String fileIndex}) async {
  final result = await FilePicker.platform.pickFiles();
  if (result != null) {
    final file = result.files.single;
    return MultipartFile.fromBytes(fileIndex ?? 'file', file.bytes,
        filename: file.name);
  }

  return null;
}
