// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_e_invoice.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_e_invoice_vm.dart';

class CreditEditEInvoiceScreen extends StatelessWidget {
  const CreditEditEInvoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreditEditEInvoiceVM>(
      converter: (Store<AppState> store) {
        return CreditEditEInvoiceVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return InvoiceEditEInvoice(viewModel: viewModel);
      },
    );
  }
}

class CreditEditEInvoiceVM extends EntityEditEInvoiceVM {
  CreditEditEInvoiceVM({
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

  factory CreditEditEInvoiceVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final credit = state.creditUIState.editing;

    return CreditEditEInvoiceVM(
      company: state.company,
      invoice: credit,
      onChanged: (InvoiceEntity credit) => store.dispatch(UpdateCredit(credit)),
      state: state,
    );
  }
}
