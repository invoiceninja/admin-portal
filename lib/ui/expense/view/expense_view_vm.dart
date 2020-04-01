import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/expense_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';

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
    @required this.onRefreshed,
    @required this.onUploadDocument,
    @required this.onDeleteDocument,
    @required this.isSaving,
    @required this.isLoading,
    @required this.isDirty,
  });

  factory ExpenseViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final expense = state.expenseState.map[state.expenseUIState.selectedId] ??
        ExpenseEntity(id: state.expenseUIState.selectedId);
    final vendor = state.vendorState.map[expense.vendorId];
    final client = state.clientState.map[expense.clientId];
    final invoice = state.invoiceState.map[expense.invoiceId];

    Future<Null> _handleRefresh(BuildContext context) {
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadExpense(completer: completer, expenseId: expense.id));
      return completer.future;
    }

    return ExpenseViewVM(
        state: state,
        company: state.company,
        isSaving: state.isSaving,
        isLoading: state.isLoading,
        isDirty: expense.isNew,
        expense: expense,
        onRefreshed: (context) => _handleRefresh(context),
        onEntityPressed: (BuildContext context, EntityType entityType,
            [longPress = false]) {
          switch (entityType) {
            case EntityType.vendor:
              if (longPress) {
                showEntityActionsDialog(
                  context: context,
                  entities: [vendor],
                );
              } else {
                viewEntity(context: context, entity: vendor);
              }
              break;
            case EntityType.client:
              if (longPress) {
                showEntityActionsDialog(context: context, entities: [client]);
              } else {
                viewEntity(context: context, entity: client);
              }
              break;
            case EntityType.invoice:
              if (longPress) {
                showEntityActionsDialog(
                    context: context, entities: [invoice], client: client);
              } else {
                viewEntity(context: context, entity: invoice);
              }
              break;
          }
        },
        onEntityAction: (BuildContext context, EntityAction action) =>
            handleExpenseAction(context, [expense], action),
        onUploadDocument: (BuildContext context, String path) {
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
          }).catchError((Object error) {
            showDialog<ErrorDialog>(
                context: context,
                builder: (BuildContext context) {
                  return ErrorDialog(error);
                });
          });
        },
        onDeleteDocument: (BuildContext context, DocumentEntity document) {
          store.dispatch(DeleteDocumentRequest(
              snackBarCompleter<Null>(
                  context, AppLocalization.of(context).deletedDocument),
              [document.id]));
        });
  }

  final AppState state;
  final ExpenseEntity expense;
  final CompanyEntity company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext, EntityType, [bool]) onEntityPressed;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, String) onUploadDocument;
  final Function(BuildContext, DocumentEntity) onDeleteDocument;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
