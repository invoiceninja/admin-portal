// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items_desktop.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_vm.dart';

class CreditEditItemsScreen extends StatelessWidget {
  const CreditEditItemsScreen({
    Key? key,
    required this.viewModel,
    this.isTasks = false,
  }) : super(key: key);

  final AbstractInvoiceEditVM viewModel;
  final bool isTasks;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreditEditItemsVM>(
      converter: (Store<AppState> store) {
        return CreditEditItemsVM.fromStore(store, isTasks);
      },
      builder: (context, viewModel) {
        if (viewModel.state!.prefState.isEditorFullScreen(EntityType.invoice)) {
          return InvoiceEditItemsDesktop(
            viewModel: viewModel,
            entityViewModel: this.viewModel,
            isTasks: isTasks,
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
    AppState? state,
    CompanyEntity? company,
    InvoiceEntity? invoice,
    int? invoiceItemIndex,
    Function? addLineItem,
    Function? deleteLineItem,
    Function(int)? onRemoveInvoiceItemPressed,
    Function? onDoneInvoiceItemPressed,
    Function(InvoiceItemEntity, int)? onChangedInvoiceItem,
    Function(int, int)? onMovedInvoiceItem,
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

  factory CreditEditItemsVM.fromStore(Store<AppState> store, bool isTasks) {
    return CreditEditItemsVM(
      state: store.state,
      company: store.state.company,
      invoice: store.state.creditUIState.editing,
      invoiceItemIndex: store.state.creditUIState.editingItemIndex,
      onRemoveInvoiceItemPressed: (index) {
        store.dispatch(DeleteCreditItem(index));
      },
      onDoneInvoiceItemPressed: () {
        store.dispatch(EditCreditItem());
      },
      onChangedInvoiceItem: (creditItem, index) {
        final credit = store.state.creditUIState.editing!;
        if (index == credit.lineItems.length) {
          store.dispatch(AddCreditItem(
              creditItem: creditItem.rebuild((b) => b
                ..typeId = isTasks
                    ? InvoiceItemEntity.TYPE_TASK
                    : InvoiceItemEntity.TYPE_STANDARD)));
        } else {
          store
              .dispatch(UpdateCreditItem(creditItem: creditItem, index: index));
        }
      },
      onMovedInvoiceItem: (oldIndex, newIndex) {
        store.dispatch(
          MoveCreditItem(oldIndex: oldIndex, newIndex: newIndex),
        );
      },
    );
  }
}
