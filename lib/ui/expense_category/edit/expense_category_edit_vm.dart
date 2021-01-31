import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/expense_category/view/expense_category_view_vm.dart';
import 'package:invoiceninja_flutter/redux/expense_category/expense_category_actions.dart';
import 'package:invoiceninja_flutter/ui/expense_category/edit/expense_category_edit.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class ExpenseCategoryEditScreen extends StatelessWidget {
  const ExpenseCategoryEditScreen({Key key}) : super(key: key);

  static const String route = '/$kSettings/$kSettingsExpenseCategoryEdit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ExpenseCategoryEditVM>(
      converter: (Store<AppState> store) {
        return ExpenseCategoryEditVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return ExpenseCategoryEdit(
          viewModel: viewModel,
          key: ValueKey(viewModel.expenseCategory.id),
        );
      },
    );
  }
}

class ExpenseCategoryEditVM {
  ExpenseCategoryEditVM({
    @required this.state,
    @required this.expenseCategory,
    @required this.company,
    @required this.onChanged,
    @required this.isSaving,
    @required this.origExpenseCategory,
    @required this.onSavePressed,
    @required this.onCancelPressed,
    @required this.isLoading,
  });

  factory ExpenseCategoryEditVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final expenseCategory = state.expenseCategoryUIState.editing;

    return ExpenseCategoryEditVM(
      state: state,
      isLoading: state.isLoading,
      isSaving: state.isSaving,
      origExpenseCategory: state.expenseCategoryState.map[expenseCategory.id],
      expenseCategory: expenseCategory,
      company: state.company,
      onChanged: (ExpenseCategoryEntity expenseCategory) {
        store.dispatch(UpdateExpenseCategory(expenseCategory));
      },
      onCancelPressed: (BuildContext context) {
        createEntity(
            context: context, entity: ExpenseCategoryEntity(), force: true);
        store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
      },
      onSavePressed: (BuildContext context) {
        final localization = AppLocalization.of(context);
        final Completer<ExpenseCategoryEntity> completer =
            new Completer<ExpenseCategoryEntity>();
        store.dispatch(SaveExpenseCategoryRequest(
            completer: completer, expenseCategory: expenseCategory));
        return completer.future.then((savedExpenseCategory) {
          showToast(expenseCategory.isNew
              ? localization.createdExpenseCategory
              : localization.updatedExpenseCategory);

          if (isMobile(context)) {
            store.dispatch(UpdateCurrentRoute(ExpenseCategoryViewScreen.route));
            if (expenseCategory.isNew) {
              Navigator.of(context)
                  .pushReplacementNamed(ExpenseCategoryViewScreen.route);
            } else {
              Navigator.of(context).pop(savedExpenseCategory);
            }
          } else {
            viewEntity(
                context: context, entity: savedExpenseCategory, force: true);
          }
        }).catchError((Object error) {
          showDialog<ErrorDialog>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(error);
              });
        });
      },
    );
  }

  final ExpenseCategoryEntity expenseCategory;
  final CompanyEntity company;
  final Function(ExpenseCategoryEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final bool isLoading;
  final bool isSaving;
  final ExpenseCategoryEntity origExpenseCategory;
  final AppState state;
}
