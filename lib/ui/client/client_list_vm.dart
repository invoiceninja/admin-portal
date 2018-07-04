
import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja/redux/client/client_selectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/ui/app/snackbar_row.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/client/client_list.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/client/client_actions.dart';

class ClientListBuilder extends StatelessWidget {
  const ClientListBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClientListVM>(
      //rebuildOnChange: true,
      converter: ClientListVM.fromStore,
      builder: (context, vm) {
        return ClientList(
          viewModel: vm,
        );
      },
    );
  }
}

class ClientListVM {
  final AppState state;
  final List<int> clientList;
  final BuiltMap<int, ClientEntity> clientMap;
  final String filter;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext, ClientEntity) onClientTap;
  final Function(BuildContext, ClientEntity, DismissDirection) onDismissed;
  final Function(BuildContext) onRefreshed;

  ClientListVM({
    @required this.state,
    @required this.clientList,
    @required this.clientMap,
    @required this.isLoading,
    @required this.isLoaded,
    @required this.filter,
    @required this.onClientTap,
    @required this.onDismissed,
    @required this.onRefreshed,
  });

  static ClientListVM fromStore(Store<AppState> store) {
      Future<Null> _handleRefresh(BuildContext context) {
        final Completer<Null> completer = new Completer<Null>();
        store.dispatch(LoadClients(completer, true));
        return completer.future.then((_) {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: SnackBarRow(
                message: AppLocalization.of(context).refreshComplete,
              )));
        });
      }

    return ClientListVM(
        state: store.state,
        clientList: memoizedClientList(store.state.clientState.map, store.state.clientState.list, store.state.clientListState),
        clientMap: store.state.clientState.map,
        isLoading: store.state.isLoading,
        isLoaded: store.state.clientState.isLoaded,
        filter: store.state.clientListState.search,
        onClientTap: (context, client) {
          store.dispatch(ViewClient(clientId: client.id, context: context));
        },
        onRefreshed: (context) => _handleRefresh(context),
        onDismissed: (BuildContext context, ClientEntity client,
            DismissDirection direction) {
          final Completer<Null> completer = new Completer<Null>();
          var message = '';
          if (direction == DismissDirection.endToStart) {
            if (client.isDeleted || client.isArchived) {
              store.dispatch(RestoreClientRequest(completer, client.id));
              message = AppLocalization.of(context).successfullyRestoredClient;
            } else {
              store.dispatch(ArchiveClientRequest(completer, client.id));
              message = AppLocalization.of(context).successfullyArchivedClient;
            }
          } else if (direction == DismissDirection.startToEnd) {
            if (client.isDeleted) {
              store.dispatch(RestoreClientRequest(completer, client.id));
              message = AppLocalization.of(context).successfullyRestoredClient;
            } else {
              store.dispatch(DeleteClientRequest(completer, client.id));
              message = AppLocalization.of(context).successfullyDeletedClient;
            }
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
