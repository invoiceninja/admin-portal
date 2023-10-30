// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:charts_common/common.dart';
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_state.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/money.dart';

class ChartDataGroup {
  ChartDataGroup(this.name);

  final String name;
  final List<ChartMoneyData> rawSeries = [];
  Map<String, List<String>> entityMap = {};
  late List<Series<dynamic, DateTime>> chartSeries;
  double periodTotal = 0.0;
  double previousTotal = 0.0;
  double total = 0.0;
  double average = 0.0;
}

class ChartMoneyData {
  ChartMoneyData(this.date, this.amount);

  final DateTime date;
  final double? amount;
}

var memoizedChartInvoices = memo5((
  BuiltMap<String, CurrencyEntity> currencyMap,
  CompanyEntity? company,
  DashboardUISettings settings,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
) =>
    _chartInvoices(
        currencyMap: currencyMap,
        company: company!,
        settings: settings,
        invoiceMap: invoiceMap,
        clientMap: clientMap));

var memoizedChartOverviewInvoices = memo5((
  BuiltMap<String, CurrencyEntity> currencyMap,
  CompanyEntity? company,
  DashboardUISettings settings,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
) =>
    _chartInvoices(
        currencyMap: currencyMap,
        company: company!,
        settings: settings,
        invoiceMap: invoiceMap,
        clientMap: clientMap));

var memoizedPreviousChartInvoices = memo5((
  BuiltMap<String, CurrencyEntity> currencyMap,
  CompanyEntity? company,
  DashboardUISettings settings,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
) =>
    _chartInvoices(
        currencyMap: currencyMap,
        company: company!,
        settings: settings,
        invoiceMap: invoiceMap,
        clientMap: clientMap));

List<ChartDataGroup> _chartInvoices({
  BuiltMap<String, CurrencyEntity>? currencyMap,
  required CompanyEntity company,
  required DashboardUISettings settings,
  required BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity>? clientMap,
}) {
  const STATUS_ACTIVE = 'active';
  const STATUS_OUTSTANDING = 'outstanding';

  final ChartDataGroup activeData = ChartDataGroup(STATUS_ACTIVE);
  final ChartDataGroup outstandingData = ChartDataGroup(STATUS_OUTSTANDING);

  final Map<String, int> counts = {
    STATUS_ACTIVE: 0,
    STATUS_OUTSTANDING: 0,
  };

  final Map<String, Map<String, double>> totals = {
    STATUS_ACTIVE: {},
    STATUS_OUTSTANDING: {},
  };

  invoiceMap.forEach((int, invoice) {
    final client =
        clientMap![invoice.clientId] ?? ClientEntity(id: invoice.clientId);

    // Fix for mock data
    var date = invoice.date.split('T')[0];
    if (date.isNotEmpty) {
      if (settings.groupBy == kReportGroupYear) {
        date = date.substring(0, 4) + '-01-01';
      } else if (settings.groupBy == kReportGroupMonth) {
        date = date.substring(0, 7) + '-01';
      }
    }

    if (!invoice.isSent ||
        invoice.isDeleted! ||
        invoice.isCancelledOrReversed ||
        client.isDeleted! ||
        date.isEmpty) {
      // skip it
    } else if (!settings.matchesCurrency(client.currencyId)) {
      // skip it
    } else {
      double amount =
          settings.includeTaxes ? invoice.amount : invoice.netAmount;
      double balance =
          settings.includeTaxes ? invoice.balance : invoice.netBalance;

      // Handle "All"
      if (settings.currencyId == kCurrencyAll &&
          client.currencyId != company.currencyId) {
        final exchangeRate = invoice.hasExchangeRate
            ? 1 / invoice.exchangeRate
            : getExchangeRate(currencyMap,
                fromCurrencyId: client.currencyId,
                toCurrencyId: company.currencyId);
        amount *= exchangeRate;
        balance *= exchangeRate;
      }

      activeData.total += amount;
      outstandingData.total += balance;

      if (invoice.isBetween(
          settings.startDate(company)!, settings.endDate(company))) {
        if (totals[STATUS_ACTIVE]![date] == null) {
          totals[STATUS_ACTIVE]![date] = 0.0;
          totals[STATUS_OUTSTANDING]![date] = 0.0;

          activeData.entityMap[date] = [];
          outstandingData.entityMap[date] = [];
        }

        totals[STATUS_ACTIVE]![date] = totals[STATUS_ACTIVE]![date]! + amount;
        totals[STATUS_OUTSTANDING]![date] =
            totals[STATUS_OUTSTANDING]![date]! + balance;

        activeData.periodTotal += amount;
        outstandingData.periodTotal += balance;

        counts[STATUS_ACTIVE] = counts[STATUS_ACTIVE]! + 1;
        activeData.entityMap[date]!.add(invoice.id);

        if (invoice.balance > 0) {
          counts[STATUS_OUTSTANDING] = counts[STATUS_OUTSTANDING]! + 1;
          outstandingData.entityMap[date]!.add(invoice.id);
        }
      }
    }
  });

  var date = convertSqlDateToDateTime(settings.startDate(company));
  final endDate = convertSqlDateToDateTime(settings.endDate(company));

  while (!date.isAfter(endDate)) {
    final key = convertDateTimeToSqlDate(date);
    if (totals[STATUS_ACTIVE]!.containsKey(key)) {
      activeData.rawSeries
          .add(ChartMoneyData(date, totals[STATUS_ACTIVE]![key]));
      outstandingData.rawSeries
          .add(ChartMoneyData(date, totals[STATUS_OUTSTANDING]![key]));
    } else {
      activeData.rawSeries.add(ChartMoneyData(date, 0.0));
      outstandingData.rawSeries.add(ChartMoneyData(date, 0.0));
    }

    if (settings.groupBy == kReportGroupDay) {
      date = date.add(Duration(days: 1));
    } else if (settings.groupBy == kReportGroupMonth) {
      date = DateTime(date.year, date.month + 1);
    } else if (settings.groupBy == kReportGroupYear) {
      date = DateTime(date.year + 1);
    }
  }

  activeData.average = (counts[STATUS_ACTIVE] ?? 0) > 0
      ? round(activeData.periodTotal / counts[STATUS_ACTIVE]!, 2)
      : 0;
  outstandingData.average = (counts[STATUS_OUTSTANDING] ?? 0) > 0
      ? round(outstandingData.periodTotal / counts[STATUS_OUTSTANDING]!, 2)
      : 0;

  final List<ChartDataGroup> data = [
    activeData,
    outstandingData,
  ];

  return data;
}

