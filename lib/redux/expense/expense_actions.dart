import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';

class ViewExpenseList implements PersistUI {
  ViewExpenseList(this.context);

  final BuildContext context;
}

class ViewExpense implements PersistUI {
  ViewExpense({this.expenseId, this.context});

  final int expenseId;
  final BuildContext context;
}

class EditExpense implements PersistUI {
  EditExpense(
      {this.expense, this.context, this.completer, this.trackRoute = true});

  final ExpenseEntity expense;
  final BuildContext context;
  final Completer completer;
  final bool trackRoute;
}

class UpdateExpense implements PersistUI {
  UpdateExpense(this.expense);

  final ExpenseEntity expense;
}

class LoadExpense {
  LoadExpense({this.completer, this.expenseId, this.loadActivities = false});

  final Completer completer;
  final int expenseId;
  final bool loadActivities;
}

class LoadExpenseActivity {
  LoadExpenseActivity({this.completer, this.expenseId});

  final Completer completer;
  final int expenseId;
}

class LoadExpenses {
  LoadExpenses({this.completer, this.force = false});

  final Completer completer;
  final bool force;
}

class LoadExpenseRequest implements StartLoading {}

class LoadExpenseFailure implements StopLoading {
  LoadExpenseFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadExpenseFailure{error: $error}';
  }
}

class LoadExpenseSuccess implements StopLoading, PersistData {
  LoadExpenseSuccess(this.expense);

  final ExpenseEntity expense;

  @override
  String toString() {
    return 'LoadExpenseSuccess{expense: $expense}';
  }
}

class LoadExpensesRequest implements StartLoading {}

class LoadExpensesFailure implements StopLoading {
  LoadExpensesFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadExpensesFailure{error: $error}';
  }
}

class LoadExpensesSuccess implements StopLoading, PersistData {
  LoadExpensesSuccess(this.expenses);

  final BuiltList<ExpenseEntity> expenses;

  @override
  String toString() {
    return 'LoadExpensesSuccess{expenses: $expenses}';
  }
}

class SaveExpenseRequest implements StartSaving {
  SaveExpenseRequest({this.completer, this.expense});

  final Completer completer;
  final ExpenseEntity expense;
}

class SaveExpenseSuccess implements StopSaving, PersistData, PersistUI {
  SaveExpenseSuccess(this.expense);

  final ExpenseEntity expense;
}

class AddExpenseSuccess implements StopSaving, PersistData, PersistUI {
  AddExpenseSuccess(this.expense);

  final ExpenseEntity expense;
}

class SaveExpenseFailure implements StopSaving {
  SaveExpenseFailure(this.error);

  final Object error;
}

class ArchiveExpenseRequest implements StartSaving {
  ArchiveExpenseRequest(this.completer, this.expenseId);

  final Completer completer;
  final int expenseId;
}

class ArchiveExpenseSuccess implements StopSaving, PersistData {
  ArchiveExpenseSuccess(this.expense);

  final ExpenseEntity expense;
}

class ArchiveExpenseFailure implements StopSaving {
  ArchiveExpenseFailure(this.expense);

  final ExpenseEntity expense;
}

class DeleteExpenseRequest implements StartSaving {
  DeleteExpenseRequest(this.completer, this.expenseId);

  final Completer completer;
  final int expenseId;
}

class DeleteExpenseSuccess implements StopSaving, PersistData {
  DeleteExpenseSuccess(this.expense);

  final ExpenseEntity expense;
}

class DeleteExpenseFailure implements StopSaving {
  DeleteExpenseFailure(this.expense);

  final ExpenseEntity expense;
}

class RestoreExpenseRequest implements StartSaving {
  RestoreExpenseRequest(this.completer, this.expenseId);

  final Completer completer;
  final int expenseId;
}

class RestoreExpenseSuccess implements StopSaving, PersistData {
  RestoreExpenseSuccess(this.expense);

  final ExpenseEntity expense;
}

class RestoreExpenseFailure implements StopSaving {
  RestoreExpenseFailure(this.expense);

  final ExpenseEntity expense;
}

class FilterExpenses {
  FilterExpenses(this.filter);

  final String filter;
}

class SortExpenses implements PersistUI {
  SortExpenses(this.field);

  final String field;
}

class FilterExpensesByState implements PersistUI {
  FilterExpensesByState(this.state);

  final EntityState state;
}

class FilterExpensesByStatus implements PersistUI {
  FilterExpensesByStatus(this.status);

  final ExpenseStatusEntity status;
}

class FilterExpensesByCustom1 implements PersistUI {
  FilterExpensesByCustom1(this.value);

  final String value;
}

class FilterExpensesByCustom2 implements PersistUI {
  FilterExpensesByCustom2(this.value);

  final String value;
}

class FilterExpensesByEntity implements PersistUI {
  FilterExpensesByEntity({this.entityId, this.entityType});

  final int entityId;
  final EntityType entityType;
}
