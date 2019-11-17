import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/client/client_screen.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';

class ClientViewScreen extends StatelessWidget {
  const ClientViewScreen({Key key}) : super(key: key);

  static const String route = '/client/view';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClientViewVM>(
      //distinct: true,
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
  ClientViewVM({
    @required this.state,
    @required this.client,
    @required this.company,
    @required this.onEntityAction,
    @required this.onEntityPressed,
    @required this.onEditPressed,
    @required this.onBackPressed,
    @required this.isSaving,
    @required this.isLoading,
    @required this.isDirty,
    @required this.onRefreshed,
    @required this.onGroupPressed,
  });

  factory ClientViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final client = state.clientState.map[state.clientUIState.selectedId] ??
        ClientEntity(id: state.clientUIState.selectedId);

    Future<Null> _handleRefresh(BuildContext context, bool loadActivities) {
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadClient(
          completer: completer,
          clientId: client.id,
          loadActivities: loadActivities));
      return completer.future;
    }

    return ClientViewVM(
      state: state,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: client.isNew,
      client: client,
      company: state.company,
      onEditPressed: (BuildContext context) {
        editEntity(
            context: context,
            entity: client,
            completer: snackBarCompleter<ClientEntity>(
                context, AppLocalization.of(context).updatedClient));
      },
      onEntityPressed: (BuildContext context, EntityType entityType,
          [longPress = false]) {
        switch (entityType) {
          case EntityType.invoice:
            if (longPress && client.isActive) {
              createEntity(
                  context: context,
                  entity:
                      InvoiceEntity(state: state, client: client));
            } else {
              viewEntitiesByType(
                  context: context,
                  entityType: EntityType.invoice,
                  filterEntity: client);
            }
            break;
          case EntityType.quote:
            if (longPress && client.isActive) {
              createEntity(
                  context: context,
                  entity: InvoiceEntity(
                      state: state, client: client, isQuote: true));
            } else {
              viewEntitiesByType(
                  context: context,
                  entityType: EntityType.quote,
                  filterEntity: client);
            }
            break;
          case EntityType.payment:
            if (longPress && client.isActive) {
              createEntity(
                  context: context,
                  entity: PaymentEntity(state: state)
                      .rebuild((b) => b..clientId = client.id));
            } else {
              viewEntitiesByType(
                  context: context,
                  entityType: EntityType.payment,
                  filterEntity: client);
            }
            break;
          case EntityType.project:
            if (longPress && client.isActive) {
              createEntity(
                  context: context,
                  entity:
                      ProjectEntity().rebuild((b) => b..clientId = client.id));
            } else {
              viewEntitiesByType(
                  context: context,
                  entityType: EntityType.project,
                  filterEntity: client);
            }
            break;
          case EntityType.task:
            if (longPress && client.isActive) {
              createEntity(
                  context: context,
                  entity: TaskEntity(state: state)
                      .rebuild((b) => b..clientId = client.id));
            } else {
              viewEntitiesByType(
                  context: context,
                  entityType: EntityType.task,
                  filterEntity: client);
            }
            break;
          case EntityType.expense:
            if (longPress && client.isActive) {
              createEntity(
                  context: context,
                  entity: ExpenseEntity(
                      state: state,
                      client: client,));
            } else {
              viewEntitiesByType(
                  context: context,
                  entityType: EntityType.expense,
                  filterEntity: client);
            }
            break;
        }
      },
      onRefreshed: (context, loadActivities) =>
          _handleRefresh(context, loadActivities),
      onBackPressed: () {
        if (state.uiState.currentRoute.contains(ClientScreen.route)) {
          store.dispatch(UpdateCurrentRoute(ClientScreen.route));
        }
      },
      onGroupPressed: (context) {
        viewEntityById(
            context: context,
            entityId: client.groupId,
            entityType: EntityType.group);
      },
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleClientAction(context, [client], action),
    );
  }

  final AppState state;
  final ClientEntity client;
  final CompanyEntity company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext) onEditPressed;
  final Function onBackPressed;
  final Function(BuildContext) onGroupPressed;
  final Function(BuildContext, EntityType, [bool]) onEntityPressed;
  final Function(BuildContext, bool) onRefreshed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;

  @override
  bool operator ==(dynamic other) =>
      client == other.client && company == other.company;

  @override
  int get hashCode => client.hashCode ^ company.hashCode;
}
