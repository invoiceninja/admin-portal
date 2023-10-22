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
  group('Invoice Tests', () {
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

      print('View invoices');
      await viewSection(driver: driver!, name: localization.invoices);
    });

    tearDownAll(() async {
      await logout(driver!, localization);

      if (driver != null) {
        driver!.close();
      }
    });

    // Create an empty invoice
    test('Try to add an empty invoice', () async {
      print('Tap new invoice');
      await driver!.tap(find.byTooltip(localization.newInvoice));

      print('Tap save');
      await driver!.tap(find.text(localization.save));

      print('Check for error');
      await driver!.waitFor(find.text(localization.pleaseSelectAClient));

      if (await isMobile(driver!)) {
        print('Click back');
        await driver!.tap(find.pageBack());
        await driver!.waitFor(find.byTooltip(localization.newInvoice));
      } else {
        print('Click cancel');
        await driver!.tap(find.text(localization.cancel));
      }
    });

    // Create a new invoice
    test('Add a new invoice', () async {
      print('Tap new invoice');
      await driver!.tap(find.byTooltip(localization.newInvoice));

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
      await driver!.waitFor(find.text(localization.newInvoice));

      print('Fill the invoice form');
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
        await driver!.waitFor(find.byTooltip(localization.newInvoice));
      }
    });

    // Edit the newly created invoice
    test('Edit an existing invoice', () async {
      if (await isMobile(driver!)) {
        print('Select invoice: $clientName');
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

    // Archive the edited invoice
    test('Archive/delete invoice test', () async {
      await testArchiveAndDelete(
          driver: driver!,
          rowText: clientName,
          archivedMessage: localization.archivedInvoice,
          deletedMessage: localization.deletedInvoice,
          restoredMessage: localization.restoredInvoice);
    });

    // Mark the invoice as paid
    test('Mark invoice as paid', () async {
      await selectAction(driver!, localization.enterPayment);
      await driver!.tap(find.text(localization.save));
      // "Completed" status
      await driver!
          .waitFor(find.text(localization.paymentStatus4.toUpperCase()));

      if (await isMobile(driver!)) {
        await driver!.tap(find.pageBack());
        await driver!.tap(find.pageBack());
      }
    });
  });
}
