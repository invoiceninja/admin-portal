import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/app_context.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view_vm.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/data/models/expense_model.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

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
          key: ValueKey(viewModel.expense.id),
        );
      },
    );
  }
}

class ExpenseEditVM {
  ExpenseEditVM({
    @required this.state,
    @required this.expense,
    @required this.company,
    @required this.onChanged,
    @required this.isSaving,
    @required this.origExpense,
    @required this.onSavePressed,
    @required this.onCancelPressed,
    @required this.isLoading,
    @required this.onAddClientPressed,
    @required this.onAddVendorPressed,
  });

  factory ExpenseEditVM.fromStore(Store<AppState> store) {
    final expense = store.state.expenseUIState.editing;
    final state = store.state;

    return ExpenseEditVM(
      state: state,
      isLoading: state.isLoading,
      isSaving: state.isSaving,
      origExpense: state.expenseState.map[expense.id],
      expense: expense,
      company: state.company,
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
      onSavePressed: (BuildContext context) {
        final appContext = context.getAppContext();
        Debouncer.runOnComplete(() {
          final expense = store.state.expenseUIState.editing;
          final localization = appContext.localization;
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
                appContext.navigator
                    .pushReplacementNamed(ExpenseViewScreen.route);
              } else {
                appContext.navigator.pop(savedExpense);
              }
            } else {
              viewEntityById(
                  appContext: appContext,
                  entityType: EntityType.expense,
                  entityId: savedExpense.id,
                  force: true);
            }
          }).catchError((Object error) {
            showDialog<ErrorDialog>(
                context: navigatorKey.currentContext,
                builder: (BuildContext context) {
                  return ErrorDialog(error);
                });
          });
        });
      },
    );
  }

  final ExpenseEntity expense;
  final CompanyEntity company;
  final Function(ExpenseEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final bool isLoading;
  final bool isSaving;
  final ExpenseEntity origExpense;
  final AppState state;
  final Function(BuildContext context, Completer<SelectableEntity> completer)
      onAddClientPressed;
  final Function(BuildContext context, Completer<SelectableEntity> completer)
      onAddVendorPressed;
}
