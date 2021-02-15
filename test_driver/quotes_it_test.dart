/*
import 'package:faker/faker.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'utils/common_actions.dart';
import 'utils/localizations.dart';

void main() {
  runTestSuite();
}

void runTestSuite({bool batchMode = false}) {
  group('Quote Tests', () {
    TestLocalization localization;
    FlutterDriver driver;

    final clientName = makeUnique(faker.company.name());
    final poNumber =
        faker.randomGenerator.integer(999999, min: 100000).toString();
    final productKey = makeUnique(faker.food.cuisine());
    final description = faker.lorem.sentences(5).toString();
    final cost =
        faker.randomGenerator.decimal(min: 50, scale: 10).toStringAsFixed(2);

    final updatedPoNumber =
        faker.randomGenerator.integer(999999, min: 100000).toString();

    setUpAll(() async {
      localization = TestLocalization('en');
      driver = await FlutterDriver.connect();

      print('Login to app');
      await login(driver, retype: batchMode);

      print('View quotes');
      await viewSection(driver: driver, name: localization.quotes);
    });

    tearDownAll(() async {
      await logout(driver, localization);

      if (driver != null) {
        driver.close();
      }
    });

    // Create an empty quote
    test('Try to add an empty quote', () async {
      print('Tap new quote');
      await driver.tap(find.byTooltip(localization.newQuote));

      print('Tap save');
      await driver.tap(find.text(localization.save));

      print('Check for error');
      await driver.waitFor(find.text(localization.pleaseSelectAClient));

      if (await isMobile(driver)) {
        print('Click back');
        await driver.tap(find.pageBack());
        await driver.waitFor(find.byTooltip(localization.newQuote));
      } else {
        print('Click cancel');
        await driver.tap(find.text(localization.cancel));
      }
    });

    // Create a new quote
    test('Add a new quote', () async {
      print('Tap new quote');
      await driver.tap(find.byTooltip(localization.newQuote));

      print('Create new client: $clientName');
      await driver.tap(find.byValueKey(localization.client));
      await driver.tap(find.byTooltip(localization.createNew));

      print('Fill the client form');
      await fillTextField(
          driver: driver, field: localization.name, value: clientName);
      await driver.tap(find.text(localization.save));

      print('Fill the quote form');
      await driver.tap(find.byTooltip(localization.addItem));
      await driver.tap(find.byTooltip(localization.createNew));

      await fillTextFields(driver, <String, String>{
        localization.product: productKey,
        localization.description: description,
        localization.unitCost: cost,
        localization.quantity: '1',
      });

      await driver.tap(find.text(localization.done));
      await driver.tap(find.text(localization.details));

      await fillAndSaveForm(driver, <String, String>{
        localization.poNumber: poNumber,
      });

      if (await isMobile(driver)) {
        print('Click back');
        await driver.tap(find.pageBack());
        await driver.waitFor(find.byTooltip(localization.newQuote));
      }
    });

    // Edit the newly created quote
    test('Edit an existing quote', () async {
      if (await isMobile(driver)) {
        print('Select quote: $clientName');
        await driver.scrollUntilVisible(
            find.byType('ListView'), find.text(clientName),
            dyScroll: -300);
        await driver.tap(find.text(clientName));
      }

      print('Tap edit');
      await driver.tap(find.text(localization.edit));

      await fillAndSaveForm(driver, <String, String>{
        localization.poNumber: updatedPoNumber,
      });
    });

    // Archive the edited quote
    test('Archive/delete quote test', () async {
      await testArchiveAndDelete(
          driver: driver,
          archivedMessage: localization.archivedQuote,
          deletedMessage: localization.deletedQuote,
          restoredMessage: localization.restoredQuote);
    });

    // Convert to invoice
    test('Convert to invoice', () async {
      await selectAction(driver, localization.convert);
      await driver.waitFor(find.byType('InvoiceView'));

      if (await isMobile(driver)) {
        await driver.tap(find.pageBack());
        await driver.tap(find.pageBack());
      }
    });
  });
}
*/