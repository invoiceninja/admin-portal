import 'dart:async';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/ui/expense/expense_screen.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/data/models/expense_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class ExpenseViewScreen extends StatelessWidget {
  const ExpenseViewScreen({Key key}) : super(key: key);
  static const String route = '/expense/view';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ExpenseViewVM>(
      converter: (Store<AppState> store) {
        return ExpenseViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return ExpenseView(
          viewModel: vm,
        );
      },
    );
  }
}

class ExpenseViewVM {
  ExpenseViewVM({
    @required this.state,
    @required this.expense,
    @required this.company,
    @required this.onActionSelected,
    @required this.onEntityPressed,
    @required this.onCategoryPressed,
    @required this.onEditPressed,
    @required this.onBackPressed,
    @required this.onRefreshed,
    @required this.isSaving,
    @required this.isLoading,
    @required this.isDirty,
  });

  factory ExpenseViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final expense = state.expenseState.map[state.expenseUIState.selectedId];
    final vendor = state.vendorState.map[expense.vendorId];
    final client = state.clientState.map[expense.clientId];
    final invoice = state.invoiceState.map[expense.invoiceId];

    Future<Null> _handleRefresh(BuildContext context) {
      final completer = snackBarCompleter(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadExpense(completer: completer, expenseId: expense.id));
      return completer.future;
    }

    return ExpenseViewVM(
        state: state,
        company: state.selectedCompany,
        isSaving: state.isSaving,
        isLoading: state.isLoading,
        isDirty: expense.isNew,
        expense: expense,
        onEditPressed: (BuildContext context) {
          final Completer<ExpenseEntity> completer = Completer<ExpenseEntity>();
          store.dispatch(EditExpense(
              expense: expense, context: context, completer: completer));
          completer.future.then((expense) {
            Scaffold.of(context).showSnackBar(SnackBar(
                content: SnackBarRow(
              message: AppLocalization.of(context).updatedExpense,
            )));
          });
        },
        onRefreshed: (context) => _handleRefresh(context),
        onBackPressed: () {
          if (state.uiState.currentRoute.contains(ExpenseScreen.route)) {
            store.dispatch(UpdateCurrentRoute(ExpenseScreen.route));
          }
        },
        onCategoryPressed: (BuildContext context) {
          store.dispatch(FilterExpensesByEntity(
              entityId: expense.categoryId, entityType: EntityType.expenseCategory));
          store.dispatch(ViewExpenseList(context));
        },
        onEntityPressed: (BuildContext context, EntityType entityType,
            [longPress = false]) {
          switch (entityType) {
            case EntityType.vendor:
              if (longPress) {
                store.dispatch(EditVendor(context: context, vendor: vendor));
              } else {
                store.dispatch(
                    ViewVendor(context: context, vendorId: vendor.id));
              }
              break;
            case EntityType.client:
              if (longPress) {
                store.dispatch(EditClient(context: context, client: client));
              } else {
                store.dispatch(
                    ViewClient(context: context, clientId: client.id));
              }
              break;
            case EntityType.invoice:
              if (longPress) {
                store.dispatch(EditInvoice(context: context, invoice: invoice));
              } else {
                store.dispatch(
                    ViewInvoice(context: context, invoiceId: invoice.id));
              }
              break;
          }
        },
        onActionSelected: (BuildContext context, EntityAction action) {
          final localization = AppLocalization.of(context);
          switch (action) {
            case EntityAction.archive:
              store.dispatch(ArchiveExpenseRequest(
                  popCompleter(context, localization.archivedExpense),
                  expense.id));
              break;
            case EntityAction.delete:
              store.dispatch(DeleteExpenseRequest(
                  popCompleter(context, localization.deletedExpense),
                  expense.id));
              break;
            case EntityAction.restore:
              store.dispatch(RestoreExpenseRequest(
                  snackBarCompleter(context, localization.restoredExpense),
                  expense.id));
              break;
          }
        });
  }

  final AppState state;
  final ExpenseEntity expense;
  final CompanyEntity company;
  final Function(BuildContext, EntityAction) onActionSelected;
  final Function(BuildContext, EntityType, [bool]) onEntityPressed;
  final Function(BuildContext) onCategoryPressed;
  final Function(BuildContext) onEditPressed;
  final Function onBackPressed;
  final Function(BuildContext) onRefreshed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
