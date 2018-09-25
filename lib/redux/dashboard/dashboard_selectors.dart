import 'package:invoiceninja_flutter/redux/dashboard/dashboard_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';

class ChartMoneyData {
  final DateTime date;
  final double amount;

  ChartMoneyData(this.date, this.amount);
}

var memoizedChartOutstandingInvoices = memo4((CompanyEntity company,
        DashboardUIState settings,
        BuiltMap<int, InvoiceEntity> invoiceMap,
        BuiltMap<int, ClientEntity> clientMap) =>
    chartOutstandingInvoices(
        company: company,
        settings: settings,
        invoiceMap: invoiceMap,
        clientMap: clientMap));

List<ChartMoneyData> chartOutstandingInvoices({
  CompanyEntity company,
  DashboardUIState settings,
  BuiltMap<int, InvoiceEntity> invoiceMap,
  BuiltMap<int, ClientEntity> clientMap,
}) {
  final Map<String, double> totals = {};

  invoiceMap.forEach((int, invoice) {
    final client =
        clientMap[invoice.clientId] ?? ClientEntity(id: invoice.clientId);
    final currencyId =
        client.currencyId > 0 ? client.currencyId : company.currencyId;

    if (!invoice.isPublic ||
        invoice.isDeleted ||
        invoice.isQuote ||
        invoice.isRecurring) {
      // skip it
    } else if (!invoice.isBetween(
        settings.startDate(company), settings.endDate(company))) {
      // skip it
    } else if (settings.currencyId > 0 && settings.currencyId != currencyId) {
      // skip it
    } else {
      if (totals[invoice.invoiceDate] == null) {
        totals[invoice.invoiceDate] = 0.0;
      }
      totals[invoice.invoiceDate] += invoice.amount;
    }
  });

  final List<ChartMoneyData> data = [];

  var date = DateTime.parse(settings.startDate(company));
  final endDate = DateTime.parse(settings.endDate(company));
  while (!date.isAfter(endDate)) {
    final key = convertDateTimeToSqlDate(date);
    if (totals.containsKey(key)) {
      data.add(ChartMoneyData(date, totals[key]));
    } else {
      data.add(ChartMoneyData(date, 0.0));
    }
    date = date.add(Duration(days: 1));
  }

  return data;
}

var memoizedChartPayments = memo5((CompanyEntity company,
        DashboardUIState settings,
        BuiltMap<int, InvoiceEntity> invoiceMap,
        BuiltMap<int, ClientEntity> clientMap,
        BuiltMap<int, PaymentEntity> paymentMap) =>
    chartPayments(company, settings, invoiceMap, clientMap, paymentMap));

List<ChartMoneyData> chartPayments(
    CompanyEntity company,
    DashboardUIState settings,
    BuiltMap<int, InvoiceEntity> invoiceMap,
    BuiltMap<int, ClientEntity> clientMap,
    BuiltMap<int, PaymentEntity> paymentMap) {
  final Map<String, double> totals = {};

  paymentMap.forEach((int, payment) {
    final invoice =
        invoiceMap[payment.invoiceId] ?? InvoiceEntity(id: payment.invoiceId);
    final client =
        clientMap[invoice.clientId] ?? ClientEntity(id: invoice.clientId);
    final currencyId =
        client.currencyId > 0 ? client.currencyId : company.currencyId;

    if (payment.isDeleted) {
      // skip it
    } else if (!payment.isBetween(
        settings.startDate(company), settings.endDate(company))) {
      // skip it
    } else if (settings.currencyId > 0 && settings.currencyId != currencyId) {
      // skip it
    } else {
      if (totals[payment.paymentDate] == null) {
        totals[payment.paymentDate] = 0.0;
      }
      totals[payment.paymentDate] += payment.completedAmount;
    }
  });

  final List<ChartMoneyData> data = [];

  var date = DateTime.parse(settings.startDate(company));
  final endDate = DateTime.parse(settings.endDate(company));
  while (!date.isAfter(endDate)) {
    final key = convertDateTimeToSqlDate(date);
    if (totals.containsKey(key)) {
      data.add(ChartMoneyData(date, totals[key]));
    } else {
      data.add(ChartMoneyData(date, 0.0));
    }
    date = date.add(Duration(days: 1));
  }

  return data;
}

var memoizedChartOutstandingQuotes = memo4((CompanyEntity company,
    DashboardUIState settings,
    BuiltMap<int, InvoiceEntity> quoteMap,
    BuiltMap<int, ClientEntity> clientMap) =>
    chartOutstandingQuotes(
        company: company,
        settings: settings,
        quoteMap: quoteMap,
        clientMap: clientMap));

List<ChartMoneyData> chartOutstandingQuotes({
  CompanyEntity company,
  DashboardUIState settings,
  BuiltMap<int, InvoiceEntity> quoteMap,
  BuiltMap<int, ClientEntity> clientMap,
}) {
  final Map<String, double> totals = {};

  quoteMap.forEach((int, quote) {
    final client =
        clientMap[quote.clientId] ?? ClientEntity(id: quote.clientId);
    final currencyId =
    client.currencyId > 0 ? client.currencyId : company.currencyId;

    if (!quote.isPublic ||
        quote.isDeleted ||
        ! quote.isQuote ||
        quote.isRecurring) {
      // skip it
    } else if (!quote.isBetween(
        settings.startDate(company), settings.endDate(company))) {
      // skip it
    } else if (settings.currencyId > 0 && settings.currencyId != currencyId) {
      // skip it
    } else {
      if (totals[quote.invoiceDate] == null) {
        totals[quote.invoiceDate] = 0.0;
      }
      totals[quote.invoiceDate] += quote.amount;
    }
  });

  final List<ChartMoneyData> data = [];

  var date = DateTime.parse(settings.startDate(company));
  final endDate = DateTime.parse(settings.endDate(company));
  while (!date.isAfter(endDate)) {
    final key = convertDateTimeToSqlDate(date);
    if (totals.containsKey(key)) {
      data.add(ChartMoneyData(date, totals[key]));
    } else {
      data.add(ChartMoneyData(date, 0.0));
    }
    date = date.add(Duration(days: 1));
  }

  return data;
}
