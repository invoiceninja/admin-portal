import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:invoiceninja_flutter/ui/quote/edit/quote_edit_details.dart';
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
      builder: (context, vm) {
        return QuoteEditDetails(
          viewModel: vm,
        );
      },
    );
  }
}

class QuoteEditDetailsVM {
  final CompanyEntity company;
  final InvoiceEntity quote;
  final Function(InvoiceEntity) onChanged;
  final BuiltMap<int, ClientEntity> clientMap;
  final BuiltList<int> clientList;
  final Function(BuildContext context, Completer<SelectableEntity> completer) onAddClientPressed;

  QuoteEditDetailsVM({
    @required this.company,
    @required this.quote,
    @required this.onChanged,
    @required this.clientMap,
    @required this.clientList,
    @required this.onAddClientPressed,
  });

  factory QuoteEditDetailsVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final quote = state.quoteUIState.editing;

    return QuoteEditDetailsVM(
        company: state.selectedCompany,
        quote: quote,
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