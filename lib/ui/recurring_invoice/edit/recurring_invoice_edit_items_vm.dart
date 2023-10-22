// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_actions.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items_desktop.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_vm.dart';

class RecurringInvoiceEditItemsScreen extends StatelessWidget {
  const RecurringInvoiceEditItemsScreen({
    Key? key,
    required this.viewModel,
    this.isTasks = false,
  }) : super(key: key);

  final AbstractInvoiceEditVM viewModel;
  final bool isTasks;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RecurringInvoiceEditItemsVM>(
      converter: (Store<AppState> store) {
        return RecurringInvoiceEditItemsVM.fromStore(store, isTasks);
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

class RecurringInvoiceEditItemsVM extends EntityEditItemsVM {
  RecurringInvoiceEditItemsVM({
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

  factory RecurringInvoiceEditItemsVM.fromStore(
      Store<AppState> store, bool isTasks) {
    return RecurringInvoiceEditItemsVM(
      state: store.state,
      company: store.state.company,
      invoice: store.state.recurringInvoiceUIState.editing,
      invoiceItemIndex: store.state.recurringInvoiceUIState.editingItemIndex,
      onRemoveInvoiceItemPressed: (index) {
        store.dispatch(DeleteRecurringInvoiceItem(index));
      },
      onDoneInvoiceItemPressed: () {
        store.dispatch(EditRecurringInvoiceItem());
      },
      onChangedInvoiceItem: (item, index) {
        final invoice = store.state.recurringInvoiceUIState.editing!;
        if (index == invoice.lineItems.length) {
          store.dispatch(AddRecurringInvoiceItem(
              invoiceItem: item.rebuild((b) => b
                ..typeId = isTasks
                    ? InvoiceItemEntity.TYPE_TASK
                    : InvoiceItemEntity.TYPE_STANDARD)));
        } else {
          store.dispatch(UpdateRecurringInvoiceItem(item: item, index: index));
        }
      },
      onMovedInvoiceItem: (oldIndex, newIndex) {
        store.dispatch(
          MoveRecurringInvoiceItem(oldIndex: oldIndex, newIndex: newIndex),
        );
      },
    );
  }
}
