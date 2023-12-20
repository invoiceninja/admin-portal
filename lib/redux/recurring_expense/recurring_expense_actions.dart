// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ViewRecurringExpenseList implements PersistUI {
  ViewRecurringExpenseList({
    this.force = false,
    this.page = 0,
  });

  final bool force;
  final int? page;
}

class ViewRecurringExpense implements PersistUI, PersistPrefs {
  ViewRecurringExpense({
    required this.recurringExpenseId,
    this.force = false,
  });

  final String? recurringExpenseId;
  final bool force;
}

class EditRecurringExpense implements PersistUI, PersistPrefs {
  EditRecurringExpense(
      {required this.recurringExpense,
      this.completer,
      this.cancelCompleter,
      this.force = false});

  final ExpenseEntity recurringExpense;
  final Completer? completer;
  final Completer? cancelCompleter;
  final bool force;
}

class UpdateRecurringExpense implements PersistUI {
  UpdateRecurringExpense(this.recurringExpense);

  final ExpenseEntity recurringExpense;
}

class LoadRecurringExpense {
  LoadRecurringExpense({this.completer, this.recurringExpenseId});

  final Completer? completer;
  final String? recurringExpenseId;
}

class LoadRecurringExpenseActivity {
  LoadRecurringExpenseActivity({this.completer, this.recurringExpenseId});

  final Completer? completer;
  final String? recurringExpenseId;
}

class LoadRecurringExpenses {
  LoadRecurringExpenses({this.completer});

  final Completer? completer;
}

class LoadRecurringExpenseRequest implements StartLoading {}

class LoadRecurringExpenseFailure implements StopLoading {
  LoadRecurringExpenseFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadRecurringExpenseFailure{error: $error}';
  }
}

class LoadRecurringExpenseSuccess implements StopLoading, PersistData {
  LoadRecurringExpenseSuccess(this.recurringExpense);

  final ExpenseEntity recurringExpense;

  @override
  String toString() {
    return 'LoadRecurringExpenseSuccess{recurringExpense: $recurringExpense}';
  }
}

class LoadRecurringExpensesRequest implements StartLoading {}

class LoadRecurringExpensesFailure implements StopLoading {
  LoadRecurringExpensesFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadRecurringExpensesFailure{error: $error}';
  }
}

class LoadRecurringExpensesSuccess implements StopLoading {
  LoadRecurringExpensesSuccess(this.recurringExpenses);

  final BuiltList<ExpenseEntity> recurringExpenses;

  @override
  String toString() {
    return 'LoadRecurringExpensesSuccess{recurringExpenses: $recurringExpenses}';
  }
}

class SaveRecurringExpenseRequest implements StartSaving {
  SaveRecurringExpenseRequest({
    this.completer,
    this.recurringExpense,
    this.action,
  });

  final Completer? completer;
  final ExpenseEntity? recurringExpense;
  final EntityAction? action;
}

class SaveRecurringExpenseSuccess
    implements StopSaving, PersistData, PersistUI {
  SaveRecurringExpenseSuccess(this.recurringExpense);

  final ExpenseEntity recurringExpense;
}

class AddRecurringExpenseSuccess implements StopSaving, PersistData, PersistUI {
  AddRecurringExpenseSuccess(this.recurringExpense);

  final ExpenseEntity recurringExpense;
}

class SaveRecurringExpenseFailure implements StopSaving {
  SaveRecurringExpenseFailure(this.error);

  final Object error;
}

class ArchiveRecurringExpensesRequest implements StartSaving {
  ArchiveRecurringExpensesRequest(this.completer, this.recurringExpenseIds);

  final Completer completer;
  final List<String> recurringExpenseIds;
}

class ArchiveRecurringExpensesSuccess implements StopSaving, PersistData {
  ArchiveRecurringExpensesSuccess(this.recurringExpenses);

  final List<ExpenseEntity> recurringExpenses;
}

class ArchiveRecurringExpensesFailure implements StopSaving {
  ArchiveRecurringExpensesFailure(this.recurringExpenses);

  final List<ExpenseEntity?> recurringExpenses;
}

