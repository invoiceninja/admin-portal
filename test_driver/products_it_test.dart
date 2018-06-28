import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'package:invoiceninja/utils/keys.dart';

import '../.env.dart';

class Constants {
  static String newProductKey = 'Example Test Driver Product';
  static String newProductNotes = 'Example Test Driver Notes';
  static String newProductCost = '100.50';
  static String updatedProductKey =  'Updated Example Test Driver Product';
  static String updatedProductNotes = 'Updated Example Test Driver Notes';
  static String updatedProductCost = '200.50';
  static String saveToolTip = 'Save';
  static String backToolTip = 'Back';
  static String deleteToolTip = 'Delete';
  static String menuToolTip = 'Show menu';
  static String loginButton = 'LOGIN';
  static String dashboardScreen = 'DashboardScreen';
  static String productScreen = 'ProductScreen';
  static String snackbarProductCreated = 'Successfully created product';
  static String snackbarProductUpdated = 'Successfully updated product';
  static String snackbarProductDeleted = 'Successfully deleted product';
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
      loginSecret = Config.LOGIN_API_SECRET;
    });

    tearDown(() async {
      if(driver!=null) {
        driver.close();
      }
    });

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

      await driver.waitFor(find.byType(Constants.dashboardScreen));

      // open the app drawer and switch to products screen
      // https://github.com/flutter/flutter/issues/9002[Issue still open] - Using this solution to implement it
      final SerializableFinder drawerOpenButton = find.byTooltip(Constants.openAppDrawer);

      await driver.tap(drawerOpenButton);

      final SerializableFinder productsDrawerButton = find.text(Constants.appDrawerProducts);
      await driver.tap(productsDrawerButton);

      await driver.waitFor(find.byType(Constants.productScreen));
    });

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

    test('Edit a existing product', () async {
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

    test('Deleteing an item test', () async {
      // delete the test product created
      await driver.tap(find.text(Constants.updatedProductKey));

      await driver.tap(find.byTooltip(Constants.menuToolTip));
      await driver.tap(find.text(Constants.deleteToolTip));

      // verify snackbar
      await driver.waitFor(find.text(Constants.snackbarProductDeleted));

      await driver.tap(find.byTooltip(Constants.backToolTip));

      // verify not in list
      await driver.waitForAbsent(find.text(Constants.updatedProductKey));
    });
  });
}