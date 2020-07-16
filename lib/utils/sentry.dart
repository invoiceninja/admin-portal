import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:sentry/sentry.dart';

Future<Event> getSentryEvent(
    {AppState state, dynamic exception, dynamic stackTrace}) async {
  OperatingSystem os;
  Device device;

  if (kIsWeb) {
    // TODO track web info
    os = OperatingSystem(
      name: 'Web',
    );
  } else {
    //final packageInfo = await PackageInfo.fromPlatform();
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      os = OperatingSystem(
        name: 'Android',
        version: androidInfo.version.release,
      );
      device = Device(
        model: androidInfo.model,
        manufacturer: androidInfo.manufacturer,
        modelId: androidInfo.product,
      );
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      os = OperatingSystem(
        name: iosInfo.systemName,
        version: iosInfo.systemVersion,
      );
      device = Device(
        model: iosInfo.utsname.machine,
        manufacturer: 'Apple',
        family: iosInfo.model,
      );
    }
  }

  return Event(
    release: kClientVersion,
    //release: packageInfo.version,
    environment: state?.environment ?? 'Unknown',
    stackTrace: stackTrace,
    exception: exception,
    contexts: Contexts(
        operatingSystem: os,
        device: device,
        app: App(
          version: kClientVersion,
          //name: packageInfo.appName,
          //version: packageInfo.version,
          //build: packageInfo.buildNumber,
        )),
  );
}
