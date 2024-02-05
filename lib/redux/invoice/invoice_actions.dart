// Dart imports:
import 'dart:async';
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/utils/files.dart';
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

import 'package:http/http.dart' as http;
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:printing/printing.dart';

class ViewInvoiceList implements PersistUI {
  ViewInvoiceList({
    this.force = false,
    this.page = 0,
  });

  final bool force;
  final int? page;
}

class ViewInvoice implements PersistUI, PersistPrefs {
  ViewInvoice({this.invoiceId, this.force = false});

  final String? invoiceId;
  final bool force;
}

class EditInvoice implements PersistUI, PersistPrefs {
  EditInvoice({
    this.invoice,
    this.completer,
    this.invoiceItemIndex,
    this.force = false,
  });

  final InvoiceEntity? invoice;
  final int? invoiceItemIndex;
  final Completer? completer;
  final bool force;
}

class ShowEmailInvoice {
  ShowEmailInvoice({this.invoice, this.context, this.completer});

  final InvoiceEntity? invoice;
  final BuildContext? context;
  final Completer? completer;
}

class ShowPdfInvoice {
  ShowPdfInvoice({this.invoice, this.context, this.activityId});

  final InvoiceEntity? invoice;
  final BuildContext? context;
  final String? activityId;
}

class EditInvoiceItem implements PersistUI {
  EditInvoiceItem([this.invoiceItemIndex]);

  final int? invoiceItemIndex;
}

class UpdateInvoice implements PersistUI {
  UpdateInvoice(this.invoice);

  final InvoiceEntity invoice;
}

class UpdateInvoiceClient implements PersistUI {
  UpdateInvoiceClient({this.client});

  final ClientEntity? client;
}

class LoadInvoice {
  LoadInvoice({this.completer, this.invoiceId});

  final Completer? completer;
  final String? invoiceId;
}

class LoadInvoices {
  LoadInvoices({this.completer, this.page = 1});

  final Completer? completer;
  final int page;
}

class LoadInvoiceRequest implements StartLoading {}

class LoadInvoiceFailure implements StopLoading {
  LoadInvoiceFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadInvoiceFailure{error: $error}';
  }
}

class LoadInvoiceSuccess implements StopLoading, PersistData {
  LoadInvoiceSuccess(this.invoice);

  final InvoiceEntity invoice;

  @override
  String toString() {
    return 'LoadInvoiceSuccess{invoice: $invoice}';
  }
}

class LoadInvoicesRequest implements StartLoading {}

class LoadInvoicesFailure implements StopLoading {
  LoadInvoicesFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadInvoicesFailure{error: $error}';
  }
}

class LoadInvoicesSuccess implements StopLoading {
  LoadInvoicesSuccess(this.invoices);

  final BuiltList<InvoiceEntity> invoices;

  @override
  String toString() {
    return 'LoadInvoicesSuccess{invoices: $invoices}';
  }
}

class AddInvoiceContact implements PersistUI {
  AddInvoiceContact({this.contact, this.invitation});

  final ClientContactEntity? contact;
  final InvitationEntity? invitation;
}

class RemoveInvoiceContact implements PersistUI {
  RemoveInvoiceContact({this.invitation});

  final InvitationEntity? invitation;
}

class AddInvoiceItem implements PersistUI {
  AddInvoiceItem({
    this.invoiceItem,
    this.index,
  });

  final InvoiceItemEntity? invoiceItem;
  final int? index;
}

class MoveInvoiceItem implements PersistUI {
  MoveInvoiceItem({
    this.oldIndex,
    this.newIndex,
  });

  final int? oldIndex;
  final int? newIndex;
}

class AddInvoiceItems implements PersistUI {
  AddInvoiceItems(this.lineItems);

  final List<InvoiceItemEntity> lineItems;
}

class UpdateInvoiceItem implements PersistUI {
  UpdateInvoiceItem({
    required this.index,
    required this.invoiceItem,
  });

  final int index;
  final InvoiceItemEntity invoiceItem;
}

