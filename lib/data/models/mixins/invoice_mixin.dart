import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

abstract class CalculateInvoiceTotal {
  bool get isAmountDiscount;
  String get taxName1;
  String get taxName2;
  double get taxRate1;
  double get taxRate2;
  double get discount;
  double get customValue1;
  double get customValue2;
  bool get customTaxes1;
  bool get customTaxes2;
  BuiltList<InvoiceItemEntity> get invoiceItems;

  double _calculateTaxAmount(double amount, double rate, bool useInclusiveTaxes) {
    double taxAmount;
    if (useInclusiveTaxes) {
      taxAmount = amount - (amount / (1 + (rate / 100)));
    } else {
      taxAmount = amount * rate / 100;
    }
    return round(taxAmount, 2);
  }

  Map<String, double> calculateTaxes(bool useInclusiveTaxes) {
    double total = baseTotal;
    double taxAmount;
    final map = <String, double>{};

    invoiceItems.forEach((item) {
      final double qty = round(item.qty, 4);
      final double cost = round(item.cost, 4);
      final double itemDiscount = round(item.discount, 2);
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
        taxAmount = _calculateTaxAmount(lineTotal, taxRate1, useInclusiveTaxes);
        map.update(item.taxName1, (value) => value + taxAmount, ifAbsent: () => taxAmount);
      }
      if (taxRate2 != 0) {
        taxAmount = _calculateTaxAmount(lineTotal, taxRate2, useInclusiveTaxes);
        map.update(item.taxName2, (value) => value + taxAmount, ifAbsent: () => taxAmount);
      }
    });

    if (discount != 0.0) {
      if (isAmountDiscount) {
        total -= round(discount, 2);
      } else {
        total -= round(total * discount / 100, 2);
      }
    }

    if (customValue1 != 0.0 && customTaxes1) {
      total += round(customValue1, 2);
    }

    if (customValue2 != 0.0 && customTaxes2) {
      total += round(customValue2, 2);
    }


    if (taxRate1 != 0) {
      taxAmount = _calculateTaxAmount(total, taxRate1, useInclusiveTaxes);
      map.update(taxName1, (value) => value + taxAmount, ifAbsent: () => taxAmount);
    }

    if (taxRate2 != 0) {
      taxAmount = _calculateTaxAmount(total, taxRate2, useInclusiveTaxes);
      map.update(taxName2, (value) => value + taxAmount, ifAbsent: () => taxAmount);
    }

    return map;
  }

  double calculateTotal(bool useInclusiveTaxes) {
    double total = baseTotal;
    double itemTax = 0.0;

    invoiceItems.forEach((item) {
      final double qty = round(item.qty, 4);
      final double cost = round(item.cost, 4);
      final double itemDiscount = round(item.discount, 2);
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
        itemTax += round(lineTotal * taxRate1 / 100, 2);
      }
      if (taxRate2 != 0) {
        itemTax += round(lineTotal * taxRate2 / 100, 2);
      }
    });

    if (discount != 0.0) {
      if (isAmountDiscount) {
        total -= round(discount, 2);
      } else {
        total -= round(total * discount / 100, 2);
      }
    }

    if (customValue1 != 0.0 && customTaxes1) {
      total += round(customValue1, 2);
    }

    if (customValue2 != 0.0 && customTaxes2) {
      total += round(customValue2, 2);
    }

    if (! useInclusiveTaxes) {
      final double taxAmount1 = round(total * taxRate1 / 100, 2);
      final double taxAmount2 = round(total * taxRate2 / 100, 2);

      total += itemTax + taxAmount1 + taxAmount2;
    }

    if (customValue1 != 0.0 && ! customTaxes1) {
      total += round(customValue1, 2);
    }

    if (customValue2 != 0.0 && ! customTaxes2) {
      total += round(customValue2, 2);
    }

    return total;
  }

  double get baseTotal {
    var total = 0.0;

    invoiceItems.forEach((item) {
      final double qty = round(item.qty, 4);
      final double cost = round(item.cost, 4);
      final double discount = round(item.discount, 2);

      double lineTotal = qty * cost;

      if (discount != 0) {
        if (isAmountDiscount) {
          lineTotal -= discount;
        } else {
          lineTotal -= round(lineTotal * discount / 100, 4);
        }
      }

      total += round(lineTotal, 2);
    });

    return total;
  }
}

