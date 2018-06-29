import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja/redux/app/app_actions.dart';

class ViewClientList implements PersistUI {}

class ViewClient implements PersistUI {
  final ClientEntity client;
  final BuildContext context;
  ViewClient({this.client, this.context});
}

class EditClient implements PersistUI {
  final ClientEntity client;
  final BuildContext context;
  EditClient({this.client, this.context});
}

class UpdateClient implements PersistUI {
  final ClientEntity client;
  UpdateClient(this.client);
}


class LoadClients {
  final Completer completer;
  final bool force;

  LoadClients([this.completer, this.force = false]);
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


class AddContact implements PersistUI {}

class UpdateContact implements PersistUI {
  final int index;
  final ContactEntity contact;
  UpdateContact({this.index, this.contact});
}

class DeleteContact implements PersistUI {
  final int index;
  DeleteContact(this.index);
}

class SaveClientRequest implements StartLoading {
  final Completer completer;
  final ClientEntity client;
  SaveClientRequest({this.completer, this.client});
}

class SaveClientSuccess implements StopLoading, PersistData {
  final ClientEntity client;

  SaveClientSuccess(this.client);
}

class SaveClientFailure implements StopLoading {
  final String error;
  SaveClientFailure (this.error);
}

class ArchiveClientRequest implements StartLoading {
  final Completer completer;
  final int clientId;

  ArchiveClientRequest(this.completer, this.clientId);
}

class ArchiveClientSuccess implements StopLoading, PersistData {
  final ClientEntity client;
  ArchiveClientSuccess(this.client);
}

class ArchiveClientFailure implements StopLoading {
  final ClientEntity client;
  ArchiveClientFailure(this.client);
}

class DeleteClientRequest implements StartLoading {
  final Completer completer;
  final int clientId;

  DeleteClientRequest(this.completer, this.clientId);
}

class DeleteClientSuccess implements StopLoading, PersistData {
  final ClientEntity client;
  DeleteClientSuccess(this.client);
}

class DeleteClientFailure implements StopLoading {
  final ClientEntity client;
  DeleteClientFailure(this.client);
}

class RestoreClientRequest implements StartLoading {
  final Completer completer;
  final int clientId;
  RestoreClientRequest(this.completer, this.clientId);
}

class RestoreClientSuccess implements StopLoading, PersistData {
  final ClientEntity client;
  RestoreClientSuccess(this.client);
}

class RestoreClientFailure implements StopLoading {
  final ClientEntity client;
  RestoreClientFailure(this.client);
}

class AddClientSuccess implements StopLoading, PersistData {
  final ClientEntity client;
  AddClientSuccess(this.client);
}



class SearchClients {
  final String search;
  SearchClients(this.search);
}

class SortClients implements PersistUI {
  final String field;
  SortClients(this.field);
}

class FilterClientsByState implements PersistUI {
  final EntityState state;

  FilterClientsByState(this.state);
}

class FilterClientDropdown {
  final String filter;
  FilterClientDropdown(this.filter);
}
