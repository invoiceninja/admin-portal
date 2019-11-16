import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja_flutter/ui/quote/quote_screen.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';

class QuoteViewScreen extends StatelessWidget {
  const QuoteViewScreen({Key key}) : super(key: key);

  static const String route = '/quote/view';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, QuoteViewVM>(
      //distinct: true,
      converter: (Store<AppState> store) {
        return QuoteViewVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return InvoiceView(
          viewModel: viewModel,
        );
      },
    );
  }
}

class QuoteViewVM extends EntityViewVM {
  QuoteViewVM({
    AppState state,
    CompanyEntity company,
    InvoiceEntity invoice,
    ClientEntity client,
    bool isSaving,
    bool isDirty,
    Function(BuildContext, EntityAction) onEntityAction,
    Function(BuildContext, [int]) onEditPressed,
    Function(BuildContext, [bool]) onClientPressed,
    Function(BuildContext) onPaymentsPressed,
    Function(BuildContext, PaymentEntity) onPaymentPressed,
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
          onPaymentsPressed: onPaymentsPressed,
          onPaymentPressed: onPaymentPressed,
          onRefreshed: onRefreshed,
          onBackPressed: onBackPressed,
          onUploadDocument: onUploadDocument,
          onDeleteDocument: onDeleteDocument,
          onViewExpense: onViewExpense,
        );

  factory QuoteViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final quote = state.quoteState.map[state.quoteUIState.selectedId] ??
        InvoiceEntity(id: state.quoteUIState.selectedId);
    final client = store.state.clientState.map[quote.clientId] ??
        ClientEntity(id: quote.clientId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadQuote(completer: completer, quoteId: quote.id));
      return completer.future;
    }

    return QuoteViewVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isDirty: quote.isNew,
      invoice: quote,
      client: client,
      onEditPressed: (BuildContext context, [int index]) {
        final Completer<InvoiceEntity> completer =
            new Completer<InvoiceEntity>();
        store.dispatch(EditQuote(
            quote: quote,
            context: context,
            completer: completer,
            quoteItemIndex: index));
        completer.future.then((invoice) {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: SnackBarRow(
            message: AppLocalization.of(context).updatedQuote,
          )));
        });
      },
      onRefreshed: (context) => _handleRefresh(context),
      onBackPressed: () {
        if (state.uiState.currentRoute.contains(QuoteScreen.route)) {
          store.dispatch(UpdateCurrentRoute(QuoteScreen.route));
        }
      },
      onClientPressed: (BuildContext context, [bool longPress = false]) {
        if (longPress) {
          showEntityActionsDialog(
            context: context,
            entities: [client],
          );
        } else {
          store.dispatch(ViewClient(clientId: client.id, context: context));
        }
      },
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleQuoteAction(context, [quote], action),
      onUploadDocument: (BuildContext context, String path) {
        final Completer<DocumentEntity> completer = Completer<DocumentEntity>();
        final document = DocumentEntity().rebuild((b) => b
          ..invoiceId = quote.id
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
      },
    );
  }
}