class DeleteInvoiceItem implements PersistUI {
  DeleteInvoiceItem(this.index);

  final int index;
}

class SaveInvoiceRequest implements StartSaving {
  SaveInvoiceRequest({
    required this.completer,
    required this.invoice,
    required this.entityAction,
  });

  final Completer completer;
  final InvoiceEntity invoice;
  final EntityAction? entityAction;
}

class SaveInvoiceSuccess implements StopSaving, PersistUI {
  SaveInvoiceSuccess(this.invoice);

  final InvoiceEntity invoice;
}

class AddInvoiceSuccess implements StopSaving, PersistUI {
  AddInvoiceSuccess(this.invoice);

  final InvoiceEntity invoice;
}

class SaveInvoiceFailure implements StopSaving {
  SaveInvoiceFailure(this.error);

  final Object error;
}

class EmailInvoiceRequest implements StartSaving {
  EmailInvoiceRequest({
    required this.completer,
    required this.invoiceId,
    required this.template,
    required this.subject,
    required this.body,
    required this.ccEmail,
  });

  final Completer completer;
  final String invoiceId;
  final EmailTemplate template;
  final String subject;
  final String body;
  final String ccEmail;
}

class EmailInvoiceSuccess implements StopSaving, PersistData {
  EmailInvoiceSuccess({required this.invoice});

  final InvoiceEntity invoice;
}

class EmailInvoiceFailure implements StopSaving {
  EmailInvoiceFailure(this.error);

  final dynamic error;
}

class MarkInvoicesSentRequest implements StartSaving {
  MarkInvoicesSentRequest(this.completer, this.invoiceIds);

  final Completer completer;
  final List<String> invoiceIds;
}

class MarkInvoicesSentSuccess implements StopSaving, PersistData {
  MarkInvoicesSentSuccess(this.invoices);

  final List<InvoiceEntity> invoices;
}

class MarkInvoicesSentFailure implements StopSaving {
  MarkInvoicesSentFailure(this.error);

  final dynamic error;
}

class BulkEmailInvoicesRequest implements StartSaving {
  BulkEmailInvoicesRequest({this.completer, this.invoiceIds, this.template});

  final Completer? completer;
  final List<String>? invoiceIds;
  final EmailTemplate? template;
}

class BulkEmailInvoicesSuccess implements StopSaving, PersistData {
  BulkEmailInvoicesSuccess(this.invoices);

  final List<InvoiceEntity> invoices;
}

class BulkEmailInvoicesFailure implements StopSaving {
  BulkEmailInvoicesFailure(this.error);

  final dynamic error;
}

class MarkInvoicesPaidRequest implements StartSaving {
  MarkInvoicesPaidRequest(this.completer, this.invoiceIds);

  final Completer completer;
  final List<String> invoiceIds;
}

class MarkInvoicesPaidSuccess implements StopSaving {
  MarkInvoicesPaidSuccess(this.invoices);

  final List<InvoiceEntity> invoices;
}

class MarkInvoicesPaidFailure implements StopSaving {
  MarkInvoicesPaidFailure(this.error);

  final dynamic error;
}

class AutoBillInvoicesRequest implements StartSaving {
  AutoBillInvoicesRequest(this.completer, this.invoiceIds);

  final Completer completer;
  final List<String> invoiceIds;
}

class AutoBillInvoicesSuccess implements StopSaving {
  AutoBillInvoicesSuccess(this.invoices);

  final List<InvoiceEntity> invoices;
}

class AutoBillInvoicesFailure implements StopSaving {
  AutoBillInvoicesFailure(this.error);

  final dynamic error;
}

class CancelInvoicesRequest implements StartSaving {
  CancelInvoicesRequest(this.completer, this.invoiceIds);

  final Completer completer;
  final List<String> invoiceIds;
}

class CancelInvoicesSuccess implements StopSaving {
  CancelInvoicesSuccess(this.invoices);

  final List<InvoiceEntity> invoices;
}

