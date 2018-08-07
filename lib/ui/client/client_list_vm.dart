import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/client/client_list.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';

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
  final List<int> clientList;
  final BuiltMap<int, ClientEntity> clientMap;
  final String filter;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext, ClientEntity) onClientTap;
  final Function(BuildContext, ClientEntity, DismissDirection) onDismissed;
  final Function(BuildContext) onRefreshed;

  ClientListVM({
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
      final completer = snackBarCompleter(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadClients(completer: completer, force: true));
      return completer.future;
    }

    return ClientListVM(
        clientList: memoizedFilteredClientList(store.state.clientState.map,
            store.state.clientState.list, store.state.clientListState),
        clientMap: store.state.clientState.map,
        isLoading: store.state.isLoading,
        isLoaded: store.state.clientState.isLoaded,
        filter: store.state.clientListState.filter,
        onClientTap: (context, client) {
          store.dispatch(ViewClient(clientId: client.id, context: context));
        },
        onRefreshed: (context) => _handleRefresh(context),
        onDismissed: (BuildContext context, ClientEntity client,
            DismissDirection direction) {
          final localization = AppLocalization.of(context);
          if (direction == DismissDirection.endToStart) {
            if (client.isDeleted || client.isArchived) {
              store.dispatch(RestoreClientRequest(
                  snackBarCompleter(
                      context, localization.successfullyRestoredClient),
                  client.id));
            } else {
              store.dispatch(ArchiveClientRequest(
                  snackBarCompleter(
                      context, localization.successfullyArchivedClient),
                  client.id));
            }
          } else if (direction == DismissDirection.startToEnd) {
            if (client.isDeleted) {
              store.dispatch(RestoreClientRequest(
                  snackBarCompleter(
                      context, localization.successfullyRestoredClient),
                  client.id));
            } else {
              store.dispatch(DeleteClientRequest(
                  snackBarCompleter(
                      context, localization.successfullyDeletedClient),
                  client.id));
            }
          }
        });
  }
}
