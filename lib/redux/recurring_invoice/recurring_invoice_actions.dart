// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/design/design_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ViewRecurringInvoiceList implements PersistUI {
  ViewRecurringInvoiceList({
    this.force = false,
    this.page = 0,
  });

  final bool force;
  final int? page;
}

class ViewRecurringInvoice implements PersistUI, PersistPrefs {
  ViewRecurringInvoice({
    required this.recurringInvoiceId,
    this.force = false,
  });

  final String? recurringInvoiceId;
  final bool force;
}

class EditRecurringInvoice implements PersistUI, PersistPrefs {
  EditRecurringInvoice(
      {required this.recurringInvoice,
      this.completer,
      this.cancelCompleter,
      this.itemIndex,
      this.force = false});

  final InvoiceEntity recurringInvoice;
  final int? itemIndex;
  final Completer? completer;
  final Completer? cancelCompleter;
  final bool force;
}

class ShowEmailRecurringInvoice {
  ShowEmailRecurringInvoice({this.invoice, this.context, this.completer});

  final InvoiceEntity? invoice;
  final BuildContext? context;
  final Completer? completer;
}

class ShowPdfRecurringInvoice {
  ShowPdfRecurringInvoice({this.invoice, this.context, this.activityId});

  final InvoiceEntity? invoice;
  final BuildContext? context;
  final String? activityId;
}

class EditRecurringInvoiceItem implements PersistUI {
  EditRecurringInvoiceItem([this.itemIndex]);

  final int? itemIndex;
}

class UpdateRecurringInvoice implements PersistUI {
  UpdateRecurringInvoice(this.recurringInvoice);

  final InvoiceEntity recurringInvoice;
}

class UpdateRecurringInvoiceClient implements PersistUI {
  UpdateRecurringInvoiceClient({this.client});

  final ClientEntity? client;
}

class LoadRecurringInvoice {
  LoadRecurringInvoice({this.completer, this.recurringInvoiceId});

  final Completer? completer;
  final String? recurringInvoiceId;
}

class LoadRecurringInvoiceActivity {
  LoadRecurringInvoiceActivity({this.completer, this.recurringInvoiceId});

  final Completer? completer;
  final String? recurringInvoiceId;
}

class LoadRecurringInvoices {
  LoadRecurringInvoices({this.completer, this.page = 1});

  final Completer? completer;
  final int page;
}

class LoadRecurringInvoiceRequest implements StartLoading {}

class LoadRecurringInvoiceFailure implements StopLoading {
  LoadRecurringInvoiceFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadRecurringInvoiceFailure{error: $error}';
  }
}

class LoadRecurringInvoiceSuccess implements StopLoading, PersistData {
  LoadRecurringInvoiceSuccess(this.recurringInvoice);

  final InvoiceEntity recurringInvoice;

  @override
  String toString() {
    return 'LoadRecurringInvoiceSuccess{recurringInvoice: $recurringInvoice}';
  }
}

class LoadRecurringInvoicesRequest implements StartLoading {}

class LoadRecurringInvoicesFailure implements StopLoading {
  LoadRecurringInvoicesFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadRecurringInvoicesFailure{error: $error}';
  }
}

class LoadRecurringInvoicesSuccess implements StopLoading {
  LoadRecurringInvoicesSuccess(this.recurringInvoices);

  final BuiltList<InvoiceEntity> recurringInvoices;

  @override
  String toString() {
    return 'LoadRecurringInvoicesSuccess{recurringInvoices: $recurringInvoices}';
  }
}

class AddRecurringInvoiceContact implements PersistUI {
  AddRecurringInvoiceContact({this.contact, this.invitation});

  final ClientContactEntity? contact;
  final InvitationEntity? invitation;
}

class RemoveRecurringInvoiceContact implements PersistUI {
  RemoveRecurringInvoiceContact({this.invitation});

  final InvitationEntity? invitation;
}

class SaveRecurringInvoiceRequest implements StartSaving {
  SaveRecurringInvoiceRequest({
    this.completer,
    this.recurringInvoice,
    this.action,
  });

  final Completer? completer;
  final InvoiceEntity? recurringInvoice;
  final EntityAction? action;
}

