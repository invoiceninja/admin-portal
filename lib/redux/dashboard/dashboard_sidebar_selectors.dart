import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:memoize/memoize.dart';

var memoizedUpcomingInvoices = memo1(
    (BuiltMap<String, InvoiceEntity> invoiceMap) =>
        _upcomingInvoices(invoiceMap: invoiceMap));

List<InvoiceEntity> _upcomingInvoices(
    {BuiltMap<String, InvoiceEntity> invoiceMap}) {
  final invoices = <InvoiceEntity>[];
  invoiceMap.forEach((index, invoice) {
    if (invoice.isUpcoming) {
      invoices.add(invoice);
    }
  });
  return invoices;
}

var memoizedPastDueInvoices = memo1(
        (BuiltMap<String, InvoiceEntity> invoiceMap) =>
            _pastDueInvoices(invoiceMap: invoiceMap));

List<InvoiceEntity> _pastDueInvoices(
    {BuiltMap<String, InvoiceEntity> invoiceMap}) {
  final invoices = <InvoiceEntity>[];
  invoiceMap.forEach((index, invoice) {
    if (invoice.isPastDue) {
      invoices.add(invoice);
    }
  });
  return invoices;
}
