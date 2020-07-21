import 'package:built_collection/built_collection.dart';
import 'package:charts_common/common.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_state.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/money.dart';
import 'package:memoize/memoize.dart';

class ChartDataGroup {
  ChartDataGroup(this.name);

  final String name;
  final List<ChartMoneyData> rawSeries = [];
  Map<String, List<String>> entityMap = {};
  List<Series<dynamic, DateTime>> chartSeries;
  double total = 0.0;
  double average = 0.0;
  double previousTotal = 0.0;
}

class ChartMoneyData {
  ChartMoneyData(this.date, this.amount);

  final DateTime date;
  final double amount;
}

var memoizedChartInvoices = memo6((
  BuiltMap<String, CurrencyEntity> currencyMap,
  CompanyEntity company,
  DashboardUIState settings,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, GroupEntity> groupMap,
) =>
    _chartInvoices(
        currencyMap: currencyMap,
        company: company,
        settings: settings,
        invoiceMap: invoiceMap,
        groupMap: groupMap,
        clientMap: clientMap));

List<ChartDataGroup> _chartInvoices({
  BuiltMap<String, CurrencyEntity> currencyMap,
  CompanyEntity company,
  DashboardUIState settings,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, GroupEntity> groupMap,
}) {
  print('## chartInvoices...');
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
        clientMap[invoice.clientId] ?? ClientEntity(id: invoice.clientId);
    final group = groupMap[client.groupId] ?? GroupEntity();
    final currencyId = client.getCurrencyId(company: company, group: group);

    if (!invoice.isSent || invoice.isDeleted || client.isDeleted) {
      // skip it
    } else if (!invoice.isBetween(
        settings.startDate(company), settings.endDate(company))) {
      // skip it
    } else if (!settings.matchesCurrency(currencyId)) {
      // skip it
    } else {
      // Fix for mock data
      final date = invoice.date.split('T')[0];

      if (totals[STATUS_ACTIVE][date] == null) {
        totals[STATUS_ACTIVE][date] = 0.0;
        totals[STATUS_OUTSTANDING][date] = 0.0;
        activeData.entityMap[date] = [];
        outstandingData.entityMap[date] = [];
      }

      double amount = invoice.amount;
      double balance = invoice.balance;

      // Handle "All"
      if (settings.currencyId == kCurrencyAll &&
          currencyId != company.currencyId) {
        amount *= getExchangeRateWithMap(currencyMap,
            fromCurrencyId: currencyId, toCurrencyId: company.currencyId);
        balance *= getExchangeRateWithMap(currencyMap,
            fromCurrencyId: currencyId, toCurrencyId: company.currencyId);
      }

      totals[STATUS_ACTIVE][date] += amount;
      totals[STATUS_OUTSTANDING][date] += balance;

      counts[STATUS_ACTIVE]++;
      activeData.entityMap[date].add(invoice.id);
      if (invoice.balance > 0) {
        counts[STATUS_OUTSTANDING]++;
        outstandingData.entityMap[date].add(invoice.id);
      }
    }
  });

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

  activeData.average =
      round(activeData.total ?? 0 / counts[STATUS_ACTIVE] ?? 0, 2);
  outstandingData.average =
      round(outstandingData.total ?? 0 / counts[STATUS_OUTSTANDING] ?? 0, 2);

  final List<ChartDataGroup> data = [
    activeData,
    outstandingData,
  ];

  return data;
}

var memoizedChartQuotes = memo6((
  BuiltMap<String, CurrencyEntity> currencyMap,
  CompanyEntity company,
  DashboardUIState settings,
  BuiltMap<String, InvoiceEntity> quoteMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, GroupEntity> groupMap,
) =>
    chartQuotes(
      currencyMap: currencyMap,
      company: company,
      settings: settings,
      quoteMap: quoteMap,
      clientMap: clientMap,
      groupMap: groupMap,
    ));