class SaveRecurringInvoiceSuccess
    implements StopSaving, PersistData, PersistUI {
  SaveRecurringInvoiceSuccess(this.recurringInvoice);

  final InvoiceEntity recurringInvoice;
}

class AddRecurringInvoiceSuccess implements StopSaving, PersistData, PersistUI {
  AddRecurringInvoiceSuccess(this.recurringInvoice);

  final InvoiceEntity recurringInvoice;
}

class AddRecurringInvoiceItem implements PersistUI {
  AddRecurringInvoiceItem({this.invoiceItem});

  final InvoiceItemEntity? invoiceItem;
}

class MoveRecurringInvoiceItem implements PersistUI {
  MoveRecurringInvoiceItem({
    this.oldIndex,
    this.newIndex,
  });

  final int? oldIndex;
  final int? newIndex;
}

class AddRecurringInvoiceItems implements PersistUI {
  AddRecurringInvoiceItems(this.items);

  final List<InvoiceItemEntity> items;
}

class UpdateRecurringInvoiceItem implements PersistUI {
  UpdateRecurringInvoiceItem({
    required this.index,
    required this.item,
  });

  final int index;
  final InvoiceItemEntity item;
}

class DeleteRecurringInvoiceItem implements PersistUI {
  DeleteRecurringInvoiceItem(this.index);

  final int index;
}

class SaveRecurringInvoiceFailure implements StopSaving {
  SaveRecurringInvoiceFailure(this.error);

  final Object error;
}

class EmailRecurringInvoiceRequest implements StartSaving {
  EmailRecurringInvoiceRequest(
      {this.completer, this.invoiceId, this.template, this.subject, this.body});

  final Completer? completer;
  final String? invoiceId;
  final EmailTemplate? template;
  final String? subject;
  final String? body;
}

class EmailRecurringInvoiceSuccess implements StopSaving, PersistData {
  EmailRecurringInvoiceSuccess({required this.invoice});

  final InvoiceEntity invoice;
}

class EmailRecurringInvoiceFailure implements StopSaving {
  EmailRecurringInvoiceFailure(this.error);

  final dynamic error;
}

class ArchiveRecurringInvoicesRequest implements StartSaving {
  ArchiveRecurringInvoicesRequest(this.completer, this.recurringInvoiceIds);

  final Completer completer;
  final List<String> recurringInvoiceIds;
}

class ArchiveRecurringInvoicesSuccess implements StopSaving, PersistData {
  ArchiveRecurringInvoicesSuccess(this.recurringInvoices);

  final List<InvoiceEntity> recurringInvoices;
}

class ArchiveRecurringInvoicesFailure implements StopSaving {
  ArchiveRecurringInvoicesFailure(this.recurringInvoices);

  final List<InvoiceEntity?> recurringInvoices;
}

class SendNowRecurringInvoicesRequest implements StartSaving {
  SendNowRecurringInvoicesRequest(this.completer, this.recurringInvoiceIds);

  final Completer completer;
  final List<String> recurringInvoiceIds;
}

class SendNowRecurringInvoicesSuccess implements StopSaving, PersistData {
  SendNowRecurringInvoicesSuccess(this.recurringInvoices);

  final List<InvoiceEntity> recurringInvoices;
}

class SendNowRecurringInvoicesFailure implements StopSaving {
  SendNowRecurringInvoicesFailure(this.recurringInvoices);

  final List<InvoiceEntity> recurringInvoices;
}

class UpdatePricesRecurringInvoicesRequest implements StartSaving {
  UpdatePricesRecurringInvoicesRequest(
      {this.completer, this.recurringInvoiceIds});

  final Completer? completer;
  final List<String>? recurringInvoiceIds;
}

class UpdatePricesRecurringInvoicesSuccess implements StopSaving, PersistData {
  UpdatePricesRecurringInvoicesSuccess(this.recurringInvoices);

  final List<InvoiceEntity> recurringInvoices;
}

class UpdatePricesRecurringInvoicesFailure implements StopSaving {
  UpdatePricesRecurringInvoicesFailure(this.recurringInvoices);

  final List<InvoiceEntity> recurringInvoices;
}

