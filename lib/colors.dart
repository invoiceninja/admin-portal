import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';
import 'constants.dart';

Color kColorBlue = convertHexStringToColor('#007BFF');
Color kColorTeal = convertHexStringToColor('#17A2B8');
Color kColorGreen = convertHexStringToColor('#28A745');
Color kColorYellow = convertHexStringToColor('#FFC107');
Color kColorRed = convertHexStringToColor('#DC3545');
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
