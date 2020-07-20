import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:memoize/memoize.dart';

var memoizedUpcomingInvoices = memo1(
    (BuiltMap<String, InvoiceEntity> invoiceMap) =>
        upcomingInvoices(invoiceMap: invoiceMap));

List<InvoiceEntity> upcomingInvoices(
    {BuiltMap<String, InvoiceEntity> invoiceMap}) {
  final invoices = <InvoiceEntity>[];
  invoiceMap.forEach((index, invoice) {
    if (invoice.isUpcoming) {
      invoices.add(invoice);
    }
  });
  return invoices;
}
