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
      'billing_address': 'Billing Address',
      'shipping_address': 'Shipping Address',
      'total_revenue': 'Total Revenue',
      'average_invoice': 'Average Invoice',
      'outstanding': 'Outstanding',
      'invoices_sent': 'Invoices Sent',
      'active_clients': 'Active Clients',
      'close': 'Close',
      'email': 'Email',
      'password': 'Password',
      'url': 'URL',
      'secret': 'Secret',
      'name': 'Name',
      'log_out': 'Log Out',
      'filter': 'Filter',
      'sort': 'Sort',
      'search': 'Search',
      'active': 'Active',
      'archived': 'Archived',
      'deleted': 'Deleted',
      'dashboard': 'Dashboard',
      'archive': 'Archive',
      'delete': 'Delete',
      'restore': 'Restore',
      'refresh_complete': 'Refresh Complete',
      'please_enter_your_email': 'Please enter your email',
      'please_enter_your_password': 'Please enter your password',
      'please_enter_your_url': 'Please enter your URL',
      'please_enter_a_product_key': 'Please enter a product key',
      'ascending': 'Ascending',
      'descending': 'Descending',
      'save': 'Save',
      'an_error_occurred': 'An error occurred',
      'paid_to_date': 'Paid to Date',

      'product': 'Product',
      'products': 'Products',
      'new_product': 'New Product',
      'successfully_created_product': 'Successfully created product',
      'successfully_updated_product': 'Successfully updated product',
      'successfully_archived_product': 'Successfully archived product',
      'successfully_deleted_product': 'Successfully deleted product',
      'successfully_restored_product': 'Successfully restored product',
      'productKey': 'Product',
      'notes': 'Notes',
      'cost': 'Cost',

      'client': 'Client',
      'clients': 'Clients',
      'new_client': 'New Client',
      'successfully_created_client': 'Successfully created client',
      'successfully_updated_client': 'Successfully updated client',
      'successfully_archived_client': 'Successfully archived client',
      'successfully_deleted_client': 'Successfully deleted client',
      'successfully_restored_client': 'Successfully restored client',
    },
  };

  String get billingAddress => _localizedValues[locale.languageCode]['billing_address'];
  String get shippingAddress => _localizedValues[locale.languageCode]['shipping_address'];
  String get totalRevenue => _localizedValues[locale.languageCode]['total_revenue'];
  String get averageInvoice => _localizedValues[locale.languageCode]['average_invoice'];
  String get outstanding => _localizedValues[locale.languageCode]['outstanding'];
  String get invoicesSent => _localizedValues[locale.languageCode]['invoices_sent'];
  String get activeClients => _localizedValues[locale.languageCode]['active_clients'];
  String get close => _localizedValues[locale.languageCode]['close'];
  String get email => _localizedValues[locale.languageCode]['email'];
  String get password => _localizedValues[locale.languageCode]['password'];
  String get url => _localizedValues[locale.languageCode]['url'];
  String get secret => _localizedValues[locale.languageCode]['secret'];
  String get name => _localizedValues[locale.languageCode]['name'];
  String get logOut => _localizedValues[locale.languageCode]['log_out'];
  String get filter => _localizedValues[locale.languageCode]['filter'];
  String get sort => _localizedValues[locale.languageCode]['sort'];
  String get search => _localizedValues[locale.languageCode]['search'];
  String get active => _localizedValues[locale.languageCode]['active'];
  String get archived => _localizedValues[locale.languageCode]['archived'];
  String get deleted => _localizedValues[locale.languageCode]['deleted'];
  String get dashboard => _localizedValues[locale.languageCode]['dashboard'];
  String get archive => _localizedValues[locale.languageCode]['archive'];
  String get delete => _localizedValues[locale.languageCode]['delete'];
  String get restore => _localizedValues[locale.languageCode]['restore'];
  String get refreshComplete => _localizedValues[locale.languageCode]['refresh_complete'];
  String get pleaseEnterYourEmail => _localizedValues[locale.languageCode]['please_enter_your_email'];
  String get pleaseEnterYourPassword => _localizedValues[locale.languageCode]['please_enter_your_password'];
  String get pleaseEnterYourUrl => _localizedValues[locale.languageCode]['please_enter_your_urll'];
  String get pleaseEnterAProductKey => _localizedValues[locale.languageCode]['please_enter_a_product_key'];
  String get ascending => _localizedValues[locale.languageCode]['ascending'];
  String get descending => _localizedValues[locale.languageCode]['descending'];
  String get save => _localizedValues[locale.languageCode]['save'];
  String get paidToDate => _localizedValues[locale.languageCode]['paid_to_date'];

  String get product => _localizedValues[locale.languageCode]['product'];
  String get products => _localizedValues[locale.languageCode]['products'];
  String get newProduct => _localizedValues[locale.languageCode]['new_product'];
  String get successfullyCreatedProduct => _localizedValues[locale.languageCode]['successfully_created_product'];
  String get successfullyUpdatedProduct => _localizedValues[locale.languageCode]['successfully_updated_product'];
  String get successfullyArchivedProduct => _localizedValues[locale.languageCode]['successfully_archived_product'];
  String get successfullyDeletedProduct=> _localizedValues[locale.languageCode]['successfully_deleted_product'];
  String get successfullyRestoredProduct => _localizedValues[locale.languageCode]['successfully_restored_product'];
  String get productKey => _localizedValues[locale.languageCode]['product_key'];
  String get notes => _localizedValues[locale.languageCode]['notes'];
  String get cost => _localizedValues[locale.languageCode]['cost'];

  String get client => _localizedValues[locale.languageCode]['client'];
  String get clients => _localizedValues[locale.languageCode]['clients'];
  String get newClient => _localizedValues[locale.languageCode]['new_client'];
  String get successfullyCreatedClient => _localizedValues[locale.languageCode]['successfully_created_client'];
  String get successfullyUpdatedClient => _localizedValues[locale.languageCode]['successfully_updated_client'];
  String get successfullyArchivedClient => _localizedValues[locale.languageCode]['successfully_archived_client'];
  String get successfullyDeletedClient=> _localizedValues[locale.languageCode]['successfully_deleted_client'];
  String get successfullyRestoredClient => _localizedValues[locale.languageCode]['successfully_restored_client'];

  String lookup(String key) {
    return _localizedValues[locale.languageCode][key] ?? 'Missing: ' + key;
  }
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