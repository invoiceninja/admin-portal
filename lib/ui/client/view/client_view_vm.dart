import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/redux/ui/ui_actions.dart';
import 'package:invoiceninja/ui/client/client_screen.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/client/client_actions.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/client/view/client_view.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/ui/app/snackbar_row.dart';

class ClientViewScreen extends StatelessWidget {
  static const String route = '/client/view';
  const ClientViewScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClientViewVM>(
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
  final AppState state;
  final ClientEntity client;
  final Function(BuildContext, EntityAction) onActionSelected;
  final Function(BuildContext) onEditPressed;
  final Function onBackPressed;
  final bool isLoading;
  final bool isDirty;

  ClientViewVM({
    @required this.state,
    @required this.client,
    @required this.onActionSelected,
    @required this.onEditPressed,
    @required this.onBackPressed,
    @required this.isLoading,
    @required this.isDirty,
  });

  factory ClientViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final client = state.clientState.map[state.clientUIState.selectedId];

    return ClientViewVM(
        state: store.state,
        isLoading: store.state.isLoading,
        isDirty: client.isNew,
        client: client,
        onEditPressed: (BuildContext context) {
          store.dispatch(EditClient(client: client, context: context));
        },
        onBackPressed: () =>
            store.dispatch(UpdateCurrentRoute(ClientScreen.route)),
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
                )));
          });
        });
  }
}
