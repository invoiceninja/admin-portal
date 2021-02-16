import 'package:flutter/material.dart';
import 'constants.dart';
import 'data/models/static/color_theme_model.dart';

class InvoiceStatusColors {
  InvoiceStatusColors(this._colorTheme);

  final ColorTheme _colorTheme;

  Map<String, Color> get colors {
    return {
      kInvoiceStatusDraft: _colorTheme.colorDarkGray,
      kInvoiceStatusSent: _colorTheme.colorInfo,
      kInvoiceStatusPartial: _colorTheme.colorPrimary,
      kInvoiceStatusPaid: _colorTheme.colorSuccess,
      kInvoiceStatusPastDue: _colorTheme.colorDanger,
      kInvoiceStatusCancelled: _colorTheme.colorLightGray,
      kInvoiceStatusReversed: _colorTheme.colorLightGray,
    };
  }
}

class RecurringInvoiceStatusColors {
  RecurringInvoiceStatusColors(this._colorTheme);

  final ColorTheme _colorTheme;

  Map<String, Color> get colors {
    return {
      kRecurringInvoiceStatusDraft: _colorTheme.colorDarkGray,
      kRecurringInvoiceStatusActive: _colorTheme.colorSuccess,
      kRecurringInvoiceStatusPaused: _colorTheme.colorLightGray,
      kRecurringInvoiceStatusCompleted: _colorTheme.colorSuccess,
      kRecurringInvoiceStatusPending: _colorTheme.colorLightGray,
    };
  }
}

class CreditStatusColors {
  CreditStatusColors(this._colorTheme);

  final ColorTheme _colorTheme;

  Map<String, Color> get colors {
    return {
      kCreditStatusDraft: _colorTheme.colorDarkGray,
      kCreditStatusSent: _colorTheme.colorInfo,
      kCreditStatusPartial: _colorTheme.colorPrimary,
      kCreditStatusApplied: _colorTheme.colorSuccess,
    };
  }
}

class QuoteStatusColors {
  QuoteStatusColors(this._colorTheme);

  final ColorTheme _colorTheme;

  Map<String, Color> get colors {
    return {
      kQuoteStatusDraft: _colorTheme.colorDarkGray,
      kQuoteStatusSent: _colorTheme.colorInfo,
      kQuoteStatusApproved: _colorTheme.colorPrimary,
      kQuoteStatusConverted: _colorTheme.colorSuccess,
      kQuoteStatusExpired: _colorTheme.colorDanger,
    };
  }
}

class PaymentStatusColors {
  PaymentStatusColors(this._colorTheme);

  final ColorTheme _colorTheme;

  Map<String, Color> get colors {
    return {
      kPaymentStatusPending: _colorTheme.colorDarkGray,
      kPaymentStatusCancelled: _colorTheme.colorLightGray,
      kPaymentStatusFailed: _colorTheme.colorDanger,
      kPaymentStatusCompleted: _colorTheme.colorSuccess,
      kPaymentStatusPartiallyRefunded: _colorTheme.colorPrimary,
      kPaymentStatusRefunded: _colorTheme.colorLightGray,
      kPaymentStatusUnapplied: _colorTheme.colorDarkGray,
      kPaymentStatusPartiallyUnapplied: _colorTheme.colorDarkGray,
    };
  }
}

class ExpenseStatusColors {
  ExpenseStatusColors(this._colorTheme);

  final ColorTheme _colorTheme;

  Map<String, Color> get colors {
    return {
      kExpenseStatusLogged: _colorTheme.colorDarkGray,
      kExpenseStatusPending: _colorTheme.colorPrimary,
      kExpenseStatusInvoiced: _colorTheme.colorSuccess,
    };
  }
}

class TaskStatusColors {
  TaskStatusColors(this._colorTheme);

  final ColorTheme _colorTheme;

  Map<String, Color> get colors {
    return {
      kTaskStatusLogged: _colorTheme.colorDarkGray,
      kTaskStatusRunning: _colorTheme.colorPrimary,
      kTaskStatusInvoiced: _colorTheme.colorSuccess,
    };
  }
}
