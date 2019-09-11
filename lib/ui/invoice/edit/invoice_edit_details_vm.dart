import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_details.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

import 'invoice_edit_vm.dart';

class InvoiceEditDetailsScreen extends StatelessWidget {
  const InvoiceEditDetailsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InvoiceEditDetailsVM>(
      converter: (Store<AppState> store) {
        return InvoiceEditDetailsVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return InvoiceEditDetails(
          viewModel: viewModel,
        );
      },
    );
  }
}

class EntityEditDetailsVM {
  EntityEditDetailsVM({
    @required this.company,
    @required this.invoice,
    @required this.onChanged,
    @required this.clientMap,
    @required this.clientList,
    @required this.onAddClientPressed,
  });

  final CompanyEntity company;
  final InvoiceEntity invoice;
  final Function(InvoiceEntity) onChanged;
  final BuiltMap<String, ClientEntity> clientMap;
  final BuiltList<String> clientList;
  final Function(BuildContext context, Completer<SelectableEntity> completer)
      onAddClientPressed;
}

class InvoiceEditDetailsVM extends EntityEditDetailsVM {
  InvoiceEditDetailsVM({
    CompanyEntity company,
    InvoiceEntity invoice,
    Function(InvoiceEntity) onChanged,
    BuiltMap<String, ClientEntity> clientMap,
    BuiltList<String> clientList,
    Function(BuildContext context, Completer<SelectableEntity> completer)
        onAddClientPressed,
  }) : super(
          company: company,
          invoice: invoice,
          onChanged: onChanged,
          clientMap: clientMap,
          clientList: clientList,
          onAddClientPressed: onAddClientPressed,
        );

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
      onAddClientPressed: (context, completer) {
        store.dispatch(EditClient(
            client: ClientEntity(),
            context: context,
            completer: completer,
            cancelCompleter: Completer<Null>()
              ..future.then((_) {
                store.dispatch(UpdateCurrentRoute(InvoiceEditScreen.route));
              }),
            force: true));
        completer.future.then((SelectableEntity client) {
          store.dispatch(UpdateCurrentRoute(InvoiceEditScreen.route));
          Scaffold.of(context).showSnackBar(SnackBar(
              content: SnackBarRow(
            message: AppLocalization.of(context).createdClient,
          )));
        });
      },
    );
  }
}
