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
import 'package:invoiceninja_flutter/ui/project/edit/project_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/quote/edit/quote_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/task/edit/task_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';

class ClientEditScreen extends StatelessWidget {
  const ClientEditScreen({Key key}) : super(key: key);

  static const String route = '/client/edit';

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
  ClientEditVM({
    @required this.company,
    @required this.isSaving,
    @required this.client,
    @required this.origClient,
    @required this.onChanged,
    @required this.onSavePressed,
    @required this.onBackPressed,
    @required this.staticState,
    @required this.copyBillingAddress,
    @required this.copyShippingAddress,
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
        onBackPressed: () {
          if (state.uiState.currentRoute.contains(ClientScreen.route)) {
            store.dispatch(UpdateCurrentRoute(
                client.isNew ? ClientScreen.route : ClientViewScreen.route));
          }
        },
        onChanged: (ClientEntity client) =>
            store.dispatch(UpdateClient(client)),
        copyBillingAddress: () =>
            store.dispatch(UpdateClient(client.rebuild((b) => b
              ..shippingAddress1 = client.address1
              ..shippingAddress2 = client.address2
              ..shippingCity = client.city
              ..shippingState = client.state
              ..shippingPostalCode = client.postalCode
              ..shippingCountryId = client.countryId))),
        copyShippingAddress: () =>
            store.dispatch(UpdateClient(client.rebuild((b) => b
              ..address1 = client.shippingAddress1
              ..address2 = client.shippingAddress2
              ..city = client.shippingCity
              ..state = client.shippingState
              ..postalCode = client.shippingPostalCode
              ..countryId = client.shippingCountryId))),
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
            if (state.uiState.currentRoute.contains(ClientScreen.route)) {
              store.dispatch(UpdateCurrentRoute(ClientViewScreen.route));
            }
            if (client.isNew) {
              if ([
                InvoiceEditScreen.route,
                QuoteEditScreen.route,
                ProjectEditScreen.route,
                TaskEditScreen.route,
              ].contains(store.state.uiState.currentRoute)) {
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

  final CompanyEntity company;
  final bool isSaving;
  final ClientEntity client;
  final ClientEntity origClient;
  final Function(ClientEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function onBackPressed;
  final StaticState staticState;
  final Function() copyShippingAddress;
  final Function() copyBillingAddress;
}
