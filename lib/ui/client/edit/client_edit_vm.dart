import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/client/client_screen.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/quote/edit/quote_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';

class ClientEditScreen extends StatelessWidget {
  static const String route = '/client/edit';

  const ClientEditScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClientEditVM>(
      converter: (Store<AppState> store) {
        return ClientEditVM.fromStore(store);
      },
      builder: (context, vm) {
        return ClientEdit(
          viewModel: vm,
        );
      },
    );
  }
}

class ClientEditVM {
  final CompanyEntity company;
  final bool isSaving;
  final ClientEntity client;
  final ClientEntity origClient;
  final Function(ClientEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function onBackPressed;
  final StaticState staticState;

  ClientEditVM({
    @required this.company,
    @required this.isSaving,
    @required this.client,
    @required this.origClient,
    @required this.onChanged,
    @required this.onSavePressed,
    @required this.onBackPressed,
    @required this.staticState,
  });

  factory ClientEditVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final client = state.clientUIState.editing;

    return ClientEditVM(
        company: state.selectedCompany,
        client: client,
        origClient: state.clientState.map[client.id],
        staticState: state.staticState,
        isSaving: state.isSaving,
        onBackPressed: () =>
            store.dispatch(UpdateCurrentRoute(ClientScreen.route)),
        onChanged: (ClientEntity client) =>
            store.dispatch(UpdateClient(client)),
        onSavePressed: (BuildContext context) {
          if (!client.hasNameSet) {
            showDialog<ErrorDialog>(
                context: context,
                builder: (BuildContext context) {
                  return ErrorDialog(AppLocalization.of(context)
                      .pleaseEnterAClientOrContactName);
                });
            return null;
          }
          final Completer<ClientEntity> completer = Completer<ClientEntity>();
          store.dispatch(
              SaveClientRequest(completer: completer, client: client));
          return completer.future.then((savedClient) {
            if (client.isNew) {
              if ([InvoiceEditScreen.route, QuoteEditScreen.route]
                  .contains(store.state.uiState.currentRoute)) {
                Navigator.of(context).pop(savedClient);
              } else {
                Navigator.of(context)
                    .pushReplacementNamed(ClientViewScreen.route);
              }
            } else {
              Navigator.of(context).pop(savedClient);
            }
          }).catchError((Object error) {
            showDialog<ErrorDialog>(
                context: context,
                builder: (BuildContext context) {
                  return ErrorDialog(error);
                });
          });
        });
  }
}
