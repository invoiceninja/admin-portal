import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items_vm.dart';
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
      builder: (context, viewModel) {
        return InvoiceEditItems(
          viewModel: viewModel,
        );
      },
    );
  }
}

class QuoteEditItemsVM extends EntityEditItemsVM {

  QuoteEditItemsVM({
    CompanyEntity company,
    InvoiceEntity invoice,
    InvoiceItemEntity invoiceItem,
    Function(int) onRemoveInvoiceItemPressed,
    Function onDoneInvoiceItemPressed,
    Function(InvoiceItemEntity, int) onChangedInvoiceItem,
  }) : super(
    company: company,
    invoice: invoice,
    invoiceItem: invoiceItem,
    onRemoveInvoiceItemPressed: onRemoveInvoiceItemPressed,
    onDoneInvoiceItemPressed: onDoneInvoiceItemPressed,
    onChangedInvoiceItem: onChangedInvoiceItem,
  );

  factory QuoteEditItemsVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final quote = state.quoteUIState.editing;

    return QuoteEditItemsVM(
        company: state.selectedCompany,
        invoice: quote,
        invoiceItem: state.quoteUIState.editingItem,
        onRemoveInvoiceItemPressed: (index) =>
            store.dispatch(DeleteQuoteItem(index)),
        onDoneInvoiceItemPressed: () => store.dispatch(EditQuoteItem()),
        onChangedInvoiceItem: (quoteItem, index) {
          store.dispatch(
              UpdateQuoteItem(quoteItem: quoteItem, index: index));
        });
  }
}
