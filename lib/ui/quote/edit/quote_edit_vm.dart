import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/quote/edit/quote_edit.dart';
import 'package:invoiceninja_flutter/ui/quote/quote_screen.dart';
import 'package:invoiceninja_flutter/ui/quote/view/quote_view_vm.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class QuoteEditScreen extends StatelessWidget {
  const QuoteEditScreen({Key key}) : super(key: key);

  static const String route = '/quote/edit';

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, QuoteEditVM>(
      converter: (Store<AppState> store) {
        return QuoteEditVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return QuoteEdit(
          viewModel: viewModel,
          formKey: _formKey,
        );
      },
    );
  }
}

class QuoteEditVM extends EntityEditVM {
  QuoteEditVM({
    AppState state,
    CompanyEntity company,
    InvoiceEntity invoice,
    InvoiceItemEntity invoiceItem,
    InvoiceEntity origInvoice,
    Function(BuildContext) onSavePressed,
    Function(List<InvoiceItemEntity>, int) onItemsAdded,
    Function onBackPressed,
    bool isSaving,
    Function(BuildContext) onCancelPressed,
  }) : super(
          state: state,
          company: company,
          invoice: invoice,
          invoiceItem: invoiceItem,
          origInvoice: origInvoice,
          onSavePressed: onSavePressed,
          onItemsAdded: onItemsAdded,
          onBackPressed: onBackPressed,
          isSaving: isSaving,
          onCancelPressed: onCancelPressed,
        );

  factory QuoteEditVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final quote = state.quoteUIState.editing;

    return QuoteEditVM(
      company: state.selectedCompany,
      isSaving: state.isSaving,
      invoice: quote,
      invoiceItem: state.quoteUIState.editingItem,
      origInvoice: store.state.quoteState.map[quote.id],
      onBackPressed: () {
        if (state.uiState.currentRoute.contains(QuoteScreen.route)) {
          store.dispatch(UpdateCurrentRoute(
              quote.isNew ? QuoteScreen.route : QuoteViewScreen.route));
        }
      },
      onSavePressed: (BuildContext context) {
        final Completer<InvoiceEntity> completer = Completer<InvoiceEntity>();
        store.dispatch(SaveQuoteRequest(completer: completer, quote: quote));
        return completer.future.then((savedQuote) {
          store.dispatch(UpdateCurrentRoute(QuoteViewScreen.route));
          if (isMobile(context)) {
            if (quote.isNew) {
              Navigator.of(context).pushReplacementNamed(QuoteViewScreen.route);
            } else {
              Navigator.of(context).pop(savedQuote);
            }
          }
        }).catchError((Object error) {
          showDialog<ErrorDialog>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(error);
              });
        });
      },
      onItemsAdded: (items, clientId) {
        if (items.length == 1) {
          store.dispatch(EditQuoteItem(items[0]));
        }
        store.dispatch(AddQuoteItems(items));
      },
      onCancelPressed: (BuildContext context) {
        store.dispatch(
            EditQuote(quote: InvoiceEntity(), context: context, force: true));
        store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
      },
    );
  }
}
