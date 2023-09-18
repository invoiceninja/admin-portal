// Dart imports:
import 'dart:math';

// Package imports:
import 'package:faker/faker.dart';
import 'package:flutter_driver/flutter_driver.dart';

// Project imports:
import 'package:invoiceninja_flutter/.env.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'localizations.dart';

class Keys {
  static const String clientPickerEmptyKey = '__client___';
  static const String invoiceLineItemBaseKey = '__line_item';
}

Future<bool> isTablet(FlutterDriver driver) async {
  final info =
      await driver.getRenderObjectDiagnostics(find.byType('MaterialApp'));

  final regExp = new RegExp(r'Size\(([\d\.]*), ([\d\.]*)');
  final match = regExp.firstMatch(info.toString())!;

  final width = double.parse(match.group(1)!);
  final height = double.parse(match.group(2)!);

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

  if (await isMobile(driver)) {
    print('Login mobile...');
  } else {
    print('Login desktop...');
  }

  if (selfHosted) {
    print('Tap ' + localization.selfhosted);
    await driver.tap(find.text(localization.selfhosted));
  }

  print('Fill in email/password');
  await fillTextFields(driver, <String, dynamic>{
    localization.email: loginEmail,
    localization.password: loginPassword,
  });

  if (selfHosted) {
    print('Fill in url/secret');
    await fillTextFields(driver, <String, dynamic>{
      localization.url: loginUrl,
      '${localization.secret} (${localization.optional})': loginSecret,
    });
  }

  print('Tap ' + localization.emailSignIn);
  await driver.tap(find.text(localization.emailSignIn));

  if (loginEmail.isNotEmpty) {
    print('Wait for  ' + localization.overview);
    await driver.waitFor(find.text(localization.overview),
        timeout: new Duration(seconds: 60));
  }
}

Future<void> logout(FlutterDriver driver, TestLocalization localization) async {
  if (await isMobile(driver)) {
    await driver.tap(find.byTooltip(localization.menuSidebar));
  }

  //await driver.scrollUntilVisible(find.byType('Drawer'), find.text(localization.settings));
  //await driver.tap(find.text(localization.settings));
  //await driver.tap(find.text(localization.deviceSettings));

  await driver.tap(find.byValueKey(kSelectCompanyDropdownKey));

  // Tap on Log Out
  await driver.tap(find.text(localization.logout));

  // Confirm log out
  await driver.waitFor(find.text(localization.areYouSure));
  await driver.tap(find.text(localization.ok.toUpperCase()));

  // Should be in the login screen now
  await driver.waitFor(find.text(localization.selfhosted));
}

Future<void> viewSection(
    {required FlutterDriver driver, required String name, TestLocalization? localization}) async {
  if (await isMobile(driver)) {
    await driver.tap(find.byTooltip('Menu Sidebar'));
  }

  await driver.tap(find.byValueKey('menu_' + name));
}

Future<void> fillTextField(
    {required FlutterDriver driver, String? field, required String value}) async {
  await driver.tap(find.byValueKey(field));
  await driver.enterText(value);
}

Future<void> fillTextFields(
    FlutterDriver? driver, Map<String, dynamic> values) async {
  for (var entry in values.entries) {
    await fillTextField(driver: driver!, field: entry.key, value: entry.value);
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
  await Future<dynamic>.delayed(Duration(milliseconds: 1000));

  print('Check for updated values');
  await checkTextFields(driver, values, except: skipCheckFor);

  print('Tap save');
  await driver.tap(find.text(localization.save));

  // verify snackbar
  //await driver.waitFor(find.text(localization.updatedProduct));
  //await driver.tap(find.pageBack());
}

Future<void> testArchiveAndDelete(
    {required FlutterDriver driver,
    required String archivedMessage,
    String? rowText,
    required String deletedMessage,
    required String restoredMessage}) async {
  final localization = TestLocalization('en');
  final mobile = await isMobile(driver);

  print('Archive record');
  await selectAction(driver, localization.archive);
  await driver.waitFor(find.text(archivedMessage));
  //await driver.waitFor(find.text(localization.archived));

  print('Show archived/deleted records');
  await driver.tap(find.byTooltip(localization.filter));
  await driver.tap(find.byValueKey('state_' + localization.archived));
  await driver.tap(find.byValueKey('state_' + localization.deleted));
  await driver.tap(find.byTooltip(localization.filter));

  print('Restore record');
  if (mobile)
    await driver.scrollUntilVisible(find.byType('ListView'), find.text(rowText!),
        dyScroll: -300);

  //await driver.tap(find.text(rowText));
  await selectAction(driver, localization.restore);
  await driver.waitFor(find.text(restoredMessage));
  await driver.waitForAbsent(find.byType('Snackbar'));

  print('Delete record');
  await selectAction(driver, localization.delete);
  await driver.waitFor(find.text(deletedMessage));
  //await driver.waitFor(find.text(localization.deleted));

  print('Restore record');
  if (mobile)
    await driver.scrollUntilVisible(find.byType('ListView'), find.text(rowText!),
        dyScroll: -300);
  //await driver.tap(find.text(rowText));
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
