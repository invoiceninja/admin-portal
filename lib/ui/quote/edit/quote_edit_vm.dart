import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/quote/edit/quote_edit.dart';
import 'package:invoiceninja_flutter/ui/quote/quote_screen.dart';
import 'package:invoiceninja_flutter/ui/quote/view/quote_view_vm.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
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
    final quote = state.quoteUIState.editing;

    return QuoteEditVM(
      company: state.selectedCompany,
      isSaving: state.isSaving,
      quote: quote,
      quoteItem: state.quoteUIState.editingItem,
      origQuote: store.state.quoteState.map[quote.id],
      onBackPressed: () =>
          store.dispatch(UpdateCurrentRoute(QuoteScreen.route)),
      onSavePressed: (BuildContext context) {
        final Completer<InvoiceEntity> completer = Completer<InvoiceEntity>();
        store.dispatch(
            SaveQuoteRequest(completer: completer, quote: quote));
        return completer.future.then((savedQuote) {
          if (quote.isNew) {
            Navigator.of(context).pushReplacementNamed(QuoteViewScreen.route);
          } else {
            Navigator.of(context).pop(savedQuote);
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
          store.dispatch(EditQuoteItem(items[0]));
        }
        store.dispatch(AddQuoteItems(items));
      },
    );
  }
}
