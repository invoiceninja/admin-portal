import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:invoiceninja_flutter/ui/expense/expense_screen.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view_vm.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/data/models/expense_model.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    @required this.onBackPressed,
    @required this.isLoading,
    @required this.onAddClientPressed,
    @required this.onAddVendorPressed,
    @required this.onAddDocumentsChanged,
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
      company: state.selectedCompany,
      onChanged: (ExpenseEntity expense) {
        store.dispatch(UpdateExpense(expense));
      },
      onBackPressed: () {
        if (state.uiState.currentRoute.contains(ExpenseScreen.route)) {
          store.dispatch(UpdateCurrentRoute(
              expense.isNew ? ExpenseScreen.route : ExpenseViewScreen.route));
        }
      },
      onAddClientPressed: (context, completer) {
        store.dispatch(EditClient(
            client: ClientEntity(),
            context: context,
            completer: completer,
            trackRoute: false));
        completer.future.then((SelectableEntity client) {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: SnackBarRow(
            message: AppLocalization.of(context).createdClient,
          )));
        });
      },
      onAddVendorPressed: (context, completer) {
        store.dispatch(EditVendor(
            vendor: VendorEntity(),
            context: context,
            completer: completer,
            trackRoute: false));
        completer.future.then((SelectableEntity client) {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: SnackBarRow(
            message: AppLocalization.of(context).createdClient,
          )));
        });
      },
      onSavePressed: (BuildContext context) {
        final Completer<ExpenseEntity> completer =
            new Completer<ExpenseEntity>();
        store.dispatch(
            SaveExpenseRequest(completer: completer, expense: expense));
        return completer.future.then((_) {
          return completer.future.then((savedExpense) {
            store.dispatch(UpdateCurrentRoute(ExpenseViewScreen.route));
            if (expense.isNew) {
              Navigator.of(context)
                  .pushReplacementNamed(ExpenseViewScreen.route);
            } else {
              Navigator.of(context).pop(savedExpense);
            }
          }).catchError((Object error) {
            showDialog<ErrorDialog>(
                context: context,
                builder: (BuildContext context) {
                  return ErrorDialog(error);
                });
          });
        });
      },
      onAddDocumentsChanged: (value) async {
        if (expense.isOld) {
          return;
        }
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool(kSharedPrefEmailPayment, value);
        store.dispatch(UserSettingsChanged(addDocumentsToInvoice: value));
      },
    );
  }

  final ExpenseEntity expense;
  final CompanyEntity company;
  final Function(ExpenseEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function onBackPressed;
  final bool isLoading;
  final bool isSaving;
  final ExpenseEntity origExpense;
  final AppState state;
  final Function(BuildContext context, Completer<SelectableEntity> completer)
      onAddClientPressed;
  final Function(BuildContext context, Completer<SelectableEntity> completer)
      onAddVendorPressed;
  final Function(bool) onAddDocumentsChanged;
}
