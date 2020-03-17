import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FileStorage {
  const FileStorage(
    this.tag,
    this.getDirectory,
  );

  final String tag;
  final Future<Directory> Function() getDirectory;

  Future<File> _getLocalFile() async {
    final dir = await getDirectory();

    return File('${dir.path}/invoiceninja__$tag.json');
  }

  Future<dynamic> load() async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(tag);
    } else {
      final file = await _getLocalFile();
      final contents = await file.readAsString();

      return contents;
    }
  }

  Future<File> save(String data) async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(tag, data);

      return null;
    } else {
      final file = await _getLocalFile();

      return file.writeAsString(data);
    }
  }

  Future<FileSystemEntity> delete() async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove(tag);
      return null;
    } else {
      final file = await _getLocalFile();

      return file.delete();
    }
  }

  Future<bool> exists() async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      return prefs.containsKey(tag);
    } else {
      final file = await _getLocalFile();

      return file.existsSync();
    }
  }
}
