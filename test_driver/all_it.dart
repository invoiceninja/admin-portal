import 'package:flutter_driver/driver_extension.dart';
import 'package:invoiceninja_flutter/main.dart' as app;

void main() {
  enableFlutterDriverExtension();
  app.main(isTesting: true);
}