var memoizedChartQuotes = memo6((
  BuiltMap<String, CurrencyEntity> currencyMap,
  CompanyEntity? company,
  DashboardUISettings settings,
  BuiltMap<String, InvoiceEntity> quoteMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
) =>
    chartQuotes(
      currencyMap: currencyMap,
      company: company!,
      settings: settings,
      quoteMap: quoteMap,
      clientMap: clientMap,
      invoiceMap: invoiceMap,
    ));

var memoizedPreviousChartQuotes = memo6((
  BuiltMap<String, CurrencyEntity> currencyMap,
  CompanyEntity? company,
  DashboardUISettings settings,
  BuiltMap<String, InvoiceEntity> quoteMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
) =>
    chartQuotes(
      currencyMap: currencyMap,
      company: company!,
      settings: settings,
      quoteMap: quoteMap,
      clientMap: clientMap,
      invoiceMap: invoiceMap,
    ));

List<ChartDataGroup> chartQuotes({
  BuiltMap<String, CurrencyEntity>? currencyMap,
  required CompanyEntity company,
  required DashboardUISettings settings,
  required BuiltMap<String, InvoiceEntity> quoteMap,
  required BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity>? clientMap,
}) {
  const STATUS_ACTIVE = 'active';
  const STATUS_APPROVED = 'approved';
  const STATUS_UNAPPROVED = 'unapproved';
  const STATUS_INVOICED = 'invoiced';
  const STATUS_PAID = 'invoice_paid';

  final Map<String, int> counts = {
    STATUS_ACTIVE: 0,
    STATUS_APPROVED: 0,
    STATUS_UNAPPROVED: 0,
    STATUS_INVOICED: 0,
    STATUS_PAID: 0,
  };

  final Map<String, Map<String, double>> totals = {
    STATUS_ACTIVE: {},
    STATUS_APPROVED: {},
    STATUS_UNAPPROVED: {},
    STATUS_INVOICED: {},
    STATUS_PAID: {},
  };

  final ChartDataGroup activeData = ChartDataGroup(STATUS_ACTIVE);
  final ChartDataGroup approvedData = ChartDataGroup(STATUS_APPROVED);
  final ChartDataGroup unapprovedData = ChartDataGroup(STATUS_UNAPPROVED);
  final ChartDataGroup invoicedData = ChartDataGroup(STATUS_INVOICED);
  final ChartDataGroup paidData = ChartDataGroup(STATUS_PAID);

  quoteMap.forEach((int, quote) {
    final client =
        clientMap![quote.clientId] ?? ClientEntity(id: quote.clientId);
    var date = quote.date;
    if (date.isNotEmpty) {
      if (settings.groupBy == kReportGroupYear) {
        date = date.substring(0, 4) + '-01-01';
      } else if (settings.groupBy == kReportGroupMonth) {
        date = date.substring(0, 7) + '-01';
      }
    }

    if (!quote.isSent ||
        quote.isDeleted! ||
        client.isDeleted! ||
        date.isEmpty) {
      // skip it
    } else if (!settings.matchesCurrency(client.currencyId)) {
      // skip it
    } else {
      double amount = settings.includeTaxes ? quote.amount : quote.netAmount;

      // Handle "All"
      if (settings.currencyId == kCurrencyAll &&
          client.currencyId != company.currencyId) {
        final exchangeRate = quote.hasExchangeRate
            ? 1 / quote.exchangeRate
            : getExchangeRate(currencyMap,
                fromCurrencyId: client.currencyId,
                toCurrencyId: company.currencyId);
        amount *= exchangeRate;
      }

      activeData.total += amount;
      if (quote.isApproved) {
        approvedData.total += amount;
      } else {
        unapprovedData.total += amount;
      }

      if (quote.isBetween(
          settings.startDate(company)!, settings.endDate(company))) {
        if (totals[STATUS_ACTIVE]![date] == null) {
          totals[STATUS_ACTIVE]![date] = 0.0;
          totals[STATUS_APPROVED]![date] = 0.0;
          totals[STATUS_UNAPPROVED]![date] = 0.0;
          totals[STATUS_INVOICED]![date] = 0.0;
          totals[STATUS_PAID]![date] = 0.0;

          activeData.entityMap[date] = [];
          approvedData.entityMap[date] = [];
          unapprovedData.entityMap[date] = [];
          invoicedData.entityMap[date] = [];
          paidData.entityMap[date] = [];
        }

        totals[STATUS_ACTIVE]![date] = totals[STATUS_ACTIVE]![date]! + amount;
        counts[STATUS_ACTIVE] = counts[STATUS_ACTIVE]! + 1;
        activeData.entityMap[date]!.add(quote.id);

        if (quote.isApproved) {
          totals[STATUS_APPROVED]![date] =
              totals[STATUS_APPROVED]![date]! + amount;
          counts[STATUS_APPROVED] = counts[STATUS_APPROVED]! + 1;
          approvedData.entityMap[date]!.add(quote.id);
          approvedData.periodTotal += amount;
        } else {
          totals[STATUS_UNAPPROVED]![date] =
              totals[STATUS_UNAPPROVED]![date]! + amount;
          counts[STATUS_UNAPPROVED] = counts[STATUS_UNAPPROVED]! + 1;
          unapprovedData.entityMap[date]!.add(quote.id);
          unapprovedData.periodTotal += amount;
        }

        if (quote.isInvoiced) {
          final invoice = invoiceMap[quote.invoiceId];
          if (invoice != null && invoice.isPaid) {
            totals[STATUS_PAID]![date] = totals[STATUS_PAID]![date]! + amount;
            counts[STATUS_PAID] = counts[STATUS_PAID]! + 1;
            paidData.entityMap[date]!.add(quote.id);
            paidData.periodTotal += amount;
          } else {
            totals[STATUS_INVOICED]![date] =
                totals[STATUS_INVOICED]![date]! + amount;
            counts[STATUS_INVOICED] = counts[STATUS_INVOICED]! + 1;
            invoicedData.entityMap[date]!.add(quote.id);
            invoicedData.periodTotal += amount;
          }
        }
      }
    }
  });

  var date = convertSqlDateToDateTime(settings.startDate(company));
  final endDate = convertSqlDateToDateTime(settings.endDate(company));

  while (!date.isAfter(endDate)) {
    final key = convertDateTimeToSqlDate(date);
    if (totals[STATUS_ACTIVE]!.containsKey(key)) {
      activeData.rawSeries
          .add(ChartMoneyData(date, totals[STATUS_ACTIVE]![key]));
      approvedData.rawSeries
          .add(ChartMoneyData(date, totals[STATUS_APPROVED]![key]));
      unapprovedData.rawSeries
          .add(ChartMoneyData(date, totals[STATUS_UNAPPROVED]![key]));
      invoicedData.rawSeries
          .add(ChartMoneyData(date, totals[STATUS_INVOICED]![key]));
      paidData.rawSeries.add(ChartMoneyData(date, totals[STATUS_PAID]![key]));
    } else {
      activeData.rawSeries.add(ChartMoneyData(date, 0.0));
      approvedData.rawSeries.add(ChartMoneyData(date, 0.0));
      unapprovedData.rawSeries.add(ChartMoneyData(date, 0.0));
      invoicedData.rawSeries.add(ChartMoneyData(date, 0.0));
      paidData.rawSeries.add(ChartMoneyData(date, 0.0));
    }

    if (settings.groupBy == kReportGroupDay) {
      date = date.add(Duration(days: 1));
    } else if (settings.groupBy == kReportGroupMonth) {
      date = DateTime(date.year, date.month + 1);
    } else if (settings.groupBy == kReportGroupYear) {
      date = DateTime(date.year + 1);
    }
  }

  activeData.average = (counts[STATUS_ACTIVE] ?? 0) > 0
      ? round(activeData.periodTotal / counts[STATUS_ACTIVE]!, 2)
      : 0;
  approvedData.average = (counts[STATUS_APPROVED] ?? 0) > 0
      ? round(approvedData.periodTotal / counts[STATUS_APPROVED]!, 2)
      : 0;
  unapprovedData.average = (counts[STATUS_UNAPPROVED] ?? 0) > 0
      ? round(unapprovedData.periodTotal / counts[STATUS_UNAPPROVED]!, 2)
      : 0;
  invoicedData.average = (counts[STATUS_INVOICED] ?? 0) > 0
      ? round(invoicedData.periodTotal / counts[STATUS_INVOICED]!, 2)
      : 0;
  paidData.average = (counts[STATUS_PAID] ?? 0) > 0
      ? round(paidData.periodTotal / counts[STATUS_PAID]!, 2)
      : 0;

  final List<ChartDataGroup> data = [
    activeData,
    approvedData,
    unapprovedData,
    invoicedData,
    paidData,
  ];

  return data;
}

