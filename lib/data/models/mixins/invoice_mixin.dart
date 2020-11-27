import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

abstract class CalculateInvoiceTotal {
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
      {@required bool useInclusiveTaxes, @required int precision}) {
    double total = calculateSubtotal(precision: precision);
    double taxAmount;
    final map = <String, double>{};

    lineItems.forEach((item) {
      final double taxRate1 = round(item.taxRate1, 3);
      final double taxRate2 = round(item.taxRate2, 3);

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

  double getItemTaxable(
      InvoiceItemEntity item, double invoiceTotal, int precision) {
    final double qty = round(item.quantity, 4);
    final double cost = round(item.cost, 4);
    final double itemDiscount = round(item.discount, precision);
    double lineTotal = qty * cost;

    if (discount != 0) {
      if (isAmountDiscount) {
        if (invoiceTotal != 0) {
          lineTotal -= round(lineTotal / invoiceTotal * discount, 4);
        }
      }
    }

    if (itemDiscount != 0) {
      if (isAmountDiscount) {
        lineTotal -= itemDiscount;
      } else {
        lineTotal -= round(lineTotal * itemDiscount / 100, 4);
      }
    }

    return round(lineTotal, precision);
  }

  double calculateTotal({@required int precision}) {
    double total = calculateSubtotal(precision: precision);
    double itemTax = 0.0;

    lineItems.forEach((item) {
      final double qty = round(item.quantity, 4);
      final double cost = round(item.cost, 4);
      final double itemDiscount = round(item.discount, precision);
      final double taxRate1 = round(item.taxRate1, 3);
      final double taxRate2 = round(item.taxRate2, 3);
      double lineTotal = qty * cost;

      if (itemDiscount != 0) {
        if (isAmountDiscount) {
          lineTotal -= itemDiscount;
        } else {
          lineTotal -= round(lineTotal * itemDiscount / 100, 4);
        }
      }

      if (discount != 0) {
        if (isAmountDiscount) {
          if (total != 0) {
            lineTotal -= round(lineTotal / total * discount, 4);
          }
        }
      }
      if (taxRate1 != 0) {
        itemTax += round(lineTotal * taxRate1 / 100, precision);
      }
      if (taxRate2 != 0) {
        itemTax += round(lineTotal * taxRate2 / 100, precision);
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

    if (!usesInclusiveTaxes) {
      final double taxAmount1 = round(total * taxRate1 / 100, precision);
      final double taxAmount2 = round(total * taxRate2 / 100, precision);

      total += itemTax + taxAmount1 + taxAmount2;
    }

    if (customSurcharge1 != 0.0 && !customTaxes1) {
      total += round(customSurcharge1, precision);
    }

    if (customSurcharge2 != 0.0 && !customTaxes2) {
      total += round(customSurcharge2, precision);
    }

    return total;
  }

  double calculateSubtotal({@required int precision}) {
    var total = 0.0;

    lineItems.forEach((item) {
      final double qty = round(item.quantity, 4);
      final double cost = round(item.cost, 4);
      final double discount = round(item.discount, precision);

      double lineTotal = qty * cost;

      if (discount != 0) {
        if (isAmountDiscount) {
          lineTotal -= discount;
        } else {
          lineTotal -= round(lineTotal * discount / 100, 4);
        }
      }

      total += round(lineTotal, precision);
    });

    return total;
  }
}
