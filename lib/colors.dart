// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'constants.dart';
import 'data/models/static/color_theme_model.dart';

class InvoiceStatusColors {
  InvoiceStatusColors(this._colorTheme);

  final ColorTheme _colorTheme;

  Map<String, Color> get colors {
    return {
      kInvoiceStatusDraft: _colorTheme.colorGray,
      kInvoiceStatusSent: _colorTheme.colorInfo,
      kInvoiceStatusPartial: _colorTheme.colorPrimary,
      kInvoiceStatusPaid: _colorTheme.colorSuccess,
      kInvoiceStatusPastDue: _colorTheme.colorDanger,
      kInvoiceStatusCancelled: _colorTheme.colorGray,
      kInvoiceStatusReversed: _colorTheme.colorGray,
      kInvoiceStatusViewed: _colorTheme.colorWarning,
    };
  }
}

class RecurringInvoiceStatusColors {
  RecurringInvoiceStatusColors(this._colorTheme);

  final ColorTheme _colorTheme;

  Map<String, Color> get colors {
    return {
      kRecurringInvoiceStatusDraft: _colorTheme.colorGray,
      kRecurringInvoiceStatusActive: _colorTheme.colorSuccess,
      kRecurringInvoiceStatusPaused: _colorTheme.colorGray,
      kRecurringInvoiceStatusCompleted: _colorTheme.colorSuccess,
      kRecurringInvoiceStatusPending: _colorTheme.colorGray,
    };
  }
}

class CreditStatusColors {
  CreditStatusColors(this._colorTheme);

  final ColorTheme _colorTheme;

  Map<String, Color> get colors {
    return {
      kCreditStatusDraft: _colorTheme.colorGray,
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
      kQuoteStatusDraft: _colorTheme.colorGray,
      kQuoteStatusSent: _colorTheme.colorInfo,
      kQuoteStatusApproved: _colorTheme.colorPrimary,
      kQuoteStatusConverted: _colorTheme.colorSuccess,
      kQuoteStatusExpired: _colorTheme.colorDanger,
      kQuoteStatusViewed: _colorTheme.colorWarning,
    };
  }
}

class PaymentStatusColors {
  PaymentStatusColors(this._colorTheme);

  final ColorTheme _colorTheme;

  Map<String, Color> get colors {
    return {
      kPaymentStatusPending: _colorTheme.colorGray,
      kPaymentStatusCancelled: _colorTheme.colorGray,
      kPaymentStatusFailed: _colorTheme.colorDanger,
      kPaymentStatusCompleted: _colorTheme.colorSuccess,
      kPaymentStatusPartiallyRefunded: _colorTheme.colorPrimary,
      kPaymentStatusRefunded: _colorTheme.colorGray,
      kPaymentStatusUnapplied: _colorTheme.colorGray,
      kPaymentStatusPartiallyUnapplied: _colorTheme.colorGray,
    };
  }
}

class ExpenseStatusColors {
  ExpenseStatusColors(this._colorTheme);

  final ColorTheme _colorTheme;

  Map<String, Color> get colors {
    return {
      kExpenseStatusLogged: _colorTheme.colorGray,
      kExpenseStatusPending: _colorTheme.colorPrimary,
      kExpenseStatusInvoiced: _colorTheme.colorSuccess,
      kExpenseStatusPaid: _colorTheme.colorInfo,
    };
  }
}

class TaskStatusColors {
  TaskStatusColors(this._colorTheme);

  final ColorTheme _colorTheme;

  Map<String, Color> get colors {
    return {
      kTaskStatusLogged: _colorTheme.colorGray,
      kTaskStatusRunning: _colorTheme.colorPrimary,
      kTaskStatusInvoiced: _colorTheme.colorSuccess,
    };
  }
}
