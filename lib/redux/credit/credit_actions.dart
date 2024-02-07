// Dart imports:
import 'dart:async';
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/utils/files.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
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

class ViewCreditList implements PersistUI {
  ViewCreditList({
    this.force = false,
    this.page = 0,
  });

  final bool force;
  final int? page;
}

class ViewCredit implements PersistUI, PersistPrefs {
  ViewCredit({
    this.creditId,
    this.force = false,
  });

  final String? creditId;
  final bool force;
}

class EditCredit implements PersistUI, PersistPrefs {
  EditCredit(
      {this.credit, this.creditItemIndex, this.completer, this.force = false});

  final InvoiceEntity? credit;
  final int? creditItemIndex;
  final Completer? completer;
  final bool force;
}

class ShowEmailCredit {
  ShowEmailCredit({this.credit, this.context, this.completer});

  final InvoiceEntity? credit;
  final BuildContext? context;
  final Completer? completer;
}

class ShowPdfCredit {
  ShowPdfCredit({this.credit, this.context, this.activityId});

  final InvoiceEntity? credit;
  final BuildContext? context;
  final String? activityId;
}

class EditCreditItem implements PersistUI {
  EditCreditItem([this.creditItemIndex]);

  final int? creditItemIndex;
}

class UpdateCredit implements PersistUI {
  UpdateCredit(this.credit);

  final InvoiceEntity credit;
}

class UpdateCreditClient implements PersistUI {
  UpdateCreditClient({this.client});

  final ClientEntity? client;
}

class LoadCredit {
  LoadCredit({this.completer, this.creditId});

  final Completer? completer;
  final String? creditId;
}

class LoadCredits {
  LoadCredits({this.completer});

  final Completer? completer;
}

class LoadCreditRequest implements StartLoading {}

class LoadCreditFailure implements StopLoading {
  LoadCreditFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadCreditFailure{error: $error}';
  }
}

class LoadCreditSuccess implements StopLoading, PersistData {
  LoadCreditSuccess(this.credit);

  final InvoiceEntity credit;

  @override
  String toString() {
    return 'LoadCreditSuccess{credit: $credit}';
  }
}

class LoadCreditsRequest implements StartLoading {}

class LoadCreditsFailure implements StopLoading {
  LoadCreditsFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadCreditsFailure{error: $error}';
  }
}

class LoadCreditsSuccess implements StopLoading {
  LoadCreditsSuccess(this.credits);

  final BuiltList<InvoiceEntity> credits;

  @override
  String toString() {
    return 'LoadCreditsSuccess{credits: $credits}';
  }
}

class AddCreditContact implements PersistUI {
  AddCreditContact({this.contact, this.invitation});

  final ClientContactEntity? contact;
  final InvitationEntity? invitation;
}

class RemoveCreditContact implements PersistUI {
  RemoveCreditContact({this.invitation});

  final InvitationEntity? invitation;
}

class AddCreditItem implements PersistUI {
  AddCreditItem({this.creditItem});

  final InvoiceItemEntity? creditItem;
}

class MoveCreditItem implements PersistUI {
  MoveCreditItem({
    this.oldIndex,
    this.newIndex,
  });

  final int? oldIndex;
  final int? newIndex;
}

class AddCreditItems implements PersistUI {
  AddCreditItems(this.creditItems);

  final List<InvoiceItemEntity> creditItems;
}

class UpdateCreditItem implements PersistUI {
  UpdateCreditItem({
    required this.index,
    required this.creditItem,
  });

  final int index;
  final InvoiceItemEntity creditItem;
}

class DeleteCreditItem implements PersistUI {
  DeleteCreditItem(this.index);

  final int index;
}

class SaveCreditRequest implements StartSaving {
  SaveCreditRequest({
    required this.completer,
    required this.credit,
    required this.action,
  });

  final Completer completer;
  final InvoiceEntity credit;
  final EntityAction? action;
}

class SaveCreditSuccess implements StopSaving, PersistData, PersistUI {
  SaveCreditSuccess(this.credit);

  final InvoiceEntity credit;
}

class AddCreditSuccess implements StopSaving, PersistData, PersistUI {
  AddCreditSuccess(this.credit);

  final InvoiceEntity credit;
}

class SaveCreditFailure implements StopSaving {
  SaveCreditFailure(this.error);

  final Object error;
}

