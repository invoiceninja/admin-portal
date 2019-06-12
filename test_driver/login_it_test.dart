// Import Flutter Driver API
import 'package:flutter_driver/flutter_driver.dart';
import 'package:invoiceninja_flutter/.env.dart';
import 'package:test/test.dart';
import 'package:invoiceninja_flutter/utils/keys.dart';

import 'localizations.dart';

void main() {
  group('LOGIN TEST', () {

    TestLocalization localization;
    FlutterDriver driver;
    String loginEmail, loginPassword, loginUrl, loginSecret;

    setUp(() async {
      localization = TestLocalization('en');

      driver = await FlutterDriver.connect();

      // read config file
      loginEmail = Config.TEST_EMAIL;
      loginPassword = Config.TEST_PASSWORD;
      loginUrl = Config.TEST_URL;
      loginSecret = Config.TEST_SECRET;

    });

    tearDown(() async {
      if(driver!=null) {
        driver.close();
      }
    });

    test('No input provided by user test', () async {
      await driver.tap(find.byValueKey(LoginKeys.loginSelfHost));

      await driver.tap(find.byValueKey(LoginKeys.email));
      await driver.enterText('');

      await driver.tap(find.byValueKey(LoginKeys.password));
      await driver.enterText('');

      await driver.tap(find.byValueKey(LoginKeys.url));
      await driver.enterText('');

      await driver.tap(find.byValueKey(LoginKeys.secret));
      await driver.enterText('');

      await driver.tap(find.text(LoginKeys.loginButton.toUpperCase()));
      await driver.waitFor(find.text(localization.pleaseEnterYourEmail));
      await driver.waitFor(find.text(localization.pleaseEnterYourPassword));
    });

    test('Details filled by user and login', () async {

      await driver.tap(find.byValueKey(LoginKeys.email));
      await driver.enterText(loginEmail);

      await driver.tap(find.byValueKey(LoginKeys.password));
      await driver.enterText(loginPassword);

      await driver.tap(find.byValueKey(LoginKeys.url));
      await driver.enterText(loginUrl);

      await driver.tap(find.byValueKey(LoginKeys.secret));
      await driver.enterText(loginSecret);

      await driver.tap(find.text(LoginKeys.loginButton.toUpperCase()));

      await driver.waitFor(find.byType('DashboardScreen'), timeout: new Duration(seconds: 60));
    });
  });
}