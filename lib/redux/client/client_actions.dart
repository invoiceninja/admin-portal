import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ViewClientList implements PersistUI {
  ViewClientList({@required this.context, this.force = false});

  final BuildContext context;
  final bool force;
}

class ViewClient implements PersistUI {
  ViewClient({
    @required this.clientId,
    @required this.context,
    this.force = false,
  });

  final String clientId;
  final BuildContext context;
  final bool force;
}

class EditClient implements PersistUI {
  EditClient(
      {@required this.client,
      @required this.context,
      this.contact,
      this.completer,
      this.cancelCompleter,
      this.force = false});

  final ClientEntity client;
  final ContactEntity contact;
  final BuildContext context;
  final Completer completer;
  final Completer cancelCompleter;
  final bool force;
}

class EditContact implements PersistUI {
  EditContact([this.contact]);

  final ContactEntity contact;
}

class UpdateClient implements PersistUI {
  UpdateClient(this.client);

  final ClientEntity client;
}

class LoadClient {
  LoadClient({this.completer, this.clientId, this.loadActivities = false});

  final Completer completer;
  final String clientId;
  final bool loadActivities;
}

class LoadClientActivity {
  LoadClientActivity({this.completer, this.clientId});

  final Completer completer;
  final String clientId;
}

class LoadClients {
  LoadClients({this.completer, this.force = false});

  final Completer completer;
  final bool force;
}

class LoadClientRequest implements StartLoading {}

class LoadClientFailure implements StopLoading {
  LoadClientFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadClientFailure{error: $error}';
  }
}

class LoadClientSuccess implements StopLoading, PersistData {
  LoadClientSuccess(this.client);

  final ClientEntity client;

  @override
  String toString() {
    return 'LoadClientSuccess{client: $client}';
  }
}

class LoadClientsRequest implements StartLoading {}

class LoadClientsFailure implements StopLoading {
  LoadClientsFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadClientsFailure{error: $error}';
  }
}

class LoadClientsSuccess implements StopLoading, PersistData {
  LoadClientsSuccess(this.clients);

  final BuiltList<ClientEntity> clients;

  @override
  String toString() {
    return 'LoadClientsSuccess{clients: $clients}';
  }
}

class AddContact implements PersistUI {
  AddContact([this.contact]);

  final ContactEntity contact;
}

class UpdateContact implements PersistUI {
  UpdateContact({this.index, this.contact});

  final int index;
  final ContactEntity contact;
}

class DeleteContact implements PersistUI {
  DeleteContact(this.index);

  final int index;
}

class SaveClientRequest implements StartSaving {
  SaveClientRequest({this.completer, this.client});

  final Completer completer;
  final ClientEntity client;
}

class SaveClientSuccess implements StopSaving, PersistData, PersistUI {
  SaveClientSuccess(this.client);

  final ClientEntity client;
}

class AddClientSuccess implements StopSaving, PersistData, PersistUI {
  AddClientSuccess(this.client);

  final ClientEntity client;
}

class SaveClientFailure implements StopSaving {
  SaveClientFailure(this.error);

  final Object error;
}

class ArchiveClientRequest implements StartSaving {
  ArchiveClientRequest(this.completer, this.clientIds);

  final Completer completer;
  final List<String> clientIds;
}

class ArchiveClientSuccess implements StopSaving, PersistData {
  ArchiveClientSuccess(this.clients);

  final List<ClientEntity> clients;
}

class ArchiveClientFailure implements StopSaving {
  ArchiveClientFailure(this.clients);

  final List<ClientEntity> clients;
}

class DeleteClientRequest implements StartSaving {
  DeleteClientRequest(this.completer, this.clientIds);

  final Completer completer;
  final List<String> clientIds;
}

class DeleteClientSuccess implements StopSaving, PersistData {
  DeleteClientSuccess(this.clients);

  final List<ClientEntity> clients;
}

