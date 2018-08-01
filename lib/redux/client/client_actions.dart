import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';

class ViewClientList implements PersistUI {
  final BuildContext context;
  ViewClientList(this.context);
}

class ViewClient implements PersistUI {
  final int clientId;
  final BuildContext context;
  ViewClient({this.clientId, this.context});
}

class EditClient implements PersistUI {
  final ClientEntity client;
  final ContactEntity contact;
  final BuildContext context;
  final Completer completer;
  final bool trackRoute;
  EditClient({this.client, this.contact, this.context, this.completer, this.trackRoute = true});
}

class EditContact implements PersistUI {
  final ContactEntity contact;
  EditContact([this.contact]);
}

class UpdateClient implements PersistUI {
  final ClientEntity client;
  UpdateClient(this.client);
}

class LoadClient {
  final Completer completer;
  final int clientId;

  LoadClient({this.completer, this.clientId});
}

class LoadClients {
  final Completer completer;
  final bool force;

  LoadClients({this.completer, this.force = false});
}

class LoadClientRequest implements StartLoading {}

class LoadClientFailure implements StopLoading {
  final dynamic error;
  LoadClientFailure(this.error);

  @override
  String toString() {
    return 'LoadClientFailure{error: $error}';
  }
}

class LoadClientSuccess implements StopLoading, PersistData {
  final ClientEntity client;
  LoadClientSuccess(this.client);

  @override
  String toString() {
    return 'LoadClientSuccess{client: $client}';
  }
}

class LoadClientsRequest implements StartLoading {}

class LoadClientsFailure implements StopLoading {
  final dynamic error;
  LoadClientsFailure(this.error);

  @override
  String toString() {
    return 'LoadClientsFailure{error: $error}';
  }
}

class LoadClientsSuccess implements StopLoading, PersistData {
  final BuiltList<ClientEntity> clients;
  LoadClientsSuccess(this.clients);

  @override
  String toString() {
    return 'LoadClientsSuccess{clients: $clients}';
  }
}


class AddContact implements PersistUI {
  final ContactEntity contact;
  AddContact([this.contact]);
}

class UpdateContact implements PersistUI {
  final int index;
  final ContactEntity contact;
  UpdateContact({this.index, this.contact});
}

class DeleteContact implements PersistUI {
  final int index;
  DeleteContact(this.index);
}

class SaveClientRequest implements StartSaving {
  final Completer completer;
  final ClientEntity client;
  SaveClientRequest({this.completer, this.client});
}

class SaveClientSuccess implements StopSaving, PersistData, PersistUI {
  final ClientEntity client;

  SaveClientSuccess(this.client);
}

class AddClientSuccess implements StopSaving, PersistData, PersistUI {
  final ClientEntity client;
  AddClientSuccess(this.client);
}

class SaveClientFailure implements StopSaving {
  final Object error;
  SaveClientFailure (this.error);
}

class ArchiveClientRequest implements StartSaving {
  final Completer completer;
  final int clientId;

  ArchiveClientRequest(this.completer, this.clientId);
}

class ArchiveClientSuccess implements StopSaving, PersistData {
  final ClientEntity client;
  ArchiveClientSuccess(this.client);
}

class ArchiveClientFailure implements StopSaving {
  final ClientEntity client;
  ArchiveClientFailure(this.client);
}

class DeleteClientRequest implements StartSaving {
  final Completer completer;
  final int clientId;

  DeleteClientRequest(this.completer, this.clientId);
}

class DeleteClientSuccess implements StopSaving, PersistData {
  final ClientEntity client;
  DeleteClientSuccess(this.client);
}

class DeleteClientFailure implements StopSaving {
  final ClientEntity client;
  DeleteClientFailure(this.client);
}

class RestoreClientRequest implements StartSaving {
  final Completer completer;
  final int clientId;
  RestoreClientRequest(this.completer, this.clientId);
}

class RestoreClientSuccess implements StopSaving, PersistData {
  final ClientEntity client;
  RestoreClientSuccess(this.client);
}

class RestoreClientFailure implements StopSaving {
  final ClientEntity client;
  RestoreClientFailure(this.client);
}




class FilterClients {
  final String filter;
  FilterClients(this.filter);
}

class SortClients implements PersistUI {
  final String field;
  SortClients(this.field);
}

class FilterClientsByState implements PersistUI {
  final EntityState state;

  FilterClientsByState(this.state);
}
