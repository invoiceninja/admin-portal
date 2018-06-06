import 'dart:async';

import 'package:invoiceninja/data/models/models.dart';
import 'package:built_collection/built_collection.dart';

class LoadClientsAction {
  final Completer completer;
  final bool force;

  LoadClientsAction([this.completer, this.force = false]);
}

class LoadClientsRequest {}

class LoadClientsFailure {
  final dynamic error;
  LoadClientsFailure(this.error);

  @override
  String toString() {
    return 'LoadClientsFailure{error: $error}';
  }
}

class LoadClientsSuccess {
  final BuiltList<ClientEntity> clients;
  LoadClientsSuccess(this.clients);

  @override
  String toString() {
    return 'LoadClientsSuccess{clients: $clients}';
  }
}

class SelectClientAction {
  final ClientEntity client;
  SelectClientAction(this.client);
}

class SaveClientRequest {
  final Completer completer;
  final ClientEntity client;
  SaveClientRequest(this.completer, this.client);
}

class SaveClientSuccess {
  final ClientEntity client;

  SaveClientSuccess(this.client);
}

class ArchiveClientRequest {
  final Completer completer;
  final int clientId;

  ArchiveClientRequest(this.completer, this.clientId);
}
class ArchiveClientSuccess {
  final ClientEntity client;
  ArchiveClientSuccess(this.client);
}
class ArchiveClientFailure {
  final ClientEntity client;
  ArchiveClientFailure(this.client);
}

class DeleteClientRequest {
  final Completer completer;
  final int clientId;

  DeleteClientRequest(this.completer, this.clientId);
}
class DeleteClientSuccess {
  final ClientEntity client;
  DeleteClientSuccess(this.client);
}
class DeleteClientFailure {
  final ClientEntity client;
  DeleteClientFailure(this.client);
}

class RestoreClientRequest {
  final Completer completer;
  final int clientId;
  RestoreClientRequest(this.completer, this.clientId);
}
class RestoreClientSuccess {
  final ClientEntity client;
  RestoreClientSuccess(this.client);
}
class RestoreClientFailure {
  final ClientEntity client;
  RestoreClientFailure(this.client);
}

class AddClientSuccess {
  final ClientEntity client;
  AddClientSuccess(this.client);
}

class SaveClientFailure {
  final String error;
  SaveClientFailure (this.error);
}


class SearchClients {
  final String search;
  SearchClients(this.search);
}

class SortClients {
  final String field;
  SortClients(this.field);
}

class FilterClientsByState {
  final EntityState state;

  FilterClientsByState(this.state);
}