class IncreasePricesRecurringInvoicesRequest implements StartSaving {
  IncreasePricesRecurringInvoicesRequest({
    this.completer,
    required this.recurringInvoiceIds,
    required this.percentageIncrease,
  });

  final Completer? completer;
  final double percentageIncrease;
  final List<String> recurringInvoiceIds;
}

class IncreasePricesRecurringInvoicesSuccess
    implements StopSaving, PersistData {
  IncreasePricesRecurringInvoicesSuccess(this.recurringInvoices);

  final List<InvoiceEntity> recurringInvoices;
}

class IncreasePricesRecurringInvoicesFailure implements StopSaving {
  IncreasePricesRecurringInvoicesFailure(this.recurringInvoices);

  final List<InvoiceEntity> recurringInvoices;
}

class DeleteRecurringInvoicesRequest implements StartSaving {
  DeleteRecurringInvoicesRequest(this.completer, this.recurringInvoiceIds);

  final Completer completer;
  final List<String> recurringInvoiceIds;
}

class DeleteRecurringInvoicesSuccess implements StopSaving, PersistData {
  DeleteRecurringInvoicesSuccess(this.recurringInvoices);

  final List<InvoiceEntity> recurringInvoices;
}

class DeleteRecurringInvoicesFailure implements StopSaving {
  DeleteRecurringInvoicesFailure(this.recurringInvoices);

  final List<InvoiceEntity?> recurringInvoices;
}

class RestoreRecurringInvoicesRequest implements StartSaving {
  RestoreRecurringInvoicesRequest(this.completer, this.recurringInvoiceIds);

  final Completer completer;
  final List<String> recurringInvoiceIds;
}

class RestoreRecurringInvoicesSuccess implements StopSaving, PersistData {
  RestoreRecurringInvoicesSuccess(this.recurringInvoices);

  final List<InvoiceEntity> recurringInvoices;
}

class RestoreRecurringInvoicesFailure implements StopSaving {
  RestoreRecurringInvoicesFailure(this.recurringInvoices);

  final List<InvoiceEntity?> recurringInvoices;
}

class FilterRecurringInvoices implements PersistUI {
  FilterRecurringInvoices(this.filter);

  final String? filter;
}

class SortRecurringInvoices implements PersistUI, PersistPrefs {
  SortRecurringInvoices(this.field);

  final String field;
}

class FilterRecurringInvoicesByState implements PersistUI {
  FilterRecurringInvoicesByState(this.state);

  final EntityState state;
}

class FilterRecurringInvoicesByStatus implements PersistUI {
  FilterRecurringInvoicesByStatus(this.status);

  final EntityStatus status;
}

class FilterRecurringInvoiceDropdown {
  FilterRecurringInvoiceDropdown(this.filter);

  final String? filter;
}

class FilterRecurringInvoicesByCustom1 implements PersistUI {
  FilterRecurringInvoicesByCustom1(this.value);

  final String value;
}

class FilterRecurringInvoicesByCustom2 implements PersistUI {
  FilterRecurringInvoicesByCustom2(this.value);

  final String value;
}

class FilterRecurringInvoicesByCustom3 implements PersistUI {
  FilterRecurringInvoicesByCustom3(this.value);

  final String value;
}

class FilterRecurringInvoicesByCustom4 implements PersistUI {
  FilterRecurringInvoicesByCustom4(this.value);

  final String value;
}

class SaveRecurringInvoiceDocumentRequest implements StartSaving {
  SaveRecurringInvoiceDocumentRequest({
    required this.isPrivate,
    required this.completer,
    required this.multipartFiles,
    required this.invoice,
  });

  final bool isPrivate;
  final Completer completer;
  final List<MultipartFile> multipartFiles;
  final InvoiceEntity invoice;
}

class SaveRecurringInvoiceDocumentSuccess
    implements StopSaving, PersistData, PersistUI {
  SaveRecurringInvoiceDocumentSuccess(this.document);

  final DocumentEntity document;
}

class SaveRecurringInvoiceDocumentFailure implements StopSaving {
  SaveRecurringInvoiceDocumentFailure(this.error);

  final Object error;
}

class StartRecurringInvoicesRequest implements StartSaving {
  StartRecurringInvoicesRequest({this.completer, this.invoiceIds});

