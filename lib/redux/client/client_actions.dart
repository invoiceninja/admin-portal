import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';

class ViewClientList implements PersistUI {
  ViewClientList(this.context);

  final BuildContext context;
}

class ViewClient implements PersistUI {
  ViewClient({this.clientId, this.context});

  final int clientId;
  final BuildContext context;
}

class EditClient implements PersistUI {
  EditClient(
      {this.client,
      this.contact,
      this.context,
      this.completer,
      this.trackRoute = true});

  final ClientEntity client;
  final ContactEntity contact;
  final BuildContext context;
  final Completer completer;
  final bool trackRoute;
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
  final int clientId;
  final bool loadActivities;
}

class LoadClientActivity {
  LoadClientActivity({this.completer, this.clientId});

  final Completer completer;
  final int clientId;
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
  ArchiveClientRequest(this.completer, this.clientId);

  final Completer completer;
  final int clientId;
}

class ArchiveClientSuccess implements StopSaving, PersistData {
  ArchiveClientSuccess(this.client);

  final ClientEntity client;
}

class ArchiveClientFailure implements StopSaving {
  ArchiveClientFailure(this.client);

  final ClientEntity client;
}

class DeleteClientRequest implements StartSaving {
  DeleteClientRequest(this.completer, this.clientId);

  final Completer completer;
  final int clientId;
}

class DeleteClientSuccess implements StopSaving, PersistData {
  DeleteClientSuccess(this.client);

  final ClientEntity client;
}

class DeleteClientFailure implements StopSaving {
  DeleteClientFailure(this.client);

  final ClientEntity client;
}

class RestoreClientRequest implements StartSaving {
  RestoreClientRequest(this.completer, this.clientId);

  final Completer completer;
  final int clientId;
}

class RestoreClientSuccess implements StopSaving, PersistData {
  RestoreClientSuccess(this.client);

  final ClientEntity client;
}

class RestoreClientFailure implements StopSaving {
  RestoreClientFailure(this.client);

  final ClientEntity client;
}

class FilterClients {
  FilterClients(this.filter);

  final String filter;
}

class SortClients implements PersistUI {
  SortClients(this.field);

  final String field;
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
