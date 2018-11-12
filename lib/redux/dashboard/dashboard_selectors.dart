import 'package:charts_common/common.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';

class ChartDataGroup {
  ChartDataGroup(this.name);

  final String name;
  final List<ChartMoneyData> rawSeries = [];
  List<Series<dynamic, DateTime>> chartSeries;
  double total = 0.0;
  double previousTotal = 0.0;
}

class ChartMoneyData {
  ChartMoneyData(this.date, this.amount);

  final DateTime date;
  final double amount;
}

var memoizedChartInvoices = memo4((CompanyEntity company,
        DashboardUIState settings,
        BuiltMap<int, InvoiceEntity> invoiceMap,
        BuiltMap<int, ClientEntity> clientMap) =>
    chartInvoices(
        company: company,
        settings: settings,
        invoiceMap: invoiceMap,
        clientMap: clientMap));

List<ChartDataGroup> chartInvoices({
  CompanyEntity company,
  DashboardUIState settings,
  BuiltMap<int, InvoiceEntity> invoiceMap,
  BuiltMap<int, ClientEntity> clientMap,
}) {
  const STATUS_ACTIVE = 'active';
  const STATUS_OUTSTANDING = 'outstanding';

  final Map<String, Map<String, double>> totals = {
    STATUS_ACTIVE: {},
    STATUS_OUTSTANDING: {},
  };

  invoiceMap.forEach((int, invoice) {
    final client =
        clientMap[invoice.clientId] ?? ClientEntity(id: invoice.clientId);
    final currencyId =
        client.currencyId > 0 ? client.currencyId : company.currencyId;

    if (!invoice.isPublic ||
        invoice.isDeleted ||
        client.isDeleted ||
        invoice.isRecurring) {
      // skip it
    } else if (!invoice.isBetween(
        settings.startDate(company), settings.endDate(company))) {
      // skip it
    } else if (settings.currencyId > 0 && settings.currencyId != currencyId) {
      // skip it
    } else {
      if (totals[STATUS_ACTIVE][invoice.invoiceDate] == null) {
        totals[STATUS_ACTIVE][invoice.invoiceDate] = 0.0;
        totals[STATUS_OUTSTANDING][invoice.invoiceDate] = 0.0;
      }
      totals[STATUS_ACTIVE][invoice.invoiceDate] += invoice.amount;
      totals[STATUS_OUTSTANDING][invoice.invoiceDate] += invoice.balance;
    }
  });

  final ChartDataGroup activeData = ChartDataGroup(STATUS_ACTIVE);
  final ChartDataGroup outstandingData = ChartDataGroup(STATUS_OUTSTANDING);

  var date = DateTime.parse(settings.startDate(company));
  final endDate = DateTime.parse(settings.endDate(company));

  while (!date.isAfter(endDate)) {
    final key = convertDateTimeToSqlDate(date);
    if (totals[STATUS_ACTIVE].containsKey(key)) {
      activeData.rawSeries
          .add(ChartMoneyData(date, totals[STATUS_ACTIVE][key]));
      activeData.total += totals[STATUS_ACTIVE][key];
      outstandingData.rawSeries
          .add(ChartMoneyData(date, totals[STATUS_OUTSTANDING][key]));
      outstandingData.total += totals[STATUS_OUTSTANDING][key];
    } else {
      activeData.rawSeries.add(ChartMoneyData(date, 0.0));
      outstandingData.rawSeries.add(ChartMoneyData(date, 0.0));
    }
    date = date.add(Duration(days: 1));
  }

  final List<ChartDataGroup> data = [
    activeData,
    outstandingData,
  ];

  return data;
}

var memoizedChartQuotes = memo4((CompanyEntity company,
    DashboardUIState settings,
    BuiltMap<int, InvoiceEntity> quoteMap,
    BuiltMap<int, ClientEntity> clientMap) =>
    chartQuotes(
        company: company,
        settings: settings,
        quoteMap: quoteMap,
        clientMap: clientMap));

