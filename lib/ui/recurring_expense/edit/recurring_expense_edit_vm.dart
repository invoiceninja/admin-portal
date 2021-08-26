import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/recurring_expense/view/recurring_expense_view_vm.dart';
import 'package:invoiceninja_flutter/redux/recurring_expense/recurring_expense_actions.dart';
import 'package:invoiceninja_flutter/ui/recurring_expense/edit/recurring_expense_edit.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class RecurringExpenseEditScreen extends StatelessWidget {
  const RecurringExpenseEditScreen({Key key}) : super(key: key);
  static const String route = '/recurring_expense/edit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RecurringExpenseEditVM>(
      converter: (Store<AppState> store) {
        return RecurringExpenseEditVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return RecurringExpenseEdit(
          viewModel: viewModel,
          key: ValueKey(viewModel.recurringExpense.id),
        );
      },
    );
  }
}

class RecurringExpenseEditVM {
  RecurringExpenseEditVM({
    @required this.state,
    @required this.recurringExpense,
    @required this.company,
    @required this.onChanged,
    @required this.isSaving,
    @required this.origRecurringExpense,
    @required this.onSavePressed,
    @required this.onCancelPressed,
    @required this.isLoading,
  });

  factory RecurringExpenseEditVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final recurringExpense = state.recurringExpenseUIState.editing;

    return RecurringExpenseEditVM(
      state: state,
      isLoading: state.isLoading,
      isSaving: state.isSaving,
      origRecurringExpense:
          state.recurringExpenseState.map[recurringExpense.id],
      recurringExpense: recurringExpense,
      company: state.company,
      onChanged: (ExpenseEntity recurringExpense) {
        store.dispatch(UpdateRecurringExpense(recurringExpense));
      },
      onCancelPressed: (BuildContext context) {
        createEntity(context: context, entity: ExpenseEntity(), force: true);
        if (state.recurringExpenseUIState.cancelCompleter != null) {
          state.recurringExpenseUIState.cancelCompleter.complete();
        } else {
          store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
        }
      },
      onSavePressed: (BuildContext context) {
        final localization = AppLocalization.of(context);
        final Completer<ExpenseEntity> completer =
            new Completer<ExpenseEntity>();
        store.dispatch(SaveRecurringExpenseRequest(
            completer: completer, recurringExpense: recurringExpense));
        return completer.future.then((savedRecurringExpense) {
          showToast(recurringExpense.isNew
              ? localization.createdRecurringExpense
              : localization.updatedRecurringExpense);
          if (state.prefState.isMobile) {
            store
                .dispatch(UpdateCurrentRoute(RecurringExpenseViewScreen.route));
            if (recurringExpense.isNew) {
              Navigator.of(context)
                  .pushReplacementNamed(RecurringExpenseViewScreen.route);
            } else {
              Navigator.of(context).pop(savedRecurringExpense);
            }
          } else {
            viewEntity(entity: savedRecurringExpense, force: true);
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

  final ExpenseEntity recurringExpense;
  final CompanyEntity company;
  final Function(ExpenseEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final bool isLoading;
  final bool isSaving;
  final ExpenseEntity origRecurringExpense;
  final AppState state;
}
