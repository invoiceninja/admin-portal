import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items_desktop.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_vm.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class QuoteEditItemsScreen extends StatelessWidget {
  const QuoteEditItemsScreen({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final EntityEditVM viewModel;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, QuoteEditItemsVM>(
      converter: (Store<AppState> store) {
        return QuoteEditItemsVM.fromStore(store);
      },
      builder: (context, viewModel) {
        if (viewModel.state.prefState.isEditorFullScreen(EntityType.invoice)) {
          return InvoiceEditItemsDesktop(
            viewModel: viewModel,
            entityViewModel: this.viewModel,
            isTasks: false,
          );
        } else {
          return InvoiceEditItems(
            viewModel: viewModel,
            entityViewModel: this.viewModel,
          );
        }
      },
    );
  }
}

class QuoteEditItemsVM extends EntityEditItemsVM {
  QuoteEditItemsVM({
    AppState state,
    CompanyEntity company,
    InvoiceEntity invoice,
    int invoiceItemIndex,
    Function addLineItem,
    Function deleteLineItem,
    Function(int) onRemoveInvoiceItemPressed,
    Function onDoneInvoiceItemPressed,
    Function(InvoiceItemEntity, int) onChangedInvoiceItem,
    Function(int, int) onMovedInvoiceItem,
  }) : super(
          state: state,
          company: company,
          invoice: invoice,
          addLineItem: addLineItem,
          deleteLineItem: deleteLineItem,
          invoiceItemIndex: invoiceItemIndex,
          onRemoveInvoiceItemPressed: onRemoveInvoiceItemPressed,
          clearSelectedInvoiceItem: onDoneInvoiceItemPressed,
          onChangedInvoiceItem: onChangedInvoiceItem,
          onMovedInvoiceItem: onMovedInvoiceItem,
        );

  factory QuoteEditItemsVM.fromStore(Store<AppState> store) {
    return QuoteEditItemsVM(
      state: store.state,
      company: store.state.company,
      invoice: store.state.quoteUIState.editing,
      invoiceItemIndex: store.state.quoteUIState.editingItemIndex,
      onRemoveInvoiceItemPressed: (index) =>
          store.dispatch(DeleteQuoteItem(index)),
      onDoneInvoiceItemPressed: () => store.dispatch(EditQuoteItem()),
      onChangedInvoiceItem: (quoteItem, index) {
        final quote = store.state.quoteUIState.editing;
        if (index == quote.lineItems.length) {
          store.dispatch(AddQuoteItem(quoteItem: quoteItem));
        } else {
          store.dispatch(UpdateQuoteItem(quoteItem: quoteItem, index: index));
        }
      },
      onMovedInvoiceItem: (oldIndex, newIndex) => store.dispatch(
        MoveQuoteItem(oldIndex: oldIndex, newIndex: newIndex),
      ),
    );
  }
}