var memoizedChartPayments = memo6((
  BuiltMap<String, CurrencyEntity> currencyMap,
  CompanyEntity? company,
  DashboardUISettings settings,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, PaymentEntity> paymentMap,
) =>
    chartPayments(
      currencyMap,
      company!,
      settings,
      invoiceMap,
      clientMap,
      paymentMap,
    ));

var memoizedPreviousChartPayments = memo6((
  BuiltMap<String, CurrencyEntity> currencyMap,
  CompanyEntity? company,
  DashboardUISettings settings,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, PaymentEntity> paymentMap,
) =>
    chartPayments(
      currencyMap,
      company!,
      settings,
      invoiceMap,
      clientMap,
      paymentMap,
    ));

List<ChartDataGroup> chartPayments(
  BuiltMap<String, CurrencyEntity> currencyMap,
  CompanyEntity company,
  DashboardUISettings settings,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, PaymentEntity> paymentMap,
) {
  const STATUS_COMPLETED = 'completed';
  const STATUS_REFUNDED = 'refunded';

  final Map<String, int> counts = {
    STATUS_COMPLETED: 0,
    STATUS_REFUNDED: 0,
  };

  final Map<String, Map<String, double>> totals = {
    STATUS_COMPLETED: {},
    STATUS_REFUNDED: {},
  };

  final ChartDataGroup activeData = ChartDataGroup(STATUS_COMPLETED);
  final ChartDataGroup refundedData = ChartDataGroup(STATUS_REFUNDED);

  paymentMap.forEach((int, payment) {
    final client =
        clientMap[payment.clientId] ?? ClientEntity(id: payment.clientId);
    var date = payment.date;
    if (date.isNotEmpty) {
      if (settings.groupBy == kReportGroupYear) {
        date = date.substring(0, 4) + '-01-01';
      } else if (settings.groupBy == kReportGroupMonth) {
        date = date.substring(0, 7) + '-01';
      }
    }

    if (payment.isDeleted! ||
        !payment.isCompletedOrPartiallyRefunded ||
        client.isDeleted! ||
        date.isEmpty) {
      // skip it
    } else if (!settings.matchesCurrency(client.currencyId)) {
      // skip it
    } else {
      double completedAmount = payment.completedAmount;
      double refunded = payment.refunded;

      var invoice = InvoiceEntity();
      if (payment.invoicePaymentables.isNotEmpty) {
        final paymentable = payment.invoicePaymentables.first;
        invoice = invoiceMap[paymentable.invoiceId] ?? InvoiceEntity();
      }

      // Handle "All"
      if (settings.currencyId == kCurrencyAll &&
          client.currencyId != company.currencyId) {
        final exchangeRate = payment.hasExchangeRate
            ? payment.exchangeRate
            : invoice.hasExchangeRate
                ? invoice.exchangeRate
                : getExchangeRate(currencyMap,
                    fromCurrencyId: client.currencyId,
                    toCurrencyId: company.currencyId);
        completedAmount *= exchangeRate;
        refunded *= exchangeRate;
      }

      activeData.total += completedAmount;
      if ((payment.refunded) > 0) {
        refundedData.total += refunded;
      }

      if (payment.isBetween(
          settings.startDate(company)!, settings.endDate(company))) {
        if (totals[STATUS_COMPLETED]![date] == null) {
          totals[STATUS_COMPLETED]![date] = 0.0;
          totals[STATUS_REFUNDED]![date] = 0.0;

          activeData.entityMap[date] = [];
          refundedData.entityMap[date] = [];
        }

        totals[STATUS_COMPLETED]![date] =
            totals[STATUS_COMPLETED]![date]! + completedAmount;
        totals[STATUS_REFUNDED]![date] =
            totals[STATUS_REFUNDED]![date]! + refunded;

        counts[STATUS_COMPLETED] = counts[STATUS_COMPLETED]! + 1;
        activeData.entityMap[date]!.add(payment.id);
        activeData.periodTotal += completedAmount;

        if ((payment.refunded) > 0) {
          counts[STATUS_REFUNDED] = counts[STATUS_REFUNDED]! + 1;
          refundedData.entityMap[date]!.add(payment.id);
          refundedData.periodTotal += refunded;
        }
      }
    }
  });

  var date = convertSqlDateToDateTime(settings.startDate(company));
  final endDate = convertSqlDateToDateTime(settings.endDate(company));

  while (!date.isAfter(endDate)) {
    final key = convertDateTimeToSqlDate(date);
    if (totals[STATUS_COMPLETED]!.containsKey(key)) {
      activeData.rawSeries
          .add(ChartMoneyData(date, totals[STATUS_COMPLETED]![key]));
      refundedData.rawSeries
          .add(ChartMoneyData(date, totals[STATUS_REFUNDED]![key]));
    } else {
      activeData.rawSeries.add(ChartMoneyData(date, 0.0));
      refundedData.rawSeries.add(ChartMoneyData(date, 0.0));
    }

    if (settings.groupBy == kReportGroupDay) {
      date = date.add(Duration(days: 1));
    } else if (settings.groupBy == kReportGroupMonth) {
      date = DateTime(date.year, date.month + 1);
    } else if (settings.groupBy == kReportGroupYear) {
      date = DateTime(date.year + 1);
    }
  }

  activeData.average = (counts[STATUS_COMPLETED] ?? 0) > 0
      ? round(activeData.periodTotal / counts[STATUS_COMPLETED]!, 2)
      : 0;
  refundedData.average = (counts[STATUS_REFUNDED] ?? 0) > 0
      ? round(refundedData.periodTotal / counts[STATUS_REFUNDED]!, 2)
      : 0;

  final List<ChartDataGroup> data = [
    activeData,
    refundedData,
  ];

  return data;
}

