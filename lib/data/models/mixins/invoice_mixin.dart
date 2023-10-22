// Flutter imports:

// Package imports:
import 'package:built_collection/built_collection.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

abstract mixin class CalculateInvoiceTotal {
  bool get isAmountDiscount;

  String get taxName1;

  double get taxRate1;

  String get taxName2;

  double get taxRate2;

  String get taxName3;

  double get taxRate3;

  double get discount;

  double get customSurcharge1;

  double get customSurcharge2;

  double get customSurcharge3;

  double get customSurcharge4;

  bool get customTaxes1;

  bool get customTaxes2;

  bool get customTaxes3;

  bool get customTaxes4;

  bool get usesInclusiveTaxes;

  BuiltList<InvoiceItemEntity> get lineItems;

  double _calculateTaxAmount(
      double amount, double rate, bool useInclusiveTaxes, int precision) {
    double taxAmount;
    if (useInclusiveTaxes) {
      taxAmount = amount - (amount / (1 + (rate / 100)));
    } else {
      taxAmount = amount * rate / 100;
    }
    return round(taxAmount, precision);
  }

  Map<String, double> calculateTaxes(
      {required bool useInclusiveTaxes, required int precision}) {
    double total = calculateSubtotal(precision: precision);
    double taxAmount;
    final map = <String, double>{};

    lineItems.forEach((item) {
      final double taxRate1 = round(item.taxRate1, 3);
      final double taxRate2 = round(item.taxRate2, 3);
      final double taxRate3 = round(item.taxRate3, 3);

      final lineTotal = getItemTaxable(item, total, precision);

      if (taxRate1 != 0) {
        taxAmount = _calculateTaxAmount(
            lineTotal, taxRate1, useInclusiveTaxes, precision);
        map.update(item.taxName1, (value) => value + taxAmount,
            ifAbsent: () => taxAmount);
      }
      if (taxRate2 != 0) {
        taxAmount = _calculateTaxAmount(
            lineTotal, taxRate2, useInclusiveTaxes, precision);
        map.update(item.taxName2, (value) => value + taxAmount,
            ifAbsent: () => taxAmount);
      }
      if (taxRate3 != 0) {
        taxAmount = _calculateTaxAmount(
            lineTotal, taxRate3, useInclusiveTaxes, precision);
        map.update(item.taxName3, (value) => value + taxAmount,
            ifAbsent: () => taxAmount);
      }
    });

    if (discount != 0.0) {
      if (isAmountDiscount) {
        total -= round(discount, precision);
      } else {
        total -= round(total * discount / 100, precision);
      }
    }

    if (customSurcharge1 != 0.0 && customTaxes1) {
      total += round(customSurcharge1, precision);
    }

    if (customSurcharge2 != 0.0 && customTaxes2) {
      total += round(customSurcharge2, precision);
    }

    if (customSurcharge3 != 0.0 && customTaxes3) {
      total += round(customSurcharge3, precision);
    }

    if (customSurcharge4 != 0.0 && customTaxes4) {
      total += round(customSurcharge4, precision);
    }

    if (taxRate1 != 0) {
      taxAmount =
          _calculateTaxAmount(total, taxRate1, useInclusiveTaxes, precision);
      map.update(taxName1, (value) => value + taxAmount,
          ifAbsent: () => taxAmount);
    }

    if (taxRate2 != 0) {
      taxAmount =
          _calculateTaxAmount(total, taxRate2, useInclusiveTaxes, precision);
      map.update(taxName2, (value) => value + taxAmount,
          ifAbsent: () => taxAmount);
    }

    if (taxRate3 != 0) {
      taxAmount =
          _calculateTaxAmount(total, taxRate3, useInclusiveTaxes, precision);
      map.update(taxName3, (value) => value + taxAmount,
          ifAbsent: () => taxAmount);
    }

    return map;
  }

  double getTaxable(int precision) {
    double total = 0;

    lineItems.forEach((invoiceItem) {
      double lineTotal = invoiceItem.quantity * invoiceItem.cost;

      if (invoiceItem.discount != 0) {
        if (isAmountDiscount) {
          lineTotal -= invoiceItem.discount;
        } else {
          lineTotal -= round(lineTotal * invoiceItem.discount / 100, precision);
        }
      }

      total += lineTotal;
    });

    if (discount != 0) {
      if (isAmountDiscount) {
        total -= discount;
      } else {
        total *= (100 - discount) / 100;
        total = round(total, 2);
      }
    }

    if (customTaxes1) {
      total += customSurcharge1;
    }
    if (customTaxes2) {
      total += customSurcharge2;
    }
    if (customTaxes3) {
      total += customSurcharge3;
    }
    if (customTaxes4) {
      total += customSurcharge4;
    }

    return total;
  }

  double getItemTaxable(
      InvoiceItemEntity item, double invoiceTotal, int precision) {
    final double qty = round(item.quantity, 5);
    final double cost = round(item.cost, 5);
    final double itemDiscount = round(item.discount, 5);
    double lineTotal = qty * cost;

    if (discount != 0) {
      if (isAmountDiscount) {
        if (invoiceTotal + discount != 0) {
          lineTotal -= invoiceTotal != 0
              ? (lineTotal / (invoiceTotal + discount) * discount)
              : 0;
        }
      } else {
        lineTotal *= (100 - discount) / 100;
      }
    }

    if (itemDiscount != 0) {
      if (isAmountDiscount) {
        lineTotal -= itemDiscount;
      } else {
        lineTotal -= lineTotal * itemDiscount / 100;
      }
    }

    return round(lineTotal, precision);
  }

  double calculateTotal({required int precision}) {
    double total = calculateSubtotal(precision: precision);
    double itemTax = 0.0;

    lineItems.forEach((item) {
      final double qty = round(item.quantity, 5);
      final double cost = round(item.cost, 5);
      final double itemDiscount = round(item.discount, 5);
      final double taxRate1 = round(item.taxRate1, 3);
      final double taxRate2 = round(item.taxRate2, 3);
      final double taxRate3 = round(item.taxRate3, 3);
      double lineTotal = qty * cost;

      if (discount != 0) {
        if (isAmountDiscount) {
          if (total != 0) {
            lineTotal -= round(lineTotal / total * discount, precision);
          }
        } else {
          lineTotal -= round(lineTotal * discount / 100, precision);
        }
      }

      if (itemDiscount != 0) {
        if (isAmountDiscount) {
          lineTotal -= itemDiscount;
        } else {
          lineTotal -= round(lineTotal * itemDiscount / 100, precision);
        }
      }

      if (taxRate1 != 0) {
        itemTax += round(lineTotal * taxRate1 / 100, precision);
      }
      if (taxRate2 != 0) {
        itemTax += round(lineTotal * taxRate2 / 100, precision);
      }
      if (taxRate3 != 0) {
        itemTax += round(lineTotal * taxRate3 / 100, precision);
      }
    });

    if (discount != 0.0) {
      if (isAmountDiscount) {
        total -= round(discount, precision);
      } else {
        total -= round(total * discount / 100, precision);
      }
    }

    if (customSurcharge1 != 0.0 && customTaxes1) {
      total += round(customSurcharge1, precision);
    }

    if (customSurcharge2 != 0.0 && customTaxes2) {
      total += round(customSurcharge2, precision);
    }

    if (customSurcharge3 != 0.0 && customTaxes3) {
      total += round(customSurcharge3, precision);
    }

    if (customSurcharge4 != 0.0 && customTaxes4) {
      total += round(customSurcharge4, precision);
    }

    if (!usesInclusiveTaxes) {
      final double taxAmount1 = round(total * taxRate1 / 100, precision);
      final double taxAmount2 = round(total * taxRate2 / 100, precision);
      final double taxAmount3 = round(total * taxRate3 / 100, precision);

      total += itemTax + taxAmount1 + taxAmount2 + taxAmount3;
    }

    if (customSurcharge1 != 0.0 && !customTaxes1) {
      total += round(customSurcharge1, precision);
    }

    if (customSurcharge2 != 0.0 && !customTaxes2) {
      total += round(customSurcharge2, precision);
    }

    if (customSurcharge3 != 0.0 && !customTaxes3) {
      total += round(customSurcharge3, precision);
    }

    if (customSurcharge4 != 0.0 && !customTaxes4) {
      total += round(customSurcharge4, precision);
    }

    return total;
  }

  double calculateSubtotal({required int precision}) {
    var total = 0.0;

    lineItems.forEach((item) {
      final double qty = round(item.quantity, 5);
      final double cost = round(item.cost, 5);
      final double discount = round(item.discount, 5);

      double lineTotal = qty * cost;

      if (discount != 0) {
        if (isAmountDiscount) {
          lineTotal -= discount;
        } else {
          lineTotal -= round(lineTotal * discount / 100, precision);
        }
      }

      total += round(lineTotal, precision);
    });

    return total;
  }
}
