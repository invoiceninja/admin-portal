import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/client/client_actions.dart';
import 'package:invoiceninja/ui/app/snackbar_row.dart';
import 'package:invoiceninja/ui/client/edit/client_edit.dart';
import 'package:invoiceninja/ui/client/view/client_view_vm.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:redux/redux.dart';

class ClientEditScreen extends StatelessWidget {
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
  final Function(BuildContext, ClientEntity) onSaveClicked;

  ClientEditVM({
    @required this.isLoading,
    @required this.client,
    @required this.onSaveClicked,
  });

  factory ClientEditVM.fromStore(Store<AppState> store) {
    final client = store.state.clientState().editing;

    return ClientEditVM(
        client: client,
        isLoading: store.state.isLoading,
        onSaveClicked: (BuildContext context, ClientEntity client) {
          final Completer<Null> completer = new Completer<Null>();
          store.dispatch(SaveClientRequest(completer, client));
          return completer.future.then((_) {
            if (client.id == null) {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => ClientViewScreen()));
            } else {
              Navigator.of(context).pop();
            }
            /*
            Scaffold.of(context).showSnackBar(SnackBar(
                content: SnackBarRow(
                  message: client.id == null
                      ? AppLocalization.of(context).successfullyCreatedClient
                      : AppLocalization.of(context).successfullyUpdatedClient,
                ),
                duration: Duration(seconds: 3)));
                */
          });
        });
  }
}