class DeleteRecurringExpensesRequest implements StartSaving {
  DeleteRecurringExpensesRequest(this.completer, this.recurringExpenseIds);

  final Completer completer;
  final List<String> recurringExpenseIds;
}

class DeleteRecurringExpensesSuccess implements StopSaving, PersistData {
  DeleteRecurringExpensesSuccess(this.recurringExpenses);

  final List<ExpenseEntity> recurringExpenses;
}

class DeleteRecurringExpensesFailure implements StopSaving {
  DeleteRecurringExpensesFailure(this.recurringExpenses);

  final List<ExpenseEntity?> recurringExpenses;
}

class RestoreRecurringExpensesRequest implements StartSaving {
  RestoreRecurringExpensesRequest(this.completer, this.recurringExpenseIds);

  final Completer completer;
  final List<String> recurringExpenseIds;
}

class RestoreRecurringExpensesSuccess implements StopSaving, PersistData {
  RestoreRecurringExpensesSuccess(this.recurringExpenses);

  final List<ExpenseEntity> recurringExpenses;
}

class RestoreRecurringExpensesFailure implements StopSaving {
  RestoreRecurringExpensesFailure(this.recurringExpenses);

  final List<ExpenseEntity?> recurringExpenses;
}

class FilterRecurringExpenses implements PersistUI {
  FilterRecurringExpenses(this.filter);

  final String? filter;
}

class SortRecurringExpenses implements PersistUI, PersistPrefs {
  SortRecurringExpenses(this.field);

  final String field;
}

class FilterRecurringExpensesByState implements PersistUI {
  FilterRecurringExpensesByState(this.state);

  final EntityState state;
}

class FilterRecurringExpensesByStatus implements PersistUI {
  FilterRecurringExpensesByStatus(this.status);

  final EntityStatus status;
}

class FilterRecurringExpensesByCustom1 implements PersistUI {
  FilterRecurringExpensesByCustom1(this.value);

  final String value;
}

class FilterRecurringExpensesByCustom2 implements PersistUI {
  FilterRecurringExpensesByCustom2(this.value);

  final String value;
}

class FilterRecurringExpensesByCustom3 implements PersistUI {
  FilterRecurringExpensesByCustom3(this.value);

  final String value;
}

class FilterRecurringExpensesByCustom4 implements PersistUI {
  FilterRecurringExpensesByCustom4(this.value);

  final String value;
}

class StartRecurringExpenseMultiselect {
  StartRecurringExpenseMultiselect();
}

class AddToRecurringExpenseMultiselect {
  AddToRecurringExpenseMultiselect({required this.entity});

  final BaseEntity? entity;
}

class RemoveFromRecurringExpenseMultiselect {
  RemoveFromRecurringExpenseMultiselect({required this.entity});

  final BaseEntity? entity;
}

class ClearRecurringExpenseMultiselect {
  ClearRecurringExpenseMultiselect();
}

class UpdateRecurringExpenseTab implements PersistUI {
  UpdateRecurringExpenseTab({this.tabIndex});

  final int? tabIndex;
}

class StartRecurringExpensesRequest implements StartSaving {
  StartRecurringExpensesRequest({this.completer, this.expenseIds});

  final Completer? completer;
  final List<String>? expenseIds;
}

class StartRecurringExpensesSuccess
    implements StopSaving, PersistData, PersistUI {
  StartRecurringExpensesSuccess(this.expenses);

  final List<ExpenseEntity> expenses;
}

class StartRecurringExpensesFailure implements StopSaving {
  StartRecurringExpensesFailure(this.error);

  final Object error;
}

class StopRecurringExpensesRequest implements StartSaving {
  StopRecurringExpensesRequest({this.completer, this.expenseIds});

  final Completer? completer;
  final List<String>? expenseIds;
}

class StopRecurringExpensesSuccess
    implements StopSaving, PersistData, PersistUI {
  StopRecurringExpensesSuccess(this.expenses);

  final List<ExpenseEntity> expenses;
}

class StopRecurringExpensesFailure implements StopSaving {
  StopRecurringExpensesFailure(this.error);

  final Object error;
}

