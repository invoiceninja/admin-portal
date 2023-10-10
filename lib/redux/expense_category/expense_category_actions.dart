// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ViewExpenseCategoryList implements PersistUI {
  ViewExpenseCategoryList({
    this.force = false,
  });

  final bool force;
}

class ViewExpenseCategory implements PersistUI, PersistPrefs {
  ViewExpenseCategory({
    required this.expenseCategoryId,
    this.force = false,
  });

  final String? expenseCategoryId;
  final bool force;
}

class EditExpenseCategory implements PersistUI, PersistPrefs {
  EditExpenseCategory(
      {required this.expenseCategory,
      this.completer,
      this.cancelCompleter,
      this.force = false});

  final ExpenseCategoryEntity expenseCategory;
  final Completer? completer;
  final Completer? cancelCompleter;
  final bool force;
}

class UpdateExpenseCategory implements PersistUI {
  UpdateExpenseCategory(this.expenseCategory);

  final ExpenseCategoryEntity expenseCategory;
}

class LoadExpenseCategory {
  LoadExpenseCategory({this.completer, this.expenseCategoryId});

  final Completer? completer;
  final String? expenseCategoryId;
}

class LoadExpenseCategoryActivity {
  LoadExpenseCategoryActivity({this.completer, this.expenseCategoryId});

  final Completer? completer;
  final String? expenseCategoryId;
}

class LoadExpenseCategories {
  LoadExpenseCategories({this.completer});

  final Completer? completer;
}

class LoadExpenseCategoryRequest implements StartLoading {}

class LoadExpenseCategoryFailure implements StopLoading {
  LoadExpenseCategoryFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadExpenseCategoryFailure{error: $error}';
  }
}

class LoadExpenseCategorySuccess implements StopLoading, PersistData {
  LoadExpenseCategorySuccess(this.expenseCategory);

  final ExpenseCategoryEntity expenseCategory;

  @override
  String toString() {
    return 'LoadExpenseCategorySuccess{expenseCategory: $expenseCategory}';
  }
}

class LoadExpenseCategoriesRequest implements StartLoading {}

class LoadExpenseCategoriesFailure implements StopLoading {
  LoadExpenseCategoriesFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadExpenseCategoriesFailure{error: $error}';
  }
}

class LoadExpenseCategoriesSuccess implements StopLoading {
  LoadExpenseCategoriesSuccess(this.expenseCategories);

  final BuiltList<ExpenseCategoryEntity> expenseCategories;

  @override
  String toString() {
    return 'LoadExpenseCategoriesSuccess{expenseCategories: $expenseCategories}';
  }
}

class SaveExpenseCategoryRequest implements StartSaving {
  SaveExpenseCategoryRequest({this.completer, this.expenseCategory});

  final Completer? completer;
  final ExpenseCategoryEntity? expenseCategory;
}

class SaveExpenseCategorySuccess implements StopSaving, PersistData, PersistUI {
  SaveExpenseCategorySuccess(this.expenseCategory);

  final ExpenseCategoryEntity expenseCategory;
}

class AddExpenseCategorySuccess implements StopSaving, PersistData, PersistUI {
  AddExpenseCategorySuccess(this.expenseCategory);

  final ExpenseCategoryEntity expenseCategory;
}

class SaveExpenseCategoryFailure implements StopSaving {
  SaveExpenseCategoryFailure(this.error);

  final Object error;
}

class ArchiveExpenseCategoriesRequest implements StartSaving {
  ArchiveExpenseCategoriesRequest(this.completer, this.expenseCategoryIds);

  final Completer completer;
  final List<String> expenseCategoryIds;
}

class ArchiveExpenseCategoriesSuccess implements StopSaving, PersistData {
  ArchiveExpenseCategoriesSuccess(this.expenseCategories);

  final List<ExpenseCategoryEntity> expenseCategories;
}

class ArchiveExpenseCategoriesFailure implements StopSaving {
  ArchiveExpenseCategoriesFailure(this.expenseCategories);

  final List<ExpenseCategoryEntity?> expenseCategories;
}

class DeleteExpenseCategoriesRequest implements StartSaving {
  DeleteExpenseCategoriesRequest(this.completer, this.expenseCategoryIds);

  final Completer completer;
  final List<String> expenseCategoryIds;
}

class DeleteExpenseCategoriesSuccess implements StopSaving, PersistData {
  DeleteExpenseCategoriesSuccess(this.expenseCategories);

  final List<ExpenseCategoryEntity> expenseCategories;
}

class DeleteExpenseCategoriesFailure implements StopSaving {
  DeleteExpenseCategoriesFailure(this.expenseCategories);

  final List<ExpenseCategoryEntity?> expenseCategories;
}

class RestoreExpenseCategoriesRequest implements StartSaving {
  RestoreExpenseCategoriesRequest(this.completer, this.expenseCategoryIds);

