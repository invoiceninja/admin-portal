import 'dart:async';
import 'dart:html';

void writeCookie(String key, String value) {
  window.document.cookie =
      '$key=$value; expires=Sat, 19 Dec 2099 12:00:00 UTC; Secure; SameSite=Strict;';
}

String readCookie() {
  return window.document.cookie;
}

Future<String> webFilePicker() {
  final completer = new Completer<String>();
  final InputElement input = document.createElement('input');
  input
    ..type = 'file'
    ..accept = 'image/*';
  input.onChange.listen((e) async {
    final List<File> files = input.files;
    final reader = new FileReader();
    reader.readAsDataUrl(files[0]);
    reader.onError.listen((error) => completer.completeError(error));
    await reader.onLoad.first;
    completer.complete(reader.result as String);
  });
  input.click();
  return completer.future;
}

void webDownload(String filename, String data) {
  final encodedFileContents = Uri.encodeComponent(data);
  AnchorElement(href: 'data:text/plain;charset=utf-8,$encodedFileContents')
    ..setAttribute('download', filename)
    ..click();
}