var memoizedChartTasks = memo8((
  BuiltMap<String, CurrencyEntity> currencyMap,
  CompanyEntity? company,
  DashboardUISettings settings,
  BuiltMap<String, TaskEntity> taskMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ProjectEntity> projectMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, GroupEntity> groupMap,
) =>
    chartTasks(
      currencyMap,
      company!,
      settings,
      taskMap,
      invoiceMap,
      projectMap,
      clientMap,
      groupMap,
    ));

var memoizedPreviousChartTasks = memo8((
  BuiltMap<String, CurrencyEntity> currencyMap,
  CompanyEntity? company,
  DashboardUISettings settings,
  BuiltMap<String, TaskEntity> taskMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ProjectEntity> projectMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, GroupEntity> groupMap,
) =>
    chartTasks(
      currencyMap,
      company!,
      settings,
      taskMap,
      invoiceMap,
      projectMap,
      clientMap,
      groupMap,
    ));

List<ChartDataGroup> chartTasks(
  BuiltMap<String, CurrencyEntity> currencyMap,
  CompanyEntity company,
  DashboardUISettings settings,
  BuiltMap<String, TaskEntity> taskMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ProjectEntity> projectMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, GroupEntity> groupMap,
) {
  const STATUS_LOGGED = 'logged';
  const STATUS_INVOICED = 'invoiced';
  const STATUS_PAID = 'invoice_paid';

  final Map<String, int> counts = {
    STATUS_LOGGED: 0,
    STATUS_INVOICED: 0,
    STATUS_PAID: 0,
  };

  final Map<String, Map<String, double>> totals = {
    STATUS_LOGGED: {},
    STATUS_INVOICED: {},
    STATUS_PAID: {},
  };

  final ChartDataGroup loggedData = ChartDataGroup(STATUS_LOGGED);
  final ChartDataGroup invoicedData = ChartDataGroup(STATUS_INVOICED);
  final ChartDataGroup paidData = ChartDataGroup(STATUS_PAID);

  taskMap.forEach((int, task) {
    final client = clientMap[task.clientId] ?? ClientEntity(id: task.clientId);
    final invoice =
        invoiceMap[task.invoiceId] ?? InvoiceEntity(id: task.clientId);
    final project =
        projectMap[task.projectId] ?? ProjectEntity(id: task.projectId);
    final group = groupMap[client.groupId] ?? GroupEntity(id: client.groupId);

    if (task.isDeleted! || client.isDeleted! || project.isDeleted!) {
      // skip it
    } else if (!settings.matchesCurrency(client.currencyId)) {
      // skip it
    } else {
      task.getTaskTimes().forEach((taskTime) {
        taskTime.getParts().forEach((date, duration) {
          if (settings.groupBy == kReportGroupYear) {
            date = date.substring(0, 4) + '-01-01';
          } else if (settings.groupBy == kReportGroupMonth) {
            date = date.substring(0, 7) + '-01';
          }

          final taskRate = taskRateSelector(
            company: company,
            project: project,
            client: client,
            task: task,
            group: group,
          )!;
          double amount = taskRate * round(duration.inSeconds / 3600, 3);

          // Handle "All"
          if (settings.currencyId == kCurrencyAll &&
              client.currencyId != company.currencyId) {
            final exchangeRate = invoice.hasExchangeRate
                ? 1 / invoice.exchangeRate
                : getExchangeRate(currencyMap,
                    fromCurrencyId: client.currencyId,
                    toCurrencyId: company.currencyId);
            amount *= exchangeRate;
          }

          if (task.isInvoiced) {
            if (invoiceMap.containsKey(task.invoiceId) &&
                invoiceMap[task.invoiceId]!.isPaid) {
              paidData.total += amount;
            } else {
              invoicedData.total += amount;
            }
          } else {
            loggedData.total += amount;
          }

          if (task.isBetween(
              settings.startDate(company), settings.endDate(company))) {
            if (totals[STATUS_LOGGED]![date] == null) {
              totals[STATUS_LOGGED]![date] = 0.0;
              totals[STATUS_INVOICED]![date] = 0.0;
              totals[STATUS_PAID]![date] = 0.0;

              loggedData.entityMap[date] = [];
              invoicedData.entityMap[date] = [];
              paidData.entityMap[date] = [];
            }

            if (task.isInvoiced) {
              if (invoiceMap.containsKey(task.invoiceId) &&
                  invoiceMap[task.invoiceId]!.isPaid) {
                totals[STATUS_PAID]![date] =
                    totals[STATUS_PAID]![date]! + amount;
                paidData.entityMap[date]!.add(task.id);
                paidData.periodTotal += amount;
              } else {
                totals[STATUS_INVOICED]![date] =
                    totals[STATUS_INVOICED]![date]! + amount;
                invoicedData.entityMap[date]!.add(task.id);
                invoicedData.periodTotal += amount;
              }
            } else {
              totals[STATUS_LOGGED]![date] =
                  totals[STATUS_LOGGED]![date]! + amount;
              loggedData.entityMap[date]!.add(task.id);
              loggedData.periodTotal += amount;
            }
          }
        });
      });

      if (task.isInvoiced) {
        if (invoiceMap.containsKey(task.invoiceId) &&
            invoiceMap[task.invoiceId]!.isPaid) {
          counts[STATUS_PAID] = counts[STATUS_PAID]! + 1;
        } else {
          counts[STATUS_INVOICED] = counts[STATUS_INVOICED]! + 1;
        }
      } else {
        counts[STATUS_LOGGED] = counts[STATUS_LOGGED]! + 1;
      }
    }
  });

  var date = convertSqlDateToDateTime(settings.startDate(company));
  final endDate = convertSqlDateToDateTime(settings.endDate(company));

  while (!date.isAfter(endDate)) {
    final key = convertDateTimeToSqlDate(date);
    if (totals[STATUS_LOGGED]!.containsKey(key)) {
      loggedData.rawSeries
          .add(ChartMoneyData(date, totals[STATUS_LOGGED]![key]));
      invoicedData.rawSeries
          .add(ChartMoneyData(date, totals[STATUS_INVOICED]![key]));
      paidData.rawSeries.add(ChartMoneyData(date, totals[STATUS_PAID]![key]));
    } else {
      loggedData.rawSeries.add(ChartMoneyData(date, 0.0));
      invoicedData.rawSeries.add(ChartMoneyData(date, 0.0));
      paidData.rawSeries.add(ChartMoneyData(date, 0.0));
    }

    if (settings.groupBy == kReportGroupDay) {
      date = date.add(Duration(days: 1));
    } else if (settings.groupBy == kReportGroupMonth) {
      date = DateTime(date.year, date.month + 1);
    } else if (settings.groupBy == kReportGroupYear) {
      date = DateTime(date.year + 1);
    }
  }

  loggedData.average = (counts[STATUS_LOGGED] ?? 0) > 0
      ? round(loggedData.periodTotal / counts[STATUS_LOGGED]!, 2)
      : 0;
  invoicedData.average = (counts[STATUS_INVOICED] ?? 0) > 0
      ? round(invoicedData.periodTotal / counts[STATUS_INVOICED]!, 2)
      : 0;
  paidData.average = (counts[STATUS_PAID] ?? 0) > 0
      ? round(paidData.periodTotal / counts[STATUS_PAID]!, 2)
      : 0;

  final List<ChartDataGroup> data = [
    loggedData,
    invoicedData,
    paidData,
  ];

  return data;
}

