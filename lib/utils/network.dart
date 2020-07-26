import 'dart:io';
import 'package:invoiceninja_flutter/data/models/serializers.dart';

Future<bool> isOnline() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } catch (_) {}

  return false;
}

dynamic computeDecode(dynamic list) {
  return serializers.deserializeWith<dynamic>(list[0], list[1]);
}
