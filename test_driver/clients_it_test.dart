import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:invoiceninja_flutter/utils/keys.dart';

import 'utils/common_actions.dart';
import 'utils/localizations.dart';

void main() {
  group('CLIENTS TEST', () {

    TestLocalization localization;
    FlutterDriver driver;

    setUpAll(() async {
      localization = TestLocalization('en');

      driver = await FlutterDriver.connect();

      await loginAndOpenClients(driver);
    });

    tearDownAll(() async {
      await logout(driver, localization);

      if (driver != null) {
        driver.close();
      }
    });

    // Create an empty client
    test('Try to add an empty client', () async {
      await driver.tap(find.byValueKey(ClientKeys.fab));

      await driver.tap(find.byTooltip(localization.save));

      await driver.waitFor(find.text(localization.pleaseEnterAClientOrContactName));

      await driver.tap(find.pageBack());
    });

  });
}
