import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_details.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_details_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class QuoteEditDetailsScreen extends StatelessWidget {
  const QuoteEditDetailsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, QuoteEditDetailsVM>(
      converter: (Store<AppState> store) {
        return QuoteEditDetailsVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return InvoiceEditDetails(
          viewModel: viewModel,
          isQuote: true,
        );
      },
    );
  }
}

class QuoteEditDetailsVM extends EntityEditDetailsVM {

  QuoteEditDetailsVM({
    CompanyEntity company,
    InvoiceEntity invoice,
    Function(InvoiceEntity) onChanged,
    BuiltMap<int, ClientEntity> clientMap,
    BuiltList<int> clientList,
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


  factory QuoteEditDetailsVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final quote = state.quoteUIState.editing;

    return QuoteEditDetailsVM(
        company: state.selectedCompany,
        invoice: quote,
        onChanged: (InvoiceEntity quote) =>
            store.dispatch(UpdateQuote(quote)),
        clientMap: state.clientState.map,
        clientList: state.clientState.list,
        onAddClientPressed: (context, completer) {
          store.dispatch(
              EditClient(client: ClientEntity(), context: context, completer: completer, trackRoute: false));
          completer.future.then((SelectableEntity client) {
            Scaffold.of(context).showSnackBar(SnackBar(
                content: SnackBarRow(
                  message: AppLocalization.of(context).createdClient,
                )
            ));
          });
        },
    );
  }
}