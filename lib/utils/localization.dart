import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

class AppLocalization {
  AppLocalization(this.locale);

  final Locale locale;

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'log_out': 'Log Out',
      'dashboard': 'Dashboard',
      'refresh_complete': 'Refresh Complete',
      'please_enter_your_email': 'Please enter your email',
      'please_enter_your_password': 'Please enter your password',
      'please_enter_your_url': 'Please enter your URL',
      'please_enter_a_product_key': 'Please enter a product key',
      'new_product': 'New Product',
      'product': 'Product',
      'products': 'Products',
      'notes': 'Notes',
      'cost': 'Cost',
      'clients': 'Clients',
      'save': 'Save',
      'an_error_occurred': 'An error occurred',
      'successfully_created_product': 'Successfully created product',
      'successfully_updated_product': 'Successfully updated product',
      'successfully_archived_product': 'Successfully archived product',
      'successfully_deleted_product': 'Successfully deleted product',
      'successfully_restored_product': 'Successfully restored product',
    },
  };

  String get logOut => _localizedValues[locale.languageCode]['log_out'];
  String get dashboard => _localizedValues[locale.languageCode]['dashboard'];
  String get refreshComplete => _localizedValues[locale.languageCode]['refresh_complete'];
  String get pleaseEnterYourEmail => _localizedValues[locale.languageCode]['please_enter_your_email'];
  String get pleaseEnterYourPassword => _localizedValues[locale.languageCode]['please_enter_your_password'];
  String get pleaseEnterYourUrl => _localizedValues[locale.languageCode]['please_enter_your_urll'];
  String get pleaseEnterAProductKey => _localizedValues[locale.languageCode]['please_enter_a_product_key'];
  String get newProduct => _localizedValues[locale.languageCode]['new_product'];
  String get product => _localizedValues[locale.languageCode]['product'];
  String get products => _localizedValues[locale.languageCode]['products'];
  String get notes => _localizedValues[locale.languageCode]['notes'];
  String get cost => _localizedValues[locale.languageCode]['cost'];
  String get clients => _localizedValues[locale.languageCode]['clients'];
  String get save => _localizedValues[locale.languageCode]['save'];
  String get successfullyCreatedProduct => _localizedValues[locale.languageCode]['successfully_created_product'];
  String get successfullyUpdatedProduct => _localizedValues[locale.languageCode]['successfully_updated_product'];
  String get successfullyArchivedProduct => _localizedValues[locale.languageCode]['successfully_archived_product'];
  String get successfullyDeletedProduct=> _localizedValues[locale.languageCode]['successfully_deleted_product'];
  String get successfullyRestoredProduct => _localizedValues[locale.languageCode]['successfully_restored_product'];


}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => [
    'en',
  ].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) {
    return new SynchronousFuture<AppLocalization>(new AppLocalization(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}