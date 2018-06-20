import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/client/client_actions.dart';
import 'package:invoiceninja/redux/ui/ui_actions.dart';
import 'package:invoiceninja/ui/app/snackbar_row.dart';
import 'package:invoiceninja/ui/client/client_screen.dart';
import 'package:invoiceninja/ui/client/edit/client_edit.dart';
import 'package:invoiceninja/ui/client/view/client_view_vm.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:redux/redux.dart';

class ClientEditScreen extends StatelessWidget {
  static final String route = '/client/edit';
  ClientEditScreen({Key key}) : super(key: key);

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
  final bool isLoading;
  final ClientEntity client;
  final Function(ClientEntity) onChanged;
  final Function() onAddContactPressed;
  final Function(int) onRemoveContactPressed;
  final Function(ContactEntity, int) onChangedContact;
  final Function(BuildContext) onSavePressed;
  final Function onBackPressed;

  ClientEditVM({
    @required this.isLoading,
    @required this.client,
    @required this.onAddContactPressed,
    @required this.onRemoveContactPressed,
    @required this.onChangedContact,
    @required this.onChanged,
    @required this.onSavePressed,
    @required this.onBackPressed,
  });

  factory ClientEditVM.fromStore(Store<AppState> store) {
    final client = store.state.clientUIState.selected;

    return ClientEditVM(
        client: client,
        isLoading: store.state.isLoading,
        onBackPressed: () =>
            store.dispatch(UpdateCurrentRoute(ClientScreen.route)),
        onAddContactPressed: () => store.dispatch(AddContact()),
        onRemoveContactPressed: (index) => store.dispatch(DeleteContact(index)),
        onChangedContact: (contact, index) {
          store.dispatch(UpdateContact(contact: contact, index: index));
        },
        onChanged: (ClientEntity client) =>
            store.dispatch(UpdateClient(client)),
        onSavePressed: (BuildContext context) {
          final Completer<Null> completer = new Completer<Null>();
          store.dispatch(
              SaveClientRequest(completer: completer, client: client));
          return completer.future.then((_) {
            if (client.isNew()) {
              Navigator.of(context).pop();
              Navigator
                  .of(context)
                  .push(MaterialPageRoute(builder: (_) => ClientViewScreen()));
            } else {
              Navigator.of(context).pop();
            }
            /*
            Scaffold.of(context).showSnackBar(SnackBar(
                content: SnackBarRow(
                  message: client.isNew()
                      ? AppLocalization.of(context).successfullyCreatedClient
                      : AppLocalization.of(context).successfullyUpdatedClient,
                ),
                duration: Duration(seconds: 3)));
            */
          });
        });
  }
}