class SaveRecurringExpenseDocumentRequest implements StartSaving {
  SaveRecurringExpenseDocumentRequest({
    required this.isPrivate,
    required this.completer,
    required this.multipartFile,
    required this.expense,
  });

  final bool isPrivate;
  final Completer completer;
  final List<MultipartFile> multipartFile;
  final ExpenseEntity expense;
}

class SaveRecurringExpenseDocumentSuccess
    implements StopSaving, PersistData, PersistUI {
  SaveRecurringExpenseDocumentSuccess(this.document);

  final DocumentEntity document;
}

class SaveRecurringExpenseDocumentFailure implements StopSaving {
  SaveRecurringExpenseDocumentFailure(this.error);

  final Object error;
}

void handleRecurringExpenseAction(BuildContext? context,
    List<BaseEntity> recurringExpenses, EntityAction? action) {
  if (recurringExpenses.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context!);
  final localization = AppLocalization.of(context);
  final recurringExpense = recurringExpenses.first as ExpenseEntity;
  final recurringExpenseIds =
      recurringExpenses.map((recurringExpense) => recurringExpense.id).toList();

  switch (action) {
    case EntityAction.edit:
      editEntity(entity: recurringExpense);
      break;
    case EntityAction.restore:
      store.dispatch(RestoreRecurringExpensesRequest(
          snackBarCompleter<Null>(localization!.restoredRecurringExpense),
          recurringExpenseIds));
      break;
    case EntityAction.archive:
      store.dispatch(ArchiveRecurringExpensesRequest(
          snackBarCompleter<Null>(localization!.archivedRecurringExpense),
          recurringExpenseIds));
      break;
    case EntityAction.delete:
      store.dispatch(DeleteRecurringExpensesRequest(
          snackBarCompleter<Null>(localization!.deletedRecurringExpense),
          recurringExpenseIds));
      break;
    case EntityAction.start:
      store.dispatch(StartRecurringExpensesRequest(
        completer: snackBarCompleter<Null>(recurringExpense.lastSentDate.isEmpty
            ? localization!.startedRecurringInvoice
            : localization!.resumedRecurringInvoice),
        expenseIds: recurringExpenseIds,
      ));
      break;
    case EntityAction.stop:
      store.dispatch(StopRecurringExpensesRequest(
        completer:
            snackBarCompleter<Null>(localization!.stoppedRecurringInvoice),
        expenseIds: recurringExpenseIds,
      ));
      break;
    case EntityAction.cloneToExpense:
      createEntity(
        entity: recurringExpense.clone
            .rebuild((b) => b..entityType = EntityType.expense),
      );
      break;
    case EntityAction.clone:
    case EntityAction.cloneToRecurring:
      createEntity(
        entity: recurringExpense.clone
            .rebuild((b) => b..entityType = EntityType.recurringExpense),
      );
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.recurringExpenseListState.isInMultiselect()) {
        store.dispatch(StartRecurringExpenseMultiselect());
      }

      if (recurringExpenses.isEmpty) {
        break;
      }

      for (final recurringExpense in recurringExpenses) {
        if (!store.state.recurringExpenseListState
            .isSelected(recurringExpense.id)) {
          store.dispatch(
              AddToRecurringExpenseMultiselect(entity: recurringExpense));
        } else {
          store.dispatch(
              RemoveFromRecurringExpenseMultiselect(entity: recurringExpense));
        }
      }
      break;
    case EntityAction.more:
      showEntityActionsDialog(
        entities: [recurringExpense],
      );
      break;
    case EntityAction.documents:
      final documentIds = <String>[];
      for (var expense in recurringExpenses) {
        for (var document in (expense as ExpenseEntity).documents) {
          documentIds.add(document.id);
        }
      }
      if (documentIds.isEmpty) {
        showMessageDialog(message: localization!.noDocumentsToDownload);
      } else {
        store.dispatch(
          DownloadDocumentsRequest(
            documentIds: documentIds,
            completer: snackBarCompleter<Null>(
              localization!.exportedData,
            ),
          ),
        );
      }
      break;
    default:
      print('## ERROR: unhandled action $action in recurring_expense_actions');
      break;
  }
}
