import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_selectors.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ViewExpenseList implements PersistUI {
  ViewExpenseList({@required this.context, this.force = false});

  final BuildContext context;
  final bool force;
}

class ViewExpense implements PersistUI {
  ViewExpense({
    @required this.expenseId,
    @required this.context,
    this.force = false,
  });

  final String expenseId;
  final BuildContext context;
  final bool force;
}

class EditExpense implements PersistUI {
  EditExpense(
      {@required this.expense,
      @required this.context,
      this.completer,
      this.force = false});

  final ExpenseEntity expense;
  final BuildContext context;
  final Completer completer;
  final bool force;
}

class UpdateExpense implements PersistUI {
  UpdateExpense(this.expense);

  final ExpenseEntity expense;
}

class LoadExpense {
  LoadExpense({this.completer, this.expenseId, this.loadActivities = false});

  final Completer completer;
  final String expenseId;
  final bool loadActivities;
}

class LoadExpenseActivity {
  LoadExpenseActivity({this.completer, this.expenseId});

  final Completer completer;
  final String expenseId;
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
  ArchiveExpenseRequest(this.completer, this.expenseIds);

  final Completer completer;
  final List<String> expenseIds;
}

class ArchiveExpenseSuccess implements StopSaving, PersistData {
  ArchiveExpenseSuccess(this.expenses);

  final List<ExpenseEntity> expenses;
}

class ArchiveExpenseFailure implements StopSaving {
  ArchiveExpenseFailure(this.expenses);

  final List<ExpenseEntity> expenses;
}

class DeleteExpenseRequest implements StartSaving {
  DeleteExpenseRequest(this.completer, this.expenseIds);

  final Completer completer;
  final List<String> expenseIds;
}

class DeleteExpenseSuccess implements StopSaving, PersistData {
  DeleteExpenseSuccess(this.expenses);

  final List<ExpenseEntity> expenses;
}

class DeleteExpenseFailure implements StopSaving {
  DeleteExpenseFailure(this.expenses);

  final List<ExpenseEntity> expenses;
}

class RestoreExpenseRequest implements StartSaving {
  RestoreExpenseRequest(this.completer, this.expenseIds);

  final Completer completer;
  final List<String> expenseIds;
}

class RestoreExpenseSuccess implements StopSaving, PersistData {
  RestoreExpenseSuccess(this.expenses);

  final List<ExpenseEntity> expenses;
}

class RestoreExpenseFailure implements StopSaving {
  RestoreExpenseFailure(this.expenses);

  final List<ExpenseEntity> expenses;
}

class FilterExpenses implements PersistUI {
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

  final String entityId;
  final EntityType entityType;
}

void handleExpenseAction(
    BuildContext context, List<BaseEntity> expenses, EntityAction action) {
  assert(
      [
            EntityAction.restore,
            EntityAction.archive,
            EntityAction.delete,
            EntityAction.toggleMultiselect
          ].contains(action) ||
          expenses.length == 1,
      'Cannot perform this action on more than one expense');

  final store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final CompanyEntity company = state.company;
  final localization = AppLocalization.of(context);
  final expense = expenses.first as ExpenseEntity;
  final expenseIds = expenses.map((expense) => expense.id).toList();

  switch (action) {
    case EntityAction.edit:
      store.dispatch(EditExpense(context: context, expense: expense));
      break;
    case EntityAction.clone:
      store.dispatch(EditExpense(context: context, expense: expense.clone));
      break;
    case EntityAction.newInvoice:
      final item = convertExpenseToInvoiceItem(
          expense: expense, categoryMap: company.expenseCategoryMap);
      store.dispatch(EditInvoice(
          invoice: InvoiceEntity(company: company).rebuild((b) => b
            ..hasExpenses = true
            ..clientId = expense.clientId
            ..lineItems.add(item)),
          context: context));
      break;
    case EntityAction.viewInvoice:
      store.dispatch(
          ViewInvoice(invoiceId: expense.invoiceId, context: context));
      break;
    case EntityAction.restore:
      store.dispatch(RestoreExpenseRequest(
          snackBarCompleter<Null>(context, localization.restoredExpense),
          expenseIds));
      break;
    case EntityAction.archive:
      store.dispatch(ArchiveExpenseRequest(
          snackBarCompleter<Null>(context, localization.archivedExpense),
          expenseIds));
      break;
    case EntityAction.delete:
      store.dispatch(DeleteExpenseRequest(
          snackBarCompleter<Null>(context, localization.deletedExpense), expenseIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.expenseListState.isInMultiselect()) {
        store.dispatch(StartExpenseMultiselect(context: context));
      }

      if (expenses.isEmpty) {
        break;
      }

      for (final expense in expenses) {
        if (!store.state.expenseListState.isSelected(expense.id)) {
          store.dispatch(
              AddToExpenseMultiselect(context: context, entity: expense));
        } else {
          store.dispatch(
              RemoveFromExpenseMultiselect(context: context, entity: expense));
        }
      }
      break;
  }
}

class StartExpenseMultiselect {
  StartExpenseMultiselect({@required this.context});

  final BuildContext context;
}

class AddToExpenseMultiselect {
  AddToExpenseMultiselect({@required this.context, @required this.entity});

  final BuildContext context;
  final BaseEntity entity;
}

class RemoveFromExpenseMultiselect {
  RemoveFromExpenseMultiselect({@required this.context, @required this.entity});

  final BuildContext context;
  final BaseEntity entity;
}

class ClearExpenseMultiselect {
  ClearExpenseMultiselect({@required this.context});

  final BuildContext context;
}