class CancelInvoicesFailure implements StopSaving {
  CancelInvoicesFailure(this.error);

  final Object error;
}

class ArchiveInvoicesRequest implements StartSaving {
  ArchiveInvoicesRequest(this.completer, this.invoiceIds);

  final Completer completer;
  final List<String> invoiceIds;
}

class ArchiveInvoicesSuccess implements StopSaving, PersistData {
  ArchiveInvoicesSuccess(this.invoices);

  final List<InvoiceEntity> invoices;
}

class ArchiveInvoicesFailure implements StopSaving {
  ArchiveInvoicesFailure(this.invoices);

  final List<InvoiceEntity?> invoices;
}

class DeleteInvoicesRequest implements StartSaving {
  DeleteInvoicesRequest(this.completer, this.invoiceIds);

  final Completer completer;
  final List<String> invoiceIds;
}

class DeleteInvoicesSuccess implements StopSaving, PersistData {
  DeleteInvoicesSuccess(this.invoices);

  final List<InvoiceEntity> invoices;
}

class DeleteInvoicesFailure implements StopSaving {
  DeleteInvoicesFailure(this.invoices);

  final List<InvoiceEntity?> invoices;
}

class DownloadInvoicesRequest implements StartSaving {
  DownloadInvoicesRequest(this.completer, this.invoiceIds);

  final Completer completer;
  final List<String> invoiceIds;
}

class DownloadInvoicesSuccess implements StopSaving {}

class DownloadInvoicesFailure implements StopSaving {
  DownloadInvoicesFailure(this.error);

  final Object error;
}

class RestoreInvoicesRequest implements StartSaving {
  RestoreInvoicesRequest(this.completer, this.invoiceIds);

  final Completer completer;
  final List<String> invoiceIds;
}

class RestoreInvoicesSuccess implements StopSaving, PersistData {
  RestoreInvoicesSuccess(this.invoices);

  final List<InvoiceEntity> invoices;
}

class RestoreInvoicesFailure implements StopSaving {
  RestoreInvoicesFailure(this.invoices);

  final List<InvoiceEntity?> invoices;
}

class FilterInvoices implements PersistUI {
  FilterInvoices(this.filter);

  final String? filter;
}

class SortInvoices implements PersistUI, PersistPrefs {
  SortInvoices(this.field);

  final String field;
}

class FilterInvoicesByState implements PersistUI {
  FilterInvoicesByState(this.state);

  final EntityState state;
}

class FilterInvoicesByStatus implements PersistUI {
  FilterInvoicesByStatus(this.status);

  final EntityStatus status;
}

class FilterInvoiceDropdown {
  FilterInvoiceDropdown(this.filter);

  final String? filter;
}

class FilterInvoicesByCustom1 implements PersistUI {
  FilterInvoicesByCustom1(this.value);

  final String value;
}

class FilterInvoicesByCustom2 implements PersistUI {
  FilterInvoicesByCustom2(this.value);

  final String value;
}

class FilterInvoicesByCustom3 implements PersistUI {
  FilterInvoicesByCustom3(this.value);

  final String value;
}

class FilterInvoicesByCustom4 implements PersistUI {
  FilterInvoicesByCustom4(this.value);

  final String value;
}

class StartInvoiceMultiselect {}

class AddToInvoiceMultiselect {
  AddToInvoiceMultiselect({required this.entity});

  final BaseEntity? entity;
}

class RemoveFromInvoiceMultiselect {
  RemoveFromInvoiceMultiselect({required this.entity});

  final BaseEntity? entity;
}

class ClearInvoiceMultiselect {}

class SaveInvoiceDocumentRequest implements StartSaving {
  SaveInvoiceDocumentRequest({
    required this.isPrivate,
    required this.completer,
    required this.multipartFiles,
    required this.invoice,
  });

  final bool? isPrivate;
  final Completer completer;
  final List<MultipartFile> multipartFiles;
  final InvoiceEntity invoice;
}

class SaveInvoiceDocumentSuccess implements StopSaving, PersistData, PersistUI {
  SaveInvoiceDocumentSuccess(this.document);

