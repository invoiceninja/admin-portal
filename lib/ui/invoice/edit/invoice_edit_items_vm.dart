import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/ui/invoice/edit/invoice_edit_items.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/app/app_state.dart';

class InvoiceEditItemsScreen extends StatelessWidget {
  InvoiceEditItemsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InvoiceEditItemsVM>(
      converter: (Store<AppState> store) {
        return InvoiceEditItemsVM.fromStore(store);
      },
      builder: (context, vm) {
        return InvoiceEditItems(
          viewModel: vm,
        );
      },
    );
  }
}

class InvoiceEditItemsVM {
  final AppState state;
  final InvoiceEntity invoice;
  final Function(int) onRemoveInvoiceItemPressed;
  final Function(InvoiceItemEntity, int) onChangedInvoiceItem;

  InvoiceEditItemsVM({
    @required this.state,
    @required this.invoice,
    @required this.onRemoveInvoiceItemPressed,
    @required this.onChangedInvoiceItem,
  });

  factory InvoiceEditItemsVM.fromStore(Store<AppState> store) {
    AppState state = store.state;
    final invoice = state.invoiceUIState.selected;

    return InvoiceEditItemsVM(
        state: state,
        invoice: invoice,
        onRemoveInvoiceItemPressed: (index) =>
            store.dispatch(DeleteInvoiceItem(index)),
        onChangedInvoiceItem: (invoiceItem, index) {
          store.dispatch(
              UpdateInvoiceItem(invoiceItem: invoiceItem, index: index));
        });
  }
}
