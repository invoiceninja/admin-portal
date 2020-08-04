import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items_desktop.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_vm.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class CreditEditItemsScreen extends StatelessWidget {
  const CreditEditItemsScreen({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final EntityEditVM viewModel;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreditEditItemsVM>(
      converter: (Store<AppState> store) {
        return CreditEditItemsVM.fromStore(store);
      },
      builder: (context, viewModel) {
        if (viewModel.state.prefState.isDesktop) {
          return InvoiceEditItemsDesktop(
            viewModel: viewModel,
            entityViewModel: this.viewModel,
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

class CreditEditItemsVM extends EntityEditItemsVM {
  CreditEditItemsVM({
    AppState state,
    CompanyEntity company,
    InvoiceEntity invoice,
    int invoiceItemIndex,
    Function addLineItem,
    Function deleteLineItem,
    Function(int) onRemoveInvoiceItemPressed,
    Function onDoneInvoiceItemPressed,
    Function(InvoiceItemEntity, int) onChangedInvoiceItem,
  }) : super(
          state: state,
          company: company,
          invoice: invoice,
          addLineItem: addLineItem,
          deleteLineItem: deleteLineItem,
          invoiceItemIndex: invoiceItemIndex,
          onRemoveInvoiceItemPressed: onRemoveInvoiceItemPressed,
          onDoneInvoiceItemPressed: onDoneInvoiceItemPressed,
          onChangedInvoiceItem: onChangedInvoiceItem,
        );

  factory CreditEditItemsVM.fromStore(Store<AppState> store) {
    return CreditEditItemsVM(
        state: store.state,
        company: store.state.company,
        invoice: store.state.creditUIState.editing,
        invoiceItemIndex: store.state.creditUIState.editingItemIndex,
        onRemoveInvoiceItemPressed: (index) =>
            store.dispatch(DeleteCreditItem(index)),
        onDoneInvoiceItemPressed: () => store.dispatch(EditCreditItem()),
        onChangedInvoiceItem: (creditItem, index) {
          final credit = store.state.creditUIState.editing;
          if (index == credit.lineItems.length) {
            store.dispatch(AddCreditItem(creditItem: creditItem));
          } else {
            store.dispatch(
                UpdateCreditItem(creditItem: creditItem, index: index));
          }
        });
  }
}
