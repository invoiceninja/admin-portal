import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';

class ClientViewScreen extends StatelessWidget {
  const ClientViewScreen({
    Key key,
    this.isFilter = false,
  }) : super(key: key);
  final bool isFilter;

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
          isFilter: isFilter,
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

    Future<Null> _handleRefresh(BuildContext context) {
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadClient(
        completer: completer,
        clientId: client.id,
      ));
      return completer.future;
    }

    return ClientViewVM(
      state: state,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: client.isNew,
      client: client,
      company: state.company,
      onEntityPressed: (BuildContext context, EntityType entityType,
          [longPress = false]) {
        switch (entityType) {
          case EntityType.invoice:
            if (longPress && client.isActive) {
              handleClientAction(context, [client], EntityAction.newInvoice);
            } else {
              viewEntitiesByType(
                  context: context,
                  entityType: EntityType.invoice,
                  filterEntity: client);
            }
            break;
          case EntityType.quote:
            if (longPress && client.isActive) {
              handleClientAction(context, [client], EntityAction.newQuote);
            } else {
              viewEntitiesByType(
                  context: context,
                  entityType: EntityType.quote,
                  filterEntity: client);
            }
            break;
          case EntityType.credit:
            if (longPress && client.isActive) {
              handleClientAction(context, [client], EntityAction.newCredit);
            } else {
              viewEntitiesByType(
                  context: context,
                  entityType: EntityType.credit,
                  filterEntity: client);
            }
            break;
          case EntityType.payment:
            if (longPress && client.isActive) {
              handleClientAction(context, [client], EntityAction.newPayment);
            } else {
              viewEntitiesByType(
                  context: context,
                  entityType: EntityType.payment,
                  filterEntity: client);
            }
            break;
          case EntityType.project:
            if (longPress && client.isActive) {
              handleClientAction(context, [client], EntityAction.newProject);
            } else {
              viewEntitiesByType(
                  context: context,
                  entityType: EntityType.project,
                  filterEntity: client);
            }
            break;
          case EntityType.task:
            if (longPress && client.isActive) {
              handleClientAction(context, [client], EntityAction.newTask);
            } else {
              viewEntitiesByType(
                  context: context,
                  entityType: EntityType.task,
                  filterEntity: client);
            }
            break;
          case EntityType.expense:
            if (longPress && client.isActive) {
              handleClientAction(context, [client], EntityAction.newExpense);
            } else {
              viewEntitiesByType(
                  context: context,
                  entityType: EntityType.expense,
                  filterEntity: client);
            }
            break;
        }
      },
      onRefreshed: (context) => _handleRefresh(context),
      onGroupPressed: (context) {
        if (isMobile(context)) {
          viewEntityById(
              context: context,
              entityId: client.groupId,
              entityType: EntityType.group);
        } else {
          store.dispatch(FilterClientsByEntity(
              entityType: EntityType.group, entityId: client.groupId));
        }
      },
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleClientAction(context, [client], action),
    );
  }

  final AppState state;
  final ClientEntity client;
  final CompanyEntity company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext) onGroupPressed;
  final Function(BuildContext, EntityType, [bool]) onEntityPressed;
  final Function(BuildContext) onRefreshed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;

  @override
  bool operator ==(dynamic other) =>
      client == other.client && company == other.company;

  @override
  int get hashCode => client.hashCode ^ company.hashCode;
}
