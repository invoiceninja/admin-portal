import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:faker/faker.dart';
import 'package:invoiceninja_flutter/utils/keys.dart';

import 'utils/common_actions.dart';
import 'utils/localizations.dart';

void main() {
  group('PRODUCTS TEST', () {

    TestLocalization localization;
    FlutterDriver driver;

    final productKey = faker.food.cuisine();
    final notes = faker.food.dish();
    final cost = faker.randomGenerator.decimal(min: 50).toStringAsFixed(2);

    final updatedProductKey = faker.food.cuisine();
    final updatedNotes = faker.food.dish();
    final updatedCost = faker.randomGenerator.decimal(min: 50).toStringAsFixed(2);

    setUpAll(() async {
      localization = TestLocalization('en');

      driver = await FlutterDriver.connect();

      await loginAndOpenProducts(driver);
    });

    tearDownAll(() async {
      await logout(driver, localization);

      if (driver != null) {
        driver.close();
      }
    });

    // Create a new product
    test('Add a new product', () async {
      await driver.tap(find.byValueKey(ProductKeys.fab));

      await driver.tap(find.byValueKey(ProductKeys.productKey));
      await driver.enterText(productKey);
      await driver.tap(find.byValueKey(ProductKeys.notes));
      await driver.enterText(notes);
      await driver.tap(find.byValueKey(ProductKeys.cost));
      await driver.enterText(cost);

      await driver.tap(find.byTooltip(localization.save));

      await driver.waitFor(find.text(localization.createdProduct));

      await driver.tap(find.pageBack());

      await driver.scrollUntilVisible(find.byType('ListView'), find.text(productKey));
      await driver.tap(find.text(productKey));
      await driver.waitFor(find.text(productKey));
      await driver.waitFor(find.text(notes));
      await driver.waitFor(find.text(cost));

      await driver.tap(find.pageBack());
    });


    // Edit the newly created product
    test('Edit an existing product', () async {
      await driver.scrollUntilVisible(find.byType('ListView'), find.text(productKey));
      await driver.tap(find.text(productKey), timeout: Duration(seconds: 3));

      await driver.tap(find.byValueKey(ProductKeys.productKey));
      await driver.enterText(updatedProductKey);
      await driver.tap(find.byValueKey(ProductKeys.notes));
      await driver.enterText(updatedNotes);
      await driver.tap(find.byValueKey(ProductKeys.cost));
      await driver.enterText(updatedCost);

      await driver.tap(find.byTooltip(localization.save));

      // verify snackbar
      await driver.waitFor(find.text(localization.updatedProduct));

      await driver.tap(find.pageBack());

      // verify updated values while editing existing product 
      await driver.tap(find.text(updatedProductKey));
      await driver.waitFor(find.text(updatedProductKey));
      await driver.waitFor(find.text(updatedNotes));
      await driver.waitFor(find.text(updatedCost));

      await driver.tap(find.pageBack());
    });

    // Archive the edited product
    test('Archieve a product test', () async {
      // delete the test product created
      await driver.tap(find.text(updatedProductKey));

      await driver.tap(find.byType('ActionMenuButton'));
      await driver.tap(find.text(localization.archive));

      // verify the product goes away from active product list when archived is not selected
      await driver.waitForAbsent(find.text(updatedProductKey));

      // Verify product in archived list
      // Show archived products
      await driver.tap(find.byValueKey(ProductKeys.filter));
      // tick the checkbox archived to show archived products
      // ** Here we assume that only active box is ticked, rest are not
      // ** Currently there is no way to determite if a checkbox is ticked or not
      // ** We also use the state value as the key because
      // ** Currently there is no way to check a checkbox without using a key
      await driver.tap(find.text(localization.archived));

      // verify product in archived product list
      await driver.waitFor(find.text(updatedProductKey));

      //open and check product details
      await driver.tap(find.text(updatedProductKey));
      await driver.waitFor(find.text(updatedProductKey));
      await driver.waitFor(find.text(updatedNotes));
      await driver.waitFor(find.text(updatedCost));

      // restore the product
      await driver.tap(find.byType('ActionMenuButton'));
      await driver.tap(find.text(localization.restore));

      await driver.waitFor(find.text(localization.restoredProduct));

      await driver.tap(find.pageBack());

      // uncheck archive and close filters
      await driver.tap(find.text(localization.archived));
      await driver.tap(find.byValueKey(ProductKeys.filter));

      // veify product is in active products
      await driver.tap(find.text(updatedProductKey));
      await driver.waitFor(find.text(updatedProductKey));
      await driver.waitFor(find.text(updatedNotes));
      await driver.waitFor(find.text(updatedCost));

      // go back
      await driver.tap(find.pageBack());
    });

    // Delete the edited product
    test('Deleteing a product test', () async {

      await driver.tap(find.text(updatedProductKey));

      await driver.tap(find.byType('ActionMenuButton'));
      await driver.tap(find.text(localization.delete));

      // verify not in list
      await driver.waitForAbsent(find.text(updatedProductKey));
    });

  });
}
