import 'package:flutter/material.dart';

// This version must be updated in tandem with the pubspec version.
const String kAppVersion = '0.1.40';
const String kAppUrl = 'https://app.invoiceninja.com';

const String kAppleStoreUrl =
    'https://itunes.apple.com/us/app/invoice-ninja/id1435514417?ls=1&mt=8';
const String kGoogleStoreUrl =
    'https://play.google.com/store/apps/details?id=com.invoiceninja.flutter';

const String kSharedPrefEmail = 'email';
const String kSharedPrefUrl = 'url';
const String kSharedPrefSecret = 'secret';
const String kSharedPrefEnableDarkMode = 'enable_dark_mode';
const String kSharedPrefEmailPayment = 'email_payment';
const String kSharedPrefAutoStartTasks = 'auto_start_tasks';
const String kSharedPrefAppVersion = 'app_version';
const String kSharedPrefRequireAuthentication = 'require_authentication';

const String kKeychainToken = 'api_token';
const String kKeychainEmail = 'email';
const String kKeychainUrl = 'url';
const String kKeychainSecret = 'secret';

String getKeychainTokenKey([int companyIndex = 0]) =>
    '${kKeychainToken}_$companyIndex';

const int kMinMajorAppVersion = 4;
const int kMinMinorAppVersion = 5;
const int kMinPatchAppVersion = 4;

const int kMaxRecordsPerApiPage = 5000;
const int kMillisecondsToRefreshData = 1000 * 60 * 15; // 15 minutes
const int kMillisecondsToRefreshActivities = 1000 * 60 * 60 * 24; // 1 day
const int kUpdatedAtBufferSeconds = 600;
//const int kMillisecondsToRefreshActivities = 1000 * 15; // 15 seconds

const int kCurrencyUSDollar = 1;
const int kCurrencyEuro = 3;

const int kCountryUnitedStates = 840;

const int kInvoiceStatusPastDue = -1;
const int kInvoiceStatusDraft = 1;
const int kInvoiceStatusSent = 2;
const int kInvoiceStatusViewed = 3;
const int kInvoiceStatusApproved = 4;
const int kInvoiceStatusPartial = 5;
const int kInvoiceStatusPaid = 6;

const int kTaskStatusLogged = -1;
const int kTaskStatusRunning = -2;
const int kTaskStatusInvoiced = -3;

const int kPaymentStatusPending = 1;
const int kPaymentStatusVoided = 2;
const int kPaymentStatusFailed = 3;
const int kPaymentStatusCompleted = 4;
const int kPaymentStatusPartiallyRefunded = 5;
const int kPaymentStatusRefunded = 6;

const int kDefaultCurrencyId = 1;
const int kDefaultDateFormat = 5;
const int kDefaultDateTimeFormat = 5;

const int kInvoiceTypeStandard = 1;
const int kInvoiceTypeQuote = 2;

const int kActivityEmailInvoice = 6;

const int kModuleRecurringInvoice = 1;
const int kModuleCredit = 2;
const int kModuleQuote = 4;
const int kModuleTask = 8;
const int kModuleExpense = 16;

class InvoiceStatusColors {
  static const colors = {
    kInvoiceStatusDraft: Colors.grey,
    kInvoiceStatusSent: Colors.blue,
    kInvoiceStatusViewed: Colors.orange,
    kInvoiceStatusApproved: Colors.green,
    kInvoiceStatusPartial: Colors.deepPurple,
    kInvoiceStatusPaid: Colors.green,
  };
}

class PaymentStatusColors {
  static const colors = {
    kPaymentStatusPending: Colors.grey,
    kPaymentStatusVoided: Colors.red,
    kPaymentStatusFailed: Colors.red,
    kPaymentStatusCompleted: Colors.green,
    kPaymentStatusPartiallyRefunded: Colors.purple,
    kPaymentStatusRefunded: Colors.red,
  };
}

const List<int> kPaymentTerms = [0, -1, 7, 10, 14, 15, 30, 60, 90];

const String kDesignCustom1 = 'Custom 1';
const String kDesignCustom2 = 'Custom 2';
const String kDesignCustom3 = 'Custom 3';

const List<String> kInvoiceDesigns = [
  'Clean',
  'Bold',
  'Modern',
  'Plain',
  'Business',
  'Creative',
  'Elegant',
  'Hipster',
  'Playful',
  'Photo',
  kDesignCustom1,
  kDesignCustom2,
  kDesignCustom3,
];

const List<String> kLanguages = [
  'ca',
  'cs',
  'da',
  'de',
  'el',
  'en',
  'en_GB',
  'en_AU',
  'es',
  'es_ES',
  'fi',
  'fr',
  'fr_CA',
  'hr',
  'it',
  'ja',
  'lt',
  'nb_NO',
  'nl',
  'pl',
  'pt_BR',
  'pt_PT',
  'ro',
  'sl',
  'sq',
  'sr_RS',
  'sv',
  'th',
  'tr_TR',
];
