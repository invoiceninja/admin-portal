// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/ui/app/forms/client_picker.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ViewClientList implements PersistUI {
  ViewClientList({
    this.force = false,
    this.page = 0,
  });

  final bool force;
  final int? page;
}

class ViewClient implements PersistUI, PersistPrefs {
  ViewClient({
    required this.clientId,
    this.force = false,
  });

  final String? clientId;
  final bool force;
}

class EditClient implements PersistUI, PersistPrefs {
  EditClient(
      {required this.client,
      this.contact,
      this.completer,
      this.cancelCompleter,
      this.force = false});

  final ClientEntity client;
  final ClientContactEntity? contact;
  final Completer? completer;
  final Completer? cancelCompleter;
  final bool force;
}

class EditContact implements PersistUI {
  EditContact([this.contact]);

  final ClientContactEntity? contact;
}

class ShowPdfClient {
  ShowPdfClient({this.client, this.context});

  final ClientEntity? client;
  final BuildContext? context;
}

class UpdateClient implements PersistUI {
  UpdateClient(this.client);

  final ClientEntity client;
}

class LoadClient {
  LoadClient({this.completer, this.clientId});

  final Completer? completer;
  final String? clientId;
}

class LoadClientActivity {
  LoadClientActivity({this.completer, this.clientId});

  final Completer? completer;
  final String? clientId;
}

class LoadClients {
  LoadClients({this.completer, this.page = 1});

  final Completer? completer;
  final int page;
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

  final ClientContactEntity? contact;
}

class UpdateContact implements PersistUI {
  UpdateContact({
    required this.index,
    required this.contact,
  });

  final int index;
  final ClientContactEntity contact;
}

class DeleteContact implements PersistUI {
  DeleteContact(this.index);

  final int index;
}

class SaveClientRequest implements StartSaving {
  SaveClientRequest({this.completer, this.client});

  final Completer? completer;
  final ClientEntity? client;
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

  final List<ClientEntity?> clients;
}

class MergeClientsRequest implements StartSaving {
  MergeClientsRequest({
    this.completer,
    this.clientId,
    this.mergeIntoClientId,
    this.password,
    this.idToken,
  });

  final Completer? completer;
  final String? clientId;
  final String? mergeIntoClientId;
  final String? password;
  final String? idToken;
}

class MergeClientsSuccess implements StopSaving, PersistData {
  MergeClientsSuccess(this.clientId);

  final String? clientId;
}

class MergeClientsFailure implements StopSaving {
  MergeClientsFailure(this.clients);

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

  final List<ClientEntity?> clients;
}

class PurgeClientRequest implements StartSaving {
  PurgeClientRequest({
    required this.completer,
    required this.clientId,
    required this.password,
    required this.idToken,
  });

  final Completer completer;
  final String clientId;
  final String? password;
  final String? idToken;
}

class PurgeClientSuccess implements StopSaving, PersistData {
  PurgeClientSuccess(this.clientId);

  final String clientId;
}

class PurgeClientFailure implements StopSaving {
  PurgeClientFailure(this.error);

  final Object error;
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

  final List<ClientEntity?> clients;
}

class FilterClients implements PersistUI {
  FilterClients(this.filter);

  final String? filter;
}

