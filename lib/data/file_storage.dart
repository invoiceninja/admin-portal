import 'dart:async';
import 'dart:io';

class FileStorage {
  final String tag;
  final Future<Directory> Function() getDirectory;

  const FileStorage(
    this.tag,
    this.getDirectory,
  );

  Future<String> loadData() async {
    final file = await _getLocalFile();
    final contents = await file.readAsString();

    return contents;
  }

  Future<File> saveData(String data) async {
    final file = await _getLocalFile();

    return file.writeAsString(data);
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