class DeleteClientFailure implements StopSaving {
  DeleteClientFailure(this.clients);

  final List<ClientEntity> clients;
}

class RestoreClientRequest implements StartSaving {
  RestoreClientRequest(this.completer, this.clientIds);

  final Completer completer;
  final List<String> clientIds;
}

class RestoreClientSuccess implements StopSaving, PersistData {
  RestoreClientSuccess(this.clients);

  final List<ClientEntity> clients;
}

class RestoreClientFailure implements StopSaving {
  RestoreClientFailure(this.clients);

  final List<ClientEntity> clients;
}

class FilterClients {
  FilterClients(this.filter);

  final String filter;
}

class SortClients implements PersistUI {
  SortClients(this.field);

  final String field;
}

class FilterClientsByEntity implements PersistUI {
  FilterClientsByEntity({this.entityId, this.entityType});

  final String entityId;
  final EntityType entityType;
}

class FilterClientsByState implements PersistUI {
  FilterClientsByState(this.state);

  final EntityState state;
}

class FilterClientsByCustom1 implements PersistUI {
  FilterClientsByCustom1(this.value);

  final String value;
}

class FilterClientsByCustom2 implements PersistUI {
  FilterClientsByCustom2(this.value);

  final String value;
}

void handleClientAction(
    BuildContext context, List<BaseEntity> clients, EntityAction action) {
  assert(
      [
            EntityAction.restore,
            EntityAction.archive,
            EntityAction.delete,
            EntityAction.toggleMultiselect
          ].contains(action) ||
          clients.length == 1,
      'Cannot perform this action on more than one client');
  final store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final CompanyEntity company = state.selectedCompany;
  final localization = AppLocalization.of(context);
  final clientIds = clients.map((client) => client.id).toList();
  final client = clients[0];

  switch (action) {
    case EntityAction.edit:
      store.dispatch(EditClient(context: context, client: client));
      break;
    case EntityAction.newInvoice:
      store.dispatch(EditInvoice(
          invoice: InvoiceEntity(company: company)
              .rebuild((b) => b.clientId = client.id),
          context: context));
      break;
    case EntityAction.newExpense:
      store.dispatch(EditExpense(
          expense: ExpenseEntity(
              company: company, client: client, uiState: state.uiState),
          context: context));
      break;
    case EntityAction.enterPayment:
      store.dispatch(EditPayment(
          payment: PaymentEntity(company: company)
              .rebuild((b) => b.clientId = client.id),
          context: context));
      break;
    case EntityAction.restore:
      store.dispatch(RestoreClientRequest(
          snackBarCompleter(context, localization.restoredClient), clientIds));
      break;
    case EntityAction.archive:
      store.dispatch(ArchiveClientRequest(
          snackBarCompleter(context, localization.archivedClient), clientIds));
      break;
    case EntityAction.delete:
      store.dispatch(DeleteClientRequest(
          snackBarCompleter(context, localization.deletedClient), clientIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.clientListState.isInMultiselect()) {
        store.dispatch(StartClientMultiselect(context: context));
      }

      if (clients.isEmpty) {
        break;
      }

      for (final client in clients) {
        if (!state.clientListState.isSelected(client)) {
          store.dispatch(
              AddToClientMultiselect(context: context, entity: client));
        } else {
          store.dispatch(
              RemoveFromClientMultiselect(context: context, entity: client));
        }
      }
      break;
  }
}

class StartClientMultiselect {
  StartClientMultiselect({@required this.context});

  final BuildContext context;
}

class AddToClientMultiselect {
  AddToClientMultiselect({@required this.context, @required this.entity});

  final BuildContext context;
  final BaseEntity entity;
}

class RemoveFromClientMultiselect {
  RemoveFromClientMultiselect({@required this.context, @required this.entity});

  final BuildContext context;
  final BaseEntity entity;
}

class ClearClientMultiselect {
  ClearClientMultiselect({@required this.context});

  final BuildContext context;
}
