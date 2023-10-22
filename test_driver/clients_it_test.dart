// Package imports:
import 'package:faker/faker.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

// Project imports:
import 'utils/common_actions.dart';
import 'utils/localizations.dart';

void main() {
  runTestSuite();
}

void runTestSuite({bool batchMode = false}) {
  group('Client Tests', () {
    late TestLocalization localization;
    FlutterDriver? driver;

    final name = makeUnique(faker.company.name());

    final updatedName = makeUnique(faker.company.name());

    setUpAll(() async {
      localization = TestLocalization('en');
      driver = await FlutterDriver.connect();

      print('Login to app');
      await login(driver!, retype: batchMode);

      print('View clients');
      await viewSection(driver: driver!, name: localization.clients);
    });

    tearDownAll(() async {
      await logout(driver!, localization);

      if (driver != null) {
        driver!.close();
      }
    });

    // Create an empty client
    test('Try to add an empty client', () async {
      print('Tap new client');
      await driver!.tap(find.byTooltip(localization.newClient));

      print('Tap save');
      await driver!.tap(find.text(localization.save));

      print('Check for error');
      await driver!
          .waitFor(find.text(localization.pleaseEnterAClientOrContactName));

      if (await isMobile(driver!)) {
        print('Click back');
        await driver!.tap(find.pageBack());
        await driver!.waitFor(find.byTooltip(localization.newClient));
      } else {
        print('Click cancel');
        await driver!.tap(find.text(localization.cancel));
      }
    });

    // Create a new client
    test('Add a new client', () async {
      print('Tap new client');
      await driver!.tap(find.byTooltip(localization.newClient));

      print('Fill form: $name');
      await fillAndSaveForm(driver!, <String, dynamic>{
        localization.name: name,
      });

      if (await isMobile(driver!)) {
        print('Click back');
        await driver!.tap(find.pageBack());
        await driver!.waitFor(find.byTooltip(localization.newClient));
      }
    });

    // Edit the newly created client
    test('Edit an existing client', () async {
      if (await isMobile(driver!)) {
        print('Select client: $name');
        await driver!.scrollUntilVisible(
            find.byType('ListView'), find.text(name),
            dyScroll: -300);
        await driver!.tap(find.text(name));
      }

      print('Tap edit');
      await driver!.tap(find.text(localization.edit));

      await fillAndSaveForm(driver!, <String, String>{
        localization.name: updatedName,
      });
    });

    // Archive the edited client
    test('Archive/delete client test', () async {
      await testArchiveAndDelete(
          driver: driver!,
          rowText: updatedName,
          archivedMessage: localization.archivedClient,
          deletedMessage: localization.deletedClient,
          restoredMessage: localization.restoredClient);

      if (await isMobile(driver!)) {
        await driver!.tap(find.pageBack());
      }
    });
  });
}
