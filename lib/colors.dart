// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'constants.dart';
import 'data/models/static/color_theme_model.dart';

class InvoiceStatusColors {
  InvoiceStatusColors(this._colorTheme);

  final ColorTheme? _colorTheme;

  Map<String, Color?> get colors {
    return {
      kInvoiceStatusDraft: _colorTheme!.colorLightGray,
      kInvoiceStatusSent: _colorTheme!.colorInfo,
      kInvoiceStatusPartial: _colorTheme!.colorPrimary,
      kInvoiceStatusPaid: _colorTheme!.colorSuccess,
      kInvoiceStatusPastDue: _colorTheme!.colorDanger,
      kInvoiceStatusCancelled: _colorTheme!.colorDarkGray,
      kInvoiceStatusReversed: _colorTheme!.colorDarkGray,
      kInvoiceStatusViewed: _colorTheme!.colorWarning,
    };
  }
}

class RecurringInvoiceStatusColors {
  RecurringInvoiceStatusColors(this._colorTheme);

  final ColorTheme? _colorTheme;

  Map<String, Color?> get colors {
    return {
      kRecurringInvoiceStatusDraft: _colorTheme!.colorLightGray,
      kRecurringInvoiceStatusActive: _colorTheme!.colorSuccess,
      kRecurringInvoiceStatusPaused: _colorTheme!.colorDarkGray,
      kRecurringInvoiceStatusCompleted: _colorTheme!.colorInfo,
      kRecurringInvoiceStatusPending: _colorTheme!.colorPrimary,
    };
  }
}

class CreditStatusColors {
  CreditStatusColors(this._colorTheme);

  final ColorTheme? _colorTheme;

  Map<String, Color?> get colors {
    return {
      kCreditStatusDraft: _colorTheme!.colorLightGray,
      kCreditStatusSent: _colorTheme!.colorInfo,
      kCreditStatusPartial: _colorTheme!.colorPrimary,
      kCreditStatusApplied: _colorTheme!.colorSuccess,
      kCreditStatusViewed: _colorTheme!.colorWarning,
    };
  }
}

class PurchaseOrderStatusColors {
  PurchaseOrderStatusColors(this._colorTheme);

  final ColorTheme? _colorTheme;

  Map<String, Color?> get colors {
    return {
      kPurchaseOrderStatusDraft: _colorTheme!.colorLightGray,
      kPurchaseOrderStatusSent: _colorTheme!.colorInfo,
      kPurchaseOrderStatusAccepted: _colorTheme!.colorPrimary,
      kPurchaseOrderStatusReceived: _colorTheme!.colorSuccess,
      kPurchaseOrderStatusCancelled: _colorTheme!.colorDanger,
      kPurchaseOrderStatusViewed: _colorTheme!.colorWarning,
    };
  }
}

class TransactionStatusColors {
  TransactionStatusColors(this._colorTheme);

  final ColorTheme? _colorTheme;

  Map<String, Color?> get colors {
    return {
      kTransactionStatusUnmatched: _colorTheme!.colorInfo,
      kTransactionStatusMatched: _colorTheme!.colorPrimary,
      kTransactionStatusConverted: _colorTheme!.colorSuccess,
    };
  }
}

class QuoteStatusColors {
  QuoteStatusColors(this._colorTheme);

  final ColorTheme? _colorTheme;

  Map<String, Color?> get colors {
    return {
      kQuoteStatusDraft: _colorTheme!.colorLightGray,
      kQuoteStatusSent: _colorTheme!.colorInfo,
      kQuoteStatusApproved: _colorTheme!.colorPrimary,
      kQuoteStatusConverted: _colorTheme!.colorSuccess,
      kQuoteStatusExpired: _colorTheme!.colorDanger,
      kQuoteStatusViewed: _colorTheme!.colorWarning,
    };
  }
}

class PaymentStatusColors {
  PaymentStatusColors(this._colorTheme);

  final ColorTheme? _colorTheme;

  Map<String, Color?> get colors {
    return {
      kPaymentStatusPending: _colorTheme!.colorLightGray,
      kPaymentStatusCancelled: _colorTheme!.colorDarkGray,
      kPaymentStatusFailed: _colorTheme!.colorDanger,
      kPaymentStatusCompleted: _colorTheme!.colorSuccess,
      kPaymentStatusPartiallyRefunded: _colorTheme!.colorPrimary,
      kPaymentStatusRefunded: _colorTheme!.colorDarkGray,
      kPaymentStatusUnapplied: _colorTheme!.colorInfo,
      kPaymentStatusPartiallyUnapplied: _colorTheme!.colorInfo,
    };
  }
}

class ExpenseStatusColors {
  ExpenseStatusColors(this._colorTheme);

  final ColorTheme? _colorTheme;

  Map<String, Color?> get colors {
    return {
      kExpenseStatusLogged: _colorTheme!.colorLightGray,
      kExpenseStatusPending: _colorTheme!.colorPrimary,
      kExpenseStatusInvoiced: _colorTheme!.colorSuccess,
      kExpenseStatusPaid: _colorTheme!.colorInfo,
    };
  }
}

class TaskStatusColors {
  TaskStatusColors(this._colorTheme);

  final ColorTheme? _colorTheme;

  Map<String, Color?> get colors {
    return {
      kTaskStatusLogged: _colorTheme!.colorLightGray,
      kTaskStatusRunning: _colorTheme!.colorPrimary,
      kTaskStatusInvoiced: _colorTheme!.colorSuccess,
    };
  }
}
