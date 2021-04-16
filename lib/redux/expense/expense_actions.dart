import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ViewExpenseList implements PersistUI, StopLoading {
  ViewExpenseList({this.force = false});

  final bool force;
}

class ViewExpense implements PersistUI, PersistPrefs {
  ViewExpense({
    @required this.expenseId,
    this.force = false,
  });

  final String expenseId;
  final bool force;
}

class EditExpense implements PersistUI, PersistPrefs {
  EditExpense({@required this.expense, this.completer, this.force = false});

  final ExpenseEntity expense;
  final Completer completer;
  final bool force;
}

class UpdateExpense implements PersistUI {
  UpdateExpense(this.expense);

  final ExpenseEntity expense;
}

class LoadExpense {
  LoadExpense({this.completer, this.expenseId});

  final Completer completer;
  final String expenseId;
}

class LoadExpenseActivity {
  LoadExpenseActivity({this.completer, this.expenseId});

  final Completer completer;
  final String expenseId;
}

class LoadExpenses {
  LoadExpenses({this.completer});

  final Completer completer;
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

class LoadExpensesSuccess implements StopLoading {
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

class FilterExpensesByCustom3 implements PersistUI {
  FilterExpensesByCustom3(this.value);

  final String value;
}

class FilterExpensesByCustom4 implements PersistUI {
  FilterExpensesByCustom4(this.value);

  final String value;
}

void handleExpenseAction(
    BuildContext context, List<BaseEntity> expenses, EntityAction action) {
  final store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final CompanyEntity company = state.company;
  final localization = AppLocalization.of(context);
  final expense = expenses.first as ExpenseEntity;
  final expenseIds = expenses.map((expense) => expense.id).toList();
  final client = state.clientState.get(expense.clientId);

  switch (action) {
    case EntityAction.edit:
      editEntity(context: context, entity: expense);
      break;
    case EntityAction.clone:
      createEntity(context: context, entity: expense.clone);
      break;
    case EntityAction.invoiceExpense:
      final items = expenses
          .where((entity) {
            final expense = entity as ExpenseEntity;
            return !expense.isDeleted && !expense.isInvoiced;
          })
          .map((expense) => convertExpenseToInvoiceItem(
                expense: expense,
                categoryMap: state.expenseCategoryState.map,
                company: company,
              ))
          .toList();
      if (items.isNotEmpty) {
        createEntity(
            context: context,
            entity: InvoiceEntity(state: state, client: client)
                .rebuild((b) => b..lineItems.addAll(items)));
      }
      break;
    case EntityAction.restore:
      final message = expenseIds.length > 1
          ? localization.restoredExpenses
              .replaceFirst(':value', expenseIds.length.toString())
          : localization.restoredExpense;
      store.dispatch(RestoreExpenseRequest(
          snackBarCompleter<Null>(context, message), expenseIds));
      break;
    case EntityAction.archive:
      final message = expenseIds.length > 1
          ? localization.archivedExpenses
              .replaceFirst(':value', expenseIds.length.toString())
          : localization.archivedExpense;
      store.dispatch(ArchiveExpenseRequest(
          snackBarCompleter<Null>(context, message), expenseIds));
      break;
    case EntityAction.delete:
      final message = expenseIds.length > 1
          ? localization.deletedExpenses
              .replaceFirst(':value', expenseIds.length.toString())
          : localization.deletedExpense;
      store.dispatch(DeleteExpenseRequest(
          snackBarCompleter<Null>(context, message), expenseIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.expenseListState.isInMultiselect()) {
        store.dispatch(StartExpenseMultiselect());
      }

      if (expenses.isEmpty) {
        break;
      }

      for (final expense in expenses) {
        if (!store.state.expenseListState.isSelected(expense.id)) {
          store.dispatch(AddToExpenseMultiselect(entity: expense));
        } else {
          store.dispatch(RemoveFromExpenseMultiselect(entity: expense));
        }
      }
      break;
    case EntityAction.more:
      showEntityActionsDialog(
        entities: [expense],
        context: context,
      );
      break;
  }
}

class StartExpenseMultiselect {}

class AddToExpenseMultiselect {
  AddToExpenseMultiselect({@required this.entity});

  final BaseEntity entity;
}

class RemoveFromExpenseMultiselect {
  RemoveFromExpenseMultiselect({@required this.entity});

  final BaseEntity entity;
}

class ClearExpenseMultiselect {}

class SaveExpenseDocumentRequest implements StartSaving {
  SaveExpenseDocumentRequest({
    @required this.completer,
    @required this.multipartFile,
    @required this.expense,
  });

  final Completer completer;
  final MultipartFile multipartFile;
  final ExpenseEntity expense;
}

class SaveExpenseDocumentSuccess implements StopSaving, PersistData, PersistUI {
  SaveExpenseDocumentSuccess(this.document);

  final DocumentEntity document;
}

class SaveExpenseDocumentFailure implements StopSaving {
  SaveExpenseDocumentFailure(this.error);

  final Object error;
}

class UpdateExpenseTab implements PersistUI {
  UpdateExpenseTab({this.tabIndex});

  final int tabIndex;
}
