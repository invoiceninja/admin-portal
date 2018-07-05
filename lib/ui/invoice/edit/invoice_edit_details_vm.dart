import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/ui/invoice/edit/invoice_edit_details.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/app/app_state.dart';

class InvoiceEditDetailsScreen extends StatelessWidget {
  const InvoiceEditDetailsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InvoiceEditDetailsVM>(
      converter: (Store<AppState> store) {
        return InvoiceEditDetailsVM.fromStore(store);
      },
      builder: (context, vm) {
        return InvoiceEditDetails(
          viewModel: vm,
        );
      },
    );
  }
}

class InvoiceEditDetailsVM {
  final CompanyEntity company;
  final InvoiceEntity invoice;
  final Function(InvoiceEntity) onChanged;
  final BuiltMap<int, ClientEntity> clientMap;
  final BuiltList<int> clientList;

  InvoiceEditDetailsVM({
    @required this.company,
    @required this.invoice,
    @required this.onChanged,
    @required this.clientMap,
    @required this.clientList,
  });

  factory InvoiceEditDetailsVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final invoice = state.invoiceUIState.editing;

    return InvoiceEditDetailsVM(
        company: state.selectedCompany,
        invoice: invoice,
        onChanged: (InvoiceEntity invoice) =>
            store.dispatch(UpdateInvoice(invoice)),
        clientMap: state.clientState.map,
        clientList: state.clientState.list,
    );
  }
}
