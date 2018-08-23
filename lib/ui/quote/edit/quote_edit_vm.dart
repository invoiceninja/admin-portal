import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_screen.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja_flutter/ui/quote/edit/quote_edit.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class QuoteEditScreen extends StatelessWidget {
  static const String route = '/quote/edit';

  const QuoteEditScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, QuoteEditVM>(
      converter: (Store<AppState> store) {
        return QuoteEditVM.fromStore(store);
      },
      builder: (context, vm) {
        return QuoteEdit(
          viewModel: vm,
        );
      },
    );
  }
}

class QuoteEditVM {
  final CompanyEntity company;
  final InvoiceEntity quote;
  final InvoiceItemEntity quoteItem;
  final InvoiceEntity origQuote;
  final Function(BuildContext) onSavePressed;
  final Function(List<InvoiceItemEntity>) onItemsAdded;
  final Function onBackPressed;
  final bool isSaving;

  QuoteEditVM({
    @required this.company,
    @required this.quote,
    @required this.quoteItem,
    @required this.origQuote,
    @required this.onSavePressed,
    @required this.onItemsAdded,
    @required this.onBackPressed,
    @required this.isSaving,
  });

  factory QuoteEditVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final invoice = state.invoiceUIState.editing;

    return QuoteEditVM(
      company: state.selectedCompany,
      isSaving: state.isSaving,
      quote: invoice,
      quoteItem: state.invoiceUIState.editingItem,
      origQuote: store.state.invoiceState.map[invoice.id],
      onBackPressed: () =>
          store.dispatch(UpdateCurrentRoute(InvoiceScreen.route)),
      onSavePressed: (BuildContext context) {
        final Completer<InvoiceEntity> completer = Completer<InvoiceEntity>();
        store.dispatch(
            SaveInvoiceRequest(completer: completer, invoice: invoice));
        return completer.future.then((savedInvoice) {
          if (invoice.isNew) {
            Navigator.of(context).pushReplacementNamed(InvoiceViewScreen.route);
          } else {
            Navigator.of(context).pop(savedInvoice);
          }
        }).catchError((Object error) {
          showDialog<ErrorDialog>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(error);
              });
        });
      },
      onItemsAdded: (items) {
        if (items.length == 1) {
          store.dispatch(EditInvoiceItem(items[0]));
        }
        store.dispatch(AddInvoiceItems(items));
      },
    );
  }
}
