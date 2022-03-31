// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_selectors.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';

class ExpenseEditScreen extends StatelessWidget {
  const ExpenseEditScreen({Key key}) : super(key: key);
  static const String route = '/expense/edit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ExpenseEditVM>(
      converter: (Store<AppState> store) {
        return ExpenseEditVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return ExpenseEdit(
          viewModel: viewModel,
          key: ValueKey(viewModel.expense.updatedAt),
        );
      },
    );
  }
}

abstract class AbstractExpenseEditVM {
  AbstractExpenseEditVM({
    @required this.state,
    @required this.expense,
    @required this.onChanged,
    @required this.origExpense,
    @required this.onSavePressed,
    @required this.onCancelPressed,
    @required this.onAddClientPressed,
    @required this.onAddVendorPressed,
  });

  final ExpenseEntity expense;
  final Function(ExpenseEntity) onChanged;
  final Function(BuildContext, [EntityAction]) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final ExpenseEntity origExpense;
  final AppState state;
  final Function(BuildContext context, Completer<SelectableEntity> completer)
      onAddClientPressed;
  final Function(BuildContext context, Completer<SelectableEntity> completer)
      onAddVendorPressed;
}

class ExpenseEditVM extends AbstractExpenseEditVM {
  ExpenseEditVM({
    AppState state,
    ExpenseEntity expense,
    Function(ExpenseEntity) onChanged,
    Function(BuildContext, [EntityAction]) onSavePressed,
    Function(BuildContext) onCancelPressed,
    bool isLoading,
    bool isSaving,
    ExpenseEntity origExpense,
    Function(BuildContext context, Completer<SelectableEntity> completer)
        onAddClientPressed,
    Function(BuildContext context, Completer<SelectableEntity> completer)
        onAddVendorPressed,
  }) : super(
          state: state,
          expense: expense,
          onChanged: onChanged,
          onSavePressed: onSavePressed,
          onCancelPressed: onCancelPressed,
          origExpense: origExpense,
          onAddClientPressed: onAddClientPressed,
          onAddVendorPressed: onAddVendorPressed,
        );

  factory ExpenseEditVM.fromStore(Store<AppState> store) {
    final expense = store.state.expenseUIState.editing;
    final state = store.state;

    return ExpenseEditVM(
      state: state,
      isLoading: state.isLoading,
      isSaving: state.isSaving,
      origExpense: state.expenseState.map[expense.id],
      expense: expense,
      onChanged: (ExpenseEntity expense) {
        store.dispatch(UpdateExpense(expense));
      },
      onCancelPressed: (BuildContext context) {
        createEntity(context: context, entity: ExpenseEntity(), force: true);
        store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
      },
      onAddClientPressed: (context, completer) {
        createEntity(
            context: context,
            entity: ClientEntity(),
            force: true,
            completer: completer,
            cancelCompleter: Completer<Null>()
              ..future.then((_) {
                store.dispatch(UpdateCurrentRoute(ExpenseEditScreen.route));
              }));
        completer.future.then((SelectableEntity client) {
          store.dispatch(UpdateCurrentRoute(ExpenseEditScreen.route));
        });
      },
      onAddVendorPressed: (context, completer) {
        createEntity(
            context: context,
            entity: VendorEntity(),
            force: true,
            completer: completer,
            cancelCompleter: Completer<Null>()
              ..future.then((_) {
                store.dispatch(UpdateCurrentRoute(ExpenseEditScreen.route));
              }));
        completer.future.then((SelectableEntity expense) {
          store.dispatch(UpdateCurrentRoute(ExpenseEditScreen.route));
        });
      },
      onSavePressed: (BuildContext context, [EntityAction action]) {
        Debouncer.runOnComplete(() {
          final expense = store.state.expenseUIState.editing;
          final localization = navigatorKey.localization;
          final navigator = navigatorKey.currentState;

          if (expense.isOld &&
              !hasExpenseChanges(expense, state.expenseState.map) &&
              action != null &&
              action.isClientSide) {
            handleEntityAction(expense, action);
          } else {
            final Completer<ExpenseEntity> completer =
                new Completer<ExpenseEntity>();
            store.dispatch(
                SaveExpenseRequest(completer: completer, expense: expense));
            return completer.future.then((savedExpense) {
              showToast(expense.isNew
                  ? localization.createdExpense
                  : localization.updatedExpense);

              if (state.prefState.isMobile) {
                store.dispatch(UpdateCurrentRoute(ExpenseViewScreen.route));
                if (expense.isNew) {
                  navigator.pushReplacementNamed(ExpenseViewScreen.route);
                } else {
                  navigator.pop(savedExpense);
                }
              } else {
                if (!state.prefState.isPreviewVisible) {
                  store.dispatch(TogglePreviewSidebar());
                }

                viewEntity(entity: savedExpense);

                if (state.prefState.isEditorFullScreen(EntityType.expense) &&
                    state.prefState.editAfterSaving) {
                  editEntity(
                      context: navigatorKey.currentContext,
                      entity: savedExpense);
                }
              }

              if (action != null && action.isClientSide) {
                handleEntityAction(savedExpense, action);
              } else if (action != null && action.requiresSecondRequest) {
                handleEntityAction(savedExpense, action);
                viewEntity(entity: savedExpense, force: true);
              }
            }).catchError((Object error) {
              showDialog<ErrorDialog>(
                  context: navigatorKey.currentContext,
                  builder: (BuildContext context) {
                    return ErrorDialog(error);
                  });
            });
          }
        });
      },
    );
  }
}
