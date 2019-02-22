import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
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
  ClientListVM({
    @required this.user,
    @required this.clientList,
    @required this.clientMap,
    @required this.isLoading,
    @required this.isLoaded,
    @required this.filter,
    @required this.onClientTap,
    @required this.onRefreshed,
    @required this.onEntityAction,
  });

  final UserEntity user;
  final List<int> clientList;
  final BuiltMap<int, ClientEntity> clientMap;
  final String filter;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext, ClientEntity) onClientTap;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, ClientEntity, EntityAction) onEntityAction;

  static ClientListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>(null);
      }
      final completer = snackBarCompleter(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadClients(completer: completer, force: true));
      return completer.future;
    }

    final state = store.state;

    return ClientListVM(
      user: state.user,
      clientList: memoizedFilteredClientList(
          state.clientState.map, state.clientState.list, state.clientListState),
      clientMap: state.clientState.map,
      isLoading: state.isLoading,
      isLoaded: state.clientState.isLoaded,
      filter: state.clientListState.filter,
      onClientTap: (context, client) {
        store.dispatch(ViewClient(clientId: client.id, context: context));
      },
      onEntityAction: (context, client, action) {
        final localization = AppLocalization.of(context);
        switch (action) {
          case EntityAction.edit:
            store.dispatch(
                EditClient(context: context, client: client));
            break;
          case EntityAction.newInvoice:
            store.dispatch(EditInvoice(
                invoice: InvoiceEntity(company: state.selectedCompany)
                    .rebuild((b) => b.clientId = client.id),
                context: context));
            break;
          case EntityAction.enterPayment:
            store.dispatch(EditPayment(
                payment: PaymentEntity(company: state.selectedCompany)
                    .rebuild((b) => b.clientId = client.id),
                context: context));
            break;
          case EntityAction.restore:
            store.dispatch(RestoreClientRequest(
                snackBarCompleter(context, localization.restoredClient),
                client.id));
            break;
          case EntityAction.archive:
            store.dispatch(ArchiveClientRequest(
                snackBarCompleter(context, localization.archivedClient),
                client.id));
            break;
          case EntityAction.delete:
            store.dispatch(DeleteClientRequest(
                snackBarCompleter(context, localization.deletedClient),
                client.id));
            break;
        }
        return false;
      },
      onRefreshed: (context) => _handleRefresh(context),
    );
  }
}
