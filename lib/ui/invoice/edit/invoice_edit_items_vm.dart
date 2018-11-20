import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class InvoiceEditItemsScreen extends StatelessWidget {
  const InvoiceEditItemsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InvoiceEditItemsVM>(
      converter: (Store<AppState> store) {
        return InvoiceEditItemsVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return InvoiceEditItems(
          viewModel: viewModel,
        );
      },
    );
  }
}

class EntityEditItemsVM {
  EntityEditItemsVM({
    @required this.company,
    @required this.invoice,
    @required this.invoiceItem,
    @required this.onRemoveInvoiceItemPressed,
    @required this.onDoneInvoiceItemPressed,
    @required this.onChangedInvoiceItem,
  });

  final CompanyEntity company;
  final InvoiceEntity invoice;
  final InvoiceItemEntity invoiceItem;
  final Function(int) onRemoveInvoiceItemPressed;
  final Function onDoneInvoiceItemPressed;
  final Function(InvoiceItemEntity, int) onChangedInvoiceItem;
}

class InvoiceEditItemsVM extends EntityEditItemsVM {
  InvoiceEditItemsVM({
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

  factory InvoiceEditItemsVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final invoice = state.invoiceUIState.editing;

    return InvoiceEditItemsVM(
        company: state.selectedCompany,
        invoice: invoice,
        invoiceItem: state.invoiceUIState.editingItem,
        onRemoveInvoiceItemPressed: (index) =>
            store.dispatch(DeleteInvoiceItem(index)),
        onDoneInvoiceItemPressed: () => store.dispatch(EditInvoiceItem()),
        onChangedInvoiceItem: (invoiceItem, index) {
          store.dispatch(
              UpdateInvoiceItem(invoiceItem: invoiceItem, index: index));
        });
  }
}
