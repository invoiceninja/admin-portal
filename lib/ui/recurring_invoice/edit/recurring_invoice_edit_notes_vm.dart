import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_actions.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_notes.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_notes_vm.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class RecurringInvoiceEditNotesScreen extends StatelessWidget {
  const RecurringInvoiceEditNotesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RecurringInvoiceEditNotesVM>(
      converter: (Store<AppState> store) {
        return RecurringInvoiceEditNotesVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return InvoiceEditNotes(
          viewModel: viewModel,
        );
      },
    );
  }
}

class RecurringInvoiceEditNotesVM extends EntityEditNotesVM {
  RecurringInvoiceEditNotesVM({
    CompanyEntity company,
    InvoiceEntity invoice,
    Function(InvoiceEntity) onChanged,
    AppState state,
  }) : super(
          company: company,
          invoice: invoice,
          onChanged: onChanged,
          state: state,
        );

  factory RecurringInvoiceEditNotesVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final quote = state.quoteUIState.editing;

    return RecurringInvoiceEditNotesVM(
      company: state.company,
      invoice: quote,
      onChanged: (InvoiceEntity quote) =>
          store.dispatch(UpdateRecurringInvoice(quote)),
    );
  }
}