class SortClients implements PersistUI, PersistPrefs {
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

void handleClientAction(BuildContext? context, List<BaseEntity> clients,
    EntityAction? action) async {
  if (clients.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context!);
  final state = store.state;
  final localization = AppLocalization.of(context);
  final clientIds = clients.map((client) => client.id).toList();
  final client = clients[0] as ClientEntity;

  switch (action) {
    case EntityAction.edit:
      editEntity(entity: client);
      break;
    case EntityAction.viewStatement:
      store.dispatch(ShowPdfClient(client: client, context: context));
      break;
    case EntityAction.clientPortal:
      final contact = client.primaryContact;
      var link = contact.silentLink;
      if (link.isNotEmpty) {
        if (!link.contains('?')) {
          link += '?';
        }
        link += '&client_hash=${client.clientHash}';
        launchUrl(Uri.parse(link));
      }
      break;
    case EntityAction.settings:
      store.dispatch(ViewSettings(
        company: store.state.company,
        user: store.state.user,
        client: client,
        section: state.prefState.isDesktop ? kSettingsLocalization : null,
        clearFilter: true,
      ));
      break;
    case EntityAction.newTask:
      createEntity(
          entity:
              TaskEntity(state: state).rebuild((b) => b..clientId = client.id));
      break;
    case EntityAction.newInvoice:
      createEntity(entity: InvoiceEntity(state: state, client: client));
      break;
    case EntityAction.newRecurringInvoice:
      createEntity(
          entity: InvoiceEntity(
              state: state,
              client: client,
              entityType: EntityType.recurringInvoice));
      break;
    case EntityAction.newRecurringExpense:
      createEntity(
          entity: ExpenseEntity(
              state: state,
              client: client,
              entityType: EntityType.recurringExpense));
      break;
    case EntityAction.newQuote:
      createEntity(
          entity: InvoiceEntity(
        state: state,
        client: client,
        entityType: EntityType.quote,
      ));
      break;
    case EntityAction.newCredit:
      createEntity(
        entity: InvoiceEntity(
          state: state,
          client: client,
          entityType: EntityType.credit,
        ),
      );
      break;
    case EntityAction.newExpense:
      createEntity(
        entity: ExpenseEntity(state: state, client: client),
      );
      break;
    case EntityAction.newPayment:
      createEntity(
        entity: PaymentEntity(state: state, client: client)
            .rebuild((b) => b.clientId = client.id),
      );
      break;
    case EntityAction.newProject:
      createEntity(
        entity:
            ProjectEntity(state: state).rebuild((b) => b.clientId = client.id),
      );
      break;
    case EntityAction.restore:
      final message = clientIds.length > 1
          ? localization!.restoredClients
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', clientIds.length.toString())
          : localization!.restoredClient;
      store.dispatch(
          RestoreClientsRequest(snackBarCompleter<Null>(message), clientIds));
      break;
    case EntityAction.archive:
      final message = clientIds.length > 1
          ? localization!.archivedClients
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', clientIds.length.toString())
          : localization!.archivedClient;
      store.dispatch(
          ArchiveClientsRequest(snackBarCompleter<Null>(message), clientIds));
      break;
    case EntityAction.delete:
      final message = clientIds.length > 1
          ? localization!.deletedClients
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', clientIds.length.toString())
          : localization!.deletedClient;
      store.dispatch(
          DeleteClientsRequest(snackBarCompleter<Null>(message), clientIds));
      break;
    case EntityAction.purge:
      confirmCallback(
          context: context,
          message: '${localization!.purge} - ${client.displayName}',
          callback: (_) {
            passwordCallback(
                alwaysRequire: true,
                context: context,
                callback: (password, idToken) {
                  store.dispatch(
                    PurgeClientRequest(
                        completer: snackBarCompleter<Null>(
                            localization.purgedClient, callback: () {
                          viewEntitiesByType(entityType: EntityType.client);
                        }),
                        clientId: client.id,
                        password: password,
                        idToken: idToken),
                  );
                });
          });
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
      );
      break;
    case EntityAction.documents:
      final documentIds = <String>[];
      for (var client in clients) {
        for (var document in (client as ClientEntity).documents) {
          documentIds.add(document.id);
        }
      }
      if (documentIds.isEmpty) {
        showMessageDialog(message: localization!.noDocumentsToDownload);
      } else {
        store.dispatch(
          DownloadDocumentsRequest(
            documentIds: documentIds,
            completer: snackBarCompleter<Null>(
              localization!.exportedData,
            ),
          ),
        );
      }
      break;
    case EntityAction.merge:
      showDialog<void>(
        context: context,
        builder: (context) => _MergClientPicker(
          client: client,
        ),
      );
      break;
    case EntityAction.runTemplate:
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => RunTemplateDialog(
          entityType: EntityType.client,
          entities: clients,
        ),
      );
      break;
    default:
      print('## Error: action $action not handled in client_actions');
  }
}

class StartClientMultiselect {}

class AddToClientMultiselect {
  AddToClientMultiselect({required this.entity});

  final BaseEntity? entity;
}

class RemoveFromClientMultiselect {
  RemoveFromClientMultiselect({required this.entity});

  final BaseEntity? entity;
}

class ClearClientMultiselect {}

class SaveClientDocumentRequest implements StartSaving {
  SaveClientDocumentRequest({
    required this.isPrivate,
    required this.completer,
    required this.multipartFile,
    required this.client,
  });

  final bool isPrivate;
  final Completer completer;
  final List<MultipartFile> multipartFile;
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

class UpdateClientTab implements PersistUI {
  UpdateClientTab({this.tabIndex});

  final int? tabIndex;
}

class _MergClientPicker extends StatefulWidget {
  const _MergClientPicker({
    Key? key,
    required this.client,
  }) : super(key: key);

  final ClientEntity? client;

  @override
  State<_MergClientPicker> createState() => __MergClientPickerState();
}

class __MergClientPickerState extends State<_MergClientPicker> {
  String? _mergeIntoClientId;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    return AlertDialog(
      title: Text(localization.mergeInto),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClientPicker(
            clientId: _mergeIntoClientId,
            clientState: state.clientState,
            excludeIds: [widget.client!.id],
            onSelected: (client) =>
                setState(() => _mergeIntoClientId = client?.id),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(localization.close),
        ),
        TextButton(
          onPressed: () {
            passwordCallback(
                context: context,
                callback: (password, idToken) {
                  store.dispatch(MergeClientsRequest(
                    clientId: widget.client!.id,
                    idToken: idToken,
                    password: password,
                    mergeIntoClientId: _mergeIntoClientId,
                    completer: snackBarCompleter<Null>(
                      localization.mergedClients,
                    ),
                  ));
                  Navigator.of(context).pop();
                });
          },
          child: Text(localization.merge),
        ),
      ],
    );
  }
}
