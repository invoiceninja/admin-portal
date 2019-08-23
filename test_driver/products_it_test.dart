import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:faker/faker.dart';
import 'utils/common_actions.dart';
import 'utils/localizations.dart';

void main() {
  group('Product Tests', () {
    TestLocalization localization;
    FlutterDriver driver;

    final productKey = makeUnique(faker.food.cuisine());
    final notes = faker.food.dish();
    final cost = faker.randomGenerator.decimal(min: 50).toStringAsFixed(2);

    final updatedProductKey = makeUnique(faker.food.cuisine());
    final updatedNotes = faker.food.dish();
    final updatedCost =
        faker.randomGenerator.decimal(min: 50).toStringAsFixed(2);

    setUpAll(() async {
      localization = TestLocalization('en');
      driver = await FlutterDriver.connect();

      print('Login to app');
      await login(driver);

      print('View products');
      viewSection(driver: driver, name: localization.products);
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

      if (await isMobile(driver)) {
        print('Click back');
        await driver.tap(find.pageBack());
        await driver.waitFor(find.byTooltip(localization.newProduct));
      } else {
        print('Click cancel');
        await driver.tap(find.text(localization.cancel));
      }
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
      await driver.waitFor(find.text(productKey));

      print('Check for new value: $productKey');
      await driver.waitFor(find.text(productKey));
      await driver.waitFor(find.text(notes));
      //await driver.waitFor(find.text(cost));

      if (await isMobile(driver)) {
        print('Click back');
        await driver.tap(find.pageBack());
        await driver.waitFor(find.byTooltip(localization.newProduct));
      }
    });

    // Edit the newly created product
    test('Edit an existing product', () async {
      print('Select product: $productKey');
      await driver.scrollUntilVisible(
          find.byType('ListView'), find.text(productKey),
          dyScroll: -300);
      await driver.tap(find.text(productKey));

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
    });

    // Archive the edited product
    test('Archieve a product test', () async {
      print('Archive product');
      await driver.tap(find.byType('ActionMenuButton'));
      await driver.tap(find.text(localization.archive));
      await driver.waitFor(find.text(localization.archivedProduct));
      await driver.waitFor(find.text(localization.archived));

      print('Restore product');
      await driver.tap(find.byType('ActionMenuButton'));
      await driver.tap(find.text(localization.restore));
      await driver.waitFor(find.text(localization.restoredProduct));
      await driver.waitForAbsent(find.text(localization.archived));

      print('Delete product');
      await driver.tap(find.byType('ActionMenuButton'));
      await driver.tap(find.text(localization.delete));
      await driver.waitFor(find.text(localization.deletedProduct));
      await driver.waitFor(find.text(localization.deleted));

      print('Restore product');
      await driver.tap(find.byType('ActionMenuButton'));
      await driver.tap(find.text(localization.restore));
      await driver.waitFor(find.text(localization.restoredProduct));
      await driver.waitForAbsent(find.text(localization.deleted));

      if (await isMobile(driver)) {
        await driver.tap(find.pageBack());
      }
    });
  });
}
