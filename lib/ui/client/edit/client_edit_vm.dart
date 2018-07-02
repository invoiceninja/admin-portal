import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/client/client_actions.dart';
import 'package:invoiceninja/redux/ui/ui_actions.dart';
import 'package:invoiceninja/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja/ui/client/client_screen.dart';
import 'package:invoiceninja/ui/client/edit/client_edit.dart';
import 'package:invoiceninja/ui/client/view/client_view_vm.dart';
import 'package:redux/redux.dart';

class ClientEditScreen extends StatelessWidget {
  static const String route = '/client/edit';
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
  final ClientEntity origClient;
  final Function(ClientEntity) onChanged;
  final Function() onAddContactPressed;
  final Function(int) onRemoveContactPressed;
  final Function(ContactEntity, int) onChangedContact;
  final Function(BuildContext) onSavePressed;
  final Function onBackPressed;
  final BuiltMap<int, CountryEntity> countryMap;

  ClientEditVM({
    @required this.isLoading,
    @required this.client,
    @required this.origClient,
    @required this.onAddContactPressed,
    @required this.onRemoveContactPressed,
    @required this.onChangedContact,
    @required this.onChanged,
    @required this.onSavePressed,
    @required this.onBackPressed,
    @required this.countryMap,
  });

  factory ClientEditVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final client = state.clientUIState.editing;

    return ClientEditVM(
        client: client,
        origClient: state.clientState.map[client.id],
        countryMap: state.staticState.countryMap,
        isLoading: state.isLoading,
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
            if (client.isNew) {
              Navigator.of(context).pop();
              Navigator
                  .of(context)
                  .push<ClientViewScreen>(MaterialPageRoute(builder: (_) => ClientViewScreen()));
            } else {
              Navigator.of(context).pop();
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
