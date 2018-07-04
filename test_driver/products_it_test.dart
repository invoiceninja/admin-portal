import 'package:flutter_driver/flutter_driver.dart';
import 'package:invoiceninja/.env.dart';
import 'package:test/test.dart';

import 'package:invoiceninja/utils/keys.dart';

class Constants {
  static String newProductKey = 'Example Test Driver Product';
  static String newProductNotes = 'Example Test Driver Notes';
  static String newProductCost = '100.5';

  static String updatedProductKey =  'Updated Example Test Driver Product';
  static String updatedProductNotes = 'Updated Example Test Driver Notes';
  static String updatedProductCost = '200.5';

  static String deleteText = 'Delete';
  static String restoreText = 'Restore';
  static String archiveText = 'Archive';

  static String saveToolTip = 'Save';
  static String backToolTip = 'Back';
  static String menuToolTip = 'Show menu';
  static String filterToolTip = 'Filter';

  static String loginButton = 'LOGIN';

  static String dashboardScreen = 'DashboardScreen';
  static String productScreen = 'ProductScreen';

  static String snackbarProductCreated = 'Successfully created product';
  static String snackbarProductUpdated = 'Successfully updated product';
  static String snackbarProductDeleted = 'Successfully deleted product';
  static String snackbarArchiveProduct = 'Successfully archived product';

  static String openAppDrawer = 'Open navigation menu';
  static String appDrawerProducts = 'Products';
}

