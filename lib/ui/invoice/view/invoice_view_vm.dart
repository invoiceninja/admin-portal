import 'dart:async';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:redux/redux.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_screen.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';

class InvoiceViewScreen extends StatelessWidget {
  const InvoiceViewScreen({Key key}) : super(key: key);

  static const String route = '/invoice/view';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InvoiceViewVM>(
      converter: (Store<AppState> store) {
        return InvoiceViewVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return InvoiceView(
          viewModel: viewModel,
        );
      },
    );
  }
}

class EntityViewVM {
  EntityViewVM({
    @required this.state,
    @required this.company,
    @required this.invoice,
    @required this.client,
    @required this.isSaving,
    @required this.isDirty,
    @required this.onActionSelected,
    @required this.onUploadDocument,
    @required this.onDeleteDocument,
    @required this.onEditPressed,
    @required this.onBackPressed,
    @required this.onClientPressed,
    @required this.onPaymentsPressed,
    @required this.onPaymentPressed,
    @required this.onRefreshed,
    @required this.onViewExpense,
  });

  final AppState state;
  final CompanyEntity company;
  final InvoiceEntity invoice;
  final ClientEntity client;
  final bool isSaving;
  final bool isDirty;
  final Function(BuildContext, EntityAction) onActionSelected;
  final Function(BuildContext, [InvoiceItemEntity]) onEditPressed;
  final Function(BuildContext, [bool]) onClientPressed;
  final Function(BuildContext) onPaymentsPressed;
  final Function(BuildContext, PaymentEntity, [bool]) onPaymentPressed;
  final Function(BuildContext) onRefreshed;
  final Function onBackPressed;
  final Function(BuildContext, String) onUploadDocument;
  final Function(BuildContext, DocumentEntity) onDeleteDocument;
  final Function(BuildContext, DocumentEntity) onViewExpense;
}

class InvoiceViewVM extends EntityViewVM {
  InvoiceViewVM({
    AppState state,
    CompanyEntity company,
    InvoiceEntity invoice,
    ClientEntity client,
    bool isSaving,
    bool isDirty,
    Function(BuildContext, EntityAction) onEntityAction,
    Function(BuildContext, [InvoiceItemEntity]) onEditPressed,
    Function(BuildContext, [bool]) onClientPressed,
    Function(BuildContext, PaymentEntity, [bool]) onPaymentPressed,
    Function(BuildContext) onPaymentsPressed,
    Function(BuildContext) onRefreshed,
    Function onBackPressed,
    Function(BuildContext, String) onUploadDocument,
    Function(BuildContext, DocumentEntity) onDeleteDocument,
    Function(BuildContext, DocumentEntity) onViewExpense,
  }) : super(
            state: state,
            company: company,
            invoice: invoice,
            client: client,
            isSaving: isSaving,
            isDirty: isDirty,
            onActionSelected: onEntityAction,
            onEditPressed: onEditPressed,
            onClientPressed: onClientPressed,
            onPaymentPressed: onPaymentPressed,
            onPaymentsPressed: onPaymentsPressed,
            onRefreshed: onRefreshed,
            onBackPressed: onBackPressed,
            onUploadDocument: onUploadDocument,
            onDeleteDocument: onDeleteDocument,
            onViewExpense: onViewExpense);

  factory InvoiceViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final invoice = state.invoiceState.get(state.invoiceUIState.selectedId);
    final client = state.clientState.get(invoice.clientId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer = snackBarCompleter(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadInvoice(completer: completer, invoiceId: invoice.id));
      return completer.future;
    }

    return InvoiceViewVM(
      state: state,
      company: state.selectedCompany,
      isSaving: state.isSaving,
      isDirty: invoice.isNew,
      invoice: invoice,
      client: client,
      onEditPressed: (BuildContext context, [InvoiceItemEntity invoiceItem]) {
        final Completer<InvoiceEntity> completer =
            new Completer<InvoiceEntity>();
        store.dispatch(EditInvoice(
            invoice: invoice,
            context: context,
            completer: completer,
            invoiceItem: invoiceItem));
        completer.future.then((invoice) {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: SnackBarRow(
            message: AppLocalization.of(context).updatedInvoice,
          )));
        });
      },
      onRefreshed: (context) => _handleRefresh(context),
      onBackPressed: () {
        if (state.uiState.currentRoute.contains(InvoiceScreen.route)) {
          store.dispatch(UpdateCurrentRoute(InvoiceScreen.route));
        }
      },
      onClientPressed: (BuildContext context, [bool longPress = false]) {
        if (longPress) {
          showEntityActionsDialog(
              userCompany: state.userCompany,
              context: context,
              entities: [client],
              onEntityAction: (BuildContext context, BaseEntity client,
                      EntityAction action) =>
                  handleClientAction(context, client, action));
        } else {
          store.dispatch(ViewClient(clientId: client.id, context: context));
        }
      },
      onPaymentPressed: (BuildContext context, payment,
          [bool longPress = false]) {
        if (longPress) {
          showEntityActionsDialog(
              userCompany: state.userCompany,
              context: context,
              client: client,
              entities: [payment],
              onEntityAction: (BuildContext context, BaseEntity payment,
                      EntityAction action) =>
                  handlePaymentAction(context, payment, action));
        } else {
          store.dispatch(ViewPayment(paymentId: payment.id, context: context));
        }
      },
      onPaymentsPressed: (BuildContext context) {
        store.dispatch(FilterPaymentsByEntity(
            entityId: invoice.id, entityType: EntityType.invoice));
        store.dispatch(ViewPaymentList(context: context));
      },
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleInvoiceAction(context, invoice, action),
      onUploadDocument: (BuildContext context, String path) {
        final Completer<DocumentEntity> completer = Completer<DocumentEntity>();
        final document = DocumentEntity().rebuild((b) => b
          ..invoiceId = invoice.id
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
            snackBarCompleter(
                context, AppLocalization.of(context).deletedDocument),
            document.id));
      },
      onViewExpense: (BuildContext context, DocumentEntity document) {
        store.dispatch(
            ViewExpense(expenseId: document.expenseId, context: context));
      },
    );
  }
}
