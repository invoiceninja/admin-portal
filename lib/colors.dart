import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';

import 'constants.dart';

Color kColorRed = convertHexStringToColor('#8D3E3F');
Color kColorGreen = convertHexStringToColor('#407535');

class InvoiceStatusColors {
  static var colors = {
    kInvoiceStatusDraft: Colors.black,
    kInvoiceStatusSent: convertHexStringToColor('#505F73'),
    //kInvoiceStatusViewed: Colors.orange,
    //kInvoiceStatusApproved: Colors.green,
    kInvoiceStatusPartial: Colors.deepPurple,
    kInvoiceStatusPaid: kColorGreen,
    kInvoiceStatusPastDue: kColorRed,
    kInvoiceStatusCancelled: convertHexStringToColor('#444444'),
    kInvoiceStatusReversed: convertHexStringToColor('#444444'),
  };
}

class RecurringInvoiceStatusColors {
  static var colors = {
    kRecurringInvoiceStatusDraft: Colors.black,
    kRecurringInvoiceStatusActive: kColorGreen,
    kRecurringInvoiceStatusPaused: convertHexStringToColor('#444444'),
    kRecurringInvoiceStatusCompleted: kColorGreen,
    kRecurringInvoiceStatusPending: convertHexStringToColor('#444444'),
  };
}

class CreditStatusColors {
  static var colors = {
    kCreditStatusDraft: Colors.black,
    kCreditStatusSent: convertHexStringToColor('#505F73'),
    //kInvoiceStatusViewed: Colors.orange,
    //kInvoiceStatusApproved: Colors.green,
    kCreditStatusPartial: Colors.deepPurple,
    kCreditStatusApplied: kColorGreen,
  };
}

class QuoteStatusColors {
  static var colors = {
    kQuoteStatusDraft: Colors.black,
    kQuoteStatusSent: convertHexStringToColor('#505F73'),
    kQuoteStatusApproved: Colors.deepPurple,
    kQuoteStatusConverted: kColorGreen,
    kQuoteStatusExpired: kColorRed,
  };
}

class PaymentStatusColors {
  static var colors = {
    kPaymentStatusPending: convertHexStringToColor('#505F73'),
    kPaymentStatusCancelled: kColorRed,
    kPaymentStatusFailed: kColorRed,
    kPaymentStatusCompleted: kColorGreen,
    kPaymentStatusPartiallyRefunded: Colors.deepPurple,
    kPaymentStatusRefunded: convertHexStringToColor('#8D3E3F'),
    kPaymentStatusUnapplied: convertHexStringToColor('#444444'),
  };
}

class ExpenseStatusColors {
  static var colors = {
    kExpenseStatusLogged: convertHexStringToColor('#505F73'),
    kExpenseStatusPending: Colors.orange,
    kExpenseStatusInvoiced: kColorGreen,
  };
}

class TaskStatusColors {
  static var colors = {
    kTaskStatusLogged: convertHexStringToColor('#444444'),
    kTaskStatusRunning: convertHexStringToColor('#505F73'),
    kTaskStatusInvoiced: kColorGreen,
  };
}
