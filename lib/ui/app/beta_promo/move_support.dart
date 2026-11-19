// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:device_info_plus/device_info_plus.dart';

// Project imports:
import 'package:invoiceninja_flutter/utils/platforms.dart';

/// How many days the move prompt waits before showing itself again, given
/// how many days are left until the sunset: monthly until the last month,
/// weekly until the last week, then daily up to and including the day itself,
/// and weekly once it has passed.
int movePromptIntervalDays(int daysLeft) {
  if (daysLeft > 30) {
    return 30;
  } else if (daysLeft > 7) {
    return 7;
  } else if (daysLeft >= 0) {
    return 1;
  }

  return 7;
}

/// Whether the move prompt is due to show itself, counted in calendar days so
/// "daily" means once a day whatever the time it was last shown
bool isMovePromptDue({
  required DateTime now,
  required DateTime? lastShown,
  required DateTime sunset,
}) {
  if (lastShown == null) {
    return true;
  }

  final today = _day(now);
  final daysSince = today.difference(_day(lastShown)).inDays;

  // A clock moved back past the last showing
  if (daysSince < 0) {
    return true;
  }

  final daysLeft = _day(sunset).difference(today).inDays;

  return daysSince >= movePromptIntervalDays(daysLeft);
}

// The local calendar day as a UTC date, so a daylight saving change can't
// turn a day's difference into 23 hours
DateTime _day(DateTime value) =>
    DateTime.utc(value.year, value.month, value.day);

/// Whether an OS version is below the oldest the new app runs on: iOS 15,
/// macOS 12 and Android 8.0 (API 26). This app runs from iOS 13, macOS 11 and
/// Android 7. Null for a platform the new app has no minimum on here.
bool? isBelowNewAppFloor({int? iosMajor, int? macosMajor, int? androidSdk}) {
  if (iosMajor != null) {
    return iosMajor < 15;
  } else if (macosMajor != null) {
    return macosMajor < 12;
  } else if (androidSdk != null) {
    return androidSdk < 26;
  }

  return null;
}

Future<bool>? _belowNewAppFloor;

/// Whether this device can't run the new app, so it's offered in the browser
/// instead. False when the version can't be read, the store says so itself.
Future<bool> deviceIsBelowNewAppFloor() =>
    _belowNewAppFloor ??= _readBelowNewAppFloor();

Future<bool> _readBelowNewAppFloor() async {
  if (kIsWeb) {
    return false;
  }

  try {
    final deviceInfo = DeviceInfoPlugin();

    if (isIOS()) {
      final version = (await deviceInfo.iosInfo).systemVersion;
      final major = int.tryParse(version.split('.').first);

      return major != null && isBelowNewAppFloor(iosMajor: major)!;
    } else if (isMacOS()) {
      final major = (await deviceInfo.macOsInfo).majorVersion;

      return isBelowNewAppFloor(macosMajor: major)!;
    } else if (isAndroid()) {
      final sdk = (await deviceInfo.androidInfo).version.sdkInt;

      return isBelowNewAppFloor(androidSdk: sdk)!;
    }
  } catch (error) {
    print('## ERROR: failed to read the OS version - $error');
  }

  return false;
}
