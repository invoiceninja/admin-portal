import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class ViewClientList extends AbstractNavigatorAction
    implements PersistUI, StopLoading {
  ViewClientList({
    @required NavigatorState navigator,
    this.force = false,
  }) : super(navigator: navigator);

  final bool force;
}

class ViewClient extends AbstractNavigatorAction
    implements PersistUI, PersistPrefs {
  ViewClient({
    @required NavigatorState navigator,
    @required this.clientId,
    this.force = false,
  }) : super(navigator: navigator);

  final String clientId;
  final bool force;
}

class EditClient extends AbstractNavigatorAction
    implements PersistUI, PersistPrefs {
  EditClient(
      {@required this.client,
      @required NavigatorState navigator,
      this.contact,
      this.completer,
      this.cancelCompleter,
      this.force = false})
      : super(navigator: navigator);

  final ClientEntity client;
  final ContactEntity contact;
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
  LoadClient({this.completer, this.clientId});

  final Completer completer;
  final String clientId;
}

class LoadClientActivity {
  LoadClientActivity({this.completer, this.clientId});

  final Completer completer;
  final String clientId;
}

class LoadClients {
  LoadClients({this.completer});

  final Completer completer;
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

class LoadClientsSuccess implements StopLoading {
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

class ArchiveClientsRequest implements StartSaving {
  ArchiveClientsRequest(this.completer, this.clientIds);

  final Completer completer;
  final List<String> clientIds;
}

class ArchiveClientsSuccess implements StopSaving, PersistData {
  ArchiveClientsSuccess(this.clients);

  final List<ClientEntity> clients;
}

class ArchiveClientsFailure implements StopSaving {
  ArchiveClientsFailure(this.clients);

  final List<ClientEntity> clients;
}

class DeleteClientsRequest implements StartSaving {
  DeleteClientsRequest(this.completer, this.clientIds);

  final Completer completer;
  final List<String> clientIds;
}

class DeleteClientsSuccess implements StopSaving, PersistData {
  DeleteClientsSuccess(this.clients);

  final List<ClientEntity> clients;
}

class DeleteClientsFailure implements StopSaving {
  DeleteClientsFailure(this.clients);

  final List<ClientEntity> clients;
}

class RestoreClientsRequest implements StartSaving {
  RestoreClientsRequest(this.completer, this.clientIds);

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

class FilterClients implements PersistUI {
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

class FilterClientsByCustom3 implements PersistUI {
  FilterClientsByCustom3(this.value);

  final String value;
}

class FilterClientsByCustom4 implements PersistUI {
  FilterClientsByCustom4(this.value);

  final String value;
}

void handleClientAction(
    BuildContext context, List<BaseEntity> clients, EntityAction action) {
  if (clients.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final localization = AppLocalization.of(context);
  final clientIds = clients.map((client) => client.id).toList();
  final client = clients[0];

  switch (action) {
    case EntityAction.edit:
      editEntity(context: context, entity: client);
      break;
    case EntityAction.settings:
      store.dispatch(ViewSettings(
        navigator: Navigator.of(context),
        client: client,
        section: isMobile(context) ? null : kSettingsCompanyDetails,
      ));
      break;
    case EntityAction.newInvoice:
      createEntity(
          context: context,
          entity: InvoiceEntity(state: state, client: client),
          filterEntity: client);
      break;
    case EntityAction.newRecurringInvoice:
      createEntity(
          context: context,
          entity: InvoiceEntity(
              state: state,
              client: client,
              entityType: EntityType.recurringInvoice),
          filterEntity: client);
      break;
    case EntityAction.newQuote:
      createEntity(
        context: context,
        entity: InvoiceEntity(
          state: state,
          client: client,
          entityType: EntityType.quote,
        ),
        filterEntity: client,
      );
      break;
    case EntityAction.newCredit:
      createEntity(
        context: context,
        entity: InvoiceEntity(
          state: state,
          client: client,
          entityType: EntityType.credit,
        ),
        filterEntity: client,
      );
      break;
    case EntityAction.newExpense:
      createEntity(
        context: context,
        entity: ExpenseEntity(state: state, client: client),
        filterEntity: client,
      );
      break;
    case EntityAction.newPayment:
      createEntity(
        context: context,
        entity:
            PaymentEntity(state: state).rebuild((b) => b.clientId = client.id),
        filterEntity: client,
      );
      break;
    case EntityAction.newProject:
      createEntity(
        context: context,
        entity:
            ProjectEntity(state: state).rebuild((b) => b.clientId = client.id),
        filterEntity: client,
      );
      break;
    case EntityAction.restore:
      store.dispatch(RestoreClientsRequest(
          snackBarCompleter<Null>(context, localization.restoredClient),
          clientIds));
      break;
    case EntityAction.archive:
      store.dispatch(ArchiveClientsRequest(
          snackBarCompleter<Null>(context, localization.archivedClient),
          clientIds));
      break;
    case EntityAction.delete:
      store.dispatch(DeleteClientsRequest(
          snackBarCompleter<Null>(context, localization.deletedClient),
          clientIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.clientListState.isInMultiselect()) {
        store.dispatch(StartClientMultiselect());
      }

      if (clients.isEmpty) {
        break;
      }

      for (final client in clients) {
        if (!state.clientListState.isSelected(client.id)) {
          store.dispatch(AddToClientMultiselect(entity: client));
        } else {
          store.dispatch(RemoveFromClientMultiselect(entity: client));
        }
      }
      break;
    case EntityAction.more:
      showEntityActionsDialog(
        entities: [client],
        context: context,
      );
      break;
  }
}

class StartClientMultiselect {}

class AddToClientMultiselect {
  AddToClientMultiselect({@required this.entity});

  final BaseEntity entity;
}

class RemoveFromClientMultiselect {
  RemoveFromClientMultiselect({@required this.entity});

  final BaseEntity entity;
}

class ClearClientMultiselect {}

class SaveClientDocumentRequest implements StartSaving {
  SaveClientDocumentRequest({
    @required this.completer,
    @required this.filePath,
    @required this.client,
  });

  final Completer completer;
  final String filePath;
  final ClientEntity client;
}

class SaveClientDocumentSuccess implements StopSaving, PersistData, PersistUI {
  SaveClientDocumentSuccess(this.document);

  final DocumentEntity document;
}

class SaveClientDocumentFailure implements StopSaving {
  SaveClientDocumentFailure(this.error);

  final Object error;
}
