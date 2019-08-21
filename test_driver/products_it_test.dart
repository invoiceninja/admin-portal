import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:faker/faker.dart';
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
    final updatedCost =
        faker.randomGenerator.decimal(min: 50).toStringAsFixed(2);

    setUpAll(() async {
      localization = TestLocalization('en');
      driver = await FlutterDriver.connect();

      print('Login to app');
      await login(driver);

      print('View products');
      await driver.tap(find.byTooltip(Keys.openAppDrawer));
      await driver.tap(find.byTooltip(localization.products));
    });

    tearDownAll(() async {
      await logout(driver, localization);

      if (driver != null) {
        driver.close();
      }
    });

    // Create an empty product
    test('Try to add an empty product', () async {

      print('Tap new product');
      await driver.tap(find.byTooltip(localization.newProduct));

      print('Tap save');
      await driver.tap(find.text(localization.save));

      print('Check for error');
      await driver.waitFor(find.text(localization.pleaseEnterAProductKey));

      print('Click back');
      await driver.tap(find.pageBack());
    });

    // Create a new product
    test('Add a new product', () async {

      print('Tap new product');
      await driver.tap(find.byTooltip(localization.newProduct));

      print('Fill form: $productKey');
      await fillTextFields(driver, <String, dynamic>{
        localization.productKey: productKey,
        localization.notes: notes,
        localization.cost: cost,
      });

      print('Tap save');
      await driver.tap(find.text(localization.save));

      //await driver.waitFor(find.text(localization.createdProduct));
      //await driver.waitFor(find.text(productKey));

      /*
      await driver.tap(find.pageBack());
      await driver.scrollUntilVisible(
          find.byType('ListView'), find.text(productKey));
      await driver.tap(find.text(productKey));
      */


      print('Check for new value: $productKey');
      await driver.waitFor(find.text(productKey));
      await driver.waitFor(find.text(notes));
      //await driver.waitFor(find.text(cost));

      print('Click back');
      await driver.tap(find.pageBack());
      await driver.waitFor(find.byTooltip(localization.newProduct));
    });

    // Edit the newly created product
    test('Edit an existing product', () async {
      /*
      await driver.scrollUntilVisible(
          find.byType('ListView'), find.text(productKey));
      */

      print('Select product: $productKey');
      await driver.tap(find.text(productKey), timeout: Duration(seconds: 3));

      print('Tap edit');
      await driver.tap(find.text(localization.edit));

      print('Fill in form: $updatedProductKey');
      await fillTextFields(driver, <String, dynamic>{
        localization.productKey: updatedProductKey,
        localization.notes: updatedNotes,
        localization.cost: updatedCost,
      });

      print('Tap save');
      await driver.tap(find.text(localization.save));

      // verify snackbar
      //await driver.waitFor(find.text(localization.updatedProduct));
      //await driver.tap(find.pageBack());

      print('Check for updated values');
      await driver.waitFor(find.text(updatedProductKey));
      await driver.waitFor(find.text(updatedNotes));
      //await driver.waitFor(find.text(updatedCost));

      print('Tap back');
      await driver.tap(find.pageBack());
      await driver.waitFor(find.byTooltip(localization.newProduct));
    });


    // Archive the edited product
    test('Archieve a product test', () async {
      print('here 1');
      await driver.tap(find.text(updatedProductKey));
      print('here 2');
      await driver.tap(find.byType('ActionMenuButton'));
      print('here 3');
      await driver.tap(find.text(localization.archive));
      print('here 4');
      // verify the product goes away from active product list when archived is not selected
      await driver.waitForAbsent(find.text(updatedProductKey));
      print('here 5');
      // Verify product in archived list
      // Show archived products
      await driver.tap(find.byValueKey(localization.filter));
      // tick the checkbox archived to show archived products
      // ** Here we assume that only active box is ticked, rest are not
      // ** Currently there is no way to determite if a checkbox is ticked or not
      // ** We also use the state value as the key because
      // ** Currently there is no way to check a checkbox without using a key
      print('here 6');
      await driver.tap(find.text(localization.archived));
      print('here 7');
      // verify product in archived product list
      await driver.waitFor(find.text(updatedProductKey));
      print('here 8');
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
      await driver.tap(find.byValueKey(localization.filter));

      // veify product is in active products
      await driver.tap(find.text(updatedProductKey));
      await driver.waitFor(find.text(updatedProductKey));
      await driver.waitFor(find.text(updatedNotes));
      await driver.waitFor(find.text(updatedCost));

      // go back
      await driver.tap(find.pageBack());
    });
    /*
    // Delete the edited product
    test('Deleteing a product test', () async {
      await driver.tap(find.text(updatedProductKey));

      await driver.tap(find.byType('ActionMenuButton'));
      await driver.tap(find.text(localization.delete));

      // verify not in list
      await driver.waitForAbsent(find.text(updatedProductKey));
    });

    */
  });
}
