// Import Flutter Driver API

// Package imports:
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

// Project imports:
import 'utils/common_actions.dart';
import 'utils/localizations.dart';

void main() {
  group('LOGIN TEST', () {
    late TestLocalization localization;
    FlutterDriver? driver;
    //StreamSubscription? streamSubscription;

    setUpAll(() async {
      localization = TestLocalization('en');
      driver = await FlutterDriver.connect(printCommunication: false);

      // https://github.com/flutter/flutter/issues/24703#issuecomment-526382318
      //streamSubscription = driver.serviceClient.onIsolateRunnable
      //    .asBroadcastStream()
      //    .listen((isolateRef) {
      //  print(
      //      'Resuming isolate: ${isolateRef.numberAsString}:${isolateRef.name}');
      //  isolateRef.resume();
      //});
    });

    tearDownAll(() async {
      if (driver != null) {
        driver!.close();
      }

      /*
      if (streamSubscription != null) {
        streamSubscription.cancel();
      }
      */
    });

    group('SELF-HOSTED', () {
      test('No input provided by user', () async {
        await login(driver!,
            loginEmail: '', loginPassword: '', loginUrl: '', loginSecret: '');

        await driver!.waitFor(find.text(localization.pleaseEnterYourEmail));
        await driver!.waitFor(find.text(localization.pleaseEnterYourPassword));
        await driver!.waitFor(find.text(localization.pleaseEnterYourUrl));
      });

      test('Details filled by user and login', () async {
        await login(driver!, retype: true);
      });

      test('Logout from a logged in user', () async {
        await logout(driver!, localization);
      });
    });
  });
}
