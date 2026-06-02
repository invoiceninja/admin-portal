// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_actions.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_e_invoice.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_e_invoice_vm.dart';

class RecurringInvoiceEditEInvoiceScreen extends StatelessWidget {
  const RecurringInvoiceEditEInvoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RecurringInvoiceEditEInvoiceVM>(
      converter: (Store<AppState> store) {
        return RecurringInvoiceEditEInvoiceVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return InvoiceEditEInvoice(viewModel: viewModel);
      },
    );
  }
}

class RecurringInvoiceEditEInvoiceVM extends EntityEditEInvoiceVM {
  RecurringInvoiceEditEInvoiceVM({
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

  factory RecurringInvoiceEditEInvoiceVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final recurringInvoice = state.recurringInvoiceUIState.editing;

    return RecurringInvoiceEditEInvoiceVM(
      company: state.company,
      invoice: recurringInvoice,
      onChanged: (InvoiceEntity recurringInvoice) =>
          store.dispatch(UpdateRecurringInvoice(recurringInvoice)),
      state: state,
    );
  }
}
