import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/data/models/payment_model.dart';
import 'package:memoize/memoize.dart';

var memoizedUpcomingInvoices = memo2((
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
) =>
    _upcomingInvoices(
      invoiceMap: invoiceMap,
      clientMap: clientMap,
    ));

List<InvoiceEntity> _upcomingInvoices({
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
}) {
  final invoices = <InvoiceEntity>[];
  invoiceMap.forEach((index, invoice) {
    final client =
        clientMap[invoice.clientId] ?? ClientEntity(id: invoice.clientId);
    if (invoice.isDeleted || client.isDeleted) {
      // do noting
    } else if (invoice.isUpcoming) {
      invoices.add(invoice);
    }
  });

  invoices.sort(
      (invoiceA, invoiceB) => invoiceA.dueDate.compareTo(invoiceB.dueDate));

  return invoices;
}

var memoizedPastDueInvoices = memo2((
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
) =>
    _pastDueInvoices(
      invoiceMap: invoiceMap,
      clientMap: clientMap,
    ));

List<InvoiceEntity> _pastDueInvoices({
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
}) {
  final invoices = <InvoiceEntity>[];
  invoiceMap.forEach((index, invoice) {
    final client =
        clientMap[invoice.clientId] ?? ClientEntity(id: invoice.clientId);
    if (invoice.isDeleted || client.isDeleted) {
      // do noting
    } else if (invoice.isPastDue) {
      invoices.add(invoice);
    }
  });

  invoices.sort(
      (invoiceA, invoiceB) => invoiceA.dueDate.compareTo(invoiceB.dueDate));

  return invoices;
}

var memoizedRecentPayments = memo2((
  BuiltMap<String, PaymentEntity> paymentMap,
  BuiltMap<String, ClientEntity> clientMap,
) =>
    _recentPayments(
      paymentMap: paymentMap,
      clientMap: clientMap,
    ));

List<PaymentEntity> _recentPayments({
  BuiltMap<String, PaymentEntity> paymentMap,
  BuiltMap<String, ClientEntity> clientMap,
}) {
  final payments = <PaymentEntity>[];
  final oneMonthAgo =
      DateTime.now().subtract(Duration(days: 30)).millisecondsSinceEpoch / 1000;
  paymentMap.forEach((index, payment) {
    final client =
        clientMap[payment.clientId] ?? ClientEntity(id: payment.clientId);
    if (payment.isDeleted || client.isDeleted) {
      // do noting
    } else if (payment.isActive && payment.createdAt > oneMonthAgo) {
      payments.add(payment);
    }
  });

  payments.sort(
      (paymentA, paymentB) => paymentA.createdAt.compareTo(paymentB.createdAt));

  return payments;
}

var memoizedUpcomingQuotes = memo2((
  BuiltMap<String, InvoiceEntity> quoteMap,
  BuiltMap<String, ClientEntity> clientMap,
) =>
    _upcomingQuotes(
      quoteMap: quoteMap,
      clientMap: clientMap,
    ));

List<InvoiceEntity> _upcomingQuotes({
  BuiltMap<String, InvoiceEntity> quoteMap,
  BuiltMap<String, ClientEntity> clientMap,
}) {
  final quotes = <InvoiceEntity>[];
  quoteMap.forEach((index, quote) {
    final client =
        clientMap[quote.clientId] ?? ClientEntity(id: quote.clientId);
    if (quote.isDeleted || client.isDeleted) {
      // do noting
    } else if (quote.isUpcoming) {
      quotes.add(quote);
    }
  });

  quotes.sort((quoteA, quoteB) => quoteA.dueDate.compareTo(quoteB.dueDate));

  return quotes;
}

var memoizedExpiredQuotes = memo2((
  BuiltMap<String, InvoiceEntity> quoteMap,
  BuiltMap<String, ClientEntity> clientMap,
) =>
    _expiredQuotes(
      quoteMap: quoteMap,
      clientMap: clientMap,
    ));

List<InvoiceEntity> _expiredQuotes({
  BuiltMap<String, InvoiceEntity> quoteMap,
  BuiltMap<String, ClientEntity> clientMap,
}) {
  final quotes = <InvoiceEntity>[];
  quoteMap.forEach((index, quote) {
    final client =
        clientMap[quote.clientId] ?? ClientEntity(id: quote.clientId);
    if (quote.isDeleted || client.isDeleted) {
      // do noting
    } else if (quote.isPastDue) {
      quotes.add(quote);
    }
  });

  quotes.sort((quoteA, quoteB) => quoteA.dueDate.compareTo(quoteB.dueDate));

  return quotes;
}
