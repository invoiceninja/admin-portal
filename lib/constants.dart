import 'package:flutter/material.dart';

// This version must be updated in tandem with the pubspec version.
const String kAppVersion = '0.1.0';

const int kMinMajorAppVersion = 4;
const int kMinMinorAppVersion = 5;

const int kMaxRecordsPerApiPage = 5000;
const int kMillisecondsToRefreshData = 1000 * 60 * 15; // 15 minutes

const int kCurrencyUSDollar = 1;
const int kCurrencyEuro = 3;

const int kInvoiceStatusSent = 2;
const int kInvoiceStatusPastDue = -1;

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