List<ChartDataGroup> chartExpenses(
    BuiltMap<String, CurrencyEntity> currencyMap,
    CompanyEntity company,
    DashboardUISettings settings,
    BuiltMap<String, InvoiceEntity> invoiceMap,
    BuiltMap<String, ExpenseEntity> expenseMap) {
  const STATUS_LOGGED = 'logged';
  const STATUS_PENDING = 'pending';
  const STATUS_INVOICED = 'invoiced';
  const STATUS_PAID = 'invoice_paid';

  final Map<String, int> counts = {
    STATUS_LOGGED: 0,
    STATUS_PENDING: 0,
    STATUS_INVOICED: 0,
    STATUS_PAID: 0,
  };

  final Map<String, Map<String, double>> totals = {
    STATUS_LOGGED: {},
    STATUS_PENDING: {},
    STATUS_INVOICED: {},
    STATUS_PAID: {},
  };

  final ChartDataGroup loggedData = ChartDataGroup(STATUS_LOGGED);
  final ChartDataGroup pendingData = ChartDataGroup(STATUS_PENDING);
  final ChartDataGroup invoicedData = ChartDataGroup(STATUS_INVOICED);
  final ChartDataGroup paidData = ChartDataGroup(STATUS_PAID);

  expenseMap.forEach((int, expense) {
    final currencyId = expense.currencyId;
    var date = expense.date!;
    if (date.isNotEmpty) {
      if (settings.groupBy == kReportGroupYear) {
        date = date.substring(0, 4) + '-01-01';
      } else if (settings.groupBy == kReportGroupMonth) {
        date = date.substring(0, 7) + '-01';
      }
    }

    double amount =
        settings.includeTaxes ? expense.grossAmount : expense.netAmount;

    if (expense.isDeleted! || date.isEmpty) {
      // skip it
    } else if (!settings.matchesCurrency(currencyId)) {
      // skip it
    } else {
      // Handle "All"
      if (settings.currencyId == kCurrencyAll &&
          currencyId != company.currencyId) {
        final exchangeRate = expense.hasExchangeRate
            ? expense.exchangeRate
            : getExchangeRate(currencyMap,
                fromCurrencyId: currencyId, toCurrencyId: company.currencyId);
        amount *= exchangeRate;
      }

      if (expense.isInvoiced) {
        final invoice = invoiceMap[expense.invoiceId] ?? InvoiceEntity();
        if (invoice.isPaid) {
          paidData.total += amount;
        } else {
          invoicedData.total += amount;
        }
      } else if (expense.isPending) {
        pendingData.total += amount;
      } else {
        loggedData.total += amount;
      }

      if (expense.isBetween(
          settings.startDate(company), settings.endDate(company))) {
        if (totals[STATUS_LOGGED]![date] == null) {
          totals[STATUS_LOGGED]![date] = 0.0;
          totals[STATUS_PENDING]![date] = 0.0;
          totals[STATUS_INVOICED]![date] = 0.0;
          totals[STATUS_PAID]![date] = 0.0;

          loggedData.entityMap[date] = [];
          pendingData.entityMap[date] = [];
          invoicedData.entityMap[date] = [];
          paidData.entityMap[date] = [];
        }

        if (expense.isInvoiced) {
          final invoice = invoiceMap[expense.invoiceId] ?? InvoiceEntity();
          if (invoice.isPaid) {
            totals[STATUS_PAID]![date] = totals[STATUS_PAID]![date]! + amount;
            counts[STATUS_PAID] = counts[STATUS_PAID]! + 1;
            paidData.entityMap[date]!.add(expense.id);
            paidData.periodTotal += amount;
          } else {
            totals[STATUS_INVOICED]![date] =
                totals[STATUS_INVOICED]![date]! + amount;
            counts[STATUS_INVOICED] = counts[STATUS_INVOICED]! + 1;
            invoicedData.entityMap[date]!.add(expense.id);
            invoicedData.periodTotal += amount;
          }
        } else if (expense.isPending) {
          totals[STATUS_PENDING]![date] =
              totals[STATUS_PENDING]![date]! + amount;
          counts[STATUS_PENDING] = counts[STATUS_PENDING]! + 1;
          pendingData.entityMap[date]!.add(expense.id);
          pendingData.periodTotal += amount;
        } else {
          totals[STATUS_LOGGED]![date] = totals[STATUS_LOGGED]![date]! + amount;
          counts[STATUS_LOGGED] = counts[STATUS_LOGGED]! + 1;
          loggedData.entityMap[date]!.add(expense.id);
          loggedData.periodTotal += amount;
        }
      }
    }
  });

  var date = convertSqlDateToDateTime(settings.startDate(company));
  final endDate = convertSqlDateToDateTime(settings.endDate(company));

  while (!date.isAfter(endDate)) {
    final key = convertDateTimeToSqlDate(date);
    if (totals[STATUS_LOGGED]!.containsKey(key)) {
      loggedData.rawSeries
          .add(ChartMoneyData(date, totals[STATUS_LOGGED]![key]));
      pendingData.rawSeries
          .add(ChartMoneyData(date, totals[STATUS_PENDING]![key]));
      invoicedData.rawSeries
          .add(ChartMoneyData(date, totals[STATUS_INVOICED]![key]));
      paidData.rawSeries.add(ChartMoneyData(date, totals[STATUS_PAID]![key]));
    } else {
      loggedData.rawSeries.add(ChartMoneyData(date, 0.0));
      pendingData.rawSeries.add(ChartMoneyData(date, 0.0));
      invoicedData.rawSeries.add(ChartMoneyData(date, 0.0));
      paidData.rawSeries.add(ChartMoneyData(date, 0.0));
    }

    if (settings.groupBy == kReportGroupDay) {
      date = date.add(Duration(days: 1));
    } else if (settings.groupBy == kReportGroupMonth) {
      date = DateTime(date.year, date.month + 1);
    } else if (settings.groupBy == kReportGroupYear) {
      date = DateTime(date.year + 1);
    }
  }

  loggedData.average = (counts[STATUS_LOGGED] ?? 0) > 0
      ? round(loggedData.periodTotal / counts[STATUS_LOGGED]!, 2)
      : 0;
  pendingData.average = (counts[STATUS_PENDING] ?? 0) > 0
      ? round(pendingData.periodTotal / counts[STATUS_PENDING]!, 2)
      : 0;
  invoicedData.average = (counts[STATUS_INVOICED] ?? 0) > 0
      ? round(invoicedData.periodTotal / counts[STATUS_INVOICED]!, 2)
      : 0;
  paidData.average = (counts[STATUS_PAID] ?? 0) > 0
      ? round(paidData.periodTotal / counts[STATUS_PAID]!, 2)
      : 0;

  final List<ChartDataGroup> data = [
    loggedData,
    pendingData,
    invoicedData,
    paidData,
  ];

  return data;
}

