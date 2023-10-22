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
  group('Quote Tests', () {
    late TestLocalization localization;
    FlutterDriver? driver;

    final clientName = makeUnique(faker.company.name());
    final poNumber =
        faker.randomGenerator.integer(999999, min: 100000).toString();
    final productKey = makeUnique(faker.food.cuisine());
    final clientKey =
        faker.randomGenerator.integer(999999, min: 100000).toString();
    final description = faker.lorem.sentences(5).toString();
    final cost =
        faker.randomGenerator.decimal(min: 50, scale: 10).toStringAsFixed(2);

    final updatedPoNumber =
        faker.randomGenerator.integer(999999, min: 100000).toString();

    setUpAll(() async {
      localization = TestLocalization('en');
      driver = await FlutterDriver.connect();

      print('Login to app');
      await login(driver!, retype: batchMode);

      print('View quotes');
      await viewSection(driver: driver!, name: localization.quotes);
    });

    tearDownAll(() async {
      await logout(driver!, localization);

      if (driver != null) {
        driver!.close();
      }
    });

    // Create an empty quote
    test('Try to add an empty quote', () async {
      print('Tap new quote');
      await driver!.tap(find.byTooltip(localization.newQuote));

      print('Tap save');
      await driver!.tap(find.text(localization.save));

      print('Check for error');
      await driver!.waitFor(find.text(localization.pleaseSelectAClient));

      if (await isMobile(driver!)) {
        print('Click back');
        await driver!.tap(find.pageBack());
        await driver!.waitFor(find.byTooltip(localization.newQuote));
      } else {
        print('Click cancel');
        await driver!.tap(find.text(localization.cancel));
      }
    });

    // Create a new quote
    test('Add a new quote', () async {
      print('Tap new quote');
      await driver!.tap(find.byTooltip(localization.newQuote));

      print('Create new client: $clientName');
      if (await isMobile(driver!)) {
        await driver!.tap(find.byValueKey(Keys.clientPickerEmptyKey));
      }
      await driver!.tap(find.byTooltip(localization.createNew));

      print('Fill the client form');
      await fillTextFields(driver, <String, String>{
        localization.name: clientName,
        localization.idNumber: clientKey
      });
      // Await for Debouncer
      await Future<dynamic>.delayed(Duration(milliseconds: 500));
      await driver!.tap(find.text(localization.save));

      // Await for Screen change
      await driver!.waitFor(find.text(localization.newQuote));

      print('Fill the quote form');
      if (await isMobile(driver!)) {
        await driver!.tap(find.byTooltip(localization.addItem));
        await driver!.tap(find.byTooltip(localization.createNew));

        await fillTextFields(driver, <String, String>{
          localization.product: productKey,
          localization.description: description,
          localization.unitCost: cost,
          localization.quantity: '1',
        });

        // Await for Debouncer
        await Future<dynamic>.delayed(Duration(milliseconds: 500));
        await driver!.tap(find.text(localization.done.toUpperCase()));
        await driver!.tap(find.text(localization.details));
      } else {
        await fillTextFields(driver, <String, String>{
          getLineItemKey('name', 0): productKey,
          getLineItemKey('description', 0): description,
          getLineItemKey('cost', 0): cost,
          getLineItemKey('quantity', 0): '1'
        });
      }

      await fillAndSaveForm(driver!, <String, String>{
        localization.poNumber: poNumber,
      });

      if (await isMobile(driver!)) {
        print('Click back');
        await driver!.tap(find.pageBack());
        await driver!.waitFor(find.byTooltip(localization.newQuote));
      }
    });

    // Edit the newly created quote
    test('Edit an existing quote', () async {
      if (await isMobile(driver!)) {
        print('Select quote: $clientName');
        await driver!.scrollUntilVisible(
            find.byType('ListView'), find.text(clientName),
            dyScroll: -300);
        await driver!.tap(find.text(clientName));
      }

      print('Tap edit');
      await driver!.tap(find.text(localization.edit));

      await fillAndSaveForm(driver!, <String, String>{
        localization.poNumber: updatedPoNumber,
      });
    });

    // Archive the edited quote
    test('Archive/delete quote test', () async {
      await testArchiveAndDelete(
          driver: driver!,
          rowText: clientName,
          archivedMessage: localization.archivedQuote,
          deletedMessage: localization.deletedQuote,
          restoredMessage: localization.restoredQuote);
    });
  });
}
