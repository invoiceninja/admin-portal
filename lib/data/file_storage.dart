import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:invoiceninja/data/models/models.dart';
//import 'package:built_redux_sample/models/serializers.dart';

/// Loads and saves a List of Products using a text file stored on the device.
class FileStorage {
  final String tag;
  final Future<Directory> Function() getDirectory;

  const FileStorage(
      this.tag,
      this.getDirectory,
      );

  /// LoadProducts
  Future<List<dynamic>> loadData() async {
    final file = await _getLocalFile();
    final contents = await file.readAsString();

    /*
    return serializers
        .deserializeWith(AppState.serializer, json.decode(contents))
        .products
        .toList();
     */

    return null;
  }

  Future<File> saveData(List<dynamic> products) async {
    final file = await _getLocalFile();

    /*
    return file.writeAsString(
      json.encode(
        serializers.serializeWith(
          AppState.serializer,
          AppState.fromProducts(products),
        ),
      ),
    );
    */

    return null;
  }

  Future<File> _getLocalFile() async {
    final dir = await getDirectory();

    return File('${dir.path}/invoiceninja__$tag.json');
  }

  Future<FileSystemEntity> clean() async {
    final file = await _getLocalFile();

    return file.delete();
  }
}
