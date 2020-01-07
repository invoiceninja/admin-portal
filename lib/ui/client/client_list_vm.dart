import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'package:invoiceninja_flutter/ui/client/client_list.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';

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
  ClientListVM({
    @required this.state,
    @required this.clientList,
    @required this.clientMap,
    @required this.isLoading,
    @required this.isLoaded,
    @required this.filter,
    @required this.onClientTap,
    @required this.onRefreshed,
    @required this.columnFields,
    @required this.onEntityAction,
    @required this.onClearEntityFilterPressed,
    @required this.onViewEntityFilterPressed,
  });

  final AppState state;
  final List<String> clientList;
  final BuiltMap<String, ClientEntity> clientMap;
  final String filter;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext, ClientEntity) onClientTap;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, List<ClientEntity>, EntityAction) onEntityAction;
  final Function onClearEntityFilterPressed;
  final Function(BuildContext) onViewEntityFilterPressed;
  final List<String> columnFields;

  static ClientListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>(null);
      }
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadClients(completer: completer, force: true));
      return completer.future;
    }

    final state = store.state;

    return ClientListVM(
      state: state,
      clientList: memoizedFilteredClientList(state.clientState.map,
          state.clientState.list, state.groupState.map, state.clientListState),
      clientMap: state.clientState.map,
      isLoading: state.isLoading,
      isLoaded: state.clientState.isLoaded,
      filter: state.clientListState.filter,
      onClientTap: (context, client) {
        viewEntity(context: context, entity: client);
      },
      onRefreshed: (context) => _handleRefresh(context),
      onEntityAction: (BuildContext context, List<BaseEntity> client,
              EntityAction action) =>
          handleClientAction(context, client, action),
      onClearEntityFilterPressed: () => store.dispatch(FilterClientsByEntity()),
      onViewEntityFilterPressed: (BuildContext context) => viewEntityById(
          context: context,
          entityId: state.clientListState.filterEntityId,
          entityType: state.clientListState.filterEntityType),
      columnFields: state.userCompany.getTableColumns(EntityType.client),
    );
  }
}
