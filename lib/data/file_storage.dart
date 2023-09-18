// Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:archive/archive.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:idb_shim/idb.dart';
//import 'package:idb_shim/idb_browser.dart';

class FileStorage {
  const FileStorage(
    this.tag,
    this.getDirectory,
  );

  static const GZIP_TAG = '_gzip';
  static const STORE_NAME = 'invoiceninja';

  final String tag;
  final Future<Directory> Function() getDirectory;

  Future<File> _getLocalFile() async {
    final dir = await getDirectory();

    if (isWindows()) {
      return File('${dir.path}/invoiceninja/$tag.json');
    } else {
      return File('${dir.path}/invoiceninja__$tag.json');
    }
  }

  /*
  Future<Database> _getIndexedDb() async {
    final idbFactory = getIdbFactory();
    idbFactory.open(kAppName, version: 1,
        onUpgradeNeeded: (VersionChangeEvent event) {
      final db = event.database;
      db.createObjectStore(STORE_NAME, autoIncrement: true);
    });

    final db = await idbFactory.open(kAppName, version: 1,
        onUpgradeNeeded: (VersionChangeEvent event) {
      final db = event.database;
      db.createObjectStore(STORE_NAME, autoIncrement: true);
    });

    return db;
  }
   */

  Future<dynamic> load() async {
    if (kIsWeb) {
      /*
      final db = await _getIndexedDb();
      final txn = db.transaction(STORE_NAME, 'readonly');
      final store = txn.objectStore(STORE_NAME);
      final String value = await store.getObject(tag);
      await txn.completed;
      return value;
      */

      final prefs = await SharedPreferences.getInstance();
      String? value = prefs.getString(tag);

      if (value != null) {
        return value;
      }

      value = prefs.getString(tag + GZIP_TAG);

      if (value != null) {
        final decoded = base64Decode(value);
        final unzipped = GZipDecoder().decodeBytes(decoded);
        return utf8.decode(unzipped);
      }
    } else {
      final file = await _getLocalFile();
      final contents = await file.readAsString();

      return contents;
    }
  }

  Future<File?> save(String data) async {
    if (kIsWeb) {
      /*
      final db = await _getIndexedDb();
      final txn = db.transaction(STORE_NAME, 'readwrite');
      final store = txn.objectStore(STORE_NAME);
      await store.put(data, tag);
      await txn.completed;
      */

      final prefs = await SharedPreferences.getInstance();
      try {
        await prefs.setString(tag, data);
      } catch (e) {
        if ('$e'.contains('QuotaExceededError')) {
          await prefs.remove(tag);
          final gzipBytes = GZipEncoder().encode(utf8.encode(data))!;
          final zipped = base64Encode(gzipBytes);
          try {
            await prefs.setString(tag + GZIP_TAG, zipped);
          } catch (e) {
            if ('$e'.contains('QuotaExceededError')) {
              await prefs.remove(tag + GZIP_TAG);
            }
          }
        }
      }

      return null;
    } else {
      final file = await _getLocalFile();

      return file.writeAsString(data);
    }
  }

  Future<FileSystemEntity?> delete() async {
    if (kIsWeb) {
      /*
      final db = await _getIndexedDb();
      final txn = db.transaction(STORE_NAME, 'readonly');
      final store = txn.objectStore(STORE_NAME);
      await store.delete(tag);
      await txn.completed;
       */

      final prefs = await SharedPreferences.getInstance();
      prefs.remove(tag);
      prefs.remove(tag + GZIP_TAG);

      return null;
    } else {
      final file = await _getLocalFile();

      return file.delete();
    }
  }

  Future<bool> exists() async {
    if (kIsWeb) {
      /*
      final db = await _getIndexedDb();
      final txn = db.transaction(STORE_NAME, 'readonly');
      final store = txn.objectStore(STORE_NAME);
      return await store.count(tag) > 0;
       */
      final prefs = await SharedPreferences.getInstance();
      return prefs.containsKey(tag) || prefs.containsKey(tag + GZIP_TAG);
    } else {
      final file = await _getLocalFile();

      return file.existsSync();
    }
  }
}
