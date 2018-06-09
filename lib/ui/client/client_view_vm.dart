import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/client/client_actions.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/client/client_view.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/ui/app/snackbar_row.dart';

class ClientViewBuilder extends StatelessWidget {
  ClientViewBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClientViewVM>(
      //ignoreChange: (state) => clientSelector(state.client().list, id).isNotPresent,
      converter: (Store<AppState> store) {
        return ClientViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return ClientView(
          viewModel: vm,
        );
      },
    );
  }
}

class ClientViewVM {
  final ClientEntity client;
  final Function onDelete;
  final Function(BuildContext, ClientEntity) onSaveClicked;
  final Function(BuildContext, EntityAction) onActionSelected;
  final bool isLoading;
  final bool isDirty;

  ClientViewVM({
    @required this.client,
    @required this.onDelete,
    @required this.onSaveClicked,
    @required this.onActionSelected,
    @required this.isLoading,
    @required this.isDirty,
  });

  factory ClientViewVM.fromStore(Store<AppState> store) {
    final client = store.state.clientState().editing;

    return ClientViewVM(
      isLoading: store.state.isLoading,
      isDirty: client.id == null,
      client: client,
      onDelete: () => false,
      onSaveClicked: (BuildContext context, ClientEntity client) {
        final Completer<Null> completer = new Completer<Null>();
        store.dispatch(SaveClientRequest(completer, client));
        return completer.future.then((_) {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: SnackBarRow(
                message: client.id == null
                    ? AppLocalization.of(context).successfullyCreatedClient
                    : AppLocalization.of(context).successfullyUpdatedClient,
              ),
              duration: Duration(seconds: 3)));
        });
      },
      onActionSelected: (BuildContext context, EntityAction action) {
        final Completer<Null> completer = new Completer<Null>();
        var message = '';
        switch (action) {
          case EntityAction.archive:
            store.dispatch(ArchiveClientRequest(completer, client.id));
            message = AppLocalization.of(context).successfullyArchivedClient;
            break;
          case EntityAction.delete:
            store.dispatch(DeleteClientRequest(completer, client.id));
            message = AppLocalization.of(context).successfullyDeletedClient;
            break;
          case EntityAction.restore:
            store.dispatch(RestoreClientRequest(completer, client.id));
            message = AppLocalization.of(context).successfullyRestoredClient;
            break;
        }
        return completer.future.then((_) {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: SnackBarRow(
                message: message,
              ),
              duration: Duration(seconds: 3)));
        });
      }
    );
  }
}
