// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_actions.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_notes.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_notes_vm.dart';

class PurchaseOrderEditNotesScreen extends StatelessWidget {
  const PurchaseOrderEditNotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PurchaseOrderEditNotesVM>(
      converter: (Store<AppState> store) {
        return PurchaseOrderEditNotesVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return InvoiceEditNotes(
          viewModel: viewModel,
        );
      },
    );
  }
}

class PurchaseOrderEditNotesVM extends EntityEditNotesVM {
  PurchaseOrderEditNotesVM({
    CompanyEntity? company,
    InvoiceEntity? invoice,
    Function(InvoiceEntity)? onChanged,
    AppState? state,
  }) : super(
          company: company,
          invoice: invoice,
          onChanged: onChanged,
          state: state,
        );

  factory PurchaseOrderEditNotesVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final purchaseOrder = state.purchaseOrderUIState.editing;

    return PurchaseOrderEditNotesVM(
      company: state.company,
      invoice: purchaseOrder,
      onChanged: (InvoiceEntity purchaseOrder) =>
          store.dispatch(UpdatePurchaseOrder(purchaseOrder)),
      state: state,
    );
  }
}