class EmailCreditRequest implements StartSaving {
  EmailCreditRequest({
    required this.completer,
    required this.creditId,
    required this.template,
    required this.subject,
    required this.body,
    required this.ccEmail,
  });

  final Completer completer;
  final String creditId;
  final EmailTemplate template;
  final String subject;
  final String body;
  final String ccEmail;
}

class EmailCreditSuccess implements StopSaving, PersistData {}

class EmailCreditFailure implements StopSaving {
  EmailCreditFailure(this.error);

  final dynamic error;
}

class MarkSentCreditRequest implements StartSaving {
  MarkSentCreditRequest(this.completer, this.creditIds);

  final Completer completer;
  final List<String> creditIds;
}

class MarkSentCreditSuccess implements StopSaving, PersistData {
  MarkSentCreditSuccess(this.credits);

  final List<InvoiceEntity> credits;
}

class MarkSentCreditFailure implements StopSaving {
  MarkSentCreditFailure(this.error);

  final Object error;
}

class BulkEmailCreditsRequest implements StartSaving {
  BulkEmailCreditsRequest({this.completer, this.creditIds, this.template});

  final Completer? completer;
  final List<String>? creditIds;
  final EmailTemplate? template;
}

class BulkEmailCreditsSuccess implements StopSaving, PersistData {
  BulkEmailCreditsSuccess(this.credits);

  final List<InvoiceEntity> credits;
}

class BulkEmailCreditsFailure implements StopSaving {
  BulkEmailCreditsFailure(this.error);

  final dynamic error;
}

class MarkCreditsPaidRequest implements StartSaving {
  MarkCreditsPaidRequest(this.completer, this.invoiceIds);

  final Completer completer;
  final List<String> invoiceIds;
}

class MarkCreditsPaidSuccess implements StopSaving {
  MarkCreditsPaidSuccess(this.invoices);

  final List<InvoiceEntity> invoices;
}

class MarkCreditsPaidFailure implements StopSaving {
  MarkCreditsPaidFailure(this.error);

  final dynamic error;
}

class ArchiveCreditsRequest implements StartSaving {
  ArchiveCreditsRequest(this.completer, this.creditIds);

  final Completer completer;

  final List<String> creditIds;
}

class ArchiveCreditsSuccess implements StopSaving, PersistData {
  ArchiveCreditsSuccess(this.credits);

  final List<InvoiceEntity> credits;
}

class ArchiveCreditsFailure implements StopSaving {
  ArchiveCreditsFailure(this.credits);

  final List<InvoiceEntity?> credits;
}

class DeleteCreditsRequest implements StartSaving {
  DeleteCreditsRequest(this.completer, this.creditIds);

  final Completer completer;

  final List<String> creditIds;
}

class DeleteCreditsSuccess implements StopSaving, PersistData {
  DeleteCreditsSuccess(this.credits);

  final List<InvoiceEntity> credits;
}

class DeleteCreditsFailure implements StopSaving {
  DeleteCreditsFailure(this.credits);

  final List<InvoiceEntity?> credits;
}

class DownloadCreditsRequest implements StartSaving {
  DownloadCreditsRequest(this.completer, this.creditIds);

  final Completer completer;
  final List<String> creditIds;
}

class DownloadCreditsSuccess implements StopSaving {}

class DownloadCreditsFailure implements StopSaving {
  DownloadCreditsFailure(this.error);

  final Object error;
}

class RestoreCreditsRequest implements StartSaving {
  RestoreCreditsRequest(this.completer, this.creditIds);

  final Completer completer;

  final List<String> creditIds;
}

class RestoreCreditsSuccess implements StopSaving, PersistData {
  RestoreCreditsSuccess(this.credits);

  final List<InvoiceEntity> credits;
}

class RestoreCreditsFailure implements StopSaving {
  RestoreCreditsFailure(this.credits);

  final List<InvoiceEntity?> credits;
}

class FilterCredits implements PersistUI {
  FilterCredits(this.filter);

  final String? filter;
}

class SortCredits implements PersistUI, PersistPrefs {
  SortCredits(this.field);

  final String field;
}

class FilterCreditsByState implements PersistUI {
  FilterCreditsByState(this.state);

  final EntityState state;
}

class FilterCreditsByStatus implements PersistUI {
  FilterCreditsByStatus(this.status);

  final EntityStatus status;
}