  final Completer? completer;
  final List<String>? invoiceIds;
}

class StartRecurringInvoicesSuccess
    implements StopSaving, PersistData, PersistUI {
  StartRecurringInvoicesSuccess(this.invoices);

  final List<InvoiceEntity> invoices;
}

class StartRecurringInvoicesFailure implements StopSaving {
  StartRecurringInvoicesFailure(this.error);

  final Object error;
}

class StopRecurringInvoicesRequest implements StartSaving {
  StopRecurringInvoicesRequest({this.completer, this.invoiceIds});

  final Completer? completer;
  final List<String>? invoiceIds;
}

class StopRecurringInvoicesSuccess
    implements StopSaving, PersistData, PersistUI {
  StopRecurringInvoicesSuccess(this.invoices);

  final List<InvoiceEntity> invoices;
}

class StopRecurringInvoicesFailure implements StopSaving {
  StopRecurringInvoicesFailure(this.error);

  final Object error;
}

void handleRecurringInvoiceAction(BuildContext? context,
    List<BaseEntity> recurringInvoices, EntityAction? action) async {
  if (recurringInvoices.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context!);
  final state = store.state;
  final localization = AppLocalization.of(context);
  final recurringInvoice = recurringInvoices.first as InvoiceEntity;
  final recurringInvoiceIds =
      recurringInvoices.map((recurringInvoice) => recurringInvoice.id).toList();
  final client = state.clientState.get(recurringInvoice.clientId);

  switch (action) {
    case EntityAction.edit:
      editEntity(entity: recurringInvoice);
      break;
    case EntityAction.viewPdf:
      store.dispatch(
          ShowPdfRecurringInvoice(invoice: recurringInvoice, context: context));
      break;
    case EntityAction.updatePrices:
      confirmCallback(
          context: context,
          message: localization!.updatePrices,
          callback: (_) {
            store.dispatch(UpdatePricesRecurringInvoicesRequest(
              completer: snackBarCompleter<Null>(localization.updatedPrices),
              recurringInvoiceIds: recurringInvoiceIds,
            ));
          });
      break;
    case EntityAction.increasePrices:
      final amount = await showDialog<double>(
          context: context,
          builder: (context) {
            double? _amount = 0.0;
            return AlertDialog(
              title: Text(localization!.increasePrices),
              content: DecoratedFormField(
                autofocus: true,
                label: localization.percent,
                onChanged: (value) => _amount = parseDouble(value),
                initialValue: '',
                keyboardType: TextInputType.numberWithOptions(
                    decimal: true, signed: true),
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(0.0),
                    child: Text(localization.cancel.toUpperCase())),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(_amount),
                    child: Text(localization.submit.toUpperCase())),
              ],
            );
          });

      if (amount != null && amount != 0) {
        store.dispatch(IncreasePricesRecurringInvoicesRequest(
          completer: snackBarCompleter<Null>(localization!.updatedPrices),
          recurringInvoiceIds: recurringInvoiceIds,
          percentageIncrease: amount,
        ));
      }
      break;
    case EntityAction.clientPortal:
      var link = recurringInvoice.invitationSilentLink;
      if (link.isNotEmpty) {
        if (!link.contains('?')) {
          link += '?';
        }
        link += '&client_hash=${client.clientHash}';
        launchUrl(Uri.parse(link));
      }
      break;
    case EntityAction.cloneToPurchaseOrder:
      final designId = getDesignIdForVendorByEntity(
          state: state,
          vendorId: recurringInvoice.vendorId,
          entityType: EntityType.purchaseOrder);
      createEntity(
          entity: recurringInvoice.clone.rebuild((b) => b
            ..entityType = EntityType.purchaseOrder
            ..designId = designId));
      break;
    case EntityAction.cloneToOther:
      cloneToDialog(invoice: recurringInvoice);
      break;
    case EntityAction.clone:
    case EntityAction.cloneToRecurring:
      createEntity(entity: recurringInvoice.clone);
      break;
    case EntityAction.cloneToInvoice:
      createEntity(
          entity: recurringInvoice.clone
              .rebuild((b) => b..entityType = EntityType.invoice));
      break;
    case EntityAction.cloneToQuote:
      final designId = getDesignIdForClientByEntity(
          state: state,
          clientId: recurringInvoice.clientId,
          entityType: EntityType.invoice);
      createEntity(
          entity: recurringInvoice.clone.rebuild((b) => b
            ..entityType = EntityType.quote
            ..designId = designId));
      break;
    case EntityAction.cloneToCredit:
      final designId = getDesignIdForClientByEntity(
          state: state,
          clientId: recurringInvoice.clientId,
          entityType: EntityType.credit);
      createEntity(
          entity: recurringInvoice.clone.rebuild((b) => b
            ..entityType = EntityType.credit
            ..designId = designId));
      break;
    case EntityAction.start:
      store.dispatch(StartRecurringInvoicesRequest(
        completer: snackBarCompleter<Null>(recurringInvoice.lastSentDate.isEmpty
            ? localization!.startedRecurringInvoice
            : localization!.resumedRecurringInvoice),
        invoiceIds: recurringInvoiceIds,
      ));
      break;
    case EntityAction.stop:
      store.dispatch(StopRecurringInvoicesRequest(
        completer:
            snackBarCompleter<Null>(localization!.stoppedRecurringInvoice),
        invoiceIds: recurringInvoiceIds,
      ));
      break;
    case EntityAction.restore:
      final message = recurringInvoiceIds.length > 1
          ? localization!.restoredRecurringInvoices
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', recurringInvoiceIds.length.toString())
          : localization!.restoredRecurringInvoice;
      store.dispatch(RestoreRecurringInvoicesRequest(
          snackBarCompleter<Null>(message), recurringInvoiceIds));
      break;
    case EntityAction.archive:
      final message = recurringInvoiceIds.length > 1
          ? localization!.archivedRecurringInvoices
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', recurringInvoiceIds.length.toString())
          : localization!.archivedRecurringInvoice;
      store.dispatch(ArchiveRecurringInvoicesRequest(
          snackBarCompleter<Null>(message), recurringInvoiceIds));
      break;
    case EntityAction.delete:
      final message = recurringInvoiceIds.length > 1
          ? localization!.deletedRecurringInvoices
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', recurringInvoiceIds.length.toString())
          : localization!.deletedRecurringInvoice;
      store.dispatch(DeleteRecurringInvoicesRequest(
          snackBarCompleter<Null>(message), recurringInvoiceIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.recurringInvoiceListState.isInMultiselect()) {
        store.dispatch(StartRecurringInvoiceMultiselect());
      }

      if (recurringInvoices.isEmpty) {
        break;
      }

      for (final recurringInvoice in recurringInvoices) {
        if (!store.state.recurringInvoiceListState
            .isSelected(recurringInvoice.id)) {
          store.dispatch(
              AddToRecurringInvoiceMultiselect(entity: recurringInvoice));
        } else {
          store.dispatch(
              RemoveFromRecurringInvoiceMultiselect(entity: recurringInvoice));
        }
      }
      break;
    case EntityAction.more:
      showEntityActionsDialog(
        entities: [recurringInvoice],
      );
      break;
    case EntityAction.documents:
      final documentIds = <String>[];
      for (var invoice in recurringInvoices) {
        for (var document in (invoice as InvoiceEntity).documents) {
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
    case EntityAction.sendNow:
      store.dispatch(SendNowRecurringInvoicesRequest(
        snackBarCompleter<Null>(recurringInvoiceIds.length == 1
            ? localization!.emailedInvoice
            : localization!.emailedInvoice),
        recurringInvoiceIds,
      ));
      break;
  }
}

class StartRecurringInvoiceMultiselect {
  StartRecurringInvoiceMultiselect();
}

class AddToRecurringInvoiceMultiselect {
  AddToRecurringInvoiceMultiselect({required this.entity});

  final BaseEntity? entity;
}

class RemoveFromRecurringInvoiceMultiselect {
  RemoveFromRecurringInvoiceMultiselect({required this.entity});

  final BaseEntity? entity;
}

class ClearRecurringInvoiceMultiselect {
  ClearRecurringInvoiceMultiselect();
}

class UpdateRecurringInvoiceTab implements PersistUI {
  UpdateRecurringInvoiceTab({this.tabIndex});

  final int? tabIndex;
}