void main() {
  group('PRODUCTS TEST', () {
    
    FlutterDriver driver;
    String loginEmail, loginPassword, loginUrl, loginSecret;

    setUp(() async {
      driver = await FlutterDriver.connect();

      // read config file
      loginEmail = Config.LOGIN_EMAIL;
      loginPassword = Config.LOGIN_PASSWORD;
      loginUrl = Config.LOGIN_URL;
      loginSecret = Config.LOGIN_SECRET;
    });

    tearDown(() async {
      if(driver!=null) {
        driver.close();
      }
    });

    // Login into the app with details from .env.dart
    test('Login into the app and switch to products screen', () async {
      
      await driver.tap(find.byValueKey(LoginKeys.emailKeyString), timeout: new Duration(seconds: 60));
      await driver.enterText(loginEmail);
      await driver.tap(find.byValueKey(LoginKeys.passwordKeyString));
      await driver.enterText(loginPassword);
      await driver.tap(find.byValueKey(LoginKeys.urlKeyString));
      await driver.enterText(loginUrl);
      await driver.tap(find.byValueKey(LoginKeys.secretKeyString));
      await driver.enterText(loginSecret);

      await driver.tap(find.text(Constants.loginButton));
      await driver.waitUntilNoTransientCallbacks();

      await driver.waitFor(find.byType(Constants.dashboardScreen));

      // open the app drawer and switch to products screen
      // https://github.com/flutter/flutter/issues/9002[Issue still open] - Using this solution to implement it
      final SerializableFinder drawerOpenButton = find.byTooltip(Constants.openAppDrawer);

      await driver.tap(drawerOpenButton);

      final SerializableFinder productsDrawerButton = find.text(Constants.appDrawerProducts);
      await driver.tap(productsDrawerButton);

      await driver.waitFor(find.byType(Constants.productScreen));
    });

    // Create a new product
    test('Add a new product', () async {
      await driver.tap(find.byValueKey(ProductKeys.productScreenFABKeyString));

      await driver.tap(find.byValueKey(ProductKeys.productEditProductFieldKeyString));
      await driver.enterText(Constants.newProductKey);
      await driver.tap(find.byValueKey(ProductKeys.productEditNotesFieldKeyString));
      await driver.enterText(Constants.newProductNotes);
      await driver.tap(find.byValueKey(ProductKeys.productEditCostFieldKeyString));
      await driver.enterText(Constants.newProductCost);

      await driver.tap(find.byTooltip(Constants.saveToolTip));

      // verify snackbar
      await driver.waitFor(find.text(Constants.snackbarProductCreated));

      await driver.tap(find.byTooltip(Constants.backToolTip));

      // verify entered text while new product creation
      await driver.tap(find.text(Constants.newProductKey));
      await driver.waitFor(find.text(Constants.newProductKey));
      await driver.waitFor(find.text(Constants.newProductNotes));
      await driver.waitFor(find.text(Constants.newProductCost));

      await driver.tap(find.byTooltip(Constants.backToolTip));
    });

    // Edit the newly created product
    test('Edit an existing product', () async {
      await driver.tap(find.text(Constants.newProductKey));

      await driver.tap(find.byValueKey(ProductKeys.productEditProductFieldKeyString));
      await driver.enterText(Constants.updatedProductKey);
      await driver.tap(find.byValueKey(ProductKeys.productEditNotesFieldKeyString));
      await driver.enterText(Constants.updatedProductNotes);
      await driver.tap(find.byValueKey(ProductKeys.productEditCostFieldKeyString));
      await driver.enterText(Constants.updatedProductCost);

      await driver.tap(find.byTooltip(Constants.saveToolTip));

      // verify snackbar
      await driver.waitFor(find.text(Constants.snackbarProductUpdated));

      await driver.tap(find.byTooltip(Constants.backToolTip));

      // verify updated values while editing existing product 
      await driver.tap(find.text(Constants.updatedProductKey));
      await driver.waitFor(find.text(Constants.updatedProductKey));
      await driver.waitFor(find.text(Constants.updatedProductNotes));
      await driver.waitFor(find.text(Constants.updatedProductCost));

      await driver.tap(find.byTooltip(Constants.backToolTip));
    });

    // Archive the edited product
    test('Archieve a product test', () async {
      // delete the test product created
      await driver.tap(find.text(Constants.updatedProductKey));

      await driver.tap(find.byTooltip(Constants.menuToolTip));
      await driver.tap(find.text(Constants.archiveText));

      // verify snackbar
      await driver.waitFor(find.text(Constants.snackbarArchiveProduct));

      await driver.tap(find.byTooltip(Constants.backToolTip));

      // veify the product goes away from active product list when archived is not selected
      await driver.waitForAbsent(find.text(Constants.updatedProductKey));

      // Verify product in archived list
      // Show archived products
      await driver.tap(find.byTooltip(Constants.filterToolTip));
      // tick the checkbox archived to show archived products
      // ** Here we assume that only active box is ticked, rest are not
      // ** Currently there is no way to determite if a checkbox is ticked or not
      // ** We also use the state value as the key because
      // ** Currently there is no way to check a checkbox without using a key
      await driver.tap(find.byValueKey('archived'));

      // verify product in archived product list
      await driver.waitFor(find.text(Constants.updatedProductKey));

      //open and check product details
      await driver.tap(find.text(Constants.updatedProductKey));
      await driver.waitFor(find.text(Constants.updatedProductKey));
      await driver.waitFor(find.text(Constants.updatedProductNotes));
      await driver.waitFor(find.text(Constants.updatedProductCost));

      // restore the product
      await driver.tap(find.byTooltip(Constants.menuToolTip));
      await driver.tap(find.text(Constants.restoreText));

      // go back
      await driver.tap(find.byTooltip(Constants.backToolTip));

      // uncheck archive and close filters
      await driver.tap(find.byValueKey('archived'));
      await driver.tap(find.byTooltip(Constants.filterToolTip));

      // veify product is in active products
      await driver.tap(find.text(Constants.updatedProductKey));
      await driver.waitFor(find.text(Constants.updatedProductKey));
      await driver.waitFor(find.text(Constants.updatedProductNotes));
      await driver.waitFor(find.text(Constants.updatedProductCost));

      // go back
      await driver.tap(find.byTooltip(Constants.backToolTip));
    });

    // Delete the edited product
    test('Deleteing a product test', () async {

      await driver.tap(find.text(Constants.updatedProductKey));

      await driver.tap(find.byTooltip(Constants.menuToolTip));
      await driver.tap(find.text(Constants.deleteText));

      // verify snackbar
      await driver.waitFor(find.text(Constants.snackbarProductDeleted));

      await driver.tap(find.byTooltip(Constants.backToolTip));

      // verify not in list
      await driver.waitForAbsent(find.text(Constants.updatedProductKey));
    });
  });
}