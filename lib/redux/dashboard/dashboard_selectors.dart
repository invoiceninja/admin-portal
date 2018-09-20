import 'package:invoiceninja_flutter/redux/dashboard/dashboard_state.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';

class ChartMoneyData {
  final DateTime date;
  final double amount;

  ChartMoneyData(this.date, this.amount);
}

var memoizedChartOutstandingInvoices = memo2(
    (DashboardUIState settings, BuiltMap<int, InvoiceEntity> invoiceMap) =>
        chartOutstandingInvoices(settings, invoiceMap));

List<ChartMoneyData> chartOutstandingInvoices(
    DashboardUIState settings, BuiltMap<int, InvoiceEntity> invoiceMap) {
  final Map<String, double> totals = {};

  invoiceMap.forEach((int, invoice) {
    if (invoice.isDeleted || invoice.isQuote || invoice.isRecurring) {
      // skip it
    } else if (!invoice.isBetween(
        settings.calculatedStartDate, settings.calculatedEndDate)) {
      // skip it
    } else {
      if (totals[invoice.invoiceDate] == null) {
        totals[invoice.invoiceDate] = 0.0;
      }
      totals[invoice.invoiceDate] += invoice.amount;
    }
  });

  final List<ChartMoneyData> data = [];
  totals.forEach((date, total) {
    data.add(ChartMoneyData(DateTime.parse(date), total));
  });

  data.sort((data1, data2) => data1.date.compareTo(data2.date));

  return data;
}