class FilterCreditDropdown {
  FilterCreditDropdown(this.filter);

  final String? filter;
}

class FilterCreditsByCustom1 implements PersistUI {
  FilterCreditsByCustom1(this.value);

  final String value;
}

class FilterCreditsByCustom2 implements PersistUI {
  FilterCreditsByCustom2(this.value);

  final String value;
}

class FilterCreditsByCustom3 implements PersistUI {
  FilterCreditsByCustom3(this.value);

  final String value;
}

class FilterCreditsByCustom4 implements PersistUI {
  FilterCreditsByCustom4(this.value);

  final String value;
}

class SaveCreditDocumentRequest implements StartSaving {
  SaveCreditDocumentRequest({
    required this.isPrivate,
    required this.completer,
    required this.multipartFiles,
    required this.credit,
  });

  final bool? isPrivate;
  final Completer completer;
  final List<MultipartFile> multipartFiles;
  final InvoiceEntity credit;
}

class SaveCreditDocumentSuccess implements StopSaving, PersistData, PersistUI {
  SaveCreditDocumentSuccess(this.document);

  final DocumentEntity document;
}

class SaveCreditDocumentFailure implements StopSaving {
  SaveCreditDocumentFailure(this.error);

  final Object error;
}

Future handleCreditAction(BuildContext context, List<BaseEntity> credits,
    EntityAction? action) async {
  final store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final localization = AppLocalization.of(context);
  final credit = credits.first as InvoiceEntity;
  final creditIds = credits.map((credit) => credit.id).toList();
  final client = state.clientState.get(credit.clientId);

  switch (action) {
    case EntityAction.edit:
      editEntity(entity: credit);
      break;
    case EntityAction.viewPdf:
      store.dispatch(ShowPdfCredit(credit: credit, context: context));
      break;
    case EntityAction.clientPortal:
      launchUrl(Uri.parse(credit.invitationSilentLink));
      break;
    case EntityAction.markSent:
      store.dispatch(MarkSentCreditRequest(
          snackBarCompleter<Null>(localization!.markedCreditAsSent),
          creditIds));
      break;
    case EntityAction.sendEmail:
    case EntityAction.bulkSendEmail:
    case EntityAction.schedule:
      bool emailValid = true;
      credits.forEach((credit) {
        final client = state.clientState.get(
          (credit as InvoiceEntity).clientId,
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
        store.dispatch(ShowEmailCredit(
            completer: snackBarCompleter<Null>(localization!.emailedCredit),
            credit: credit,
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
                  ..parameters.entityType = EntityType.credit.apiValue
                  ..parameters.entityId = credit.id));
      } else {
        confirmCallback(
            context: context,
            message: localization!.bulkEmailCredits,
            callback: (_) {
              store.dispatch(BulkEmailCreditsRequest(
                completer: snackBarCompleter<Null>(creditIds.length == 1
                    ? localization.emailedCredit
                    : localization.emailedCredits),
                creditIds: creditIds,
              ));
            });
      }
      break;
    case EntityAction.cloneToPurchaseOrder:
      final designId = getDesignIdForVendorByEntity(
          state: state,
          vendorId: credit.vendorId,
          entityType: EntityType.purchaseOrder);
      createEntity(
          entity: credit.clone.rebuild((b) => b
            ..entityType = EntityType.purchaseOrder
            ..designId = designId));
      break;
    case EntityAction.cloneToOther:
      cloneToDialog(invoice: credit);
      break;
    case EntityAction.cloneToInvoice:
      final designId = getDesignIdForClientByEntity(
          state: state,
          clientId: credit.clientId,
          entityType: EntityType.invoice);
      createEntity(
          entity: credit.clone.rebuild((b) => b
            ..entityType = EntityType.invoice
            ..designId = designId));
      break;
    case EntityAction.cloneToQuote:
      final designId = getDesignIdForClientByEntity(
          state: state,
          clientId: credit.clientId,
          entityType: EntityType.quote);
      createEntity(
          entity: credit.clone.rebuild((b) => b
            ..entityType = EntityType.quote
            ..designId = designId));
      break;
    case EntityAction.clone:
    case EntityAction.cloneToCredit:
      createEntity(entity: credit.clone);
      break;
    case EntityAction.cloneToRecurring:
      final designId = getDesignIdForClientByEntity(
          state: state,
          clientId: credit.clientId,
          entityType: EntityType.invoice);
      createEntity(
          entity: credit.clone.rebuild((b) => b
            ..entityType = EntityType.recurringInvoice
            ..designId = designId));
      break;
    case EntityAction.markPaid:
      store.dispatch(MarkCreditsPaidRequest(
          snackBarCompleter<Null>(credits.length == 1
              ? localization!.markedCreditAsPaid
              : localization!.markedCreditsAsPaid),
          creditIds));
      break;
    case EntityAction.applyCredit:
      createEntity(
        entity: PaymentEntity(state: state, client: client).rebuild((b) => b
          ..typeId = kPaymentTypeCredit
          ..credits.addAll(credits
              .map((credit) =>
                  PaymentableEntity.fromCredit(credit as InvoiceEntity))
              .toList())),
        filterEntity: client,
      );
      break;
    case EntityAction.download:
      store.dispatch(StartLoading());
      await WebClient()
          .get(credit.invitationDownloadLink, state.token, rawResponse: true)
          .then((response) {
        store.dispatch(StopLoading());
        saveDownloadedFile(
          response.bodyBytes,
          credit.number + '.pdf',
          prefix: EntityType.credit.apiValue,
          languageId: client.languageId,
        );
      }).catchError((_) {
        store.dispatch(StopLoading());
      });
      break;
    case EntityAction.bulkDownload:
      store.dispatch(DownloadCreditsRequest(
          snackBarCompleter<Null>(localization!.exportedData), creditIds));
      break;
    case EntityAction.restore:
      final message = creditIds.length > 1
          ? localization!.restoredCredits
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', creditIds.length.toString())
          : localization!.restoredCredit;
      store.dispatch(
          RestoreCreditsRequest(snackBarCompleter<Null>(message), creditIds));
      break;
    case EntityAction.archive:
      final message = creditIds.length > 1
          ? localization!.archivedCredits
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', creditIds.length.toString())
          : localization!.archivedCredit;
      store.dispatch(
          ArchiveCreditsRequest(snackBarCompleter<Null>(message), creditIds));
      break;
    case EntityAction.delete:
      final message = creditIds.length > 1
          ? localization!.deletedCredits
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', creditIds.length.toString())
          : localization!.deletedCredit;
      store.dispatch(
          DeleteCreditsRequest(snackBarCompleter<Null>(message), creditIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.creditListState.isInMultiselect()) {
        store.dispatch(StartCreditMultiselect());
      }
      for (final credit in credits) {
        if (!store.state.creditListState.isSelected(credit.id)) {
          store.dispatch(AddToCreditMultiselect(entity: credit));
        } else {
          store.dispatch(RemoveFromCreditMultiselect(entity: credit));
        }
      }
      break;
    case EntityAction.printPdf:
      final invitation = credit.invitations.first;
      final url = invitation.downloadLink;
      store.dispatch(StartSaving());
      final http.Response? response =
          await WebClient().get(url, state.token, rawResponse: true);
      store.dispatch(StopSaving());
      await Printing.layoutPdf(onLayout: (_) => response!.bodyBytes);
      break;
    case EntityAction.bulkPrint:
      store.dispatch(StartSaving());
      final url = state.credentials.url + '/credits/bulk';
      final data = json.encode(
          {'ids': creditIds, 'action': EntityAction.bulkPrint.toApiParam()});
      final http.Response? response = await WebClient()
          .post(url, state.credentials.token, data: data, rawResponse: true);
      store.dispatch(StopSaving());
      await Printing.layoutPdf(onLayout: (_) => response!.bodyBytes);
      break;
    case EntityAction.more:
      showEntityActionsDialog(
        entities: [credit],
      );
      break;
    case EntityAction.documents:
      final documentIds = <String>[];
      for (var credit in credits) {
        for (var document in (credit as InvoiceEntity).documents) {
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
      print('## ERROR: unhandled action $action in credit_actions');
      break;
  }
}

class StartCreditMultiselect {}

class AddToCreditMultiselect {
  AddToCreditMultiselect({required this.entity});

  final BaseEntity? entity;
}

class RemoveFromCreditMultiselect {
  RemoveFromCreditMultiselect({required this.entity});

  final BaseEntity? entity;
}

class ClearCreditMultiselect {}

class UpdateCreditTab implements PersistUI {
  UpdateCreditTab({this.tabIndex});

  final int? tabIndex;
}
