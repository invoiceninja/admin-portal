import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:idb_shim/idb.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:idb_shim/idb_browser.dart';

class FileStorage {
  const FileStorage(
    this.tag,
    this.getDirectory,
  );

  static const STORE_NAME = 'records';

  final String tag;
  final Future<Directory> Function() getDirectory;

  Future<File> _getLocalFile() async {
    final dir = await getDirectory();

    return File('${dir.path}/invoiceninja__$tag.json');
  }

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

  Future<dynamic> load() async {
    if (kIsWeb) {
      final db = await _getIndexedDb();
      final txn = db.transaction(STORE_NAME, 'readonly');
      final store = txn.objectStore(STORE_NAME);
      final String value = await store.getObject(tag);
      await txn.completed;

      return value;
    } else {
      final file = await _getLocalFile();
      final contents = await file.readAsString();

      return contents;
    }
  }

  Future<File> save(String data) async {
    if (kIsWeb) {
      final db = await _getIndexedDb();
      final txn = db.transaction(STORE_NAME, 'readwrite');
      final store = txn.objectStore(STORE_NAME);
      await store.put(data, tag);
      await txn.completed;

      return null;
    } else {
      final file = await _getLocalFile();

      return file.writeAsString(data);
    }
  }

  Future<FileSystemEntity> delete() async {
    if (kIsWeb) {
      final db = await _getIndexedDb();
      final txn = db.transaction(STORE_NAME, 'readonly');
      final store = txn.objectStore(STORE_NAME);
      await store.delete(tag);
      await txn.completed;
      return null;
    } else {
      final file = await _getLocalFile();

      return file.delete();
    }
  }

  Future<bool> exists() async {
    if (kIsWeb) {
      final db = await _getIndexedDb();
      final txn = db.transaction(STORE_NAME, 'readonly');
      final store = txn.objectStore(STORE_NAME);
      return await store.count(tag) > 0;
    } else {
      final file = await _getLocalFile();

      return file.existsSync();
    }
  }
}
