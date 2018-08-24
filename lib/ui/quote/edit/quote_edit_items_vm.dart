import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/quote/edit/quote_edit_items.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class QuoteEditItemsScreen extends StatelessWidget {
  const QuoteEditItemsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, QuoteEditItemsVM>(
      converter: (Store<AppState> store) {
        return QuoteEditItemsVM.fromStore(store);
      },
      builder: (context, vm) {
        return QuoteEditItems(
          viewModel: vm,
        );
      },
    );
  }
}

class QuoteEditItemsVM {
  final CompanyEntity company;
  final InvoiceEntity quote;
  final InvoiceItemEntity quoteItem;
  final Function(int) onRemoveQuoteItemPressed;
  final Function onDoneQuoteItemPressed;
  final Function(InvoiceItemEntity, int) onChangedQuoteItem;

  QuoteEditItemsVM({
    @required this.company,
    @required this.quote,
    @required this.quoteItem,
    @required this.onRemoveQuoteItemPressed,
    @required this.onDoneQuoteItemPressed,
    @required this.onChangedQuoteItem,
  });

  factory QuoteEditItemsVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final quote = state.quoteUIState.editing;

    return QuoteEditItemsVM(
        company: state.selectedCompany,
        quote: quote,
        quoteItem: state.quoteUIState.editingItem,
        onRemoveQuoteItemPressed: (index) =>
            store.dispatch(DeleteQuoteItem(index)),
        onDoneQuoteItemPressed: () => store.dispatch(EditQuoteItem()),
        onChangedQuoteItem: (quoteItem, index) {
          store.dispatch(
              UpdateQuoteItem(quoteItem: quoteItem, index: index));
        });
  }
}
