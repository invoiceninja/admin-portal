import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';
import 'constants.dart';

Color kColorPrimary = convertHexStringToColor('#1266F1'); // blue
Color kColorSecondary = convertHexStringToColor('#B23CFD'); // purple
Color kColorInfo = convertHexStringToColor('#39C0ED');
Color kColorSuccess = convertHexStringToColor('#00B74A');
Color kColorWarning = convertHexStringToColor('#FFA900');
Color kColorDanger = convertHexStringToColor('#F93154');
Color kColorGray = convertHexStringToColor('#6C757D');
Color kColorDarkGray = convertHexStringToColor('#262626');

class InvoiceStatusColors {
  static var colors = {
    kInvoiceStatusDraft: kColorDarkGray,
    kInvoiceStatusSent: kColorInfo,
    kInvoiceStatusPartial: kColorPrimary,
    kInvoiceStatusPaid: kColorSuccess,
    kInvoiceStatusPastDue: kColorDanger,
    kInvoiceStatusCancelled: kColorGray,
    kInvoiceStatusReversed: kColorGray,
  };
}

class RecurringInvoiceStatusColors {
  static var colors = {
    kRecurringInvoiceStatusDraft: kColorDarkGray,
    kRecurringInvoiceStatusActive: kColorSuccess,
    kRecurringInvoiceStatusPaused: kColorGray,
    kRecurringInvoiceStatusCompleted: kColorSuccess,
    kRecurringInvoiceStatusPending: kColorGray,
  };
}

class CreditStatusColors {
  static var colors = {
    kCreditStatusDraft: kColorDarkGray,
    kCreditStatusSent: kColorInfo,
    kCreditStatusPartial: kColorPrimary,
    kCreditStatusApplied: kColorSuccess,
  };
}

class QuoteStatusColors {
  static var colors = {
    kQuoteStatusDraft: kColorDarkGray,
    kQuoteStatusSent: kColorInfo,
    kQuoteStatusApproved: kColorPrimary,
    kQuoteStatusConverted: kColorSuccess,
    kQuoteStatusExpired: kColorDanger,
  };
}

class PaymentStatusColors {
  static var colors = {
    kPaymentStatusPending: kColorDarkGray,
    kPaymentStatusCancelled: kColorGray,
    kPaymentStatusFailed: kColorDanger,
    kPaymentStatusCompleted: kColorSuccess,
    kPaymentStatusPartiallyRefunded: kColorPrimary,
    kPaymentStatusRefunded: kColorGray,
    kPaymentStatusUnapplied: kColorDarkGray,
  };
}

class ExpenseStatusColors {
  static var colors = {
    kExpenseStatusLogged: kColorDarkGray,
    kExpenseStatusPending: kColorPrimary,
    kExpenseStatusInvoiced: kColorSuccess,
  };
}

class TaskStatusColors {
  static var colors = {
    kTaskStatusLogged: kColorDarkGray,
    kTaskStatusRunning: kColorPrimary,
    kTaskStatusInvoiced: kColorSuccess,
  };
}
