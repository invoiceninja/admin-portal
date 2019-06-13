import 'package:flutter_driver/flutter_driver.dart';
import 'package:invoiceninja_flutter/.env.dart';
import 'package:invoiceninja_flutter/utils/keys.dart';

Future<void> login(FlutterDriver driver,
  {
    bool selfHosted = true,
    bool retype = false,
    String loginEmail = Config.TEST_EMAIL,
    String loginPassword = Config.TEST_PASSWORD,
    String loginUrl = Config.TEST_URL,
    String loginSecret = Config.TEST_SECRET
  }) async {
  if (selfHosted && !retype) {
    await driver.tap(find.byValueKey(LoginKeys.loginSelfHost));
  }

  await driver.tap(find.byValueKey(LoginKeys.email));
  await driver.enterText(loginEmail);
  await driver.tap(find.byValueKey(LoginKeys.password));
  await driver.enterText(loginPassword);

  if (selfHosted) {
    await driver.tap(find.byValueKey(LoginKeys.url));
    await driver.enterText(loginUrl);
    await driver.tap(find.byValueKey(LoginKeys.secret));
    await driver.enterText(loginSecret);
  }

  await driver.tap(find.text(LoginKeys.loginButton.toUpperCase()));
}

Future<void> loginAndOpenProducts(FlutterDriver driver) async {
  login(driver);
  await driver.waitFor(find.byType(AppKeys.dashboardScreen));
  await driver.tap(find.byTooltip(AppKeys.openAppDrawer));
  await driver.tap(find.byValueKey(ProductKeys.drawer));
  await driver.waitFor(find.byType(ProductKeys.screen));
}