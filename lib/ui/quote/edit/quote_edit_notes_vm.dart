import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_notes.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_notes_vm.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class QuoteEditNotesScreen extends StatelessWidget {
  const QuoteEditNotesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, QuoteEditNotesVM>(
      converter: (Store<AppState> store) {
        return QuoteEditNotesVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return InvoiceEditNotes(
          viewModel: viewModel,
        );
      },
    );
  }
}

class QuoteEditNotesVM extends EntityEditNotesVM {
  QuoteEditNotesVM({
    CompanyEntity company,
    InvoiceEntity invoice,
    Function(InvoiceEntity) onChanged,
  }) : super(
    company: company,
    invoice: invoice,
    onChanged: onChanged,
  );

  factory QuoteEditNotesVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final quote = state.quoteUIState.editing;

    return QuoteEditNotesVM(
      company: state.selectedCompany,
      invoice: quote,
      onChanged: (InvoiceEntity quote) =>
          store.dispatch(UpdateQuote(quote)),
    );
  }
}
