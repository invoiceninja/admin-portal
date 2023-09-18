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
  group('Vendor Tests', () {
    late TestLocalization localization;
    FlutterDriver? driver;

    final name = makeUnique(faker.company.name());

    final updatedName = makeUnique(faker.company.name());

    setUpAll(() async {
      localization = TestLocalization('en');
      driver = await FlutterDriver.connect();

      print('Login to app');
      await login(driver!, retype: batchMode);

      print('View vendors');
      await viewSection(driver: driver!, name: localization.vendors);
    });

    tearDownAll(() async {
      await logout(driver!, localization);

      if (driver != null) {
        driver!.close();
      }
    });

    // Create an empty vendor
    test('Try to add an empty vendor', () async {
      print('Tap new vendor');
      await driver!.tap(find.byTooltip(localization.newVendor));

      print('Tap save');
      await driver!.tap(find.text(localization.save));

      print('Check for error');
      await driver!.waitFor(find.text(localization.pleaseEnterAName));

      if (await isMobile(driver!)) {
        print('Click back');
        await driver!.tap(find.pageBack());
        await driver!.waitFor(find.byTooltip(localization.newVendor));
      } else {
        print('Click cancel');
        await driver!.tap(find.text(localization.cancel));
      }
    });

    // Create a new vendor
    test('Add a new vendor', () async {
      print('Tap new vendor');
      await driver!.tap(find.byTooltip(localization.newVendor));

      print('Fill form: $name');
      await fillAndSaveForm(driver!, <String, dynamic>{
        localization.name: name,
      });

      if (await isMobile(driver!)) {
        print('Click back');
        await driver!.tap(find.pageBack());
        await driver!.waitFor(find.byTooltip(localization.newVendor));
      }
    });

    // Edit the newly created vendor
    test('Edit an existing vendor', () async {
      if (await isMobile(driver!)) {
        print('Select vendor: $name');
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

    // Archive the edited vendor
    test('Archieve/delete vendor test', () async {
      await testArchiveAndDelete(
          driver: driver!,
          rowText: updatedName,
          archivedMessage: localization.archivedVendor,
          deletedMessage: localization.deletedVendor,
          restoredMessage: localization.restoredVendor);

      if (await isMobile(driver!)) {
        await driver!.tap(find.pageBack());
      }
    });
  });
}
