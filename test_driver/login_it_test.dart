// Import Flutter Driver API
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:invoiceninja_flutter/utils/keys.dart';

import 'utils/common_actions.dart';
import 'utils/localizations.dart';

void main() {
  group('LOGIN TEST', () {

    TestLocalization localization;
    FlutterDriver driver;

    setUpAll(() async {
      localization = TestLocalization('en');

      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    group('SELF-HOSTED', () {
      test('No input provided by user', () async {
        await login(driver, loginEmail: '',
          loginPassword: '',
          loginUrl: '',
          loginSecret: '');

        await driver.waitFor(find.text(localization.pleaseEnterYourEmail));
        await driver.waitFor(find.text(localization.pleaseEnterYourPassword));
        await driver.waitFor(find.text(localization.pleaseEnterYourUrl));
      });

      test('Details filled by user and login', () async {
        await login(driver, retype: true);

        await driver.waitFor(
          find.byType(AppKeys.dashboardScreen),
          timeout: new Duration(seconds: 60),
        );
      });

      test('Logout from a logged in user', () async {
        await logout(driver, localization);
      });
    });
  });
}