// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_state.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/money.dart';
import 'package:nimble_charts/flutter.dart';

class ChartDataGroup {
  ChartDataGroup(this.name);

  final String name;
  final List<ChartMoneyData> rawSeries = [];
  Map<String, List<String>> entityMap = {};
  late List<Series<dynamic, DateTime>> chartSeries;

  double periodTotal = 0.0;
  double previousTotal = 0.0;
  double total = 0.0;

  int periodCount = 0;
  int totalCount = 0;

  double get periodAverage =>
      periodCount == 0 ? 0 : round(periodTotal / periodCount, 2);

  double get totalAverage => totalCount == 0 ? 0 : round(total / totalCount, 2);

  bool get isDuration => name.endsWith('_duration');
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
      activeData.totalCount++;

      outstandingData.total += balance;
      outstandingData.totalCount++;

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

        activeData.periodCount++;
        activeData.entityMap[date]!.add(invoice.id);

        if (invoice.balance > 0) {
          outstandingData.periodCount++;
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
      activeData.totalCount++;

      if (quote.isApproved) {
        approvedData.total += amount;
        approvedData.totalCount++;
      } else {
        unapprovedData.total += amount;
        unapprovedData.totalCount++;
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
        activeData.periodCount++;
        activeData.entityMap[date]!.add(quote.id);

        if (quote.isApproved) {
          totals[STATUS_APPROVED]![date] =
              totals[STATUS_APPROVED]![date]! + amount;
          approvedData.entityMap[date]!.add(quote.id);
          approvedData.periodTotal += amount;
          approvedData.periodCount++;
        } else {
          totals[STATUS_UNAPPROVED]![date] =
              totals[STATUS_UNAPPROVED]![date]! + amount;
          unapprovedData.entityMap[date]!.add(quote.id);
          unapprovedData.periodTotal += amount;
          unapprovedData.periodCount++;
        }

        if (quote.isInvoiced) {
          final invoice = invoiceMap[quote.invoiceId];
          if (invoice != null && invoice.isPaid) {
            totals[STATUS_PAID]![date] = totals[STATUS_PAID]![date]! + amount;
            paidData.entityMap[date]!.add(quote.id);
            paidData.periodTotal += amount;
            paidData.periodCount++;
          } else {
            totals[STATUS_INVOICED]![date] =
                totals[STATUS_INVOICED]![date]! + amount;
            invoicedData.entityMap[date]!.add(quote.id);
            invoicedData.periodTotal += amount;
            invoicedData.periodCount++;
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
      activeData.totalCount++;

      if ((payment.refunded) > 0) {
        refundedData.total += refunded;
        refundedData.totalCount++;
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

        activeData.entityMap[date]!.add(payment.id);
        activeData.periodTotal += completedAmount;
        activeData.periodCount++;

        if ((payment.refunded) > 0) {
          refundedData.entityMap[date]!.add(payment.id);
          refundedData.periodTotal += refunded;
          refundedData.periodCount++;
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
  const STATUS_LOGGED_DURATION = 'logged_duration';
  const STATUS_INVOICED_DURATION = 'invoiced_duration';
  const STATUS_PAID_DURATION = 'invoice_paid_duration';

  final Map<String, Map<String, double>> totals = {
    STATUS_LOGGED: {},
    STATUS_INVOICED: {},
    STATUS_PAID: {},
    STATUS_LOGGED_DURATION: {},
    STATUS_INVOICED_DURATION: {},
    STATUS_PAID_DURATION: {},
  };

  final ChartDataGroup loggedData = ChartDataGroup(STATUS_LOGGED);
  final ChartDataGroup invoicedData = ChartDataGroup(STATUS_INVOICED);
  final ChartDataGroup paidData = ChartDataGroup(STATUS_PAID);

  final ChartDataGroup loggedDataDuration =
      ChartDataGroup(STATUS_LOGGED_DURATION);
  final ChartDataGroup invoicedDataDuration =
      ChartDataGroup(STATUS_INVOICED_DURATION);
  final ChartDataGroup paidDataDuration = ChartDataGroup(STATUS_PAID_DURATION);

  taskMap.forEach((int, task) {
    final client = clientMap[task.clientId] ?? ClientEntity(id: task.clientId);
    final invoice =
        invoiceMap[task.invoiceId] ?? InvoiceEntity(id: task.clientId);
    final project =
        projectMap[task.projectId] ?? ProjectEntity(id: task.projectId);
    final group = groupMap[client.groupId] ?? GroupEntity(id: client.groupId);

    final startDate = settings.startDate(company) ?? '';
    final endDate = settings.endDate(company) ?? '';

    if (task.isDeleted! || client.isDeleted! || project.isDeleted!) {
      // skip it
    } else if (!settings.matchesCurrency(client.currencyId)) {
      // skip it
    } else {
      var isIncluded = false;

      if (task.isInvoiced) {
        if (invoiceMap.containsKey(task.invoiceId) &&
            invoiceMap[task.invoiceId]!.isPaid) {
          paidData.totalCount++;
          paidDataDuration.totalCount++;
        } else {
          invoicedData.totalCount++;
          invoicedDataDuration.totalCount++;
        }
      } else {
        loggedData.totalCount++;
        loggedDataDuration.totalCount++;
      }

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

          final seconds = duration.inSeconds;
          double amount = taskRate * round(seconds / 3600, 3);

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
              paidDataDuration.total += seconds;
            } else {
              invoicedData.total += amount;
              invoicedDataDuration.total += seconds;
            }
          } else {
            loggedData.total += amount;
            loggedDataDuration.total += seconds;
          }

          if (startDate.compareTo(date) <= 0 && endDate.compareTo(date) >= 0) {
            isIncluded = true;

            if (totals[STATUS_LOGGED]![date] == null) {
              totals[STATUS_LOGGED]![date] = 0.0;
              totals[STATUS_INVOICED]![date] = 0.0;
              totals[STATUS_PAID]![date] = 0.0;

              loggedData.entityMap[date] = [];
              invoicedData.entityMap[date] = [];
              paidData.entityMap[date] = [];

              totals[STATUS_LOGGED_DURATION]![date] = 0.0;
              totals[STATUS_INVOICED_DURATION]![date] = 0.0;
              totals[STATUS_PAID_DURATION]![date] = 0.0;

              //loggedDataDuration.entityMap[date] = [];
              //invoicedDataDuration.entityMap[date] = [];
              //paidDataDuration.entityMap[date] = [];
            }

            if (task.isInvoiced) {
              if (invoiceMap.containsKey(task.invoiceId) &&
                  invoiceMap[task.invoiceId]!.isPaid) {
                totals[STATUS_PAID]![date] =
                    totals[STATUS_PAID]![date]! + amount;
                paidData.entityMap[date]!.add(task.id);
                paidData.periodTotal += amount;

                totals[STATUS_PAID_DURATION]![date] =
                    totals[STATUS_PAID_DURATION]![date]! + seconds;
                //paidDataDuration.entityMap[date]!.add(task.id);
                paidDataDuration.periodTotal += amount;
              } else {
                totals[STATUS_INVOICED]![date] =
                    totals[STATUS_INVOICED]![date]! + amount;
                invoicedData.entityMap[date]!.add(task.id);
                invoicedData.periodTotal += amount;

                totals[STATUS_INVOICED_DURATION]![date] =
                    totals[STATUS_INVOICED_DURATION]![date]! + seconds;
                //invoicedDataDuration.entityMap[date]!.add(task.id);
                invoicedDataDuration.periodTotal += seconds;
              }
            } else {
              totals[STATUS_LOGGED]![date] =
                  totals[STATUS_LOGGED]![date]! + amount;
              loggedData.entityMap[date]!.add(task.id);
              loggedData.periodTotal += amount;

              totals[STATUS_LOGGED_DURATION]![date] =
                  totals[STATUS_LOGGED_DURATION]![date]! + seconds;
              //loggedDataDuration.entityMap[date]!.add(task.id);
              loggedDataDuration.periodTotal += seconds;
            }
          }
        });
      });

      if (isIncluded) {
        if (task.isInvoiced) {
          if (invoiceMap.containsKey(task.invoiceId) &&
              invoiceMap[task.invoiceId]!.isPaid) {
            paidData.periodCount++;
            paidDataDuration.periodCount++;
          } else {
            invoicedData.periodCount++;
            invoicedDataDuration.periodCount++;
          }
        } else {
          loggedData.periodCount++;
          loggedDataDuration.periodCount++;
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

  final List<ChartDataGroup> data = [
    loggedData,
    invoicedData,
    paidData,
    loggedDataDuration,
    invoicedDataDuration,
    paidDataDuration,
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
        final exchangeRate = expense.hasExchangeRate &&
                expense.invoiceCurrencyId == company.currencyId
            ? expense.exchangeRate
            : getExchangeRate(currencyMap,
                fromCurrencyId: currencyId, toCurrencyId: company.currencyId);
        amount *= exchangeRate;
      }

      if (expense.isInvoiced) {
        final invoice = invoiceMap[expense.invoiceId] ?? InvoiceEntity();
        if (invoice.isPaid) {
          paidData.total += amount;
          paidData.totalCount++;
        } else {
          invoicedData.total += amount;
          invoicedData.totalCount++;
        }
      } else if (expense.isPending) {
        pendingData.total += amount;
        pendingData.totalCount++;
      } else {
        loggedData.total += amount;
        loggedData.totalCount++;
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
            paidData.entityMap[date]!.add(expense.id);
            paidData.periodTotal += amount;
            paidData.periodCount++;
          } else {
            totals[STATUS_INVOICED]![date] =
                totals[STATUS_INVOICED]![date]! + amount;
            invoicedData.entityMap[date]!.add(expense.id);
            invoicedData.periodTotal += amount;
            invoicedData.periodCount++;
          }
        } else if (expense.isPending) {
          totals[STATUS_PENDING]![date] =
              totals[STATUS_PENDING]![date]! + amount;
          pendingData.entityMap[date]!.add(expense.id);
          pendingData.periodTotal += amount;
          pendingData.periodCount++;
        } else {
          totals[STATUS_LOGGED]![date] = totals[STATUS_LOGGED]![date]! + amount;
          loggedData.entityMap[date]!.add(expense.id);
          loggedData.periodTotal += amount;
          loggedData.periodCount++;
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
