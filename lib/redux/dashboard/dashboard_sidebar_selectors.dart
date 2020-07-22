import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/data/models/payment_model.dart';
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

  invoices.sort(
      (invoiceA, invoiceB) => invoiceA.dueDate.compareTo(invoiceB.dueDate));

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

  invoices.sort(
      (invoiceA, invoiceB) => invoiceA.dueDate.compareTo(invoiceB.dueDate));

  return invoices;
}

var memoizedRecentPayments = memo1(
    (BuiltMap<String, PaymentEntity> paymentMap) =>
        _recentPayments(paymentMap: paymentMap));

List<PaymentEntity> _recentPayments(
    {BuiltMap<String, PaymentEntity> paymentMap}) {
  final payments = <PaymentEntity>[];
  final oneMonthAgo =
      DateTime.now().subtract(Duration(days: 30)).millisecondsSinceEpoch / 1000;
  paymentMap.forEach((index, payment) {
    if (payment.isActive && payment.createdAt > oneMonthAgo) {
      payments.add(payment);
    }
  });

  payments.sort(
      (paymentA, paymentB) => paymentA.createdAt.compareTo(paymentB.createdAt));

  return payments;
}

var memoizedUpcomingQuotes = memo1((BuiltMap<String, InvoiceEntity> quoteMap) =>
    _upcomingQuotes(quoteMap: quoteMap));

List<InvoiceEntity> _upcomingQuotes(
    {BuiltMap<String, InvoiceEntity> quoteMap}) {
  final quotes = <InvoiceEntity>[];
  quoteMap.forEach((index, quote) {
    if (quote.isUpcoming) {
      quotes.add(quote);
    }
  });

  quotes.sort((quoteA, quoteB) => quoteA.dueDate.compareTo(quoteB.dueDate));

  return quotes;
}

var memoizedExpiredQuotes = memo1((BuiltMap<String, InvoiceEntity> quoteMap) =>
    _expiredQuotes(quoteMap: quoteMap));

List<InvoiceEntity> _expiredQuotes({BuiltMap<String, InvoiceEntity> quoteMap}) {
  final quotes = <InvoiceEntity>[];
  quoteMap.forEach((index, quote) {
    if (quote.isPastDue) {
      quotes.add(quote);
    }
  });

  quotes.sort((quoteA, quoteB) => quoteA.dueDate.compareTo(quoteB.dueDate));

  return quotes;
}
