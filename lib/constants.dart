import 'package:flutter/material.dart';

// This version must be updated in tandem with the pubspec version.
const String kAppVersion = '0.1.7';

const String kSharedPrefEmail = 'email';
const String kSharedPrefUrl = 'url';
const String kSharedPrefSecret = 'secret';
const String kSharedPrefEnableDarkMode = 'enable_dark_mode';
const String kSharedPrefAppVersion = 'app_version';

const int kMinMajorAppVersion = 4;
const int kMinMinorAppVersion = 5;
const int kMinPatchAppVersion = 3;

const int kMaxRecordsPerApiPage = 5000;
const int kMillisecondsToRefreshData = 1000 * 60 * 15; // 15 minutes
const int kMillisecondsToRefreshActivities = 1000 * 60 * 60 * 24; // 1 day
//const int kMillisecondsToRefreshActivities = 1000 * 15; // 15 seconds

const int kCurrencyUSDollar = 1;
const int kCurrencyEuro = 3;

const int kCountryUnitedStates = 840;

const int kInvoiceStatusPastDue = -1;
const int kInvoiceStatusSent = 2;
const int kInvoiceStatusPaid = 6;

const int kDefaultDateFormat = 5;
const int kDefaultDateTimeFormat = 5;

const int kActivityEmailInvoice = 6;

class InvoiceStatusColors {
  static const colors = {
    1: Colors.grey, // draft
    2: Colors.blue, // sent
    3: Colors.orange, // viewed
    4: Colors.green, // approved
    5: Colors.deepPurple, // partial
    6: Colors.green, // paid
  };
}

const List<int> kPaymentTerms = [
  0,
  -1,
  7,
  10,
  14,
  15,
  30,
  60,
  90
];
