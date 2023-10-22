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
  group('Product Tests', () {
    late TestLocalization localization;
    FlutterDriver? driver;

    final productKey = makeUnique(faker.food.cuisine());
    final description = faker.food.dish();
    //final cost = faker.randomGenerator.decimal(min: 50).toStringAsFixed(2);

    final updatedProductKey = makeUnique(faker.food.cuisine());
    final updatedDescription = faker.food.dish();
    //final updatedCost = faker.randomGenerator.decimal(min: 50).toStringAsFixed(2);

    setUpAll(() async {
      localization = TestLocalization('en');
      driver = await FlutterDriver.connect();

      print('Login to app');
      await login(driver!, retype: batchMode);

      print('View products');
      await viewSection(driver: driver!, name: localization.products);
    });

    tearDownAll(() async {
      await logout(driver!, localization);

      if (driver != null) {
        driver!.close();
      }
    });

    // Create an empty product
    test('Try to add an empty product', () async {
      print('Tap new product');
      await driver!.tap(find.byTooltip(localization.newProduct));

      print('Tap save');
      await driver!.tap(find.text(localization.save));

      print('Check for error');
      await driver!.waitFor(find.text(localization.pleaseEnterAProductKey));

      if (await isMobile(driver!)) {
        print('Click back');
        await driver!.tap(find.pageBack());
        await driver!.waitFor(find.byTooltip(localization.newProduct));
      } else {
        print('Click cancel');
        await driver!.tap(find.text(localization.cancel));
      }
    });

    // Create a new product
    test('Add a new product', () async {
      print('Tap new product');
      await driver!.tap(find.byTooltip(localization.newProduct));

      print('Fill form: $productKey');
      await fillAndSaveForm(driver!, <String, dynamic>{
        localization.product: productKey,
        localization.description: description,
        //localization.cost: cost,
      }, skipCheckFor: [
        localization.product,
        localization.description
        //localization.cost
      ]);

      if (await isMobile(driver!)) {
        print('Click back');
        await driver!.tap(find.pageBack());
        await driver!.waitFor(find.byTooltip(localization.newProduct));
      }
    });

    // Edit the newly created product
    test('Edit an existing product', () async {
      if (await isMobile(driver!)) {
        print('Select product: $productKey');
        await driver!.scrollUntilVisible(
            find.byType('ListView'), find.text(productKey),
            dyScroll: -300);
        await driver!.tap(find.text(productKey));
      }

      print('Tap edit');
      await driver!.tap(find.text(localization.edit));

      await fillAndSaveForm(driver!, <String, dynamic>{
        localization.product: updatedProductKey,
        localization.description: updatedDescription,
        //localization.cost: updatedCost,
      }, skipCheckFor: [
        localization.product,
        localization.description
      ]);
    });

    // Archive the edited product
    test('Archive/delete product test', () async {
      await testArchiveAndDelete(
          driver: driver!,
          rowText: updatedProductKey,
          archivedMessage: localization.archivedProduct,
          deletedMessage: localization.deletedProduct,
          restoredMessage: localization.restoredProduct);

      if (await isMobile(driver!)) {
        await driver!.tap(find.pageBack());
      }
    });
  });
}
