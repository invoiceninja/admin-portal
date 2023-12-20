// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';

var memoizedUpcomingInvoices = memo2((
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
) =>
    _upcomingInvoices(
      invoiceMap: invoiceMap,
      clientMap: clientMap,
    ));

List<InvoiceEntity?> _upcomingInvoices({
  required BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity>? clientMap,
}) {
  final invoices = <InvoiceEntity?>[];
  invoiceMap.forEach((index, invoice) {
    final client =
        clientMap![invoice.clientId] ?? ClientEntity(id: invoice.clientId);
    if (invoice.isNotActive ||
        invoice.isCancelledOrReversed ||
        client.isNotActive) {
      // do noting
    } else if (invoice.isUpcoming) {
      invoices.add(invoice);
    }
  });

  invoices.sort((invoiceA, invoiceB) =>
      invoiceA!.primaryDate.compareTo(invoiceB!.primaryDate));

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

List<InvoiceEntity?> _pastDueInvoices({
  required BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity>? clientMap,
}) {
  final invoices = <InvoiceEntity?>[];
  invoiceMap.forEach((index, invoice) {
    final client =
        clientMap![invoice.clientId] ?? ClientEntity(id: invoice.clientId);
    if (invoice.isNotActive ||
        invoice.isCancelledOrReversed ||
        client.isNotActive) {
      // do noting
    } else if (invoice.isPastDue) {
      invoices.add(invoice);
    }
  });

  invoices.sort((invoiceA, invoiceB) =>
      invoiceA!.primaryDate.compareTo(invoiceB!.primaryDate));

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

List<PaymentEntity?> _recentPayments({
  required BuiltMap<String, PaymentEntity> paymentMap,
  BuiltMap<String, ClientEntity>? clientMap,
}) {
  final payments = <PaymentEntity?>[];
  final threeMonthsAgo =
      (DateTime.now().subtract(Duration(days: 60)).millisecondsSinceEpoch /
              1000)
          .round();
  paymentMap.forEach((index, payment) {
    final client =
        clientMap![payment.clientId] ?? ClientEntity(id: payment.clientId);
    if (payment.isNotActive || client.isNotActive) {
      // do noting
    } else if (payment.isActive && payment.createdAt > threeMonthsAgo) {
      payments.add(payment);
    }
  });

  payments.sort((paymentA, paymentB) {
    if (paymentA!.date == paymentB!.date) {
      return paymentB.createdAt.compareTo(paymentA.createdAt);
    } else {
      return paymentB.date.compareTo(paymentA.date);
    }
  });

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

List<InvoiceEntity?> _upcomingQuotes({
  required BuiltMap<String, InvoiceEntity> quoteMap,
  BuiltMap<String, ClientEntity>? clientMap,
}) {
  final quotes = <InvoiceEntity?>[];
  quoteMap.forEach((index, quote) {
    final client =
        clientMap![quote.clientId] ?? ClientEntity(id: quote.clientId);
    if (quote.isNotActive || client.isNotActive) {
      // do noting
    } else if (quote.isUpcoming) {
      quotes.add(quote);
    }
  });

  quotes.sort(
      (quoteA, quoteB) => quoteA!.primaryDate.compareTo(quoteB!.primaryDate));

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

List<InvoiceEntity?> _expiredQuotes({
  required BuiltMap<String, InvoiceEntity> quoteMap,
  BuiltMap<String, ClientEntity>? clientMap,
}) {
  final quotes = <InvoiceEntity?>[];
  quoteMap.forEach((index, quote) {
    final client =
        clientMap![quote.clientId] ?? ClientEntity(id: quote.clientId);
    if (quote.isNotActive || client.isNotActive) {
      // do noting
    } else if (quote.isPastDue) {
      quotes.add(quote);
    }
  });

  quotes.sort(
      (quoteA, quoteB) => quoteA!.primaryDate.compareTo(quoteB!.primaryDate));

  return quotes;
}

var memoizedRunningTasks = memo2((
  BuiltMap<String, TaskEntity> taskMap,
  BuiltMap<String, ClientEntity> clientMap,
) =>
    _runningTasks(
      taskMap: taskMap,
      clientMap: clientMap,
    ));

List<TaskEntity?> _runningTasks({
  required BuiltMap<String, TaskEntity> taskMap,
  required BuiltMap<String, ClientEntity> clientMap,
}) {
  final tasks = <TaskEntity>[];
  taskMap.forEach((index, task) {
    final client = clientMap[task.clientId] ?? ClientEntity(id: task.clientId);
    if (task.isNotActive || client.isNotActive) {
      // do noting
    } else if (task.isRunning) {
      tasks.add(task);
    }
  });

  tasks.sort((taskA, taskB) => taskB.updatedAt.compareTo(taskA.updatedAt));

  return tasks;
}

var memoizedRecentTasks = memo2((
  BuiltMap<String, TaskEntity> taskMap,
  BuiltMap<String, ClientEntity> clientMap,
) =>
    _recentTasks(
      taskMap: taskMap,
      clientMap: clientMap,
    ));

List<TaskEntity> _recentTasks({
  required BuiltMap<String, TaskEntity> taskMap,
  required BuiltMap<String, ClientEntity> clientMap,
}) {
  final tasks = <TaskEntity>[];
  taskMap.forEach((index, task) {
    final client = clientMap[task.clientId] ?? ClientEntity(id: task.clientId);
    if (task.isNotActive || client.isNotActive) {
      // do noting
    } else if (!task.isRunning) {
      tasks.add(task);
    }
  });

  tasks.sort((taskA, taskB) => taskB.updatedAt.compareTo(taskA.updatedAt));

  return tasks;
}

/*
var memoizedUpcomingExpenses = memo2((
  BuiltMap<String, ExpenseEntity> expenseMap,
  BuiltMap<String, ClientEntity> clientMap,
) =>
    _upcomingExpenses(
      expenseMap: expenseMap,
      clientMap: clientMap,
    ));

List<ExpenseEntity> _upcomingExpenses({
  BuiltMap<String, ExpenseEntity> expenseMap,
  BuiltMap<String, ClientEntity> clientMap,
}) {
  final expenses = <ExpenseEntity>[];
  expenseMap.forEach((index, expense) {
    final client =
        expenseMap[expense.clientId] ?? ClientEntity(id: expense.clientId);
    if (expense.isNotActive || client.isNotActive) {
      // do noting
    } else if (expense.isUpcoming) {
      expenses.add(expense);
    }
  });

  expenses.sort((expenseA, expenseB) =>
      (expenseA.date ?? '').compareTo(expenseB.date ?? ''));

  return expenses;
}
*/

var memoizedRecentExpenses = memo2((
  BuiltMap<String, ExpenseEntity> expenseMap,
  BuiltMap<String, ClientEntity> clientMap,
) =>
    _recentExpenses(
      expenseMap: expenseMap,
      clientMap: clientMap,
    ));

List<ExpenseEntity?> _recentExpenses({
  required BuiltMap<String, ExpenseEntity> expenseMap,
  BuiltMap<String, ClientEntity>? clientMap,
}) {
  final expenses = <ExpenseEntity?>[];
  expenseMap.forEach((index, expense) {
    final client =
        clientMap![expense.clientId] ?? ClientEntity(id: expense.clientId);
    if (client.isNotActive || expense.isNotActive || expense.isInvoiced) {
      // do noting
    } else {
      expenses.add(expense);
    }
  });

  expenses.sort((expenseA, expenseB) {
    final expenseAdate = expenseA!.date ?? '';
    final expenseBdate = expenseB!.date ?? '';

    if (expenseAdate == expenseBdate) {
      return expenseB.number.compareTo(expenseA.number);
    } else {
      return expenseBdate.compareTo(expenseAdate);
    }
  });

  return expenses;
}
