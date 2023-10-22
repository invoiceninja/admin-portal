// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_notes.dart';

class InvoiceEditNotesScreen extends StatelessWidget {
  const InvoiceEditNotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InvoiceEditNotesVM>(
      converter: (Store<AppState> store) {
        return InvoiceEditNotesVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return InvoiceEditNotes(
          viewModel: viewModel,
        );
      },
    );
  }
}

class EntityEditNotesVM {
  EntityEditNotesVM({
    required this.state,
    required this.company,
    required this.invoice,
    required this.onChanged,
  });

  final AppState? state;
  final CompanyEntity? company;
  final InvoiceEntity? invoice;
  final Function(InvoiceEntity)? onChanged;
}

class InvoiceEditNotesVM extends EntityEditNotesVM {
  InvoiceEditNotesVM({
    required CompanyEntity? company,
    required InvoiceEntity? invoice,
    required Function(InvoiceEntity) onChanged,
    required AppState state,
  }) : super(
          company: company,
          invoice: invoice,
          onChanged: onChanged,
          state: state,
        );

  factory InvoiceEditNotesVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final invoice = state.invoiceUIState.editing;

    return InvoiceEditNotesVM(
      company: state.company,
      invoice: invoice,
      onChanged: (InvoiceEntity invoice) =>
          store.dispatch(UpdateInvoice(invoice)),
      state: state,
    );
  }
}
