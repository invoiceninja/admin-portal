import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:faker/faker.dart';
import 'utils/common_actions.dart';
import 'utils/localizations.dart';

void main() {
  group('Invoice Tests', () {
    TestLocalization localization;
    FlutterDriver driver;

    final clientName = makeUnique(faker.company.name());
    final updatedClientName = makeUnique(faker.company.name());

    setUpAll(() async {
      localization = TestLocalization('en');
      driver = await FlutterDriver.connect();

      print('Login to app');
      await login(driver);

      print('View invoices');
      viewSection(driver: driver, name: localization.invoices);
    });

    tearDownAll(() async {
      await logout(driver, localization);

      if (driver != null) {
        driver.close();
      }
    });

    // Create an empty invoice
    test('Try to add an empty invoice', () async {
      print('Tap new invoice');
      await driver.tap(find.byTooltip(localization.newInvoice));

      print('Tap save');
      await driver.tap(find.text(localization.save));

      print('Check for error');
      await driver
          .waitFor(find.text(localization.pleaseSelectAClient));

      if (await isMobile(driver)) {
        print('Click back');
        await driver.tap(find.pageBack());
        await driver.waitFor(find.byTooltip(localization.newInvoice));
      } else {
        print('Click cancel');
        await driver.tap(find.text(localization.cancel));
      }
    });

    // Create a new invoice
    test('Add a new invoice', () async {
      print('Tap new invoice');
      await driver.tap(find.byTooltip(localization.newInvoice));

      print('Fill form: $clientName');
      await driver.tap(find.text(localization.client));
      await driver.tap(find.text(localization.createNew));

      await driver.tap(find.byValueKey(localization.name));
      await driver.enterText(clientName);

      await driver.tap(find.text(localization.save));
      await driver.tap(find.text(localization.save));

      if (await isMobile(driver)) {
        print('Click back');
        await driver.tap(find.pageBack());
        await driver.waitFor(find.byTooltip(localization.newInvoice));
      }
    });

    // Edit the newly created invoice
    test('Edit an existing invoice', () async {
      if (await isMobile(driver)) {
        print('Select invoice: $clientName');
        await driver.scrollUntilVisible(
            find.byType('ListView'), find.text(clientName),
            dyScroll: -300);
        await driver.tap(find.text(clientName));
      }

      print('Tap edit');
      await driver.tap(find.text(localization.edit));

      await fillAndSaveForm(driver, <String, dynamic>{
        localization.name: updatedClientName,
      });
    });

    // Archive the edited invoice
    test('Archieve/delete invoice test', () async {
      await testArchiveAndDelete(
          driver: driver,
          archivedMessage: localization.archivedInvoice,
          deletedMessage: localization.deletedInvoice,
          restoredMessage: localization.restoredInvoice);

      if (await isMobile(driver)) {
        await driver.tap(find.pageBack());
      }
    });
  });
}
