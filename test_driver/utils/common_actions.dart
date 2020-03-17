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

Future<bool> isMobile(FlutterDriver driver) async => !await isTablet(driver);

Future<void> login(FlutterDriver driver,
    {bool selfHosted = true,
    bool retype = false,
    String loginEmail = Config.TEST_EMAIL,
    String loginPassword = Config.TEST_PASSWORD,
    String loginUrl = Config.TEST_URL,
    String loginSecret = Config.TEST_SECRET}) async {
  final localization = TestLocalization('en');

  /*
  if (selfHosted && !retype) {
    await driver.tap(find.byValueKey(localization.selfhostLogin));
  }
   */

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

  if (loginEmail.isNotEmpty) {
    await driver.waitFor(find.text(localization.dashboard),
        timeout: new Duration(seconds: 60));
  }
}

Future<void> logout(FlutterDriver driver, TestLocalization localization) async {
  if (await isMobile(driver)) {
    await driver.tap(find.byTooltip(Keys.openAppDrawer));
  }

  //await driver.scrollUntilVisible(find.byType('Drawer'), find.byValueKey(SettingsKeys.drawer));
  await driver.tap(find.text(localization.settings));

  // Tap on Log Out
  await driver.tap(find.text(localization.logout));

  // Confirm log out
  await driver.waitFor(find.text(localization.areYouSure));
  await driver.tap(find.text(localization.ok.toUpperCase()));

  // Should be in the login screen now
  await driver.waitFor(find.text(localization.emailLogin.toUpperCase()));
}

Future<void> viewSection({FlutterDriver driver, String name}) async {
  if (await isMobile(driver)) {
    await driver.tap(find.byTooltip(Keys.openAppDrawer));
  }

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

Future<void> checkTextFields(FlutterDriver driver, Map<String, dynamic> values,
    {List<String> except = const []}) async {
  for (var entry in values.entries) {
    if (except.contains(entry.key)) {
      continue;
    }
    print('Checking for $entry');
    await driver.waitFor(find.text(entry.value));
  }
}

Future<void> fillAndSaveForm(FlutterDriver driver, Map<String, dynamic> values,
    {List<String> skipCheckFor = const []}) async {
  final localization = TestLocalization('en');

  print('Fill in form');
  await fillTextFields(driver, values);

  print('Tap save');
  await driver.tap(find.text(localization.save));

  // verify snackbar
  //await driver.waitFor(find.text(localization.updatedProduct));
  //await driver.tap(find.pageBack());

  print('Check for updated values');
  await checkTextFields(driver, values, except: skipCheckFor);
}

Future<void> testArchiveAndDelete(
    {FlutterDriver driver,
    String archivedMessage,
    String deletedMessage,
    String restoredMessage}) async {
  final localization = TestLocalization('en');

  print('Archive record');
  selectAction(driver, localization.archive);
  await driver.waitFor(find.text(archivedMessage));
  await driver.waitFor(find.text(localization.archived));

  print('Restore record');
  selectAction(driver, localization.restore);
  await driver.waitFor(find.text(restoredMessage));
  await driver.waitForAbsent(find.text(localization.archived));

  print('Delete record');
  selectAction(driver, localization.delete);
  await driver.waitFor(find.text(deletedMessage));
  await driver.waitFor(find.text(localization.deleted));

  print('Restore record');
  selectAction(driver, localization.restore);
  await driver.waitFor(find.text(restoredMessage));
  await driver.waitForAbsent(find.text(localization.deleted));
}

Future<void> selectAction(FlutterDriver driver, String action) async {
  await driver.tap(find.byType('ActionMenuButton'));
  await driver.tap(find.text(action));
}

String makeUnique(String value) =>
    '$value ${faker.randomGenerator.integer(999999, min: 100000)}';
