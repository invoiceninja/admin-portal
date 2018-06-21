// This is our test!

// Import Flutter Driver API
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'package:invoiceninja/utils/keys.dart';

void main() {
  group('LOGIN TEST', () {
    
    FlutterDriver driver;

    setUp(() async {
      driver = await FlutterDriver.connect();
    });

    tearDown(() async {
      if(driver!=null) {
        driver.close();
      }
    });

    test('No input provided by user test', () async {
      await driver.tap(find.text('LOGIN'));
      await driver.waitFor(find.text('Please enter your email'));
      await driver.waitFor(find.text('Please enter your password'));
    });

    test('Details filled by user and login', () async {

      // details for sever running laravel
      String email = 'sanghapal.ahankare@gmail.com';
      String password = '12345qazdr';
      String url = 'http://192.168.1.74';
      String secret = 'asdf';

      await driver.tap(find.byValueKey(LoginKeys.emailKeyString), timeout: new Duration(seconds: 60));
      await driver.enterText(email);

      await driver.tap(find.byValueKey(LoginKeys.passwordKeyString));
      await driver.enterText(password);

      await driver.tap(find.byValueKey(LoginKeys.urlKeyString));
      await driver.enterText(url);

      await driver.tap(find.byValueKey(LoginKeys.secretKeyString));
      await driver.enterText(secret);

      await driver.tap(find.text('LOGIN'));

      await driver.waitFor(find.byType('DashboardScreen'));
    });
  });
}