import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';
import 'constants.dart';

Color kColorBlue = convertHexStringToColor('#0275d8');
Color kColorTeal = convertHexStringToColor('#5bc0de');
Color kColorGreen = convertHexStringToColor('#5cb85c');
Color kColorYellow = convertHexStringToColor('#f0ad4e');
Color kColorRed = convertHexStringToColor('#d9534f');
Color kColorGray = convertHexStringToColor('#6C757D');
Color kColorDarkGray = convertHexStringToColor('#343A40');

class InvoiceStatusColors {
  static var colors = {
    kInvoiceStatusDraft: kColorDarkGray,
    kInvoiceStatusSent: kColorTeal,
    kInvoiceStatusPartial: kColorBlue,
    kInvoiceStatusPaid: kColorGreen,
    kInvoiceStatusPastDue: kColorRed,
    kInvoiceStatusCancelled: kColorGray,
    kInvoiceStatusReversed: kColorGray,
  };
}

class RecurringInvoiceStatusColors {
  static var colors = {
    kRecurringInvoiceStatusDraft: kColorDarkGray,
    kRecurringInvoiceStatusActive: kColorGreen,
    kRecurringInvoiceStatusPaused: kColorGray,
    kRecurringInvoiceStatusCompleted: kColorGreen,
    kRecurringInvoiceStatusPending: kColorGray,
  };
}

class CreditStatusColors {
  static var colors = {
    kCreditStatusDraft: kColorDarkGray,
    kCreditStatusSent: kColorTeal,
    kCreditStatusPartial: kColorBlue,
    kCreditStatusApplied: kColorGreen,
  };
}

class QuoteStatusColors {
  static var colors = {
    kQuoteStatusDraft: kColorDarkGray,
    kQuoteStatusSent: kColorTeal,
    kQuoteStatusApproved: kColorBlue,
    kQuoteStatusConverted: kColorGreen,
    kQuoteStatusExpired: kColorRed,
  };
}

class PaymentStatusColors {
  static var colors = {
    kPaymentStatusPending: kColorDarkGray,
    kPaymentStatusCancelled: kColorGray,
    kPaymentStatusFailed: kColorRed,
    kPaymentStatusCompleted: kColorGreen,
    kPaymentStatusPartiallyRefunded: kColorBlue,
    kPaymentStatusRefunded: kColorGray,
    kPaymentStatusUnapplied: kColorDarkGray,
  };
}

class ExpenseStatusColors {
  static var colors = {
    kExpenseStatusLogged: kColorDarkGray,
    kExpenseStatusPending: kColorBlue,
    kExpenseStatusInvoiced: kColorGreen,
  };
}

class TaskStatusColors {
  static var colors = {
    kTaskStatusLogged: kColorDarkGray,
    kTaskStatusRunning: kColorBlue,
    kTaskStatusInvoiced: kColorGreen,
  };
}