  final DocumentEntity document;
}

class SaveInvoiceDocumentFailure implements StopSaving {
  SaveInvoiceDocumentFailure(this.error);

  final Object error;
}

class UpdateInvoiceTab implements PersistUI {
  UpdateInvoiceTab({this.tabIndex});

  final int? tabIndex;
}

void handleInvoiceAction(BuildContext? context, List<BaseEntity> invoices,
    EntityAction? action) async {
  if (invoices.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context!);
  final state = store.state;
  final localization = AppLocalization.of(context);
  final invoice = invoices.first as InvoiceEntity;
  final invoiceIds = invoices.map((invoice) => invoice.id).toList();
  final client = state.clientState.get(invoice.clientId);

  switch (action) {
    case EntityAction.edit:
      editEntity(entity: invoice);
      break;
    case EntityAction.viewPdf:
      store.dispatch(ShowPdfInvoice(invoice: invoice, context: context));
      break;
    case EntityAction.clientPortal:
      var link = invoice.invitationSilentLink;
      if (link.isNotEmpty) {
        if (!link.contains('?')) {
          link += '?';
        }
        link += '&client_hash=${client.clientHash}';
        launchUrl(Uri.parse(link));
      }
      break;
    case EntityAction.markSent:
      store.dispatch(MarkInvoicesSentRequest(
          snackBarCompleter<Null>(invoiceIds.length == 1
              ? localization!.markedInvoiceAsSent
              : localization!.markedInvoicesAsSent),
          invoiceIds));
      break;
    case EntityAction.reverse:
      final designId = getDesignIdForClientByEntity(
          state: state,
          clientId: invoice.clientId,
          entityType: EntityType.credit);
      createEntity(
          entity: invoice.clone.rebuild((b) => b
            ..invoiceId = invoice.id
            ..entityType = EntityType.credit
            ..designId = designId));
      break;
    case EntityAction.cancelInvoice:
      confirmCallback(
          context: context,
          message: localization!.cancelInvoice,
          callback: (_) {
            store.dispatch(CancelInvoicesRequest(
                snackBarCompleter<Null>(invoiceIds.length == 1
                    ? localization.cancelledInvoice
                    : localization.cancelledInvoices),
                invoiceIds));
          });
      break;
    case EntityAction.markPaid:
      store.dispatch(MarkInvoicesPaidRequest(
          snackBarCompleter<Null>(invoiceIds.length == 1
              ? localization!.markedInvoiceAsPaid
              : localization!.markedInvoicesAsPaid),
          invoiceIds));
      break;
    case EntityAction.autoBill:
      confirmCallback(
          context: context,
          message: localization!.autoBill,
          callback: (_) {
            store.dispatch(AutoBillInvoicesRequest(
                snackBarCompleter<Null>(invoiceIds.length == 1
                    ? localization.autoBilledInvoice
                    : localization.autoBilledInvoices),
                invoiceIds));
          });
      break;
    case EntityAction.sendEmail:
    case EntityAction.bulkSendEmail:
    case EntityAction.schedule:
      bool emailValid = true;
      invoices.forEach((invoice) {
        final client = state.clientState.get(
          (invoice as InvoiceEntity).clientId,
        );
        if (!client.hasEmailAddress) {
          emailValid = false;
        }
      });
      if (!emailValid) {
        showMessageDialog(
            message: localization!.clientEmailNotSet,
            secondaryActions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    editEntity(entity: client);
                  },
                  child: Text(localization.editClient.toUpperCase()))
            ]);
        return;
      }
      if (action == EntityAction.sendEmail) {
        store.dispatch(ShowEmailInvoice(
            completer: snackBarCompleter<Null>(localization!.emailedInvoice),
            invoice: invoice,
            context: context));
      } else if (action == EntityAction.schedule) {
        if (!state.isProPlan) {
          showMessageDialog(
              message: localization!.upgradeToPaidPlanToSchedule,
              secondaryActions: [
                TextButton(
                    onPressed: () {
                      store.dispatch(
                          ViewSettings(section: kSettingsAccountManagement));
                      Navigator.of(context).pop();
                    },
                    child: Text(localization.upgrade.toUpperCase())),
              ]);
          return;
        }

        createEntity(
            entity: ScheduleEntity(ScheduleEntity.TEMPLATE_EMAIL_RECORD)
                .rebuild((b) => b
                  ..parameters.entityType = EntityType.invoice.apiValue
                  ..parameters.entityId = invoice.id));
      } else {
        final template = await showDialog<EmailTemplate>(
          context: context,
          builder: (context) {
            final settings = getClientSettings(state, client);
            final templates = {
              EmailTemplate.invoice: localization!.initialEmail,
              EmailTemplate.reminder1: localization.firstReminder,
              EmailTemplate.reminder2: localization.secondReminder,
              EmailTemplate.reminder3: localization.thirdReminder,
              EmailTemplate.reminder_endless: localization.endlessReminder,
              if ((settings.emailSubjectCustom1 ?? '').isNotEmpty)
                EmailTemplate.custom1: localization.firstCustom,
              if ((settings.emailSubjectCustom2 ?? '').isNotEmpty)
                EmailTemplate.custom2: localization.secondCustom,
              if ((settings.emailSubjectCustom3 ?? '').isNotEmpty)
                EmailTemplate.custom3: localization.thirdCustom,
            };
            return SimpleDialog(
              title: Text(
                invoiceIds.length == 1
                    ? localization.emailInvoice
                    : localization.emailCountInvoices
                        .replaceFirst(':count', '${invoiceIds.length}'),
              ),
              children: templates.keys
                  .map((template) => SimpleDialogOption(
                        child: Text(templates[template]!),
                        onPressed: () {
                          Navigator.of(context).pop(template);
                        },
                      ))
                  .toList(),
            );
          },
        );

        if (template != null) {
          store.dispatch(BulkEmailInvoicesRequest(
            completer: snackBarCompleter<Null>(invoiceIds.length == 1
                ? localization!.emailedInvoice
                : localization!.emailedInvoices),
            invoiceIds: invoiceIds,
            template: template,
          ));
        }
      }
      break;
    case EntityAction.cloneToOther:
      cloneToDialog(invoice: invoice);
      break;
    case EntityAction.clone:
    case EntityAction.cloneToInvoice:
      createEntity(entity: invoice.clone);
      break;
    case EntityAction.cloneToQuote:
      final designId = getDesignIdForClientByEntity(
          state: state,
          clientId: invoice.clientId,
          entityType: EntityType.quote);
      createEntity(
          entity: invoice.clone.rebuild((b) => b
            ..entityType = EntityType.quote
            ..designId = designId));
      break;
    case EntityAction.cloneToCredit:
      final designId = getDesignIdForClientByEntity(
          state: state,
          clientId: invoice.clientId,
          entityType: EntityType.credit);
      createEntity(
          entity: invoice.clone.rebuild((b) => b
            ..entityType = EntityType.credit
            ..designId = designId));
      break;
    case EntityAction.cloneToPurchaseOrder:
      final designId = getDesignIdForVendorByEntity(
          state: state,
          vendorId: invoice.vendorId,
          entityType: EntityType.purchaseOrder);
      createEntity(
          entity: invoice.clone
              .rebuild((b) => b
                ..entityType = EntityType.purchaseOrder
                ..designId = designId)
              .recreateInvitations(state));
      break;
    case EntityAction.cloneToRecurring:
      createEntity(
          entity: invoice.clone
              .rebuild((b) => b..entityType = EntityType.recurringInvoice));
      break;
    case EntityAction.newPayment:
      createEntity(
        entity: PaymentEntity(state: state, client: client).rebuild((b) => b
          ..invoices.addAll(invoices
              .where((invoice) => !(invoice as InvoiceEntity).isPaid)
              .map((invoice) =>
                  PaymentableEntity.fromInvoice(invoice as InvoiceEntity))
              .toList())),
        filterEntity: client,
      );
      break;
    case EntityAction.download:
      store.dispatch(StartLoading());
      await WebClient()
          .get(invoice.invitationDownloadLink, state.token, rawResponse: true)
          .then((response) {
        store.dispatch(StopLoading());
        saveDownloadedFile(
          response.bodyBytes,
          invoice.number + '.pdf',
          prefix: EntityType.invoice.apiValue,
          languageId: client.languageId,
        );
      }).catchError((_) {
        store.dispatch(StopLoading());
      });
      break;
    case EntityAction.eInvoice:
      store.dispatch(StartLoading());
      await WebClient()
          .get(invoice.invitationEInvoiceDownloadLink, state.token,
              rawResponse: true)
          .then((response) {
        store.dispatch(StopLoading());
        saveDownloadedFile(
          response.bodyBytes,
          invoice.number + '.xml',
          prefix: EntityType.invoice.apiValue,
          languageId: client.languageId,
        );
      }).catchError((_) {
        store.dispatch(StopLoading());
      });
      break;
    case EntityAction.bulkDownload:
      store.dispatch(DownloadInvoicesRequest(
          snackBarCompleter<Null>(localization!.exportedData), invoiceIds));
      break;
    case EntityAction.restore:
      final message = invoiceIds.length > 1
          ? localization!.restoredInvoices
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', invoiceIds.length.toString())
          : localization!.restoredInvoice;
      store.dispatch(
          RestoreInvoicesRequest(snackBarCompleter<Null>(message), invoiceIds));
      break;
    case EntityAction.archive:
      final message = invoiceIds.length > 1
          ? localization!.archivedInvoices
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', invoiceIds.length.toString())
          : localization!.archivedInvoice;
      store.dispatch(
          ArchiveInvoicesRequest(snackBarCompleter<Null>(message), invoiceIds));
      break;
    case EntityAction.delete:
      final message = invoiceIds.length > 1
          ? localization!.deletedInvoices
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', invoiceIds.length.toString())
          : localization!.deletedInvoice;
      store.dispatch(
          DeleteInvoicesRequest(snackBarCompleter<Null>(message), invoiceIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.invoiceListState.isInMultiselect()) {
        store.dispatch(StartInvoiceMultiselect());
      }
      for (final invoice in invoices) {
        if (!store.state.invoiceListState.isSelected(invoice.id)) {
          store.dispatch(AddToInvoiceMultiselect(entity: invoice));
        } else {
          store.dispatch(RemoveFromInvoiceMultiselect(entity: invoice));
        }
      }
      break;
    case EntityAction.printPdf:
      final invitation = invoice.invitations.first;
      final url = invitation.downloadLink;
      store.dispatch(StartSaving());
      final http.Response? response =
          await WebClient().get(url, state.token, rawResponse: true);
      store.dispatch(StopSaving());
      await Printing.layoutPdf(onLayout: (_) => response!.bodyBytes);
      break;
    case EntityAction.bulkPrint:
      store.dispatch(StartSaving());
      final url = state.credentials.url + '/invoices/bulk';
      final data = json.encode(
          {'ids': invoiceIds, 'action': EntityAction.bulkPrint.toApiParam()});
      final http.Response? response = await WebClient()
          .post(url, state.credentials.token, data: data, rawResponse: true);
      store.dispatch(StopSaving());
      await Printing.layoutPdf(onLayout: (_) => response!.bodyBytes);
      break;
    case EntityAction.runTemplate:
      showDialog<void>(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (context) => RunTemplateDialog(
          entityType: EntityType.invoice,
          entities: invoices,
        ),
      );
      break;
    case EntityAction.more:
      showEntityActionsDialog(
        entities: [invoice],
      );
      break;
    case EntityAction.documents:
      final documentIds = <String>[];
      for (var invoice in invoices) {
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
    default:
      print('## ERROR: unhandled action $action in invoice_actions');
      break;
  }
}
