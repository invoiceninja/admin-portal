import 'package:flutter_driver/flutter_driver.dart';
import 'package:invoiceninja_flutter/.env.dart';
import 'package:invoiceninja_flutter/utils/keys.dart';

import 'localizations.dart';

Future<void> login(FlutterDriver driver,
  {
    bool selfHosted = true,
    bool retype = false,
    String loginEmail = Config.TEST_EMAIL,
    String loginPassword = Config.TEST_PASSWORD,
    String loginUrl = Config.TEST_URL,
    String loginSecret = Config.TEST_SECRET
  }) async {
  await fillTextFields(driver, <String, dynamic>{
    LoginKeys.email: loginEmail,
    LoginKeys.password: loginPassword,
  });

  if (selfHosted) {
    await fillTextFields(driver, <String, dynamic>{
      LoginKeys.url: loginUrl,
      LoginKeys.secret: loginSecret,
    });
  }

  await driver.tap(find.text(LoginKeys.loginButton.toUpperCase()));
}

Future<void> logout(FlutterDriver driver, TestLocalization localization) async {
  // Go to Settings Screen
  await driver.tap(find.byTooltip(AppKeys.openAppDrawer));
  await driver.scrollUntilVisible(find.byType('Drawer'), find.byValueKey(SettingsKeys.drawer));
  await driver.tap(find.byValueKey(SettingsKeys.drawer));

  // Tap on Log Out
  await driver.tap(find.text(localization.logout));

  // Confirm log out
  await driver.waitFor(find.text(localization.areYouSure));
  await driver.tap(find.text(localization.ok.toUpperCase()));

  // Should be in the login screen now
  await driver.waitFor(find.text(localization.login.toUpperCase()));
}

Future<void> loginAndOpenProducts(FlutterDriver driver) async {
  login(driver);
  await driver.waitFor(find.byType(AppKeys.dashboardScreen));
  await driver.tap(find.byTooltip(AppKeys.openAppDrawer));
  await driver.tap(find.byValueKey(ProductKeys.drawer));
  await driver.waitFor(find.byType(ProductKeys.screen));
}

Future<void> loginAndOpenClients(FlutterDriver driver) async {
  login(driver);
  await driver.waitFor(find.byType(AppKeys.dashboardScreen));
  await driver.tap(find.byTooltip(AppKeys.openAppDrawer));
  await driver.tap(find.byValueKey(ClientKeys.drawer));
  await driver.waitFor(find.byType(ClientKeys.screen));
}

Future<void> fillTextFields(FlutterDriver driver, Map<String, dynamic> values) async {
  for (var entry in values.entries) {
    await driver.tap(find.byValueKey(entry.key));
    await driver.enterText(entry.value);
  }
}