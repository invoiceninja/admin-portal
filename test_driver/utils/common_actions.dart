import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:invoiceninja_flutter/.env.dart';

import 'localizations.dart';

class Keys {
  static const String openAppDrawer = 'Open navigation menu';
}

Future<bool> isTablet(FlutterDriver driver) async {
  final info =
      await driver.getRenderObjectDiagnostics(find.byType('MaterialApp'));

  final regExp = new RegExp(r'Size\(([\d\.]*), ([\d\.]*)');
  final match = regExp.firstMatch(info.toString());

  final width = double.parse(match.group(1));
  final height = double.parse(match.group(2));

  return min(width, height) > 600;
}

Future<void> login(FlutterDriver driver,
    {bool selfHosted = true,
    bool retype = false,
    String loginEmail = Config.TEST_EMAIL,
    String loginPassword = Config.TEST_PASSWORD,
    String loginUrl = Config.TEST_URL,
    String loginSecret = Config.TEST_SECRET}) async {
  final localization = TestLocalization('en');

  await fillTextFields(driver, <String, dynamic>{
    localization.email: loginEmail,
    localization.password: loginPassword,
  });

  if (selfHosted) {
    await fillTextFields(driver, <String, dynamic>{
      localization.url: loginUrl,
      localization.secret: loginSecret,
    });
  }

  await driver.tap(find.text(localization.login.toUpperCase()));

  await driver.waitFor(
    find.byTooltip(Keys.openAppDrawer),
    timeout: new Duration(seconds: 60),
  );
}

Future<void> logout(FlutterDriver driver, TestLocalization localization) async {
  await driver.tap(find.byTooltip(Keys.openAppDrawer));
  //await driver.scrollUntilVisible(find.byType('Drawer'), find.byValueKey(SettingsKeys.drawer));
  await driver.tap(find.byTooltip(localization.settings));

  // Tap on Log Out
  await driver.tap(find.text(localization.logout));

  // Confirm log out
  await driver.waitFor(find.text(localization.areYouSure));
  await driver.tap(find.text(localization.ok.toUpperCase()));

  // Should be in the login screen now
  await driver.waitFor(find.text(localization.login.toUpperCase()));
}

Future<void> viewSection({FlutterDriver driver, String name}) async {
  await driver.tap(find.byTooltip(Keys.openAppDrawer));
  await driver.tap(find.byTooltip(name));
}

Future<void> fillTextField(
    {FlutterDriver driver, String field, String value}) async {
  await driver.tap(find.byValueKey(field));
  await driver.enterText(value);
}

Future<void> fillTextFields(
    FlutterDriver driver, Map<String, dynamic> values) async {
  for (var entry in values.entries) {
    await fillTextField(driver: driver, field: entry.key, value: entry.value);
  }
}

String makeUnique(String value) =>
    '$value ${faker.randomGenerator.integer(999999, min: 100000)}';
