// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_notes.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_notes_vm.dart';

class CreditEditNotesScreen extends StatelessWidget {
  const CreditEditNotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreditEditNotesVM>(
      converter: (Store<AppState> store) {
        return CreditEditNotesVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return InvoiceEditNotes(
          viewModel: viewModel,
        );
      },
    );
  }
}

class CreditEditNotesVM extends EntityEditNotesVM {
  CreditEditNotesVM({
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

  factory CreditEditNotesVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final credit = state.creditUIState.editing;

    return CreditEditNotesVM(
      company: state.company,
      invoice: credit,
      onChanged: (InvoiceEntity credit) => store.dispatch(UpdateCredit(credit)),
      state: state,
    );
  }
}
