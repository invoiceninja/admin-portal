import 'dart:async';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
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
    @required this.onEntityAction,
    @required this.onEntityPressed,
    @required this.onEditPressed,
    @required this.onBackPressed,
    @required this.onRefreshed,
    @required this.onFileUpload,
    @required this.onDeleteDocument,
    @required this.isSaving,
    @required this.isLoading,
    @required this.isDirty,
  });

  factory ExpenseViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final user = state.user;
    final expense = state.expenseState.map[state.expenseUIState.selectedId] ??
        ExpenseEntity(id: state.expenseUIState.selectedId);
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
        onEntityPressed: (BuildContext context, EntityType entityType,
            [longPress = false]) {
          switch (entityType) {
            case EntityType.vendor:
              if (longPress) {
                showEntityActionsDialog(
                    user: user,
                    context: context,
                    entity: vendor,
                    onEntityAction: (BuildContext context, BaseEntity vendor,
                            EntityAction action) =>
                        handleVendorAction(context, vendor, action));
              } else {
                store.dispatch(
                    ViewVendor(vendorId: vendor.id, context: context));
              }
              break;
            case EntityType.client:
              if (longPress) {
                showEntityActionsDialog(
                    user: user,
                    context: context,
                    entity: client,
                    onEntityAction: (BuildContext context, BaseEntity client,
                            EntityAction action) =>
                        handleClientAction(context, client, action));
              } else {
                store.dispatch(
                    ViewClient(clientId: client.id, context: context));
              }
              break;
            case EntityType.invoice:
              if (longPress) {
                showEntityActionsDialog(
                    user: user,
                    context: context,
                    entity: invoice,
                    client: client,
                    onEntityAction: (BuildContext context, BaseEntity invoice,
                            EntityAction action) =>
                        handleInvoiceAction(context, invoice, action));
              } else {
                store.dispatch(
                    ViewInvoice(invoiceId: invoice.id, context: context));
              }
              break;
          }
        },
        onEntityAction: (BuildContext context, EntityAction action) =>
            handleExpenseAction(context, expense, action),
        onFileUpload: (BuildContext context, String path) {
          final Completer<DocumentEntity> completer =
              Completer<DocumentEntity>();
          final document = DocumentEntity().rebuild((b) => b
            ..expenseId = expense.id
            ..path = path);
          store.dispatch(
              SaveDocumentRequest(document: document, completer: completer));
          completer.future.then((client) {
            Scaffold.of(context).showSnackBar(SnackBar(
                content: SnackBarRow(
              message: AppLocalization.of(context).uploadedDocument,
            )));
          });
        },
        onDeleteDocument: (BuildContext context, DocumentEntity document) {
          store.dispatch(DeleteDocumentRequest(
              snackBarCompleter(
                  context, AppLocalization.of(context).deletedDocument),
              document.id));
        });
  }

  final AppState state;
  final ExpenseEntity expense;
  final CompanyEntity company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext, EntityType, [bool]) onEntityPressed;
  final Function(BuildContext) onEditPressed;
  final Function onBackPressed;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, String) onFileUpload;
  final Function(BuildContext, DocumentEntity) onDeleteDocument;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