  final Completer completer;
  final List<String> expenseCategoryIds;
}

class RestoreExpenseCategoriesSuccess implements StopSaving, PersistData {
  RestoreExpenseCategoriesSuccess(this.expenseCategories);

  final List<ExpenseCategoryEntity> expenseCategories;
}

class RestoreExpenseCategoriesFailure implements StopSaving {
  RestoreExpenseCategoriesFailure(this.expenseCategories);

  final List<ExpenseCategoryEntity?> expenseCategories;
}

class FilterExpenseCategories implements PersistUI {
  FilterExpenseCategories(this.filter);

  final String? filter;
}

class SortExpenseCategories implements PersistUI, PersistPrefs {
  SortExpenseCategories(this.field);

  final String field;
}

class FilterExpenseCategoriesByState implements PersistUI {
  FilterExpenseCategoriesByState(this.state);

  final EntityState state;
}

class FilterExpenseCategoriesByCustom1 implements PersistUI {
  FilterExpenseCategoriesByCustom1(this.value);

  final String value;
}

class FilterExpenseCategoriesByCustom2 implements PersistUI {
  FilterExpenseCategoriesByCustom2(this.value);

  final String value;
}

class FilterExpenseCategoriesByCustom3 implements PersistUI {
  FilterExpenseCategoriesByCustom3(this.value);

  final String value;
}

class FilterExpenseCategoriesByCustom4 implements PersistUI {
  FilterExpenseCategoriesByCustom4(this.value);

  final String value;
}

class StartExpenseCategoryMultiselect {
  StartExpenseCategoryMultiselect();
}

class AddToExpenseCategoryMultiselect {
  AddToExpenseCategoryMultiselect({required this.entity});

  final BaseEntity? entity;
}

class RemoveFromExpenseCategoryMultiselect {
  RemoveFromExpenseCategoryMultiselect({required this.entity});

  final BaseEntity? entity;
}

class ClearExpenseCategoryMultiselect {
  ClearExpenseCategoryMultiselect();
}

void handleExpenseCategoryAction(BuildContext? context,
    List<BaseEntity> expenseCategories, EntityAction? action) {
  if (expenseCategories.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context!);
  final state = store.state;
  final localization = AppLocalization.of(context);
  final expenseCategory = expenseCategories.first as ExpenseCategoryEntity;
  final expenseCategoryIds =
      expenseCategories.map((expenseCategory) => expenseCategory.id).toList();

  switch (action) {
    case EntityAction.edit:
      editEntity(entity: expenseCategory);
      break;
    case EntityAction.restore:
      final message = expenseCategoryIds.length > 1
          ? localization!.restoredExpenseCategories
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', expenseCategoryIds.length.toString())
          : localization!.restoredExpenseCategory;
      store.dispatch(RestoreExpenseCategoriesRequest(
          snackBarCompleter<Null>(message), expenseCategoryIds));
      break;
    case EntityAction.archive:
      final message = expenseCategoryIds.length > 1
          ? localization!.archivedExpenseCategories
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', expenseCategoryIds.length.toString())
          : localization!.archivedExpenseCategory;
      store.dispatch(ArchiveExpenseCategoriesRequest(
          snackBarCompleter<Null>(message), expenseCategoryIds));
      break;
    case EntityAction.delete:
      final message = expenseCategoryIds.length > 1
          ? localization!.deletedExpenseCategories
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', expenseCategoryIds.length.toString())
          : localization!.deletedExpenseCategory;
      store.dispatch(DeleteExpenseCategoriesRequest(
          snackBarCompleter<Null>(message), expenseCategoryIds));
      break;
    case EntityAction.newExpense:
      createEntity(
        entity: ExpenseEntity(state: state)
            .rebuild((b) => b..categoryId = expenseCategory.id),
      );
      break;
    case EntityAction.newTransaction:
      createEntity(
        entity: TransactionEntity(state: state)
            .rebuild((b) => b..categoryId = expenseCategory.id),
      );
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.expenseCategoryListState.isInMultiselect()) {
        store.dispatch(StartExpenseCategoryMultiselect());
      }

      if (expenseCategories.isEmpty) {
        break;
      }

      for (final expenseCategory in expenseCategories) {
        if (!store.state.expenseCategoryListState
            .isSelected(expenseCategory.id)) {
          store.dispatch(
              AddToExpenseCategoryMultiselect(entity: expenseCategory));
        } else {
          store.dispatch(
              RemoveFromExpenseCategoryMultiselect(entity: expenseCategory));
        }
      }
      break;
    case EntityAction.more:
      showEntityActionsDialog(
        entities: [expenseCategory],
      );
      break;
    default:
      print('## ERROR: unhandled action $action in expense_category_actions');
      break;
  }
}
