import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';

class ChartMoneyData {
  final DateTime date;
  final double amount;
  ChartMoneyData(this.date, this.amount);
}


var memoizedChartOutstandingInvoices = memo1(
    (BuiltMap<int, InvoiceEntity> invoiceMap) =>
        chartOutstandingInvoices(invoiceMap));

List<ChartMoneyData> chartOutstandingInvoices(
    BuiltMap<int, InvoiceEntity> invoiceMap) {
  final Map<String, double> totals = {};
  invoiceMap.forEach((int, invoice) {
    if (invoice.isDeleted || invoice.isQuote || invoice.isRecurring) {
      // do nothing
    } else {
      if (totals[invoice.invoiceDate] == null) {
        totals[invoice.invoiceDate] = 0.0;
      }
      totals[invoice.invoiceDate] += invoice.amount;
      //print('${invoice.invoiceDate}: ${invoice.amount}');
    }
  });

  final List<ChartMoneyData> data = [];
  totals.forEach((date, total) {
    data.add(ChartMoneyData(DateTime.parse(date), total));
  });

  data.sort((data1, data2) => data1.date.compareTo(data2.date));

  return data;
}