List<ChartDataGroup> chartQuotes({
  BuiltMap<String, CurrencyEntity> currencyMap,
  CompanyEntity company,
  DashboardUIState settings,
  BuiltMap<String, InvoiceEntity> quoteMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, GroupEntity> groupMap,
}) {
  print('## chartQuotes...');

  const STATUS_ACTIVE = 'active';
  const STATUS_APPROVED = 'approved';
  const STATUS_UNAPPROVED = 'unapproved';

  final Map<String, int> counts = {
    STATUS_ACTIVE: 0,
    STATUS_APPROVED: 0,
    STATUS_UNAPPROVED: 0,
  };

  final Map<String, Map<String, double>> totals = {
    STATUS_ACTIVE: {},
    STATUS_APPROVED: {},
    STATUS_UNAPPROVED: {},
  };

  quoteMap.forEach((int, quote) {
    final client =
        clientMap[quote.clientId] ?? ClientEntity(id: quote.clientId);
    final group = groupMap[client.groupId] ?? GroupEntity();
    final currencyId = client.getCurrencyId(company: company, group: group);

    if (!quote.isSent || quote.isDeleted || client.isDeleted) {
      // skip it
    } else if (!quote.isBetween(
        settings.startDate(company), settings.endDate(company))) {
      // skip it
    } else if (!settings.matchesCurrency(currencyId)) {
      // skip it
    } else {
      if (totals[STATUS_ACTIVE][quote.date] == null) {
        totals[STATUS_ACTIVE][quote.date] = 0.0;
        totals[STATUS_APPROVED][quote.date] = 0.0;
        totals[STATUS_UNAPPROVED][quote.date] = 0.0;
      }

      double amount = quote.amount;

      // Handle "All"
      if (settings.currencyId == kCurrencyAll &&
          currencyId != company.currencyId) {
        amount *= getExchangeRateWithMap(currencyMap,
            fromCurrencyId: currencyId, toCurrencyId: company.currencyId);
      }

      totals[STATUS_ACTIVE][quote.date] += amount;
      counts[STATUS_ACTIVE]++;
      if (quote.isApproved) {
        totals[STATUS_APPROVED][quote.date] += quote.amount;
        counts[STATUS_APPROVED]++;
      } else {
        totals[STATUS_UNAPPROVED][quote.date] += quote.amount;
        counts[STATUS_UNAPPROVED]++;
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
      unapprovedData.rawSeries.add(ChartMoneyData(date, 0.0));
    }
    date = date.add(Duration(days: 1));
  }

  activeData.average =
      round(activeData.total ?? 0 / counts[STATUS_ACTIVE] ?? 0, 2);
  approvedData.average =
      round(approvedData.total ?? 0 / counts[STATUS_APPROVED] ?? 0, 2);
  unapprovedData.average =
      round(unapprovedData.total ?? 0 / counts[STATUS_UNAPPROVED] ?? 0, 2);

  final List<ChartDataGroup> data = [
    activeData,
    approvedData,
    unapprovedData,
  ];

  return data;
}

var memoizedChartPayments = memo7((
  BuiltMap<String, CurrencyEntity> currencyMap,
  CompanyEntity company,
  DashboardUIState settings,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, GroupEntity> groupMap,
  BuiltMap<String, PaymentEntity> paymentMap,
) =>
    chartPayments(currencyMap, company, settings, invoiceMap, clientMap,
        groupMap, paymentMap));

List<ChartDataGroup> chartPayments(
  BuiltMap<String, CurrencyEntity> currencyMap,
  CompanyEntity company,
  DashboardUIState settings,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, GroupEntity> groupMap,
  BuiltMap<String, PaymentEntity> paymentMap,
) {
  print('## chartPayments...');

  const STATUS_ACTIVE = 'active';
  const STATUS_REFUNDED = 'refunded';

  final Map<String, int> counts = {
    STATUS_ACTIVE: 0,
    STATUS_REFUNDED: 0,
  };

  final Map<String, Map<String, double>> totals = {
    STATUS_ACTIVE: {},
    STATUS_REFUNDED: {},
  };

  paymentMap.forEach((int, payment) {
    final client =
        clientMap[payment.clientId] ?? ClientEntity(id: payment.clientId);
    final group = groupMap[client.groupId] ?? GroupEntity();
    final currencyId = client.getCurrencyId(company: company, group: group);

    if (payment.isDeleted || client.isDeleted) {
      // skip it
    } else if (!payment.isBetween(
        settings.startDate(company), settings.endDate(company))) {
      // skip it
    } else if (!settings.matchesCurrency(currencyId)) {
      // skip it
    } else {
      if (totals[STATUS_ACTIVE][payment.date] == null) {
        totals[STATUS_ACTIVE][payment.date] = 0.0;
        totals[STATUS_REFUNDED][payment.date] = 0.0;
      }

      double completedAmount = payment.completedAmount;
      double refunded = payment.refunded;

      // Handle "All"
      if (settings.currencyId == kCurrencyAll &&
          currencyId != company.currencyId) {
        completedAmount *= getExchangeRateWithMap(currencyMap,
            fromCurrencyId: currencyId, toCurrencyId: company.currencyId);
        refunded *= getExchangeRateWithMap(currencyMap,
            fromCurrencyId: currencyId, toCurrencyId: company.currencyId);
      }

      totals[STATUS_ACTIVE][payment.date] += completedAmount;
      totals[STATUS_REFUNDED][payment.date] += refunded ?? 0;

      counts[STATUS_ACTIVE]++;
      if ((payment.refunded ?? 0) > 0) {
        counts[STATUS_REFUNDED]++;
      }
    }
  });

  final ChartDataGroup activeData = ChartDataGroup(STATUS_ACTIVE);
  final ChartDataGroup refundedData = ChartDataGroup(STATUS_REFUNDED);

  var date = DateTime.parse(settings.startDate(company));
  final endDate = DateTime.parse(settings.endDate(company));

  while (!date.isAfter(endDate)) {
    final key = convertDateTimeToSqlDate(date);
    if (totals[STATUS_ACTIVE].containsKey(key)) {
      activeData.rawSeries
          .add(ChartMoneyData(date, totals[STATUS_ACTIVE][key]));
      activeData.total += totals[STATUS_ACTIVE][key];
      refundedData.rawSeries
          .add(ChartMoneyData(date, totals[STATUS_REFUNDED][key]));
      refundedData.total += totals[STATUS_REFUNDED][key];
    } else {
      activeData.rawSeries.add(ChartMoneyData(date, 0.0));
      refundedData.rawSeries.add(ChartMoneyData(date, 0.0));
    }
    date = date.add(Duration(days: 1));
  }

  activeData.average =
      round(activeData.total ?? 0 / counts[STATUS_ACTIVE] ?? 0, 2);
  refundedData.average =
      round(refundedData.total ?? 0 / counts[STATUS_REFUNDED] ?? 0, 2);

  final List<ChartDataGroup> data = [
    activeData,
    refundedData,
  ];

  return data;
}

var memoizedChartTasks = memo8((
  BuiltMap<String, CurrencyEntity> currencyMap,
  CompanyEntity company,
  DashboardUIState settings,
  BuiltMap<String, TaskEntity> taskMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ProjectEntity> projectMap,
  BuiltMap<String, GroupEntity> groupMap,
  BuiltMap<String, ClientEntity> clientMap,
) =>
    chartTasks(currencyMap, company, settings, taskMap, invoiceMap, projectMap,
        groupMap, clientMap));

List<ChartDataGroup> chartTasks(
    BuiltMap<String, CurrencyEntity> currencyMap,
    CompanyEntity company,
    DashboardUIState settings,
    BuiltMap<String, TaskEntity> taskMap,
    BuiltMap<String, InvoiceEntity> invoiceMap,
    BuiltMap<String, ProjectEntity> projectMap,
    BuiltMap<String, GroupEntity> groupMap,
    BuiltMap<String, ClientEntity> clientMap) {
  const STATUS_LOGGED = 'logged';
  const STATUS_INVOICED = 'invoiced';
  const STATUS_PAID = 'paid';

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

  taskMap.forEach((int, task) {
    final client = clientMap[task.clientId] ?? ClientEntity(id: task.clientId);
    final project =
        projectMap[task.projectId] ?? ProjectEntity(id: task.projectId);
    final group = groupMap[client.groupId] ?? GroupEntity();
    final currencyId = client.getCurrencyId(company: company, group: group);

    if (task.isDeleted || client.isDeleted || project.isDeleted) {
      // skip it
    } else if (!task.isBetween(
        settings.startDate(company), settings.endDate(company))) {
      // skip it
    } else if (!settings.matchesCurrency(currencyId)) {
      // skip it
    } else {
      task.taskTimes.forEach((taskTime) {
        taskTime.getParts(0).forEach((date, duration) {
          if (totals[STATUS_LOGGED][date] == null) {
            totals[STATUS_LOGGED][date] = 0.0;
            totals[STATUS_INVOICED][date] = 0.0;
            totals[STATUS_PAID][date] = 0.0;
          }

          final taskRate = taskRateSelector(
              company: company, project: project, client: client);
          double amount = taskRate * round(duration.inSeconds / 3600, 3);

          // Handle "All"
          if (settings.currencyId == kCurrencyAll &&
              currencyId != company.currencyId) {
            amount *= getExchangeRateWithMap(currencyMap,
                fromCurrencyId: currencyId, toCurrencyId: company.currencyId);
          }

          if (task.isInvoiced) {
            if (invoiceMap.containsKey(task.invoiceId) &&
                invoiceMap[task.invoiceId].isPaid) {
              totals[STATUS_PAID][date] += amount;
              counts[STATUS_PAID]++;
            } else {
              totals[STATUS_INVOICED][date] += amount;
              counts[STATUS_INVOICED]++;
            }
          } else {
            totals[STATUS_LOGGED][date] += amount;
            counts[STATUS_LOGGED]++;
          }
        });
      });
    }
  });

  final ChartDataGroup loggedData = ChartDataGroup(STATUS_LOGGED);
  final ChartDataGroup invoicedData = ChartDataGroup(STATUS_INVOICED);
  final ChartDataGroup paidData = ChartDataGroup(STATUS_PAID);

  var date = DateTime.parse(settings.startDate(company));
  final endDate = DateTime.parse(settings.endDate(company));

  while (!date.isAfter(endDate)) {
    final key = convertDateTimeToSqlDate(date);
    if (totals[STATUS_LOGGED].containsKey(key)) {
      loggedData.rawSeries
          .add(ChartMoneyData(date, totals[STATUS_LOGGED][key]));
      loggedData.total += totals[STATUS_LOGGED][key];
      invoicedData.rawSeries
          .add(ChartMoneyData(date, totals[STATUS_INVOICED][key]));
      invoicedData.total += totals[STATUS_INVOICED][key];
      paidData.rawSeries.add(ChartMoneyData(date, totals[STATUS_PAID][key]));
      paidData.total += totals[STATUS_PAID][key];
    } else {
      loggedData.rawSeries.add(ChartMoneyData(date, 0.0));
      invoicedData.rawSeries.add(ChartMoneyData(date, 0.0));
      paidData.rawSeries.add(ChartMoneyData(date, 0.0));
    }
    date = date.add(Duration(days: 1));
  }

  loggedData.average =
      round(loggedData.total ?? 0 / counts[STATUS_LOGGED] ?? 0, 2);
  invoicedData.average =
      round(invoicedData.total ?? 0 / counts[STATUS_INVOICED] ?? 0, 2);
  paidData.average = round(paidData.total ?? 0 / counts[STATUS_PAID] ?? 0, 2);

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
    DashboardUIState settings,
    BuiltMap<String, InvoiceEntity> invoiceMap,
    BuiltMap<String, ExpenseEntity> expenseMap) {
  const STATUS_LOGGED = 'logged';
  const STATUS_PENDING = 'pending';
  const STATUS_INVOICED = 'invoiced';
  const STATUS_PAID = 'paid';

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

  expenseMap.forEach((int, expense) {
    final currencyId = expense.expenseCurrencyId;
    final date = expense.expenseDate;
    double amount = expense.amountWithTax;

    if (expense.isDeleted) {
      // skip it
    } else if (!expense.isBetween(
        settings.startDate(company), settings.endDate(company))) {
      // skip it
    } else if (!settings.matchesCurrency(currencyId)) {
      // skip it
    } else {
      if (totals[STATUS_LOGGED][date] == null) {
        totals[STATUS_LOGGED][date] = 0.0;
        totals[STATUS_PENDING][date] = 0.0;
        totals[STATUS_INVOICED][date] = 0.0;
        totals[STATUS_PAID][date] = 0.0;
      }

      // Handle "All"
      if (settings.currencyId == kCurrencyAll &&
          currencyId != company.currencyId) {
        amount *= getExchangeRateWithMap(currencyMap,
            fromCurrencyId: currencyId, toCurrencyId: company.currencyId);
      }

      if (expense.isInvoiced) {
        final invoice = invoiceMap[expense.invoiceId] ?? InvoiceEntity();
        if (invoice.isPaid) {
          totals[STATUS_PAID][date] += amount;
          counts[STATUS_PAID]++;
        } else {
          totals[STATUS_INVOICED][date] += amount;
          counts[STATUS_INVOICED]++;
        }
      } else if (expense.isPending) {
        totals[STATUS_PENDING][date] += amount;
        counts[STATUS_PENDING]++;
      } else {
        totals[STATUS_LOGGED][date] += amount;
        counts[STATUS_LOGGED]++;
      }
    }
  });

  final ChartDataGroup loggedData = ChartDataGroup(STATUS_LOGGED);
  final ChartDataGroup pendingData = ChartDataGroup(STATUS_PENDING);
  final ChartDataGroup invoicedData = ChartDataGroup(STATUS_INVOICED);
  final ChartDataGroup paidData = ChartDataGroup(STATUS_PAID);

  var date = DateTime.parse(settings.startDate(company));
  final endDate = DateTime.parse(settings.endDate(company));

  while (!date.isAfter(endDate)) {
    final key = convertDateTimeToSqlDate(date);
    if (totals[STATUS_LOGGED].containsKey(key)) {
      loggedData.rawSeries
          .add(ChartMoneyData(date, totals[STATUS_LOGGED][key]));
      loggedData.total += totals[STATUS_LOGGED][key];
      pendingData.rawSeries
          .add(ChartMoneyData(date, totals[STATUS_PENDING][key]));
      pendingData.total += totals[STATUS_PENDING][key];
      invoicedData.rawSeries
          .add(ChartMoneyData(date, totals[STATUS_INVOICED][key]));
      invoicedData.total += totals[STATUS_INVOICED][key];
      paidData.rawSeries.add(ChartMoneyData(date, totals[STATUS_PAID][key]));
      paidData.total += totals[STATUS_PAID][key];
    } else {
      loggedData.rawSeries.add(ChartMoneyData(date, 0.0));
      pendingData.rawSeries.add(ChartMoneyData(date, 0.0));
      invoicedData.rawSeries.add(ChartMoneyData(date, 0.0));
      paidData.rawSeries.add(ChartMoneyData(date, 0.0));
    }
    date = date.add(Duration(days: 1));
  }

  loggedData.average =
      round(loggedData.total ?? 0 / counts[STATUS_LOGGED] ?? 0, 2);
  pendingData.average =
      round(pendingData.total ?? 0 / counts[STATUS_PENDING] ?? 0, 2);
  invoicedData.average =
      round(invoicedData.total ?? 0 / counts[STATUS_INVOICED] ?? 0, 2);
  paidData.average = round(paidData.total ?? 0 / counts[STATUS_PAID] ?? 0, 2);

  final List<ChartDataGroup> data = [
    loggedData,
    pendingData,
    invoicedData,
    paidData,
  ];

  return data;
}

var memoizedChartExpenses = memo5((BuiltMap<String, CurrencyEntity> currencyMap,
        CompanyEntity company,
        DashboardUIState settings,
        BuiltMap<String, InvoiceEntity> invoiceMap,
        BuiltMap<String, ExpenseEntity> expenseMap) =>
    chartExpenses(currencyMap, company, settings, invoiceMap, expenseMap));