List<ChartDataGroup> chartQuotes({
  CompanyEntity company,
  DashboardUIState settings,
  BuiltMap<int, InvoiceEntity> quoteMap,
  BuiltMap<int, ClientEntity> clientMap,
}) {
  const STATUS_ACTIVE = 'active';
  const STATUS_APPROVED = 'approved';
  const STATUS_UNAPPROVED = 'unapproved';

  final Map<String, Map<String, double>> totals = {
    STATUS_ACTIVE: {},
    STATUS_APPROVED: {},
    STATUS_UNAPPROVED: {},
  };

  quoteMap.forEach((int, quote) {
    final client =
        clientMap[quote.clientId] ?? ClientEntity(id: quote.clientId);
    final currencyId =
    client.currencyId > 0 ? client.currencyId : company.currencyId;

    if (!quote.isPublic ||
        quote.isDeleted ||
        client.isDeleted ||
        quote.isRecurring) {
      // skip it
    } else if (!quote.isBetween(
        settings.startDate(company), settings.endDate(company))) {
      // skip it
    } else if (settings.currencyId > 0 && settings.currencyId != currencyId) {
      // skip it
    } else {
      if (totals[STATUS_ACTIVE][quote.invoiceDate] == null) {
        totals[STATUS_ACTIVE][quote.invoiceDate] = 0.0;
        totals[STATUS_APPROVED][quote.invoiceDate] = 0.0;
        totals[STATUS_UNAPPROVED][quote.invoiceDate] = 0.0;
      }
      totals[STATUS_ACTIVE][quote.invoiceDate] += quote.amount;
      if (quote.invoiceStatusId == kInvoiceStatusApproved) {
        totals[STATUS_APPROVED][quote.invoiceDate] += quote.amount;
      } else {
        totals[STATUS_UNAPPROVED][quote.invoiceDate] += quote.amount;
      }
    }
  });

  final ChartDataGroup activeData = ChartDataGroup(STATUS_ACTIVE);
  final ChartDataGroup approvedData = ChartDataGroup(STATUS_APPROVED);
  final ChartDataGroup unapprovedData = ChartDataGroup(STATUS_UNAPPROVED);

  var date = DateTime.parse(settings.startDate(company));
  final endDate = DateTime.parse(settings.endDate(company));

  while (!date.isAfter(endDate)) {
    final key = convertDateTimeToSqlDate(date);
    if (totals[STATUS_ACTIVE].containsKey(key)) {
      activeData.rawSeries
          .add(ChartMoneyData(date, totals[STATUS_ACTIVE][key]));
      activeData.total += totals[STATUS_ACTIVE][key];
      approvedData.rawSeries
          .add(ChartMoneyData(date, totals[STATUS_APPROVED][key]));
      approvedData.total += totals[STATUS_APPROVED][key];
      unapprovedData.rawSeries
          .add(ChartMoneyData(date, totals[STATUS_UNAPPROVED][key]));
      unapprovedData.total += totals[STATUS_UNAPPROVED][key];
    } else {
      activeData.rawSeries.add(ChartMoneyData(date, 0.0));
      approvedData.rawSeries.add(ChartMoneyData(date, 0.0));
    }
    date = date.add(Duration(days: 1));
  }

  final List<ChartDataGroup> data = [
    activeData,
    approvedData,
  ];

  return data;
}

var memoizedChartPayments = memo5((CompanyEntity company,
        DashboardUIState settings,
        BuiltMap<int, InvoiceEntity> invoiceMap,
        BuiltMap<int, ClientEntity> clientMap,
        BuiltMap<int, PaymentEntity> paymentMap) =>
    chartPayments(company, settings, invoiceMap, clientMap, paymentMap));

List<ChartDataGroup> chartPayments(
    CompanyEntity company,
    DashboardUIState settings,
    BuiltMap<int, InvoiceEntity> invoiceMap,
    BuiltMap<int, ClientEntity> clientMap,
    BuiltMap<int, PaymentEntity> paymentMap) {

  const STATUS_ACTIVE = 'active';
  const STATUS_REFUNDED = 'refunded';

  final Map<String, Map<String, double>> totals = {
    STATUS_ACTIVE: {},
    STATUS_REFUNDED: {},
  };

  paymentMap.forEach((int, payment) {
    final invoice =
        invoiceMap[payment.invoiceId] ?? InvoiceEntity(id: payment.invoiceId);
    final client =
        clientMap[invoice.clientId] ?? ClientEntity(id: invoice.clientId);
    final currencyId =
        client.currencyId > 0 ? client.currencyId : company.currencyId;

    if (payment.isDeleted || invoice.isDeleted || client.isDeleted) {
      // skip it
    } else if (!payment.isBetween(
        settings.startDate(company), settings.endDate(company))) {
      // skip it
    } else if (settings.currencyId > 0 && settings.currencyId != currencyId) {
      // skip it
    } else {
      if (totals[STATUS_ACTIVE][payment.paymentDate] == null) {
        totals[STATUS_ACTIVE][payment.paymentDate] = 0.0;
        totals[STATUS_REFUNDED][payment.paymentDate] = 0.0;
      }
      totals[STATUS_ACTIVE][payment.paymentDate] += payment.completedAmount;
      totals[STATUS_REFUNDED][payment.paymentDate] += payment.refunded;
    }
  });

  final ChartDataGroup activeData = ChartDataGroup(STATUS_ACTIVE);
  final ChartDataGroup outstandingData = ChartDataGroup(STATUS_REFUNDED);

  var date = DateTime.parse(settings.startDate(company));
  final endDate = DateTime.parse(settings.endDate(company));

  while (!date.isAfter(endDate)) {
    final key = convertDateTimeToSqlDate(date);
    if (totals[STATUS_ACTIVE].containsKey(key)) {
      activeData.rawSeries
          .add(ChartMoneyData(date, totals[STATUS_ACTIVE][key]));
      activeData.total += totals[STATUS_ACTIVE][key];
      outstandingData.rawSeries
          .add(ChartMoneyData(date, totals[STATUS_REFUNDED][key]));
      outstandingData.total += totals[STATUS_REFUNDED][key];
    } else {
      activeData.rawSeries.add(ChartMoneyData(date, 0.0));
      outstandingData.rawSeries.add(ChartMoneyData(date, 0.0));
    }
    date = date.add(Duration(days: 1));
  }

  final List<ChartDataGroup> data = [
    activeData,
    outstandingData,
  ];

  return data;
}
