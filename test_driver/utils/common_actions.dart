/*
import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:invoiceninja_flutter/.env.dart';

import 'localizations.dart';

class Keys {
  static const String openAppDrawer = 'Open navigation menu';
  static const String clientPickerEmptyKey = '__client___';
  static const String invoiceLineItemBaseKey = '__line_item';
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
  if (selfHosted) {
    await driver.tap(find.text(localization.selfhosted.toUpperCase()));
  }

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

  await driver.tap(find.text(localization.emailSignIn));

  if (loginEmail.isNotEmpty) {
    await driver.waitFor(find.text(localization.overview),
        timeout: new Duration(seconds: 60));
  }
}

Future<void> logout(FlutterDriver driver, TestLocalization localization,
    {bool fromDashboard = false}) async {
  if (await isMobile(driver)) {
    await driver.tap(fromDashboard
        ? find.byTooltip(Keys.openAppDrawer)
        : find.byTooltip(localization.menuSidebar));
  }

  //await driver.scrollUntilVisible(find.byType('Drawer'), find.text(localization.settings));
  await driver.tap(find.text(localization.settings));
  await driver.tap(find.text(localization.deviceSettings));

  // Tap on Log Out
  await driver.tap(find.text(localization.logout));

  // Confirm log out
  await driver.waitFor(find.text(localization.areYouSure));
  await driver.tap(find.text(localization.ok.toUpperCase()));

  // Should be in the login screen now
  await driver.waitFor(find.text(localization.selfhosted.toUpperCase()));
}

Future<void> viewSection({FlutterDriver driver, String name}) async {
  if (await isMobile(driver)) {
    await driver.tap(find.byTooltip(Keys.openAppDrawer));
  }

  await driver.tap(find.text(name));
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

  // Await for Debouncer
  await Future<dynamic>.delayed(Duration(milliseconds: 400));

  print('Check for updated values');
  await checkTextFields(driver, values, except: skipCheckFor);

  print('Tap save');
  await driver.tap(find.text(localization.save));

  // verify snackbar
  //await driver.waitFor(find.text(localization.updatedProduct));
  //await driver.tap(find.pageBack());
}

Future<void> testArchiveAndDelete(
    {FlutterDriver driver,
    String archivedMessage,
    String deletedMessage,
    String restoredMessage}) async {
  final localization = TestLocalization('en');
  final mobile = await isMobile(driver);

  if (!mobile) {
    // Show archived and deleted entries on tablet/web
    await driver.tap(find.byTooltip(localization.filter));
    await driver.tap(find.text(localization.archived));
    await driver.tap(find.text(localization.deleted));
    await driver.tap(find.byTooltip(localization.filter));
  }

  print('Archive record');
  await selectAction(driver, localization.archive);
  await driver.waitFor(find.text(archivedMessage));
  //await driver.waitFor(find.text(localization.archived));

  print('Restore record');
  await selectAction(driver, localization.restore);
  await driver.waitFor(find.text(restoredMessage));
  await driver.waitForAbsent(find.byType('Snackbar'));

  print('Delete record');
  await selectAction(driver, localization.delete);
  await driver.waitFor(find.text(deletedMessage));
  //await driver.waitFor(find.text(localization.deleted));

  print('Restore record');
  await selectAction(driver, localization.restore);
  await driver.waitFor(find.text(restoredMessage));
  await driver.waitForAbsent(find.byType('Snackbar'));
}

Future<void> selectAction(FlutterDriver driver, String action) async {
  await driver.tap(find.byType('ViewActionMenuButton'));
  await driver.tap(find.text(action));
}

String makeUnique(String value) =>
    '$value ${faker.randomGenerator.integer(999999, min: 100000)}';

String getLineItemKey(String key, int index) =>
    '${Keys.invoiceLineItemBaseKey}_${index}_${key}__';
*/