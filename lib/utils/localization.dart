import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:invoiceninja/utils/strings.dart';

class AppLocalization {
  AppLocalization(this.locale);

  final Locale locale;

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  static final Map<String, Map<String, String>> _localizedValues = {
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
      'login': 'Login',
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
      'balance_due': 'Balance Due',
      'balance': 'Balance',
      'overview': 'Overview',
      'details': 'Details',
      'phone': 'Phone',
      'website': 'Website',
      'vat_number': 'VAT Number',
      'id_number': 'Id Number',
      'create': 'Create',
      'copied_to_clipboard': 'Copied to clipboard',
      'error': 'Error',
      'could_not_launch': 'Could not launch',
      'contacts': 'Contacts',
      'additional': 'Additional',
      'first_name': 'First Name',
      'last_name': 'Last Name',
      'add_contact': 'Add Contact',
      'are_you_sure': 'Are you sure?',
      'cancel': 'Cancel',
      'ok': 'Ok',
      'remove': 'Remove',
      'email_is_invalid': 'Email is invalid',

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
      'address1': 'Street',
      'address2': 'Apt/Suite',
      'city': 'City',
      'state': 'State/Province',
      'postal_code': 'Postal Code',
      'country': 'Country',

      'invoice': 'Invoice',
      'invoices': 'Invoices',
      'new_invoice': 'New Invoice',
      'successfully_created_invoice': 'Successfully created invoice',
      'successfully_updated_invoice': 'Successfully updated invoice',
      'successfully_archived_invoice': 'Successfully archived invoice',
      'successfully_deleted_invoice': 'Successfully deleted invoice',
      'successfully_restored_invoice': 'Successfully restored invoice',
      'successfully_emailed_invoice': 'Successfully emailed invoice',
      'amount': 'Amount',
      'invoice_number': 'Invoice Number',
      'invoice_date': 'Invoice Date',
      'discount': 'Discount',
      'po_number': 'PO Number',
      'terms': 'Terms',
      'public_notes': 'Public Notes',
      'private_notes': 'Private Notes',
      'frequency': 'Frequency',
      'start_date': 'Start Date',
      'end_date': 'End Date',
      'quote_number': 'Quote Number',
      'quote_date': 'Quote Date',
      'valid_until': 'Valid Until',
      'items': 'Items',
      'partial': 'Partial/Deposit',
      'description': 'Description',
      'unit_cost': 'Unit Cost',
      'quantity': 'Quantity',
      'add_item': 'Add Item',
      'contact': 'Contact',
      'work_phone': 'Phone',
      'total_amount': 'Total Amount',
      'pdf': 'PDF',
      'due_date': 'Due Date',
      'partial_due_date': 'Partial Due Date',
      'status': 'Status',
      'invoice_status_id': 'Invoice Status',
      'click_plus_to_add_item': 'Click + to add an item',
      'count_selected': ':count selected',
      'total': 'Total',
      'percent': 'Percent',
      'edit': 'Edit',
      'dismiss': 'Dismiss',
      'please_select_a_date': 'Please select a date',
      'please_select_a_client': 'Please select a client',
      'task_rate': 'Task Rate',
      'settings': 'Settings',
      'language': 'Language',
      'currency': 'Currency',
      'created_at': 'Created',
      'updated_at': 'Updated',
      'tax': 'Tax',
      'please_enter_an_invoice_number': 'Please enter an invoice number',
      'please_enter_a_quote_number': 'Please enter a quote number',

      'payment': 'Payment',
      'payments': 'Payments',

      'quote': 'Quote',
      'quotes': 'Quotes',

      'expense': 'Expense',
      'expenses': 'Expenses',

      'vendor': 'Vendor',
      'vendors': 'Vendors',

      'task': 'Task',
      'tasks': 'Tasks',

      'project': 'Project',
      'projects': 'Projects',



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
  String get login => _localizedValues[locale.languageCode]['login'];
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
  String get anErrorOccurred => _localizedValues[locale.languageCode]['an_error_occurred'];
  String get paidToDate => _localizedValues[locale.languageCode]['paid_to_date'];
  String get balanceDue => _localizedValues[locale.languageCode]['balance_due'];
  String get balance => _localizedValues[locale.languageCode]['balance'];
  String get overview => _localizedValues[locale.languageCode]['overview'];
  String get details => _localizedValues[locale.languageCode]['details'];
  String get phone => _localizedValues[locale.languageCode]['phone'];
  String get website => _localizedValues[locale.languageCode]['website'];
  String get vatNumber => _localizedValues[locale.languageCode]['vat_number'];
  String get idNumber => _localizedValues[locale.languageCode]['id_number'];
  String get create => _localizedValues[locale.languageCode]['create'];
  String get copiedToClipboard => _localizedValues[locale.languageCode]['copied_to_clipboard'];
  String get error => _localizedValues[locale.languageCode]['error'];
  String get couldNotLaunch => _localizedValues[locale.languageCode]['could_not_launch'];
  String get contacts => _localizedValues[locale.languageCode]['contacts'];
  String get additional => _localizedValues[locale.languageCode]['additional'];
  String get firstName => _localizedValues[locale.languageCode]['first_name'];
  String get lastName => _localizedValues[locale.languageCode]['last_name'];
  String get addContact => _localizedValues[locale.languageCode]['add_contact'];
  String get areYouSure => _localizedValues[locale.languageCode]['are_you_sure'];
  String get cancel => _localizedValues[locale.languageCode]['cancel'];
  String get ok => _localizedValues[locale.languageCode]['ok'];
  String get remove => _localizedValues[locale.languageCode]['remove'];
  String get emailIsInvalid => _localizedValues[locale.languageCode]['email_is_invalid'];

  String get product => _localizedValues[locale.languageCode]['product'];
  String get products => _localizedValues[locale.languageCode]['products'];
  String get newProduct => _localizedValues[locale.languageCode]['new_product'];
  String get successfullyCreatedProduct => _localizedValues[locale.languageCode]['successfully_created_product'];
  String get successfullyUpdatedProduct => _localizedValues[locale.languageCode]['successfully_updated_product'];
  String get successfullyArchivedProduct => _localizedValues[locale.languageCode]['successfully_archived_product'];
  String get successfullyDeletedProduct => _localizedValues[locale.languageCode]['successfully_deleted_product'];
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
  String get successfullyDeletedClient => _localizedValues[locale.languageCode]['successfully_deleted_client'];
  String get successfullyRestoredClient => _localizedValues[locale.languageCode]['successfully_restored_client'];
  String get address1 => _localizedValues[locale.languageCode]['address1'];
  String get address2 => _localizedValues[locale.languageCode]['address2'];
  String get city => _localizedValues[locale.languageCode]['city'];
  String get state => _localizedValues[locale.languageCode]['state'];
  String get postalCode => _localizedValues[locale.languageCode]['postal_code'];
  String get country => _localizedValues[locale.languageCode]['country'];

  String get invoice => _localizedValues[locale.languageCode]['invoice'];
  String get invoices => _localizedValues[locale.languageCode]['invoices'];
  String get newInvoice => _localizedValues[locale.languageCode]['new_invoice'];
  String get successfullyCreatedInvoice => _localizedValues[locale.languageCode]['successfully_created_invoice'];
  String get successfullyUpdatedInvoice => _localizedValues[locale.languageCode]['successfully_updated_invoice'];
  String get successfullyArchivedInvoice => _localizedValues[locale.languageCode]['successfully_archived_invoice'];
  String get successfullyDeletedInvoice => _localizedValues[locale.languageCode]['successfully_deleted_invoice'];
  String get successfullyRestoredInvoice => _localizedValues[locale.languageCode]['successfully_restored_invoice'];
  String get successfullyEmailedInvoice => _localizedValues[locale.languageCode]['successfully_emailed_invoice'];
  String get amount => _localizedValues[locale.languageCode]['amount'];
  String get invoiceNumber => _localizedValues[locale.languageCode]['invoice_number'];
  String get invoiceDate => _localizedValues[locale.languageCode]['invoice_date'];
  String get discount => _localizedValues[locale.languageCode]['discount'];
  String get poNumber => _localizedValues[locale.languageCode]['po_number'];
  String get terms => _localizedValues[locale.languageCode]['terms'];
  String get publicNotes => _localizedValues[locale.languageCode]['public_notes'];
  String get privateNotes => _localizedValues[locale.languageCode]['private_notes'];
  String get frequency => _localizedValues[locale.languageCode]['frequency'];
  String get startDate => _localizedValues[locale.languageCode]['start_date'];
  String get endDate => _localizedValues[locale.languageCode]['end_date'];
  String get quoteNumber => _localizedValues[locale.languageCode]['quote_number'];
  String get quoteDate => _localizedValues[locale.languageCode]['quote_date'];
  String get validUntil => _localizedValues[locale.languageCode]['valid_until'];
  String get items => _localizedValues[locale.languageCode]['items'];
  String get partial => _localizedValues[locale.languageCode]['partial'];
  String get description => _localizedValues[locale.languageCode]['description'];
  String get unitCost => _localizedValues[locale.languageCode]['unit_cost'];
  String get quantity => _localizedValues[locale.languageCode]['quantity'];
  String get addItem => _localizedValues[locale.languageCode]['add_item'];
  String get contact => _localizedValues[locale.languageCode]['contact'];
  String get workPhone => _localizedValues[locale.languageCode]['work_phone'];
  String get totalAmount => _localizedValues[locale.languageCode]['total_amount'];
  String get pdf => _localizedValues[locale.languageCode]['pdf'];
  String get dueDate => _localizedValues[locale.languageCode]['due_date'];
  String get partialDueDate => _localizedValues[locale.languageCode]['partial_due_date'];
  String get status => _localizedValues[locale.languageCode]['status'];
  String get invoiceStatusId => _localizedValues[locale.languageCode]['invoice_status_id'];
  String get clickPlusToAddItem => _localizedValues[locale.languageCode]['click_plus_to_add_item'];
  String get countSelected => _localizedValues[locale.languageCode]['count_selected'];
  String get total => _localizedValues[locale.languageCode]['total'];
  String get percent => _localizedValues[locale.languageCode]['percent'];
  String get edit => _localizedValues[locale.languageCode]['edit'];
  String get dismiss => _localizedValues[locale.languageCode]['dismiss'];
  String get pleaseSelectADate => _localizedValues[locale.languageCode]['please_select_a_date'];
  String get pleaseSelectAClient => _localizedValues[locale.languageCode]['please_select_a_client'];
  String get taskRate => _localizedValues[locale.languageCode]['task_rate'];
  String get settings => _localizedValues[locale.languageCode]['settings'];
  String get language => _localizedValues[locale.languageCode]['language'];
  String get currency => _localizedValues[locale.languageCode]['currency'];
  String get createdAt => _localizedValues[locale.languageCode]['created_at'];
  String get updatedAt => _localizedValues[locale.languageCode]['updated_at'];
  String get tax => _localizedValues[locale.languageCode]['tax'];
  String get pleaseEnterAnInvoiceNumber => _localizedValues[locale.languageCode]['please_enter_an_invoice_number'];
  String get pleaseEnterAQuoteNumber => _localizedValues[locale.languageCode]['please_enter_a_quote_number'];

  String get payment => _localizedValues[locale.languageCode]['payment'];
  String get payments => _localizedValues[locale.languageCode]['payments'];

  String get quote => _localizedValues[locale.languageCode]['quote'];
  String get quotes => _localizedValues[locale.languageCode]['quotes'];

  String get expense => _localizedValues[locale.languageCode]['expense'];
  String get expenses => _localizedValues[locale.languageCode]['expenses'];

  String get vendor => _localizedValues[locale.languageCode]['vendor'];
  String get vendors => _localizedValues[locale.languageCode]['vendors'];

  String get task => _localizedValues[locale.languageCode]['task'];
  String get tasks => _localizedValues[locale.languageCode]['tasks'];

  String get project => _localizedValues[locale.languageCode]['project'];
  String get projects => _localizedValues[locale.languageCode]['projects'];


  String lookup(String key) {    
    return _localizedValues[locale.languageCode][toSnakeCase(key)] ?? key;
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