var memoizedChartExpenses = memo5((BuiltMap<String, CurrencyEntity> currencyMap,
        CompanyEntity? company,
        DashboardUISettings settings,
        BuiltMap<String, InvoiceEntity> invoiceMap,
        BuiltMap<String, ExpenseEntity> expenseMap) =>
    chartExpenses(currencyMap, company!, settings, invoiceMap, expenseMap));

var memoizedPreviousChartExpenses = memo5(
    (BuiltMap<String, CurrencyEntity> currencyMap,
            CompanyEntity? company,
            DashboardUISettings settings,
            BuiltMap<String, InvoiceEntity> invoiceMap,
            BuiltMap<String, ExpenseEntity> expenseMap) =>
        chartExpenses(currencyMap, company!, settings, invoiceMap, expenseMap));

var memoizedRunningTasks = memo2(
    (BuiltMap<String, TaskEntity> taskMap, String userId) =>
        runningTasks(taskMap, userId));

List<TaskEntity?> runningTasks(
    BuiltMap<String, TaskEntity> taskMap, String userId) {
  final tasks = <TaskEntity?>[];

  taskMap.forEach((taskId, task) {
    if (task.isRunning &&
        !task.isDeleted! &&
        (task.createdUserId == userId || task.assignedUserId == userId)) {
      tasks.add(task);
    }
  });

  return tasks;
}
